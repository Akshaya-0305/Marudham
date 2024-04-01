<?php

session_start();
include '../../ajaxconfig.php';

$where = "1";

if(isset($_POST['from_date']) && isset($_POST['to_date']) && $_POST['from_date'] !='' && $_POST['to_date'] != ''){
    $from_date = date('Y-m-d',strtotime($_POST['from_date']));
    $to_date = date('Y-m-d',strtotime($_POST['to_date']));
    $where  = "(date(coll.coll_date) >= '".$from_date."') and (date(coll.coll_date) <= '".$to_date."') ";

}

if(isset($_SESSION["userid"])){
    $userid = $_SESSION["userid"];
}
if($userid != 1){
    
    $userQry = $con->query("SELECT * FROM USER WHERE user_id = $userid ");
    while($rowuser = $userQry->fetch_assoc()){
        $group_id = $rowuser['group_id'];
        $line_id = $rowuser['line_id'];
    }

    $line_id = explode(',',$line_id);
    $sub_area_list = array();
    foreach($line_id as $line){
        $lineQry = $con->query("SELECT * FROM area_line_mapping where map_id = $line ");
        $row_sub = $lineQry->fetch_assoc();
        $sub_area_list[] = $row_sub['sub_area_id'];
    }
    $sub_area_ids = array();
    foreach ($sub_area_list as $subarray) {
        $sub_area_ids = array_merge($sub_area_ids, explode(',',$subarray));
    }
    $sub_area_list = array();
    $sub_area_list = implode(',',$sub_area_ids);
}

$qry = $con->query("
            SELECT 
            cp.area_line as line,
            ii.loan_id,
            ii.updated_date as loan_date,
            coll.cus_id,
            coll.req_id,
            coll.cus_name,
            al.area_name,
            sal.sub_area_name,
            (SELECT loan_category_creation_name From loan_category_creation WHERE loan_category_creation_id = lc.loan_category) as loan_cat_name,
            lc.sub_category,
            lc.due_type,
            lc.due_period,
            lc.principal_amt_cal,
            lc.int_amt_cal,
            (SELECT ag_name from agent_creation where ag_id = req.agent_id) as ag_name,
            req.user_type,
            req.user_name,
            coll.coll_date,
            coll.trans_date,
            coll.due_amt_track,
            coll.princ_amt_track,
            coll.int_amt_track,
            coll.penalty_track,
            coll.coll_charge_track,
            coll.total_paid_track,
            req.cus_status

            FROM collection coll
            JOIN acknowlegement_customer_profile cp ON coll.req_id = cp.req_id
            JOIN in_issue ii ON coll.req_id = ii.req_id
            JOIN area_list_creation al ON cp.area_confirm_area = al.area_id
            JOIN sub_area_list_creation sal ON cp.area_confirm_subarea = sal.sub_area_id
            JOIN acknowlegement_loan_calculation lc ON coll.req_id = lc.req_id
            JOIN request_creation req ON coll.req_id = req.req_id
            
            WHERE req.cus_status >= 14 and ".$where."
            and cp.area_confirm_subarea IN ($sub_area_list)
            ORDER BY coll.coll_date ASC
            ");

    $statusObj = [
        '14'=> 'Current',
        '15'=> 'Error',
        '16'=> 'Legal',
        '17'=> 'Current',
        '20'=> 'In Closed',
        '21'=> 'Closed',
    ]
?>


<table id="collection_report_table" class="table custom-table">
    <thead>
        <th>S.No</th>
        <th>Line</th>
        <th>Loan ID</th>
        <th>Loan Date</th>
        <th>Cust. ID</th>
        <th>Cust. Name</th>
        <th>Area</th>
        <th>Sub Area</th>
        <th>Loan Category</th>
        <th>Sub Category</th>
        <th>Agent</th>
        <th>User Type</th>
        <th>User</th>
        <th>Receipt Date</th>
        <th>Due Amount</th>
        <th>Principal Amount</th>
        <th>Interest Amount</th>
        <th>Penalty</th>
        <th>Fine</th>
        <th>Total Paid</th>
        <th>Status</th>
        <th>Sub Status</th>
    </thead>
    <tbody>
        <?php
                $i=1;
                $consider_lvl_arr = [1=>'Bronze',2=>'Silver',3=>'Gold',4=>'Platinum',5=>'Diamond'];
                while ($row = $qry->fetch_assoc()){
                    ?>
                    <tr>
                        <td><?php echo $i++; ?></td>
                        <td><?php echo $row['line']; ?></td>
                        <td><?php echo $row['loan_id']; ?></td>
                        <td><?php echo date('d-m-Y',strtotime($row['loan_date'])); ?></td>
                        <td><?php echo $row['cus_id']; ?></td>
                        <td><?php echo $row['cus_name']; ?></td>
                        <td><?php echo $row['area_name']; ?></td>
                        <td><?php echo $row['sub_area_name']; ?></td>
                        <td><?php echo $row['loan_cat_name']; ?></td>
                        <td><?php echo $row['sub_category']; ?></td>
                        <td><?php echo $row['ag_name']; ?></td>
                        <td><?php echo $row['user_type']; ?></td>
                        <td><?php echo $row['user_name']; ?></td>
                        <td>
                            <?php 
                                if($row['trans_date'] != '0000-00-00'){
                                    echo date('d-m-Y',strtotime($row['trans_date']));
                                }else{
                                    echo date('d-m-Y',strtotime($row['coll_date']));
                                }
                            ?>
                        </td>
                        <?php 
                            //if its not interest loan then we need to separate due paid amt by princ and interest to show
                            if($row['due_type'] != 'Interest'){
                            //to get the principal and interest amt separate in due amt paid
                            $response = calculatePrincipalAndInterest(intVal($row['principal_amt_cal']/$row['due_period']),intVal($row['int_amt_cal'])/$row['due_period'],intVal($row['due_amt_track']));
                        ?>
                            <td><?php echo moneyFormatIndia($row['due_amt_track']); ?></td>
                            <td>
                                <?php 
                                    // echo moneyFormatIndia($response['principal_paid']); 
                                    $rounderd_princ = ceil($response['principal_paid'] / 5) * 5; //to increase principal to nearest multiple of 5
                                    if ($rounderd_princ < $response['principal_paid']) {
                                        $rounderd_princ += 5;
                                    }
                                    echo moneyFormatIndia($rounderd_princ); 
                                ?>
                            </td>
                            <td>
                                <?php 
                                    $rounderd_int = intVal($row['due_amt_track']) - $rounderd_princ;
                                    echo moneyFormatIndia($rounderd_int); 
                                ?>
                            </td>
                        <?php
                            }else{
                                //else if its interest loan we can empty due amt coz it will not be paid on that loan, direclty show princ and int
                        ?>
                            <td><?php echo ''; ?></td>
                            <td><?php echo moneyFormatIndia($row['princ_amt_track']); ?></td>
                            <td><?php echo moneyFormatIndia($row['int_amt_track']); ?></td>
                        <?php
                            }
                        ?>
                        <td><?php echo moneyFormatIndia($row['penalty_track']); ?></td>
                        <td><?php echo moneyFormatIndia($row['coll_charge_track']); ?></td>
                        <td><?php echo moneyFormatIndia($row['total_paid_track']); ?></td>

                        <?php if($row['cus_status'] >= '20'){ ?>
                            <td><?php echo 'Closed'; ?></td>
                            <td><?php
                                $closedSts = $con->query("SELECT * FROM `closed_status` WHERE `req_id` ='".strip_tags($row['req_id'])."' ");
                                if($closedSts->num_rows > 0){
                                    $closedStsrow = $closedSts->fetch_assoc();
                                    $rclosed = $closedStsrow['closed_sts'];
                                    $consider_lvl = $closedStsrow['consider_level'];
                                    if($rclosed == '1'){echo 'Consider - '.$consider_lvl_arr[$consider_lvl]; }else
                                    if($rclosed == '2'){echo 'Waiting List';}else
                                    if($rclosed == '3'){echo 'Block List';}

                                }else{ echo $statusObj[$row['cus_status']]; }
                            ?></td>
                        <?php }else{ ?>
                            <td><?php echo 'Present'; ?></td>
                            <td><?php echo $statusObj[$row['cus_status']]; ?></td>
                        <?php } ?>
                    </tr>
                    <?php
                }
            ?>
    </tbody>
</table>

<?php
function moneyFormatIndia($num){
    $explrestunits = "";
    if (strlen($num) > 3) {
        $lastthree = substr($num, strlen($num) - 3, strlen($num));
        $restunits = substr($num, 0, strlen($num) - 3);
        $restunits = (strlen($restunits) % 2 == 1) ? "0" . $restunits : $restunits;
        $expunit = str_split($restunits, 2);
        for ($i = 0; $i < sizeof($expunit); $i++) {
            if ($i == 0) {
                $explrestunits .= (int)$expunit[$i] . ",";
            } else {
                $explrestunits .= $expunit[$i] . ",";
            }
        }
        $thecash = $explrestunits . $lastthree;
    } else {
        $thecash = $num;
    }
    return $thecash;
}

function calculatePrincipalAndInterest($principal,  $interest,  $paidAmount):array{
    $principal_paid = 0;
    $interest_paid = 0;
    
    while ($paidAmount > 0) {
        
        if ($paidAmount >= $principal) {
            $principal_paid += $principal;
            $paidAmount -= $principal;
        } else {
            $principal_paid += $paidAmount;
            break;
        }
        
        if ($paidAmount >= $interest) {
            $interest_paid += $interest;
            $paidAmount -= $interest;
        } else {
            $interest_paid += $paidAmount;
            break;
        }
    }
    
    return( [
        'principal_paid' => (int) $principal_paid,
        'interest_paid' => (int) $interest_paid
    ]);
}

?>


<script>
    $(document).ready(function () {
        $('#collection_report_table').DataTable({
            "title":"Collection Report",
            'processing': true,
            'iDisplayLength': 10,
            "lengthMenu": [
                [10, 25, 50, -1],
                [10, 25, 50, "All"]
            ],
            dom: 'lBfrtip',
            buttons: [{
                    extend: 'excel',
                },
                {
                    extend: 'colvis',
                    collectionLayout: 'fixed four-column',
                }
            ],
        });
    });
</script>


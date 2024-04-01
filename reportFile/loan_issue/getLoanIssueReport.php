<?php

session_start();
include '../../ajaxconfig.php';

$where = "1";

if(isset($_POST['from_date']) && isset($_POST['to_date']) && $_POST['from_date'] !='' && $_POST['to_date'] != ''){
    $from_date = date('Y-m-d',strtotime($_POST['from_date']));
    $to_date = date('Y-m-d',strtotime($_POST['to_date']));
    $where  = "(date(ii.updated_date) >= '".$from_date."') and (date(ii.updated_date) <= '".$to_date."') ";

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
            ii.loan_id,
            cp.*,
            fam.famname,
            fam.relationship,
            al.area_name,
            sal.sub_area_name,
            (SELECT loan_category_creation_name From loan_category_creation WHERE loan_category_creation_id = lc.loan_category) as loan_cat_name,
            lc.sub_category,
            (SELECT ag_name from agent_creation where ag_id = req.agent_id) as ag_name,
            ii.updated_date as loan_date,
            lc.loan_amt_cal,
            lc.principal_amt_cal,
            lc.int_amt_cal,
            lc.doc_charge_cal,
            lc.proc_fee_cal,
            lc.tot_amt_cal,
            lc.net_cash_cal,
            li.relationship as rec_relationship,
            (SELECT famname FROM verification_family_info WHERE relation_aadhar = li.cash_guarentor_name) as received_by,
            (SELECT relationship FROM verification_family_info WHERE relation_aadhar = li.cash_guarentor_name) as rel_name

            FROM in_issue ii
            JOIN acknowlegement_customer_profile cp ON ii.req_id = cp.req_id
            JOIN acknowlegement_loan_calculation lc ON ii.req_id = lc.req_id
            JOIN verification_family_info fam ON cp.guarentor_name = fam.id
            JOIN area_list_creation al ON cp.area_confirm_area = al.area_id
            JOIN sub_area_list_creation sal ON cp.area_confirm_subarea = sal.sub_area_id
            JOIN request_creation req ON ii.req_id = req.req_id
            JOIN loan_issue li ON li.req_id = ii.req_id
            
            WHERE ii.cus_status >= 14 and ".$where." 
            and cp.area_confirm_subarea IN ($sub_area_list)
            ");

    
?>


<table id="loan_issue_report_table" class="table custom-table">
    <thead>
        <th>S.No</th>
        <th>Loan ID</th>
        <th>Cust. ID</th>
        <th>Cust. Name</th>
        <th>Guarantor Name</th>
        <th>Relationship</th>
        <th>Area</th>
        <th>Sub Area</th>
        <th>Loan Category</th>
        <th>Sub Category</th>
        <th>Agent</th>
        <th>Loan Date</th>
        <th>Loan Amount</th>
        <th>Principal Amount</th>
        <th>Interest Amount</th>
        <th>Document Charge</th>
        <th>Processing Fee</th>
        <th>Total Amount</th>
        <th>Net Cash</th>
        <th>Received By</th>
        <th>Relation Name</th>
    </thead>
    <tbody>
        <?php
                $i=1;
                while ($row = $qry->fetch_assoc()){
                    ?>
                    <tr>
                        <td><?php echo $i++; ?></td>
                        <td><?php echo $row['loan_id']; ?></td>
                        <td><?php echo $row['cus_id']; ?></td>
                        <td><?php echo $row['cus_name']; ?></td>
                        <td><?php echo $row['famname']; ?></td>
                        <td><?php echo $row['relationship']; ?></td>
                        <td><?php echo $row['area_name']; ?></td>
                        <td><?php echo $row['sub_area_name']; ?></td>
                        <td><?php echo $row['loan_cat_name']; ?></td>
                        <td><?php echo $row['sub_category']; ?></td>
                        <td><?php echo $row['ag_name']; ?></td>
                        <td><?php echo date('d-m-Y', strtotime($row['loan_date'])); ?></td>
                        <td><?php echo moneyFormatIndia($row['loan_amt_cal']); ?></td>
                        <td><?php echo moneyFormatIndia($row['principal_amt_cal']); ?></td>
                        <td><?php echo moneyFormatIndia($row['int_amt_cal']); ?></td>
                        <td><?php echo moneyFormatIndia($row['doc_charge_cal']); ?></td>
                        <td><?php echo moneyFormatIndia($row['proc_fee_cal']); ?></td>
                        <td><?php echo moneyFormatIndia($row['tot_amt_cal']); ?></td>
                        <td><?php echo moneyFormatIndia($row['net_cash_cal']); ?></td>
                        <?php
                            if($row['rec_relationship'] == 'Customer'){
                                //if loan issued to customer then direclty place customer name from cp table
                        ?>
                            <td><?php echo $row['cus_name']; ?></td>
                            <td><?php echo 'Customer'; ?></td>
                        <?php 
                            }else{
                                //else place received by and relation name from fam table
                        ?>
                            <td><?php echo $row['received_by']; ?></td>
                            <td><?php echo $row['rel_name']; ?></td>
                        <?php 
                            }
                        ?>
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
?>


<script>
    $(document).ready(function () {
        $('#loan_issue_report_table').DataTable({
            "title":"Loan Issue Report",
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

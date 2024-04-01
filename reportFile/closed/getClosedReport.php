<?php

session_start();
include '../../ajaxconfig.php';

$where = "1";

if(isset($_POST['from_date']) && isset($_POST['to_date']) && $_POST['from_date'] !='' && $_POST['to_date'] != ''){
    $from_date = date('Y-m-d',strtotime($_POST['from_date']));
    $to_date = date('Y-m-d',strtotime($_POST['to_date']));
    $where  = "(date(cs.created_date) >= '".$from_date."') and (date(cs.created_date) <= '".$to_date."') ";

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
            cp.cus_id,
            cp.cus_name,
            al.area_name,
            sal.sub_area_name,
            (SELECT loan_category_creation_name From loan_category_creation WHERE loan_category_creation_id = lc.loan_category) as loan_cat_name,
            lc.sub_category,
            lc.loan_amt_cal,
            lc.maturity_month,
            cs.created_date,
            (SELECT coll_location FROM collection where req_id = ii.req_id GROUP BY coll_location ORDER BY COUNT(coll_location) DESC LIMIT 1) as coll_format,
            cs.closed_sts,
            cs.consider_level

            FROM in_issue ii
            JOIN acknowlegement_customer_profile cp ON ii.req_id = cp.req_id
            JOIN acknowlegement_loan_calculation lc ON ii.req_id = lc.req_id
            JOIN area_list_creation al ON cp.area_confirm_area = al.area_id
            JOIN sub_area_list_creation sal ON cp.area_confirm_subarea = sal.sub_area_id
            JOIN closed_status cs ON ii.req_id = cs.req_id
            
            WHERE ii.cus_status >= 20 and ".$where."
            and cp.area_confirm_subarea IN ($sub_area_list)
            ");

    $closed_sts_arr = [
        '1'=> 'Consider',
        '2'=> 'Waiting List',
        '3'=> 'Block List'
    ];
    $closed_lvl_arr = [
        '1'=> 'Bronze',
        '2'=> 'Silver',
        '3'=> 'Gold',
        '4'=> 'Platinum',
        '5'=> 'Diamond'
    ] ;
?>


<table id="closed_report_table" class="table custom-table">
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
        <th>Loan Amount</th>
        <th>Maturity Date</th>
        <th>Closed Date</th>
        <th>Collection Format</th>
        <th>Status</th>
        <th>Sub Status</th>
    </thead>
    <tbody>
        <?php
                $i=1;
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
                        <td><?php echo moneyFormatIndia($row['loan_amt_cal']); ?></td>
                        <td><?php echo date('d-m-Y',strtotime($row['maturity_month'])); ?></td>
                        <td><?php echo date('d-m-Y',strtotime($row['created_date'])); ?></td>
                        <td><?php echo $row['coll_format']=='1'? 'By Self': 'On Spot'; ?></td>
                        <td><?php echo $closed_sts_arr[$row['closed_sts']]; ?></td>
                        <td><?php echo $closed_lvl_arr[$row['consider_level']]; ?></td>
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
        $('#closed_report_table').DataTable({
            "title":"Closed Report",
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

<?php
session_start();
include '../../ajaxconfig.php';


$where = "1";

if(isset($_POST['from_date']) && isset($_POST['to_date']) && $_POST['from_date'] !='' && $_POST['to_date'] != ''){
    $from_date = date('Y-m-d',strtotime($_POST['from_date']));
    $to_date = date('Y-m-d',strtotime($_POST['to_date']));
    $where  = "(date(req.dor) >= '".$from_date."') and (date(req.dor) <= '".$to_date."') ";

}

if(isset($_SESSION["userid"])){
    $userid = $_SESSION["userid"];
}
if($userid != 1){
    
    $userQry = $con->query("SELECT * FROM USER WHERE user_id = $userid ");
    while($rowuser = $userQry->fetch_assoc()){
        $group_id = $rowuser['group_id'];
    }
    $group_id = explode(',',$group_id);
    $sub_area_list = array();
    foreach($group_id as $group){
        $groupQry = $con->query("SELECT * FROM area_group_mapping where map_id = $group "); 
        $row_sub = $groupQry->fetch_assoc();
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
            req.*,
            al.area_name,
            sal.sub_area_name,
            lcc.loan_category_creation_name,
            (select ag_name from agent_creation where ag_id = req.agent_id) as ag_name

            FROM request_creation req 
            JOIN area_list_creation al ON req.area = al.area_id
            JOIN sub_area_list_creation sal ON req.sub_area = sal.sub_area_id
            JOIN loan_category_creation lcc ON req.loan_category = lcc.loan_category_creation_id

            WHERE ".$where." and 
            CASE 
                WHEN req.cus_status >= 10  THEN (select area_confirm_subarea from customer_profile where req_id = req.req_id) IN ($sub_area_list)
                WHEN req.cus_status < 10  THEN (select sub_area from request_creation where req_id = req.req_id) IN ($sub_area_list)
            END
        ");

    $statusLabels = [
        '0' => "In Request",
        '1' => 'In Verification',
        '2' => 'In Approval',
        '3' => 'In Acknowledgement',
        '4' => 'Cancel - Request',
        '5' => 'Cancel - Verification',
        '6' => 'Cancel - Approval',
        '7' => 'Cancel - Acknowledgement',
        '8' => 'Revoke - Request',
        '9' => 'Revoke - Verification',
        '10' => 'In Verification',
        '11' => 'In Verification',
        '12' => 'In Verification',
        '13' => 'In Issue',
        '14' => 'Collection',
        '15' => 'Collection Error',
        '16' => 'Collection Legal',
        '17' => 'Collection',
        '20' => 'Closed',
        '21' => 'NOC',
    ];
?>


<table id="request_report_table" class="table custom-table">
    <thead>
        <th>S.No</th>
        <th>Req. ID</th>
        <th>Req. Date</th>
        <th>Cust. ID</th>
        <th>Cust. Name</th>
        <th>Area</th>
        <th>Sub Area</th>
        <th>Loan Category</th>
        <th>Sub Category</th>
        <th>Loan Amount</th>
        <th>User Type</th>
        <th>User Name</th>
        <th>Agent</th>
        <th>Responsible</th>
        <th>Cust. Data</th>
        <th>Cust. Status</th>
        <!-- <th>Status</th>
        <th>Sub Status</th> -->
    </thead>
    <tbody>
        <?php
                $i=1;
                while ($row = $qry->fetch_assoc()){
                    ?>
                    <tr>
                    <td><?php echo $i++; ?></td>
                    <td><?php echo $row['req_code']; ?></td>
                    <td><?php echo date('d-m-Y',strtotime($row['dor'])); ?></td>
                    <td><?php echo $row['cus_id']; ?></td>
                    <td><?php echo $row['cus_name']; ?></td>
                    <td><?php echo $row['area_name']; ?></td>
                    <td><?php echo $row['sub_area_name']; ?></td>
                    <td><?php echo $row['loan_category_creation_name']; ?></td>
                    <td><?php echo $row['sub_category']; ?></td>
                    <td><?php echo moneyFormatIndia($row['loan_amt']); ?></td>
                    <td><?php echo $row['user_type']; ?></td>
                    <td><?php echo $row['user_name']; ?></td>
                    <td><?php echo $row['ag_name']; ?></td>
                    <td><?php echo ($row['responsible']==0)?'Yes':'No'; ?></td>
                    <td><?php echo $row['cus_data']; ?></td>
                    <!-- <td><?php echo $row['cus_data']; ?></td> -->
                    <td><?php echo $statusLabels[$row['cus_status']]; ?></td>
                    <!-- <td><?php echo $row['cus_data']; ?></td> -->
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
        $('#request_report_table').DataTable({
            "title":"Monthly Ledger",
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

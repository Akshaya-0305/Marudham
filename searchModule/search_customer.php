<?php
include '../ajaxconfig.php';

$cus_id = $_POST['cus_id'] ?? '';
$cus_name = $_POST['cus_name'] ?? '';
$area = $_POST['area'] ?? '';
$sub_area = $_POST['sub_area'] ?? '';
$mobile = $_POST['mobile'] ?? '';
$loan_id = $_POST['loan_id'] ?? '';

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

if ($cus_id != '') {
    $sql = "SELECT cus_id from customer_register WHERE cus_id LIKE '%$cus_id%' ";
} else if ($cus_name != '') {
    $sql = "SELECT cus_id from customer_register WHERE customer_name LIKE '%$cus_name%' ";
} else if ($mobile != '') {
    $sql = "SELECT cus_id from customer_register WHERE mobile1 LIKE '%$mobile%' or mobile2 LIKE '%$mobile%' ";
} else if ($area != '') {
    $sql = "SELECT cr.cus_id from area_list_creation ac 
        JOIN customer_register cr ON 
        CASE 
        WHEN (cr.area_confirm_area IS NOT NULL OR cr.area_confirm_area != '') THEN ac.area_id = cr.area_confirm_area 
        ELSE ac.area_id = cr.area 
        END
        WHERE ac.area_name LIKE '%$area%' GROUP BY cr.cus_id ";
} else if ($sub_area != '') {
    $sql = "SELECT cr.cus_id from sub_area_list_creation sac 
        JOIN customer_register cr ON 
        CASE 
        WHEN (cr.area_confirm_subarea IS NOT NULL OR cr.area_confirm_subarea != '') THEN sac.sub_area_id = cr.area_confirm_subarea 
        ELSE sac.sub_area_id = cr.sub_area
        END
        WHERE sac.sub_area_name LIKE '%$sub_area%' GROUP BY cr.cus_id ";
} else if ($loan_id != '') {
    $sql = "SELECT cus_id from in_issue where loan_id = '$loan_id' ";
}

// echo $sql;
$runSql = $con->query($sql);
if ($runSql->num_rows > 0) {
    while ($row = $runSql->fetch_assoc())
        $cus_id_fetched[] = $row['cus_id'];
} else {
    $cus_id_fetched = [];
}

if (!empty($cus_id_fetched)) {
    foreach ($cus_id_fetched as $cus_id) {
        $sql = $con->query("SELECT req_id,cus_id,cus_status From request_creation where cus_id = $cus_id ORDER BY req_id DESC LIMIT 1 ");
        $row = $sql->fetch_assoc();
        $req_id[] = $row['req_id'];
        $cus_status[] = $row['cus_status'];
    }
}
?>

<table class="table custom-table" id="custListTable">
    <thead>
        <tr>
            <th>S.No</th>
            <th>Customer ID</th>
            <th>Customer Name</th>
            <th>Area</th>
            <th>Sub Area</th>
            <th>Branch</th>
            <th>Line</th>
            <th>Group</th>
            <th>Mobile 1</th>
            <th>Mobile 2</th>
            <th>Action</th>
        </tr>
    </thead>
    <tbody>
        <?php
        $i = 1;
        $x = 0;
        if (!empty($req_id)) {
            foreach ($req_id as $req) {
                if ($cus_status[$x] == '0' || $cus_status[$x] == '1' || $cus_status[$x] == '4' || $cus_status[$x] == '5' || $cus_status[$x] == '8' || $cus_status[$x] == '9') {
                    $req_sql = $con->query("SELECT req.cus_id,req.cus_name,ac.area_name,sac.sub_area_name,bc.branch_name,alm.line_name,agm.group_name,req.mobile1,req.mobile2 
                        From request_creation req 
                        LEFT JOIN area_list_creation ac ON req.area = ac.area_id 
                        LEFT JOIN sub_area_list_creation sac ON req.sub_area = sac.sub_area_id 
                        LEFT JOIN area_line_mapping alm ON FIND_IN_SET(sac.sub_area_id,alm.sub_area_id)
                        LEFT JOIN area_group_mapping agm ON FIND_IN_SET(sac.sub_area_id,agm.sub_area_id)
                        LEFT JOIN branch_creation bc ON agm.branch_id = bc.branch_id 
                        where req.req_id = $req ");
                } else {
                    $req_sql = $con->query("SELECT cp.cus_id,cp.cus_name,ac.area_name,sac.sub_area_name,bc.branch_name,alm.line_name,agm.group_name,cp.mobile1,cp.mobile2 
                    FROM customer_profile cp
                    LEFT JOIN area_list_creation ac ON cp.area_confirm_area = ac.area_id 
                    LEFT JOIN sub_area_list_creation sac ON cp.area_confirm_subarea = sac.sub_area_id 
                    LEFT JOIN area_line_mapping alm ON FIND_IN_SET(sac.sub_area_id,alm.sub_area_id)
                    LEFT JOIN area_group_mapping agm ON FIND_IN_SET(sac.sub_area_id,agm.sub_area_id)
                    LEFT JOIN branch_creation bc ON agm.branch_id = bc.branch_id 
                    WHERE cp.req_id = $req  ");
                }
                $x++;
                while ($req_row = $req_sql->fetch_assoc()) {
        ?>
                    <tr>
                        <td><?php echo $i++; ?></td>
                        <td><?php echo $req_row['cus_id']; ?></td>
                        <td><?php echo $req_row['cus_name']; ?></td>
                        <td><?php echo $req_row['area_name']; ?></td>
                        <td><?php echo $req_row['sub_area_name']; ?></td>
                        <td><?php echo $req_row['branch_name']; ?></td>
                        <td><?php echo $req_row['line_name']; ?></td>
                        <td><?php echo $req_row['group_name']; ?></td>
                        <td><?php echo $req_row['mobile1']; ?></td>
                        <td><?php echo $req_row['mobile2']; ?></td>
                        <td><input type="button" class="view_cust btn btn-primary" value="View" data-toggle="modal" data-target="#customerStatusModal" data-cusid="<?php echo $req_row['cus_id']; ?>"></td>
                    </tr>
        <?php
                }
            }
        }
        ?>
    </tbody>
</table>
<input type="hidden" name="pending_sts" id="pending_sts" value="" />
<input type="hidden" name="od_sts" id="od_sts" value="" />
<input type="hidden" name="due_nil_sts" id="due_nil_sts" value="" />
<input type="hidden" name="closed_sts" id="closed_sts" value="" />
<input type="hidden" name="bal_amt" id="bal_amt" value="" />
<script>
    // let table = $('#custListTable').DataTable();
    // table.destroy();
    // $('#custListTable').DataTable({
    //     'processing': true,
    //     'iDisplayLength': 5,
    //     "lengthMenu": [
    //         [10, 25, 50, -1],
    //         [10, 25, 50, "All"]
    //     ],
    //     dom: 'lBfrtip',
    //     buttons: [{
    //             extend: 'excel',
    //         },
    //         {
    //             extend: 'colvis',
    //             collectionLayout: 'fixed four-column',
    //         }
    //     ],
    // });
    viewCusOnClick();
</script>
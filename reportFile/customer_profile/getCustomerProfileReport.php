<?php
session_start();
include '../../ajaxconfig.php';

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
            cp.*,
            fam.famname,
            fam.relationship,
            al.area_name,
            sal.sub_area_name,
            reg.loan_limit,
            reg.how_to_know,
            reg.travel_with_company,
            reg.blood_group as reg_blood,
            req.cus_status

            FROM customer_profile cp
            JOIN verification_family_info fam ON cp.guarentor_name = fam.id
            JOIN area_list_creation al ON cp.area_confirm_area = al.area_id
            JOIN sub_area_list_creation sal ON cp.area_confirm_subarea = sal.sub_area_id
            JOIN customer_register reg ON cp.cus_id = reg.cus_id
            JOIN request_creation req ON cp.req_id = req.req_id
            
            WHERE cp.area_confirm_subarea IN ($sub_area_list)
            
            GROUP BY cp.cus_id
            ");

    $statusObj = [
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
    $how_to_know_obj = [
        '0' => 'Customer Reference',
        '1' => 'Advertisement',
        '2' => 'Promotion Activity',
        '3' => 'Agent Reference',
        '4' => 'Staff Reference',
        '5' => 'Other Reference',
    ];
    $occupationTypeObj = [
        0 => '',//for not mentioned occ type
        1 => 'Govt Job',
        2 => 'Pvt Job',
        3 => 'Business',
        4 => 'Self Employed',
        5 => 'Daily wages',
        6 => 'Agriculture',
        7 => 'Others'
    ];
    $residentialTypeObj = [
        4 => '',//for not mentioned resident type
        0 => 'Own',
        1 => 'Rental',
        2 => 'Lease',
        3 => 'Quarters'
    ];
?>


<table id="cust_profile_report_table" class="table custom-table">
    <thead>
        <th>S.No</th>
        <th>Cust. ID</th>
        <th>Cust. Name</th>
        <th>Guarantor Name</th>
        <th>Relationship</th>
        <th>Area</th>
        <th>Sub Area</th>
        <th>Mobile</th>
        <th>Cust. Limit</th>
        <th>Line</th>
        <th>Group</th>
        <th>How to Know</th>
        <th>Occupation type</th>
        <th>Detail</th>
        <th>Residential type</th>
        <th>Detail</th>
        <th>Travel with Company</th>
        <th>Blood Group</th>
        <th>Customer Status</th>
    </thead>
    <tbody>
        <?php
                $i=1;
                while ($row = $qry->fetch_assoc()){
                    ?>
                    <tr>
                    <td><?php echo $i++; ?></td>
                    <td><?php echo $row['cus_id']; ?></td>
                    <td><?php echo $row['cus_name']; ?></td>
                    <td><?php echo $row['famname']; ?></td>
                    <td><?php echo $row['relationship']; ?></td>
                    <td><?php echo $row['area_name']; ?></td>
                    <td><?php echo $row['sub_area_name']; ?></td>
                    <td><?php echo $row['mobile1']; ?></td>
                    <td><?php echo moneyFormatIndia($row['loan_limit']); ?></td>
                    <td><?php echo $row['area_line']; ?></td>
                    <td><?php echo $row['area_group']; ?></td>
                    <td><?php echo $how_to_know_obj[$row['how_to_know']]; ?></td>
                    <td>
                        <?php 
                            $row['occupation_type'] = $row['occupation_type']!=''?$row['occupation_type']:0;
                            echo $occupationTypeObj[$row['occupation_type']]; 
                        ?>
                    </td>
                    <td><?php echo $row['occupation_details']; ?></td>
                    <td>
                        <?php 
                            $row['residential_type'] = $row['residential_type']!=''?$row['residential_type']:4;
                            echo $residentialTypeObj[$row['residential_type']??4]; 
                        ?>
                    </td>
                    <td><?php echo $row['residential_details']; ?></td>
                    <td><?php echo $row['travel_with_company']; ?></td>
                    <td><?php echo ($row['reg_blood']!='')?$row['reg_blood']:$row['blood_group']; ?></td>
                    <td><?php echo $statusObj[$row['cus_status']]; ?></td>
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
        $('#cust_profile_report_table').DataTable({
            "title":"Customer Profile Report",
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

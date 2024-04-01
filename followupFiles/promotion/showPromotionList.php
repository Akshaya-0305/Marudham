<?php
include("../../ajaxconfig.php");
include("./promotionListClass.php");

$type = $_POST['type'];
$sno = 1;

$Obj = new promotionListClass($con);
$arr = $Obj->getdetails($con, $type);

if ($type == 'existing') {
    
    $orgin_table_id = 'existing';

    $sub_status = [1 => 'Bronze', 2 => 'Silver', 3 => 'Gold', 4 => 'Platinum', 5 => 'Diamond'];
} else {
    $orgin_table_id = 'repromotion';

    $status = [4 => 'Request', 5 => 'Verification', 6 => 'Approval', 7 => 'Acknowledgement', 8 => 'Request', 9 => 'Verification'];

    $sub_status = [4 => 'Cancel', 5 => 'Cancel', 6 => 'Cancel', 7 => 'Cancel', 8 => 'Revoke', 9 => 'Revoke'];
}
?>

<table class="table custom-table" id='promotion_list' data-id="<?php echo $orgin_table_id ?>">
    <thead>
        <th width='20'>S.No</th>
        <th>Customer ID</th>
        <th>Customer Name</th>
        <th>Area</th>
        <th>Sub Area</th>
        <th>Branch</th>
        <th>Group</th>
        <th>Line</th>
        <th>Mobile</th>
        <th>Status</th>
        <th>Sub Status</th>
        <?php if ($type != 'existing') { ?>
            <th>Remarks</th>
        <?php } ?> <!--show remarks only for repromotion -->
        <th>List Date</th>
        <th>View</th>
        <th>Action</th>
        <th>Follow Date</th>
    </thead>
    <tbody>

        <?php
        foreach ($arr as $val) {
            $sql = $con->query(
                "SELECT cp.*,al.area_name,sl.sub_area_name,bc.branch_name from customer_profile cp 
                LEFT JOIN area_list_creation al ON cp.area_confirm_area = al.area_id 
                LEFT JOIN sub_area_list_creation sl ON cp.area_confirm_subarea = sl.sub_area_id 
                LEFT JOIN area_group_mapping agm ON FIND_IN_SET(sl.sub_area_id,agm.sub_area_id)
                LEFT JOIN branch_creation bc ON agm.branch_id = bc.branch_id
                WHERE cp.cus_id = " . $val['cus_id'] . " ORDER BY cp.id DESC LIMIT 1"
            );
            if ($sql->num_rows == '0') {
                $sql = $con->query("SELECT cp.*,al.area_name,sl.sub_area_name,bc.branch_name,agm.group_name,alm.line_name from customer_register cp 
                        LEFT JOIN area_list_creation al ON cp.area = al.area_id 
                        LEFT JOIN sub_area_list_creation sl ON cp.sub_area = sl.sub_area_id 
                        LEFT JOIN area_group_mapping agm ON FIND_IN_SET(sl.sub_area_id,agm.sub_area_id)
                        LEFT JOIN area_line_mapping alm ON FIND_IN_SET(sl.sub_area_id,alm.sub_area_id)
                        LEFT JOIN branch_creation bc ON agm.branch_id = bc.branch_id
                        WHERE cp.cus_id = " . $val['cus_id'] . " ORDER BY cp.cus_reg_id DESC LIMIT 1");
            }
            $row = $sql->fetch_assoc();
            ?>
            <tr>
                <td>
                    <?php echo $sno;
                    $sno++; ?>
                </td>
                <td>
                    <?php echo $row['cus_id']; ?>
                </td>
                <td>
                    <?php echo $row['cus_name'] ?? $row['customer_name']; ?>
                </td>
                <td>
                    <?php echo $row['area_name']; ?>
                </td>
                <td>
                    <?php echo $row['sub_area_name']; ?>
                </td>
                <td>
                    <?php echo $row['branch_name']; ?>
                </td>
                <td>
                    <?php echo $row['area_group'] ?? $row['group_name']; ?>
                </td>
                <td>
                    <?php echo $row['area_line'] ?? $row['line_name']; ?>
                </td>
                <td>
                    <?php echo $row['mobile1']; ?>
                </td>

                <?php if ($type == 'existing') { ?>
                    <td>
                        <?php echo 'Consider'; ?>
                    </td>
                    <td>
                        <?php echo $sub_status[$val['sub_status']]; //fetched from closed status table above mentioned    ?>
                    </td>
                    <td>
                        <?php
                        $qry = $con->query("SELECT created_date FROM closed_status WHERE cus_id = '" . $row['cus_id'] . "' ORDER BY id DESC limit 1");
                        //take last closed date of this customer to show when this customer added to promotion list
                        if ($qry->num_rows > 0) {
                            $ldate = $qry->fetch_assoc()['created_date'];
                            echo date('d-m-Y', strtotime($ldate));
                        } else {
                            echo '';
                        }
                        ?>
                    </td>
                <?php } else { ?>
                    <td>
                        <?php echo $status[$val['sub_status']]; ?>
                    </td>
                    <td>
                        <?php echo $sub_status[$val['sub_status']]; //fetched from request table above mentioned     ?>
                    </td>
                    <?php if ($type != 'existing') { ?>
                        <td>
                            <?php
                            $qry = $con->query("SELECT prompt_remark FROM request_creation WHERE cus_id = '" . $row['cus_id'] . "' and prompt_remark != '' ORDER BY updated_date DESC limit 1");
                            if ($qry->num_rows > 0) {
                                echo $qry->fetch_assoc()['prompt_remark'];
                            } else {
                                echo '';
                            }
                            ?>
                        </td>
                    <?php } ?>

                    <td>
                        <?php echo date('d-m-Y', strtotime($val['last_updated_date'])); ?>
                    </td>
                <?php } ?>
                <td>
                    <?php
                    $action = "<div class='dropdown'><button class='btn btn-outline-secondary'><i class='fa'>&#xf107;</i></button><div class='dropdown-content'> ";

                    $action .= "<a class='promo-chart' data-id='" . $row['cus_id'] . "' data-toggle='modal' data-target='#promoChartModal'><span>Promotion Chart</span></a>
                        <a class='personal-info' data-toggle='modal' data-target='#personalInfoModal' data-cusid='" . $row['cus_id'] . "'><span>Personal Info</span></a>";
                    if ($type == 'existing') {
                        $action .= "<a class='cust-profile' data-reqid='" . $row['req_id'] . "' data-cusid='" . $row['cus_id'] . "'><span>Customer Profile</span></a>
                            <a class='loan-history' data-reqid='" . $row['req_id'] . "' data-cusid='" . $row['cus_id'] . "'><span>Loan History</span></a>
                            <a class='doc-history' data-reqid='" . $row['req_id'] . "' data-cusid='" . $row['cus_id'] . "'><span>Document History</span></a>";
                    }
                    $action .= "</div></div>";
                    echo $action;
                    ?>
                </td>
                <td>
                    <?php  //for intrest or not intrest choice to make
                        $action = "<div class='dropdown'><button class='btn btn-outline-secondary'><i class='fa'>&#xf107;</i></button><div class='dropdown-content'> ";

                        $action .= "<a class='intrest' data-toggle='modal' data-target='#addPromotion' data-id='" . $row['cus_id'] . "'><span>Interested</span></a>
                            <a class='not-intrest' data-toggle='modal' data-target='#addPromotion' data-id='" . $row['cus_id'] . "'><span>Not Interested</span></a>";

                        $action .= "</div></div>";
                        echo $action;
                        ?>
                </td>
                <td>
                    <?php
                    $qry = $con->query("SELECT follow_date FROM new_promotion WHERE cus_id = '" . $row['cus_id'] . "' ORDER BY created_date DESC limit 1");
                    //take last promotion follow up date inserted from new promotion table
                    if ($qry->num_rows > 0) {
                        $fdate = $qry->fetch_assoc()['follow_date'];
                        echo date('d-m-Y', strtotime($fdate));
                    } else {
                        echo '';
                    }
                    ?>
                </td>
            </tr>

        <?php }
        ?>

    </tbody>
</table>

<script>
    $('#promotion_list').dataTable({
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
    })

    let dropdownOpen = false;

    $('.dropdown').off('click').click(function (event) {
        event.preventDefault();
        if (!dropdownOpen) {
            $('.dropdown').not(this).removeClass('active');
            $(this).toggleClass('active');
            dropdownOpen = true;
        } else {
            dropdownOpen = false;
        }
    });

    $(document).click(function (event) {
        var target = $(event.target);
        if (!target.closest('.dropdown').length) {
            $('.dropdown').removeClass('active');
            dropdownOpen = false;
        }
    });

    $('.intrest, .not-intrest').click(function (event) {
        event.stopPropagation();
    });

    $('#promotion_list tbody tr').not('th').each(function () {
        let tddate = $(this).find('td:eq(14)').text(); // Get the text content of the 14th td element (Follow date)
        let datecorrection = tddate.split("-").reverse().join("-").replaceAll(/\s/g, ''); // Correct the date format
        let values = new Date(datecorrection); // Create a Date object from the corrected date
        values.setHours(0, 0, 0, 0); // Set the time to midnight for accurate date comparison

        let curDate = new Date(); // Get the current date
        curDate.setHours(0, 0, 0, 0); // Set the time to midnight for accurate date comparison

        let colors = { 'past': 'FireBrick', 'current': 'DarkGreen', 'future': 'CornflowerBlue' }; // Define colors for different date types

        if (tddate != '' && values != 'Invalid Date') { // Check if the extracted date and the created Date object are valid

            if (values < curDate) { // Compare the extracted date with the current date
                $(this).find('td:eq(14)').css({ 'background-color': colors.past, 'color': 'white' }); // Apply styling for past dates
            } else if (values > curDate) {
                $(this).find('td:eq(14)').css({ 'background-color': colors.future, 'color': 'white' }); // Apply styling for future dates
            } else {
                $(this).find('td:eq(14)').css({ 'background-color': colors.current, 'color': 'white' }); // Apply styling for the current date
            }
        }
    });

    $('#promotion_list tbody tr').not('th').each(function () {
        let tddate = $(this).find('td:eq(15)').text(); // Get the text content of the 15th td element (Follow date)
        let datecorrection = tddate.split("-").reverse().join("-").replaceAll(/\s/g, ''); // Correct the date format
        let values = new Date(datecorrection); // Create a Date object from the corrected date
        values.setHours(0, 0, 0, 0); // Set the time to midnight for accurate date comparison

        let curDate = new Date(); // Get the current date
        curDate.setHours(0, 0, 0, 0); // Set the time to midnight for accurate date comparison

        let colors = { 'past': 'FireBrick', 'current': 'DarkGreen', 'future': 'CornflowerBlue' }; // Define colors for different date types

        if (tddate != '' && values != 'Invalid Date') { // Check if the extracted date and the created Date object are valid

            if (values < curDate) { // Compare the extracted date with the current date
                $(this).find('td:eq(15)').css({ 'background-color': colors.past, 'color': 'white' }); // Apply styling for past dates
            } else if (values > curDate) {
                $(this).find('td:eq(15)').css({ 'background-color': colors.future, 'color': 'white' }); // Apply styling for future dates
            } else {
                $(this).find('td:eq(15)').css({ 'background-color': colors.current, 'color': 'white' }); // Apply styling for the current date
            }
        }
    });


</script>
<style>
    .dropdown-content {
        color: black;
    }

    @media (max-width: 598px) {
        #exCusDiv {
            overflow: auto;
        }
    }
</style>
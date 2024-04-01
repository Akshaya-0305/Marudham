<?php
session_start();
include('../../ajaxconfig.php');

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

//used two queries because some customers will not have submitted customer profile where true details will be given.
//fo those take details from request else use customer profile tables

$sql2 = $con->query("SELECT cp.*, rc.cus_status, rc.updated_date, alc.area_name, salc.sub_area_name, lcc2.loan_category_creation_name, rc.sub_category, vlc.sub_category, ac.ag_name, bc.branch_name, agm.group_name, alm.line_name FROM request_creation rc
    LEFT JOIN customer_profile cp ON cp.req_id = rc.req_id
    LEFT JOIN area_list_creation alc ON  cp.area_confirm_area = alc.area_id
    LEFT JOIN sub_area_list_creation salc ON  cp.area_confirm_subarea = salc.sub_area_id
    LEFT JOIN verification_loan_calculation vlc ON  cp.req_id = vlc.req_id
    LEFT JOIN loan_category_creation lcc2 ON  vlc.loan_category = lcc2.loan_category_creation_id
    LEFT JOIN agent_creation ac ON  rc.agent_id = ac.ag_id
    LEFT JOIN area_group_mapping agm ON FIND_IN_SET( cp.area_confirm_subarea, agm.sub_area_id )
    LEFT JOIN branch_creation bc ON agm.branch_id = bc.branch_id
    LEFT JOIN area_line_mapping alm ON FIND_IN_SET(  cp.area_confirm_subarea, alm.sub_area_id )
    WHERE
        (
            rc.cus_status > 1 AND rc.cus_status NOT IN(4, 5, 6, 7, 8, 9) AND rc.cus_status < 14
        ) and cp.area_confirm_subarea IN ($sub_area_list) 
    ");


$sql1 = $con->query("SELECT rc.*,alc.area_name,salc.sub_area_name,lcc.loan_category_creation_name, ac.ag_name, bc.branch_name,agm.group_name,alm.line_name FROM request_creation rc 
    LEFT JOIN area_list_creation alc ON rc.area = alc.area_id 
    LEFT JOIN sub_area_list_creation salc ON rc.sub_area = salc.sub_area_id 
    LEFT JOIN loan_category_creation lcc ON rc.loan_category = lcc.loan_category_creation_id 
    LEFT JOIN agent_creation ac ON rc.agent_id = ac.ag_id
    LEFT JOIN area_group_mapping agm ON FIND_IN_SET(rc.sub_area,agm.sub_area_id)
    LEFT JOIN branch_creation bc ON agm.branch_id = bc.branch_id
    LEFT JOIN area_line_mapping alm ON FIND_IN_SET(rc.sub_area,alm.sub_area_id)
    WHERE 
        (rc.cus_status >= 0  AND rc.cus_status <= 1 ) and
        ( rc.sub_area IN ($sub_area_list) or 
        (select area_confirm_subarea from customer_profile where req_id = rc.req_id) IN (".$sub_area_list.") )
    ");
//this query will get all the request which are raised in request and shows till loan gets issued.
//this query will not result entries which are cancelled or revoked

$stage_arr = [
    0=>'Request',
    1=>'Verification',
    10=>'Verification',
    11=>'Verification',
    12=>'Verification',
    2=>'Approval',
    3=>'Acknowledgement',
    13=>'Loan Issue',
];
$sno = 1;
?>


<table class="table custom-table" id='loan_follow_table'>
    <thead>
        <th>S.No</th>
        <th>Date</th>
        <th>Customer ID</th>
        <th>Customer Name</th>
        <!-- <th>Mobile No.</th> -->
        <th>Area</th>
        <th>Sub Area</th>
        <th>Loan Category</th>
        <th>Sub Category</th>
        <th>Agent</th>
        <th>Branch</th>
        <th>Group</th>
        <th>Line</th>
        <th>View</th>
        <th>Action</th>
        <th>Follow Date</th>
    </thead>
    <tbody>
        <?php while($row =  $sql1->fetch_assoc()){?>
            <tr>
                <td><?php echo $sno; $sno++; ?></td>
                <td><?php echo date('d-m-Y',strtotime($row['updated_date'])); ?></td>
                <td><?php echo $row['cus_id'] ; ?></td>
                <td><?php echo $row['cus_name']; ?></td>
                <!-- <td><?php echo $row['mobile1']; ?></td> -->
                <td><?php echo $row['area_name']; ?></td>
                <td><?php echo $row['sub_area_name']; ?></td>
                <td><?php echo $row['loan_category_creation_name']; ?></td>
                <td><?php echo $row['sub_category']; ?></td>
                <td><?php echo $row['ag_name']; ?></td>
                <td><?php echo $row['branch_name']; ?></td>
                <td><?php echo $row['group_name']; ?></td>
                <td><?php echo $row['line_name']; ?></td>
                <td>
                    <?php  
                        $action="<div class='dropdown'><button class='btn btn-outline-secondary'><i class='fa'>&#xf107;</i></button><div class='dropdown-content'> ";
                        
                        $action .= "<a class='loan-follow-chart' data-cusid='".$row['cus_id']."' data-toggle='modal' data-target='#loanFollowChartModal'><span>Loan Followup Chart</span></a>
                        <a class='personal-info' data-toggle='modal' data-target='#personalInfoModal' data-cusid='".$row['cus_id']."'><span>Personal Info</span></a>
                        <a class='cust-profile' data-reqid='".$row['req_id']."' data-cusid='".$row['cus_id']."'><span>Customer Profile</span></a>
                        <a class='loan-history' data-reqid='".$row['req_id']."' data-cusid='".$row['cus_id']."'><span>Loan History</span></a>
                        <a class='doc-history' data-reqid='".$row['req_id']."' data-cusid='".$row['cus_id']."'><span>Document History</span></a>";
                        
                        $action .= "</div></div>";

                        echo $action;

                    ?>
                </td>
                <td>
                    <?php 
                        //for Loan Followup edit
                        echo "<input type='button' class='btn btn-primary loan-follow-edit' data-cusid='".$row['cus_id']."' data-stage='".$stage_arr[$row['cus_status']]."' data-toggle='modal' data-target='#addLoanFollow' value='Follow' />";
                    ?>
                </td>
                <td>
                    <?php 
                    $qry = $con->query("SELECT follow_date FROM loan_followup WHERE cus_id = '".$row['cus_id']."' ORDER BY created_date DESC limit 1");
                    //take last promotion follow up date inserted from new promotion table
                    if($qry->num_rows > 0){
                        $fdate = $qry->fetch_assoc()['follow_date'];
                        echo date('d-m-Y',strtotime($fdate));
                    }else{
                        echo '';
                    }
                    ?></td>

            </tr>
        <?php } ?>
        <?php while($row =  $sql2->fetch_assoc()){?>
            <tr>
                <td><?php echo $sno; $sno++; ?></td>
                <td><?php echo date('d-m-Y',strtotime($row['updated_date'])); ?></td>
                <td><?php echo $row['cus_id'] ; ?></td>
                <td><?php echo $row['cus_name']; ?></td>
                <!-- <td><?php echo $row['mobile1']; ?></td> -->
                <td><?php echo $row['area_name']; ?></td>
                <td><?php echo $row['sub_area_name']; ?></td>
                <td><?php echo $row['loan_category_creation_name']; ?></td>
                <td><?php echo $row['sub_category']; ?></td>
                <td><?php echo $row['ag_name']; ?></td>
                <td><?php echo $row['branch_name']; ?></td>
                <td><?php echo $row['group_name']; ?></td>
                <td><?php echo $row['line_name']; ?></td>
                <td>
                    <?php  
                        $action="<div class='dropdown'><button class='btn btn-outline-secondary'><i class='fa'>&#xf107;</i></button><div class='dropdown-content'> ";
                        
                        $action .= "<a class='loan-follow-chart' data-cusid='".$row['cus_id']."' data-toggle='modal' data-target='#loanFollowChartModal'><span>Loan Followup Chart</span></a>
                        <a class='personal-info' data-toggle='modal' data-target='#personalInfoModal' data-cusid='".$row['cus_id']."'><span>Personal Info</span></a>
                        <a class='cust-profile' data-reqid='".$row['req_id']."' data-cusid='".$row['cus_id']."'><span>Customer Profile</span></a>
                        <a class='loan-history' data-reqid='".$row['req_id']."' data-cusid='".$row['cus_id']."'><span>Loan History</span></a>
                        <a class='doc-history' data-reqid='".$row['req_id']."' data-cusid='".$row['cus_id']."'><span>Document History</span></a>";
                        
                        $action .= "</div></div>";

                        echo $action;

                    ?>
                </td>
                <td>
                    <?php 
                        //for Loan Followup edit
                        echo "<input type='button' class='btn btn-primary loan-follow-edit' data-cusid='".$row['cus_id']."' data-stage='".$stage_arr[$row['cus_status']]."' data-toggle='modal' data-target='#addLoanFollow' value='Follow' />";
                    ?>
                </td>
                <td>
                    <?php 
                    $qry = $con->query("SELECT follow_date FROM loan_followup WHERE cus_id = '".$row['cus_id']."' ORDER BY created_date DESC limit 1");
                    //take last promotion follow up date inserted from new promotion table
                    if($qry->num_rows > 0){
                        $fdate = $qry->fetch_assoc()['follow_date'];
                        echo date('d-m-Y',strtotime($fdate));
                    }else{
                        echo '';
                    }
                    ?></td>

            </tr>
        <?php } ?>
    </tbody>
</table>

<script>
    $('#loan_follow_table').dataTable({
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
    $('.dropdown').click(function(event) {
        event.preventDefault();
        $('.dropdown').not(this).removeClass('active');
        $(this).toggleClass('active');
    });

    $(document).click(function(event) {
        var target = $(event.target);
        if (!target.closest('.dropdown').length) {
            $('.dropdown').removeClass('active');
        }
    });
    $('#loan_follow_table tbody tr').not('th').each(function(){
        let tddate = $(this).find('td:eq(14)').text(); // Get the text content of the 14th td element (Follow date)
        let datecorrection = tddate.split("-").reverse().join("-").replaceAll(/\s/g, ''); // Correct the date format
        let values = new Date(datecorrection); // Create a Date object from the corrected date
        values.setHours(0, 0, 0, 0); // Set the time to midnight for accurate date comparison

        let curDate = new Date(); // Get the current date
        curDate.setHours(0, 0, 0, 0); // Set the time to midnight for accurate date comparison

        let colors = {'past':'FireBrick','current':'DarkGreen','future':'CornflowerBlue'}; // Define colors for different date types

        if(tddate != '' && values != 'Invalid Date'){ // Check if the extracted date and the created Date object are valid

            if(values < curDate){ // Compare the extracted date with the current date
                $(this).find('td:eq(14)').css({'background-color':colors.past, 'color':'white'}); // Apply styling for past dates
            }else if(values > curDate){
                $(this).find('td:eq(14)').css({'background-color': colors.future, 'color':'white'}); // Apply styling for future dates
            }else {
                $(this).find('td:eq(14)').css({'background-color':colors.current, 'color':'white'}); // Apply styling for the current date
            }
        }
    });
</script>
<style>
    .dropdown-content{
        color: black;
    }
    @media (max-width: 598px) {
        #loanListDiv{
            overflow: auto;
        }
    }
    
</style>
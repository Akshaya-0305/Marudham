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

$sql = $con->query("SELECT rc.*,alc.area_name,salc.sub_area_name,lcc.loan_category_creation_name, ac.ag_name, bc.branch_name,agm.group_name,alm.line_name FROM request_creation rc 
LEFT JOIN area_list_creation alc ON rc.area = alc.area_id 
LEFT JOIN sub_area_list_creation salc ON rc.sub_area = salc.sub_area_id 
LEFT JOIN loan_category_creation lcc ON rc.loan_category = lcc.loan_category_creation_id 
LEFT JOIN agent_creation ac ON rc.agent_id = ac.ag_id
LEFT JOIN area_group_mapping agm ON FIND_IN_SET(rc.sub_area,agm.sub_area_id)
LEFT JOIN branch_creation bc ON agm.branch_id = bc.branch_id
LEFT JOIN area_line_mapping alm ON FIND_IN_SET(rc.sub_area,alm.sub_area_id)
WHERE rc.cus_status >= 14 and 
(select area_confirm_subarea from acknowlegement_customer_profile where req_id = rc.req_id LIMIT 1) IN (".$sub_area_list.") 
");
//this query will get all the request which are raised in request and shows till loan gets issued.
//this query will not result entries which are cancelled or revoked

$status_arr = [
    '1'=>'Completed',
    '2'=>'Unavailable',
    '3'=>'Reconfirmation'
];
$sno = 1;
?>


<table class="table custom-table" id='conf_follow_table'>
    <thead>
        <th>S.No</th>
        <th>Date</th>
        <th>Customer ID</th>
        <th>Customer Name</th>
        <th>Area</th>
        <th>Sub Area</th>
        <!-- <th>Loan Category</th> -->
        <!-- <th>Sub Category</th> -->
        <!-- <th>Agent</th> -->
        <th>Branch</th>
        <th>Group</th>
        <th>Line</th>
        <th>Mobile No.</th>
        <th>View</th>
        <th>Action</th>
        <th>Status</th>
    </thead>
    <tbody>
        <?php while($row =  $sql->fetch_assoc()){
                $req_id = $row['req_id'];
                $qry = $con->query("SELECT remove_status FROM confirmation_followup WHERE req_id = '".$req_id."' ORDER BY created_date DESC limit 1");
                $rst = $qry->fetch_assoc()['remove_status']??Null;
                if(mysqli_num_rows($qry) == 0 || $rst != 1){//show below contents only if confirmation of the request id is not removed from table already
            ?>
            <tr>
                <td><?php echo $sno; $sno++; ?></td>
                <td><?php echo date('d-m-Y',strtotime($row['updated_date'])); ?></td>
                <td><?php echo $row['cus_id'] ; ?></td>
                <td><?php echo $row['cus_name']; ?></td>
                <td><?php echo $row['area_name']; ?></td>
                <td><?php echo $row['sub_area_name']; ?></td>
                <!-- <td><?php echo $row['loan_category_creation_name']; ?></td> -->
                <!-- <td><?php echo $row['sub_category']; ?></td> -->
                <!-- <td><?php echo $row['ag_name']; ?></td> -->
                <td><?php echo $row['branch_name']; ?></td>
                <td><?php echo $row['group_name']; ?></td>
                <td><?php echo $row['line_name']; ?></td>
                <td><?php echo $row['mobile1']; ?></td>
                <td>
                    <?php  
                        $action="<div class='dropdown'><button class='btn btn-outline-secondary'><i class='fa'>&#xf107;</i></button><div class='dropdown-content'> ";
                        
                        $action .= "<a class='conf-chart' data-cusid='".$row['cus_id']."' data-reqid='".$row['req_id']."' data-toggle='modal' data-target='#confChartModal'><span>Confirmation Chart</span></a>
                        <a class='personal-info' data-toggle='modal' data-target='#personalInfoModal' data-cusid='".$row['cus_id']."'><span>Personal Info</span></a>
                        <a class='cust-profile' data-reqid='".$row['req_id']."' data-cusid='".$row['cus_id']."'><span>Customer Profile</span></a>
                        <a class='documentation' data-reqid='".$row['req_id']."' data-cusid='".$row['cus_id']."'><span>Documentation</span></a>
                        <a class='loan-calc' data-reqid='".$row['req_id']."' data-cusid='".$row['cus_id']."'><span>Loan Calculation</span></a>
                        <a class='loan-history' data-reqid='".$row['req_id']."' data-cusid='".$row['cus_id']."'><span>Loan History</span></a>
                        <a class='doc-history' data-reqid='".$row['req_id']."' data-cusid='".$row['cus_id']."'><span>Document History</span></a>";
                        
                        $action .= "</div></div>";

                        echo $action;

                    ?>
                </td>
                <td>
                    <?php 
                        //for Confirmation edit
                        $action="<div class='dropdown'><button class='btn btn-outline-secondary'><i class='fa'>&#xf107;</i></button><div class='dropdown-content'> ";

                        $qry = $con->query("SELECT `status` FROM confirmation_followup WHERE req_id = '".$row['req_id']."' ORDER BY created_date DESC limit 1");
                        if($qry->num_rows > 0){
                            $status = $qry->fetch_assoc()['status'];
                            if($status == '1'){//1 means completed
                                $action .= "<a class='conf-remove' data-cusid='".$row['cus_id']."' data-reqid='".$row['req_id']."' ><span>Remove</span></a>";
                            }else{
                                $action .= "<a class='conf-edit' data-cusid='".$row['cus_id']."' data-cusname='".$row['cus_name']."' data-reqid='".$row['req_id']."' data-toggle='modal' data-target='#addConfimation'><span>Confirmation</span></a>";
                            }
                        }else{
                            $action .= "<a class='conf-edit' data-cusid='".$row['cus_id']."' data-cusname='".$row['cus_name']."' data-reqid='".$row['req_id']."' data-toggle='modal' data-target='#addConfimation'><span>Confirmation</span></a>";
                        }

                        $action .= "</div></div>";

                        echo $action;
                    ?>
                </td>
                <td>
                    <?php 
                    $qry = $con->query("SELECT status FROM confirmation_followup WHERE req_id = '".$row['req_id']."' ORDER BY created_date DESC limit 1");
                    //take last confirmation follow up date inserted from confirmation table
                    if($qry->num_rows > 0){
                        $status = $qry->fetch_assoc()['status'];
                        echo $status_arr[$status];
                    }else{
                        echo 'In Confirmation';
                    }
                    ?></td>

            </tr>
        <?php } } ?>

    </tbody>
</table>

<script>
    $('#conf_follow_table').dataTable({
        'processing': true,
        'iDisplayLength': 20,
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
    
</script>
<style>
    .dropdown-content{
        color: black;
    }
    @media (max-width: 598px) {
        #confChartDiv{
            overflow: auto;
        }
    }
    
</style>
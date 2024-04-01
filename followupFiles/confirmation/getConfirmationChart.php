<?php

include('../../ajaxconfig.php');

$cus_id = $_POST['cus_id'];
$req_id = $_POST['req_id'];

$sql = $con->query("SELECT a.*,b.fullname, CASE b.role WHEN 1 then 'Director' when 2 then 'Agent' when 3 then 'Staff' end as role FROM confirmation_followup a 
        JOIN user b ON a.insert_login_id = b.user_id WHERE a.req_id = '$req_id'  ORDER BY a.id DESC "); //order by desc will show last entered data of confirmation table

//this query will take Confirmation followup data from that table with username and user type according to inserted login id and using switch case in query for output

$per_type_arr = [1=>'Customer',2=>'Garentor',3=>'Family Member'];
$status_arr = [1=>'Completed',2=>'Unavailable',3=>'Reconfirmation'];
$sub_status_arr = [1=>'RNR',2=>'Not Reachable',3=>'Switch off', 4=>'Blocked',5=>'Not in use'];
$sno = 1;

function getCustomer($con,$cus_id){
    $result = $con->query("SELECT customer_name from customer_register where cus_id = '$cus_id' ");
    $cus_name = $result->fetch_assoc()['customer_name'];
    return $cus_name;
}
function getGarentor($con,$req_id){
    $query = "SELECT cp.guarentor_name, vfi.famname, vfi.relationship FROM customer_profile cp JOIN verification_family_info vfi ON cp.guarentor_name = vfi.id WHERE cp.req_id = '$req_id'";
    $result = $con->query($query);
    $row = $result->fetch_assoc();
    
    $response = [
        "name" => $row['famname'],
        "relationship" => $row['relationship']
    ];
    return $response;
}

function getFamilyMember($con,$fam_id){
    
    $result = $con->query("SELECT id,famname,relationship FROM `verification_family_info` where id='$fam_id'");

    $row = $result->fetch_assoc();
    $fam_name = $row['famname'];
    $relationship = $row['relationship'];
    $response = array("name" => $fam_name, "relationship" => $relationship);
    return $response;
}

?>


<table class="table custom-table" id='conf_follow_chart'>
    <thead>
        <th width='20'>S No</th>
        <th>Date</th>
        <th>Person Type</th>
        <th>Person Name</th>
        <th>Relationship</th>
        <th>Mobile</th>
        <th>Upload</th>
        <th>Status</th>
        <th>Sub Status</th>
        <th>Label</th>
        <th>Remark</th>
    </thead>
    <tbody>
        <?php while($row =  $sql->fetch_assoc()){?>
            <tr>
                <td><?php echo $sno;$sno++; ?></td>
                <td><?php echo date('d-m-Y',strtotime($row['created_date'])); ?></td>
                <td><?php echo $per_type_arr[$row['person_type']]; ?></td>
                <td>
                    <?php 
                        if($row['person_type'] == 1){$person_name = getCustomer($con,$cus_id); echo $person_name; }else
                        if($row['person_type'] == 2){$person_name = getGarentor($con,$req_id); echo $person_name['name']; }else
                        if($row['person_type'] == 3){$person_name = getFamilyMember($con,$row['person_name']); echo $person_name['name'];}
                    ?>
                </td>
                <td>
                    <?php 
                        if($row['person_type'] == 1){echo 'NIL'; }else
                        if($row['person_type'] == 2){echo $person_name['relationship']; }else
                        if($row['person_type'] == 3){echo $person_name['relationship']; }
                    ?>
                </td>
                
                <td><?php echo $row['mobile']; ?></td>
                <td>
                    <?php 
                        if($row['upload'] != ''){
                            echo "<a href='uploads/confirmation_followup/".$row['upload']."' target='_blank'>View File</a>"; 
                        }
                    ?>
                </td>
                <td><?php echo $status_arr[$row['status']]; ?></td>
                
                <?php if($row['status'] == 1){?>

                    <td><?php echo ''; ?></td>
                    <td><?php echo ''; ?></td>
                    <td><?php echo ''; ?></td>

                <?php }else if($row['status'] == 2){?>

                    <td><?php echo $sub_status_arr[$row['sub_status']]; ?></td>
                    <td><?php echo ''; ?></td>
                    <td><?php echo ''; ?></td>

                <?php }else if($row['status'] == 3){?>
                    
                    <td><?php echo ''; ?></td>
                    <td><?php echo $row['label']; ?></td>
                    <td><?php echo $row['remark']; ?></td>

                <?php }
                ?>
                
            </tr>
        <?php } ?>

    </tbody>
</table>

<script>
    $('#conf_follow_chart').dataTable({
        'processing': true,
        'iDisplayLength': 5,
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
    
</script>
<style>
    @media (max-width: 598px) {
        #loanFollowChartDiv{
            overflow: auto;
        }
    }
</style>
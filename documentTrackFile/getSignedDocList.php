<?php
include('../ajaxconfig.php');
if(isset($_POST['req_id'])){
    $req_id = $_POST['req_id'];
}
if(isset($_POST['cus_name'])){
    $cus_name = $_POST['cus_name'];
}

function getfamName($con,$rel_id){
    $qry1=$con->query("SELECT famname FROM `verification_family_info` where id=$rel_id");
    $run=$qry1->fetch_assoc();
    return $run['famname'];
}
function getGuarentorName($con,$req_id){
    $qry1=$con->query("SELECT famname FROM `verification_family_info` a JOIN `acknowlegement_customer_profile` b on b.guarentor_name = a.id where b.req_id=$req_id");
    $run=$qry1->fetch_assoc();
    return $run['famname'];
}

?>
<table class="table custom-table" id='signDocTable'>
    <thead>
        <tr>
            <th>S.No</th>
            <th>Doc Name</th>
            <th>Sign Type</th>
            <th>Name</th>
            <th>Document</th>
        </tr>
    </thead>
    <tbody>
        <?php
        $i=1;
        $qry = $con->query("SELECT a.doc_name,a.sign_type,a.signType_relationship,b.id,b.upload_doc_name,b.noc_given,b.noc_date,b.noc_person,b.noc_name FROM `signed_doc_info` a join signed_doc b on a.id = b.signed_doc_id  where b.req_id = $req_id  ");
        while($row = $qry->fetch_assoc()){
            $rel_id = $row['signType_relationship'];
            $name ='';
        ?>
            <tr>
                <td><?php echo $i;$i++;?></td>
                <td><?php if($row['doc_name'] == '0'){echo 'Promissory Note';}elseif($row['doc_name'] == '1'){echo 'Stamp Paper';}elseif($row['doc_name'] == '2'){echo 'P Additional';}elseif($row['doc_name'] == '3'){echo 'S Additional';}?></td>
                <td><?php if($row['sign_type'] == '0'){echo 'Customer'; $name=$cus_name;}elseif($row['sign_type'] == '1'){echo 'Guarentor';$name = getGuarentorName($con,$req_id);}
                            elseif($row['sign_type'] == '2'){echo 'Combined';}elseif($row['sign_type'] == '3'){echo 'Family Member'; $name = getfamName($con,$rel_id);} ?></td>
                <td><?php echo $name;?></td>
                <td><a href='<?php echo 'uploads/verification/signed_doc/'.$row['upload_doc_name'];?>' target="_blank"><?php echo $row['upload_doc_name'];?></a></td>

            </tr>
        <?php
        }
        ?>

    </tbody>
</table>


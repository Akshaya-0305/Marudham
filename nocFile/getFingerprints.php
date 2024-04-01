<?php
include('../ajaxconfig.php');

if(isset($_POST['id'])){
    $id = $_POST['id'];
}
if(isset($_POST['family'])){
    $family = $_POST['family'];
}

$records = array();
if($family == 'true'){
    $qry = $con->query("SELECT fp.ansi_template FROM verification_family_info fam JOIN fingerprints fp on fam.relation_aadhar = fp.adhar_num  WHERE fam.id='$id' ");
    $row = $qry->fetch_assoc();
    $records['fingerprint'] = $row['ansi_template'];
}else{
    $qry = $con->query("SELECT ansi_template FROM fingerprints WHERE adhar_num='$id' ");
    $row = $qry->fetch_assoc();
    $records['fingerprint'] = $row['ansi_template'];
}

echo json_encode($records);
?>
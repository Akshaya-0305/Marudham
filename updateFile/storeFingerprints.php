<?php
session_start();

include '../ajaxconfig.php';

$userid = $_SESSION['userid'];

$fdata = $_POST['fdata'];
$hand = $_POST['hand'];
$cus_id = $_POST['cus_id'];
$cus_name = $_POST['cus_name'];

$checkqry = $con->query("SELECT * from fingerprints where adhar_num = $cus_id ");
if($checkqry->num_rows > 0){

    $qry = $con->query("UPDATE `fingerprints` SET `hand`='".$hand."',`ansi_template`='".$fdata."',`update_user_id`='$userid',`updated_date`= now() WHERE `adhar_num`='".strip_tags($cus_id)."' ");

}else{

    $qry = $con->query("INSERT INTO `fingerprints`(`adhar_num`, `name`,`hand`,`ansi_template`, `insert_user_id`, `created_date`) VALUES ('".$cus_id."','".$cus_name."','".$hand."','".$fdata."',$userid,now() ) ");

}


if($qry){
    $response = "Submitted Successfully";
}else{
    $response = "Error";
}

echo json_encode($response);
?>
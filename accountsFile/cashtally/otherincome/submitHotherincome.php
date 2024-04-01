<?php
session_start();
$user_id = $_SESSION['userid'];

include('../../../ajaxconfig.php');

$cat_info = $_POST['cat_info'];
$remark = $_POST['remark'];
$amt = $_POST['amt'];
$op_date = date('Y-m-d',strtotime($_POST['op_date']));


$qry = $con->query("INSERT INTO `ct_cr_hoti`(`category`, `remark`, `amt`, `insert_login_id`, `created_date`) 
VALUES ('$cat_info','$remark','$amt','$user_id','$op_date')");

if($qry){
    $response = "Submitted Successfully";
}else{
    $response = "Error While Submitting";
}

echo $response;

?>
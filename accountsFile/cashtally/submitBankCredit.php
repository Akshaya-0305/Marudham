<?php
session_start();
$user_id = $_SESSION['userid'];

include('../../ajaxconfig.php');

$bank_id = $_POST['bank_id'];
$credited_amt = $_POST['credited_amt'];
$op_date = date('Y-m-d',strtotime($_POST['op_date']));

$qry=$con->query("SELECT created_date from ct_bank_collection where bank_id = '$bank_id' and date(created_date) = '$op_date'");
// check whether today's date has been already entered
if($qry->num_rows == 0){

    $qry = $con->query("INSERT INTO `ct_bank_collection`( `bank_id`, `credited_amt`, `insert_login_id`, `created_date` ) VALUES ( '$bank_id','$credited_amt','$user_id','$op_date' )");

    if($qry){
        $response = "Submitted Successfully";
    }else{
        $response = "Error While Submit";
    }
}else{
    $response = "Today's Collection Already Submitted";
}

echo $response;
?>
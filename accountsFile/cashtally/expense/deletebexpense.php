<?php

include('../../../ajaxconfig.php');

$bexp_id = $_POST['bexp_id'];

$qry = $con->query("SELECT * from ct_db_bexpense where id='$bexp_id' ");
$upd = $qry->fetch_assoc()['upload'];
if($upd != ''){
    unlink('../../../uploads/expenseBill/'.$upd);
}

$qry = $con->query("DELETE  from ct_db_bexpense where id = '$bexp_id' ");
if($qry){
    $response = "Deleted Successfully";
}else{
    $response = "Error While Deleting";
}

echo $response;
?>
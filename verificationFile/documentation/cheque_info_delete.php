<?php
include '../../ajaxconfig.php';

$id = $_POST['chequeid'];

 
$delct = $connect->query("DELETE FROM `cheque_info` WHERE id = '$id' ");

	if($delct){
		$message=" cheque Info Deleted Successfully";
	}


echo json_encode($message);
?>
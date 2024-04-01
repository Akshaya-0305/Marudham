<?php
include '../ajaxconfig.php';

if(isset($_POST["area_id"])){
	$area_id  = $_POST["area_id"];
}
$isdel = '';

$ctqry=$con->query("SELECT * FROM area_creation WHERE area_name_id = '".$area_id."' and status =0 ");
while($row=$ctqry->fetch_assoc()){
	$isdel=$row["area_creation_id"];
}

if($isdel != ''){ 
	$message="You Don't Have Rights To Delete This Area";
}
else
{ 
	$delct=$con->query("UPDATE area_list_creation SET status = 1 WHERE area_id = '".$area_id."' ");
	if($delct){
		$message="Area Inactivated Successfully";
	}
}

echo json_encode($message);
?>
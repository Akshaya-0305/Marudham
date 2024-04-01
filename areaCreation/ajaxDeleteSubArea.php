<?php
include '../ajaxconfig.php';

if(isset($_POST["sub_area_id"])){
	$sub_area_id  = $_POST["sub_area_id"];
}
$isdel = '';

$ctqry=$con->query("SELECT * FROM area_creation where FIND_IN_SET($sub_area_id,sub_area) and status=0 ");
while($row=$ctqry->fetch_assoc()){
	$isdel=$row["area_creation_id"];
}

if($isdel != ''){ 
	$message="You Don't Have Rights To Delete This Sub Area";
}
else
{ 
	$delct=$con->query("UPDATE sub_area_list_creation SET status = 1 WHERE sub_area_id = '".$sub_area_id."' ");
	if($delct){
		$message="Sub Area Inactivated Successfully";
	}
}

echo json_encode($message);
?>
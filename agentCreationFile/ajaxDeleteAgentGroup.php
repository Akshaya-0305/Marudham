<?php
include '../ajaxconfig.php';

if(isset($_POST["agent_group_id"])){
	$agent_group_id  = $_POST["agent_group_id"];
}
$isdel = '';

$ctqry=$con->query("SELECT * FROM agent_creation WHERE ag_group_id = '".$agent_group_id."' ");
while($row=$ctqry->fetch_assoc()){
	$isdel=$row["ag_id"];
}

if($isdel != ''){ 
	$message="You Don't Have Rights To Delete This Agent Group";
}
else
{ 
	$delct=$con->query("UPDATE agent_group_creation SET status = 1 WHERE agent_group_id = '".$agent_group_id."' ");
	if($delct){
		$message="Agent Group Inactivated Successfully";
	}
}

echo json_encode($message);
?>
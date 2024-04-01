<?php
include('../ajaxconfig.php');
if(isset($_POST["ag_name"])){
    $ag_name = $_POST["ag_name"];
}

$message = "";
$selectIC = $con->query("SELECT * FROM agent_group_creation WHERE agent_group_name = '".$ag_name."' and status=0 ");
if($selectIC->num_rows>0)
{
    $message="Already Exist";
}

echo $message;
?>

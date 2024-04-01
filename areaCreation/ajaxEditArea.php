<?php
include '../ajaxconfig.php';

if(isset($_POST["area_id"])){
	$area_id  = $_POST["area_id"];
}

$getct = "SELECT * FROM area_list_creation WHERE area_id = '".$area_id."' AND status=0";
$result = $con->query($getct);
while($row=$result->fetch_assoc())
{
    $area_name = $row['area_name'];
}

echo $area_name;
?>
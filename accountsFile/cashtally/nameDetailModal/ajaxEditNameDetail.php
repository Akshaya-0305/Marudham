<?php
include '../../../ajaxconfig.php';

if(isset($_POST["name_id"])){
	$name_id  = $_POST["name_id"];
}

$records = array();

$qry = "SELECT * FROM name_detail_creation WHERE name_id = '".$name_id."' AND status=0";
$result = $con->query($qry);
while($row=$result->fetch_assoc())
{
    $records['name'] = $row['name'];
    $records['area'] = $row['area'];
    $records['ident'] = $row['ident'];
}

echo json_encode($records);
?>
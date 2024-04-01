<?php
include '../ajaxconfig.php';

if(isset($_POST["loan_category_creation_id"])){
	$loan_category_creation_id  = $_POST["loan_category_creation_id"];
}

$getct = "SELECT * FROM loan_category_creation WHERE loan_category_creation_id = '".$loan_category_creation_id."' AND status=0";
$result = $con->query($getct);
while($row=$result->fetch_assoc())
{
    $loan_category_creation_name = $row['loan_category_creation_name'];
}

echo $loan_category_creation_name;
?>
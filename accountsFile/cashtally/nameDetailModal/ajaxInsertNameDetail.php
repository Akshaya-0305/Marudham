<?php
session_start();
$user_id = $_SESSION['userid'];

include '../../../ajaxconfig.php';

if (isset($_POST['name_id'])) {
    $name_id = $_POST['name_id'];
}
if (isset($_POST['name'])) {
    $name = $_POST['name'];
}
if (isset($_POST['area'])) {
    $area = $_POST['area'];
}
if (isset($_POST['ident'])) {
    $ident = $_POST['ident'];
}


$nameCheck='';
$name_sts='';
$qry=$con->query("SELECT * FROM name_detail_creation WHERE name = '".$name."' ");
while ($row=$qry->fetch_assoc()){
	$nameCheck    = $row["name"];
	$name_sts  = $row["status"];
}

if($nameCheck != '' && $name_sts == 0){
	$message="Name Detail Already Exists, Please Enter a Different Name!";
}
else if($nameCheck != '' && $name_sts == 1){
	$qry=$con->query("UPDATE name_detail_creation SET status=0 WHERE name='".$name."' ");
	$message="Name Detail Added Succesfully";
}
else{
	if($name_id>0){
		$qry=$con->query("UPDATE name_detail_creation SET name='".$name."' WHERE name_id='".$name_id."' ");
		if($qry == true){
		    $message="Name Detail Updated Succesfully";
	    }
    }
	else{
	    $qry=$con->query("INSERT INTO name_detail_creation(name,area,ident,insert_login_id) VALUES('".strip_tags($name)."','".strip_tags($area)."','".strip_tags($ident)."','$user_id')");
	    if($qry == true){
		    $message="Name Detail Added Succesfully";
	    }
    }
}

echo json_encode($message);
?>
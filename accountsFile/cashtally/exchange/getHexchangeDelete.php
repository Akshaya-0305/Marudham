<?php
include("../../../ajaxconfig.php");

$hex_id = $_POST['hex_id'];

$qry = $con->query("delete from ct_db_hexchange where id='$hex_id' ");

if($qry){
    $response = "Deleted Successfully";
}else{
    $response = "Error while Deleting";
}

echo $response;
?>
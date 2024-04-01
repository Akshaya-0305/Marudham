<?php
require '../ajaxconfig.php';

if(isset($_POST['reqId'])){
    $reqId = $_POST['reqId'];
}
if(isset($_POST['cus_id'])){
    $cus_id = preg_replace('/\D/', '', $_POST['cus_id']);
}

$records = array();
$run = $connect -> query("SELECT famname FROM `verification_family_info` WHERE cus_id = '".$cus_id."' ");
$cnt = $run->rowCount();
if($cnt > 0){
    while($row = $run->fetch()){
        $records[] = $row['famname'];
    }
}

echo json_encode($records);
?>



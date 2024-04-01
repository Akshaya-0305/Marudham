<?php
include('../../ajaxconfig.php');


$i=0;
$records = array();

$qry = $con->query("SELECT * from name_detail_creation ");
while($row = $qry->fetch_assoc()){
    $records[$i]['name_id'] = $row['name_id'];
    $records[$i]['name'] = $row['name'];
    $records[$i]['area'] = $row['area'];
    $records[$i]['ident'] = $row['ident'];
    $i++;
}


echo json_encode($records);
?>
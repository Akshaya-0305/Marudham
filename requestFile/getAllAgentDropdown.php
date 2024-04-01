<?php 
include('../ajaxconfig.php');


$detailrecords = array();

$i=0;
    $qry = $con->query("SELECT * From agent_creation where status = 0 ");
    while($row = $qry->fetch_assoc()){
        $detailrecords[$i]['ag_id'] = $row['ag_id'];
        $detailrecords[$i]['ag_name'] = $row['ag_name'];
        $i++;
    }

echo json_encode($detailrecords);
?>
<?php 
include('../../ajaxconfig.php');

if(isset($_POST['scheme_id'])){
    $scheme_id = $_POST['scheme_id'];
}
$detailrecords = array();


$result=$con->query("SELECT * FROM loan_scheme where scheme_id = '".strip_tags($scheme_id)."' ");
$i=0;
while($row = $result->fetch_assoc()){
    $detailrecords['intrest_rate'] = $row['intrest_rate'];
    $detailrecords['due_period'] = $row['due_period'];
    $detailrecords['doc_charge_type'] = $row['doc_charge_type'];
    $detailrecords['doc_charge_min'] = $row['doc_charge_min'];
    $detailrecords['doc_charge_max'] = $row['doc_charge_max'];
    $detailrecords['proc_fee_type'] = $row['proc_fee_type'];
    $detailrecords['proc_fee_min'] = $row['proc_fee_min'];
    $detailrecords['proc_fee_max'] = $row['proc_fee_max'];
    $i++;
}


echo json_encode($detailrecords);
?>
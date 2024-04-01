<?php 
include('../ajaxconfig.php');

if(isset($_POST['lc_id'])){
    $lc_id = $_POST['lc_id'];
}

$detailrecords = array();

    $qry = $con->query("SELECT * From loan_category_creation where loan_category_creation_id = '".$lc_id."' ");
    $row = $qry->fetch_assoc();
    $detailrecords[] = $row['loan_category_creation_name'];
 
echo json_encode($detailrecords);
?>
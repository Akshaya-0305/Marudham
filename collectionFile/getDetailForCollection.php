<?php 
include('../ajaxconfig.php');

if (isset($_POST['req_id'])) {
    $req_id = $_POST['req_id'];
}

$records = array();

$selectIC = $con->query("SELECT lc.loan_category,lc.sub_category FROM acknowlegement_loan_calculation lc JOIN in_issue ii ON lc.req_id = ii.req_id WHERE ii.req_id = '".$req_id."' and ii.cus_status = '14'  ");
if($selectIC->num_rows>0)
{
    $row = $selectIC->fetch_assoc();
    $records['loan_category'] = $row["loan_category"];
    $records['sub_category'] = $row["sub_category"];
}

echo json_encode($records);
?>
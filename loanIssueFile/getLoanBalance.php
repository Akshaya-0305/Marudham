<?php
include('../ajaxconfig.php');

if(isset($_POST['req_id'])){
    $req_id = $_POST['req_id'];
}

$detailrecords = array();

    $qry = $con->query("SELECT balance_amount,net_cash FROM `loan_issue` WHERE req_id='".$req_id."' order by id desc LIMIT 1");
    $rowCnt = mysqli_num_rows($qry);
    if($rowCnt > 0){
    $row = $qry->fetch_assoc();
    $detailrecords['rowCnt'] = $rowCnt;
    $detailrecords['balance_amount'] = $row['balance_amount'];
    }else{
        $detailrecords['rowCnt'] = $rowCnt;
        $detailrecords['balance_amount'] = '0';
    }
    
echo json_encode($detailrecords);

?>
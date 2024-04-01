<?php 
session_start();
include('../ajaxconfig.php');
if (isset($_POST['req_id'])) {
    $req_id = $_POST['req_id'];
}
if (isset($_SESSION['userid'])) {
    $userid = $_SESSION['userid'];
}

//////////////////////////////////////////////////////////////////////////
$myStr = "LID";
$selectIC = $con->query("SELECT loan_id FROM in_issue WHERE loan_id != '' ");
if($selectIC->num_rows>0)
{
    $codeAvailable = $con->query("SELECT loan_id FROM in_issue WHERE (loan_id != '' or loan_id != NULL) ORDER BY id DESC LIMIT 1");
    while($row = $codeAvailable->fetch_assoc()){
        $ac2 = $row["loan_id"];
    }
    $appno2 = ltrim(strstr($ac2, '-'), '-'); $appno2 = $appno2+1;
    $loan_id = $myStr."-". "$appno2";
}
else
{
    $initialapp = $myStr."-101";
    $loan_id = $initialapp;
}
//////////////////////////////////////////////////////////////////////////

//Issue  Completed And Move to Collection = 14.

    $selectIC = $con->query("UPDATE request_creation set cus_status = 14, updated_date = now(),update_login_id = $userid WHERE  req_id = '".$req_id."' ") or die('Error on Request Table');
    $selectIC = $con->query("UPDATE customer_register set cus_status = 14 WHERE req_ref_id = '".$req_id."' ")or die('Error on Customer Table');
    $selectIC = $con->query("UPDATE in_verification set cus_status = 14, update_login_id = $userid WHERE req_id = '".$req_id."' ")or die('Error on inVerification Table');
    $selectIC = $con->query("UPDATE `in_approval` SET `cus_status`= 14,`update_login_id`= $userid WHERE  req_id = '".$req_id."' ") or die('Error on in_approval Table');
    $selectIC = $con->query("UPDATE `in_acknowledgement` SET `cus_status`= 14,`update_login_id`= $userid and updated_date=now() WHERE req_id = '".$req_id."' ") or die('Error on in_acknowledgement Table');
    $insertIssue = $con->query("UPDATE `in_issue` SET `loan_id` = '$loan_id',`cus_status`= 14,`updated_date`=now(),`update_login_id` = $userid where req_id = '".$req_id."' ") or die('Error on in_issue Table');

    $qry = $con->query("SELECT agent_id FROM in_verification where req_id = $req_id ");
    $ag_id = $qry->fetch_assoc()['agent_id'];
    if($ag_id > 0 and $ag_id != '' and $ag_id != null){//if agent id is mentioned for this request, then this request is directly moving to collection without issuing cash
        $qry = $con->query("SELECT cus_id_loan,loan_amt_cal, net_cash_cal from acknowlegement_loan_calculation where req_id = $req_id ");
        $row = $qry->fetch_assoc();
        $cus_id = $row['cus_id_loan'];
        $loan_amt = $row['loan_amt_cal'];
        $net_cash = $row['net_cash_cal'];

        //insert query need to be places here and in cash tally issued should be edited as per this agent id. if agent id mentioned then no need to take that issued debit
        $qry = $con->query("INSERT INTO `loan_issue` (`req_id`, `cus_id`, `issued_to`, `agent_id`, `cash`, `balance_amount`, `loan_amt`, `net_cash`, `insert_login_id`,`created_date`) 
        VALUES ('$req_id', '$cus_id', 'Agent', '$ag_id', '$net_cash', '0', '$loan_amt', '$net_cash', '$userid', now()) ");
    }

    $response = 'Loan Issue Completed';
    echo json_encode($response);
?>
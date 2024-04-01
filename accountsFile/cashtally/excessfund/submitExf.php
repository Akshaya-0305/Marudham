<?php

session_start();
$user_id= $_SESSION['userid'];

include('../../../ajaxconfig.php');

$bank_id = $_POST['bank_id'];
$username = $_POST['username_exf'];
$usertype = $_POST['usertype_exf'];
$ucl_ref_code = $_POST['ucl_ref_code_exf'];
$ref_code = $_POST['ref_code_exf'];
$ucl_trans_id = $_POST['ucl_trans_id_exf'];
$trans_id = $_POST['trans_id_exf'];
$remark = $_POST['remark_exf'];
$amt = $_POST['amt_exf'];
$op_date = date('Y-m-d',strtotime($_POST['op_date']));


$ref_code = refcodes($con);
$ucl_ref_code = uclrefcode($con);

$qry = $con->query("INSERT INTO `ct_db_exf`(`username`,`usertype`,`bank_id`,`ucl_ref_code`,`ref_code`,`ucl_trans_id`,`trans_id`,`remark`, `amt`, `insert_login_id`, `created_date`) 
VALUES ('$username','$usertype','$bank_id','$ucl_ref_code','$ref_code','$ucl_trans_id','$trans_id','$remark','$amt','$user_id','$op_date')");

if($qry){
    $response = "Submitted Successfully";
}else{
    $response = "Error While Submitting";
}

echo $response;


function refcodes($con){
    //////////////////////// To get Exchange reference Code once again /////////////////////////
    $myStr = "EXS";
    $selectIC = $con->query("SELECT ref_code FROM ct_db_exf WHERE ref_code != '' ");
    if($selectIC->num_rows>0)
    {
        $codeAvailable = $con->query("SELECT ref_code FROM ct_db_exf WHERE ref_code != '' ORDER BY id DESC LIMIT 1");
        while($row = $codeAvailable->fetch_assoc()){
            $ac2 = $row["ref_code"];
        }
        $appno2 = ltrim(strstr($ac2, '-'), '-'); $appno2 = $appno2+1;
        $ref_code = $myStr."-". "$appno2";
    }
    else
    {
        $initialapp = $myStr."-100001";
        $ref_code = $initialapp;
    }
    ///////////////////////////////////////////////////////////////////////////////////////////
    return $ref_code;
}

function uclrefcode($con){
    //////////////////////// To get Exchange reference Code once again /////////////////////////
    $myStr = "UCL";
    $selectIC = $con->query("SELECT ref_code FROM ct_db_exf WHERE ref_code != '' ");
    if($selectIC->num_rows>0)
    {
        $codeAvailable = $con->query("SELECT ref_code FROM ct_db_exf WHERE ref_code != '' ORDER BY id DESC LIMIT 1");
        while($row = $codeAvailable->fetch_assoc()){
            $ac2 = $row["ref_code"];
        }
        $appno2 = ltrim(strstr($ac2, '-'), '-'); $appno2 = $appno2+1;
        $ucl_ref_code = $myStr."-". "$appno2";
    }
    else
    {
        $initialapp = $myStr."-100001";
        $ucl_ref_code = $initialapp;
    }
    ///////////////////////////////////////////////////////////////////////////////////////////
    return $ucl_ref_code;
}
?>
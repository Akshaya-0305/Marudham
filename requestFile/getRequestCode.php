<?php
include('../ajaxconfig.php');


$myStr = "REQ";
$selectIC = $con->query("SELECT req_code FROM request_creation WHERE req_code != '' ");
if($selectIC->num_rows>0)
{
    $codeAvailable = $con->query("SELECT req_code FROM request_creation WHERE req_code != '' ORDER BY req_id DESC LIMIT 1");
    while($row = $codeAvailable->fetch_assoc()){
        $ac2 = $row["req_code"];
    }
    $appno2 = ltrim(strstr($ac2, '-'), '-'); $appno2 = $appno2+1;
    $req_code = $myStr."-". "$appno2";
}
else
{
    $initialapp = $myStr."-101";
    $req_code = $initialapp;
}
echo json_encode($req_code);
?>

<?php
include('../ajaxconfig.php');


$myStr = "ST";
$selectIC = $con->query("SELECT staff_code FROM staff_creation WHERE staff_code != '' ");
if($selectIC->num_rows>0)
{
    $codeAvailable = $con->query("SELECT staff_code FROM staff_creation WHERE staff_code != '' ORDER BY staff_id DESC LIMIT 1");
    while($row = $codeAvailable->fetch_assoc()){
        $ac2 = $row["staff_code"];
    }
    $appno2 = ltrim(strstr($ac2, '-'), '-'); $appno2 = $appno2+1;
    $staff_code = $myStr."-". "$appno2";
}
else
{
    $initialapp = $myStr."-101";
    $staff_code = $initialapp;
}
echo json_encode($staff_code);
?>

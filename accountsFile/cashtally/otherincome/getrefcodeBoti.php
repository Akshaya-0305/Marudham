<?php
include('../../../ajaxconfig.php');

//////////////////////// To get Exchange reference Code once again /////////////////////////
$myStr = "OTI";
$selectIC = $con->query("SELECT ref_code FROM ct_cr_boti WHERE ref_code != '' ");
if($selectIC->num_rows>0)
{
    $codeAvailable = $con->query("SELECT ref_code FROM ct_cr_boti WHERE ref_code != '' ORDER BY id DESC LIMIT 1");
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


echo json_encode($ref_code);
?>
<?php
// include('../../../ajaxconfig.php');

// //////////////////////// To get Exchange reference Code once again /////////////////////////
// $myStr = "INV";
// $selectIC = $con->query("SELECT ref_code FROM ct_cr_binvest WHERE ref_code != '' ");
// if($selectIC->num_rows>0)
// {
//     $codeAvailable = $con->query("SELECT ref_code FROM ct_cr_binvest WHERE ref_code != '' ORDER BY id DESC LIMIT 1");
//     while($row = $codeAvailable->fetch_assoc()){
//         $ac2 = $row["ref_code"];
//     }
//     $appno2 = ltrim(strstr($ac2, '-'), '-'); $appno2 = $appno2+1;
//     $ref_code = $myStr."-". "$appno2";
// }
// else
// {
//     $initialapp = $myStr."-100001";
//     $ref_code = $initialapp;
// }
// ///////////////////////////////////////////////////////////////////////////////////////////


// echo json_encode($ref_code);
?>

<?php
include('../../../ajaxconfig.php');

//////////////////////// To get Exchange reference Code once again /////////////////////////
$myStr = "INV";
$codeAvailable = $con->query("SELECT ref_code FROM ct_cr_binvest WHERE ref_code != '' UNION SELECT ref_code FROM ct_db_binvest WHERE ref_code != '' ORDER BY ref_code DESC LIMIT 1");

if ($codeAvailable->num_rows > 0) {
    $row = $codeAvailable->fetch_assoc();
    $latestRefCode = $row["ref_code"];
    $latestAppNo = ltrim(strstr($latestRefCode, '-'), '-');
    $appno2 = $latestAppNo + 1;
    $ref_code = $myStr . "-" . str_pad($appno2, 6, '0', STR_PAD_LEFT);
} else {
    $initialapp = $myStr . "-100001";
    $ref_code = $initialapp;
}
///////////////////////////////////////////////////////////////////////////////////////////

$ref_code = str_replace(`"`,'',$ref_code);

echo $ref_code;
?>

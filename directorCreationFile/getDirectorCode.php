<?php
include('../ajaxconfig.php');
if(isset($_POST["dir_type"])){
    $sdir_type = $_POST["dir_type"];
}

if($sdir_type == '1'){
    $myStr = "D";
}
if($sdir_type == '2'){
    $myStr = "EXD";
}
$selectIC = $con->query("SELECT dir_code FROM director_creation WHERE dir_code != '' ");
if($selectIC->num_rows>0)
{
    $codeAvailable = $con->query("SELECT dir_code FROM director_creation WHERE dir_code != '' ORDER BY dir_id DESC LIMIT 1");
    while($row = $codeAvailable->fetch_assoc()){
        $ac2 = $row["dir_code"];
    }
    $appno2 = ltrim(strstr($ac2, '-'), '-'); $appno2 = $appno2+1;
    // $appno1 = substr($appno2, 4, strpos($appno2, "/")) + 101 ;
    $dir_code = $myStr."-". "$appno2";
	// print_r($dir_code);die;
}
else
{
    $initialapp = $myStr."-101";
    $dir_code = $initialapp;
}
echo json_encode($dir_code);
?>

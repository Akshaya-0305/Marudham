<?php
include('../../ajaxconfig.php');

$id  = $_POST['id'];

if($id !=''){
    $select = $con->query("SELECT doc_id FROM verification_documentation WHERE id = '$id' ");
    $code = $select ->fetch_assoc();
    $doc_id = $code['doc_id'];

}else{
$myStr = "DOC";
$selectIC = $con->query("SELECT doc_id FROM verification_documentation WHERE doc_id != '' ");
if($selectIC->num_rows>0)
{
    $codeAvailable = $con->query("SELECT doc_id FROM verification_documentation WHERE doc_id != '' ORDER BY id DESC LIMIT 1");
    while($row = $codeAvailable->fetch_assoc()){
        $ac2 = $row["doc_id"];
    }
    $appno2 = ltrim(strstr($ac2, '-'), '-'); $appno2 = $appno2+1;
    $doc_id = $myStr."-". "$appno2";
}
else
{
    $initialapp = $myStr."-101";
    $doc_id = $initialapp;
}
}
echo json_encode($doc_id);
?>
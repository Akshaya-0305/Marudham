<?php 
include('../ajaxconfig.php');
if(isset($_POST['sub_cat'])){
    $sub_cat = $_POST['sub_cat'];
}

$detailrecords = array();

$result=$con->query("SELECT * FROM loan_category where status=0 and sub_category_name = '".strip_tags($sub_cat)."' ");
while( $row = $result->fetch_assoc()){
    $loan_category_id = $row['loan_category_id'];
}

$i=0;
    $qry = $con->query("SELECT * From  loan_category_ref where loan_category_id = '".$loan_category_id."' ");
    while($row = $qry->fetch_assoc()){

        $detailrecords[$i]['loan_category_ref_name'] = $row['loan_category_ref_name'];
        $i++;
    }

echo json_encode($detailrecords);
?>
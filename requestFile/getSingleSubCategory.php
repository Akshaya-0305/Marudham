<?php 
include('../ajaxconfig.php');
if (isset($_POST['loan_cat'])) {
    $loan_cat = $_POST['loan_cat'];
}


$records = array();
    $selectIC = $con->query("SELECT * FROM loan_category WHERE loan_category_name = '".$loan_cat."' and status =0 ");
    if($selectIC->num_rows>0)
    {   $i=0;
        while($row = $selectIC->fetch_assoc()){
            $sub_cat_name = $row["sub_category_name"];
            $Qry = $con->query("SELECT * from loan_calculation where sub_category = '".strip_tags($sub_cat_name)."' ");
            if($Qry->num_rows>0){
                
                $row1 = $Qry->fetch_assoc();
                $records[$i]['sub_category_name'] = $row1["sub_category"];
                $i++;
            }
        }

    }

echo json_encode($records);
?>
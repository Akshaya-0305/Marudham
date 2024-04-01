<?php
include('../ajaxconfig.php');

// if(isset($_POST["loan_cat"])){
// 	$loan_cat  = $_POST["loan_cat"];
// }
$loanCatSelect = "SELECT * FROM loan_category where status = 0  GROUP BY loan_category_name"; 
$res = $con->query($loanCatSelect) ;
$detailrecords = array();
if ($res->num_rows>0)
{$i=0;
    while($row = $res->fetch_assoc()){	
        $rowsCount1 = '';$rowsCount2='';
        // $loan_categoryId[$i]      = $row['loan_category_id']; 
        $detailrecords[$i]['loan_category_id']      = $row['loan_category_id']; 
        $detailrecords[$i]['loan_category_name_id']    = $row['loan_category_name'];
        $detailrecords[$i]['sub_category_name']    = $row['sub_category_name']; 
        
        //For getting loan category name
        $Qry = "SELECT * FROM loan_category_creation WHERE loan_category_creation_id= '".$detailrecords[$i]['loan_category_name_id']."' and status = 0 "; 
        $res1 = $mysqli->query($Qry) ;
        $row1 = $res1->fetch_object();
        $detailrecords[$i]['loan_category_name'] = $row1->loan_category_creation_name;

            $checkLoan = $con->query("SELECT * from loan_category where loan_category_name = '".$detailrecords[$i]['loan_category_name_id']."' and status = 0");
            if($checkLoan->num_rows>0){
                $rowsCount1 = $checkLoan->num_rows;
                
                $checkSub = $con->query("SELECT * from loan_calculation where loan_category = '".$detailrecords[$i]['loan_category_name_id']."'");
                if($checkSub->num_rows>0){
                    $rowsCount2 = $checkSub->num_rows;
                    
                }
            }
            if($rowsCount1 !='' and $rowsCount2 != '' and $rowsCount1 == $rowsCount2){
                $detailrecords[$i]['disabled'] = 'disabled';
            }else{
                $detailrecords[$i]['disabled'] = '';
            }
            $i++;
    }
}
        

echo json_encode($detailrecords);
?>
<?php 
session_start();
include('../../ajaxconfig.php');

if(isset($_SESSION['userid'])){
    $userid = $_SESSION['userid'];
}
$detailrecords = array();


$result=$con->query("SELECT * FROM user where user_id = $userid ");
$row = $result->fetch_assoc();
$role = $row['role'];
$ag_id = $row['ag_id'];

if($role == '2'){

    $result=$con->query("SELECT * FROM agent_creation where status=0 and ag_id = $ag_id ");
    while( $row = $result->fetch_assoc()){
        $loan_category = $row['loan_category'];
    }
    $loan_category_id = explode(',',$loan_category);
    $i=0;
    foreach($loan_category_id as $cat){
        $qry = $con->query("SELECT * From loan_category_creation where loan_category_creation_id = '".$cat."' ");
        $row = $qry->fetch_assoc();
        $detailrecords[$i]['loan_category_id'] = $row['loan_category_creation_id'];
        $detailrecords[$i]['loan_category_name'] = $row['loan_category_creation_name'];
        $i++;
    }
}else{
    // below query will give the result of loan categories which are available in loan calculation or loan scheme. 
    // if any one of the tables having the loan category, then that one will be returned in this query
    // old - select * from loan_category_creation where status = 0
    $qry = $con->query("SELECT lcc.loan_category_creation_id, lcc.loan_category_creation_name
    FROM loan_category_creation lcc
    INNER JOIN loan_calculation lc ON lc.loan_category = lcc.loan_category_creation_id
    LEFT OUTER JOIN loan_scheme ls ON ls.loan_category = lcc.loan_category_creation_id
    GROUP BY lc.loan_category  
ORDER BY `lcc`.`loan_category_creation_name` ASC; ");
    $i=0;
    while($row = $qry->fetch_assoc()){
        $detailrecords[$i]['loan_category_id'] = $row['loan_category_creation_id'];
        $detailrecords[$i]['loan_category_name'] = $row['loan_category_creation_name'];
        $i++;
    }
}
    


echo json_encode($detailrecords);
?>
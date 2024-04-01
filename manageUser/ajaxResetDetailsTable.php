<?php 
include('../ajaxconfig.php');

if(isset($_POST['staff_id'])){
    $staff_id = $_POST['staff_id'];
}

$staffArr = array();

$result=$con->query("SELECT * FROM staff_creation where status=0 and staff_id = $staff_id ");
while( $row = $result->fetch_assoc()){
    
    $staff_code = $row['staff_code'];
    $staff_name = $row['staff_name'];
    $mail = $row['mail'];
    
    $company_id = $row['company_id'];
    $qry = "SELECT * From company_creation where company_id = $company_id and status = 0";
    $res = $con->query($qry);
    $row1 = $res->fetch_assoc();
    $company_name = $row1['company_name'];

    $department = $row['department'];
    $team = $row['team'];
    $designation = $row['designation'];

    $staffArr[] = array("staff_code" => $staff_code, "staff_name" => $staff_name,'mail'=>$mail,'company_name'=>$company_name,'department'=>$department,
    'team'=>$team,'designation'=>$designation,'company_id'=>$company_id);
}

echo json_encode($staffArr);
?>
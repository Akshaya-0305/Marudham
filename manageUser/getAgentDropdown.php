<?php 
include('../ajaxconfig.php');

if(isset($_POST['company_id'])){
    $company_id = $_POST['company_id'];
}

$staffArr = array();

    $result=$con->query("SELECT * FROM agent_creation where status=0 and company_id = '".$company_id."' ");
    while( $row = $result->fetch_assoc()){
        $ag_id = $row['ag_id'];
        $ag_name = $row['ag_name'];

        $staffArr[] = array("ag_id" => $ag_id, "ag_name" => $ag_name);
    }

echo json_encode($staffArr);
?>
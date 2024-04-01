<?php 
include('../ajaxconfig.php');

if(isset($_POST['branch_id'])){
    $branch_id = $_POST['branch_id'];
}

$staffArr = array();
$branch_id1 = explode(',',$branch_id);

foreach($branch_id1 as $branch_id){
    $result=$con->query("SELECT * FROM area_line_mapping where status=0 and branch_id = '".$branch_id."' ");
    while( $row = $result->fetch_assoc()){
        $map_id = $row['map_id'];
        $line_name = $row['line_name'];

        $staffArr[] = array("map_id" => $map_id, "line_name" => $line_name);
    }
}

echo json_encode($staffArr);
?>
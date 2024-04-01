<?php
include('../ajaxconfig.php');
@session_start();

if(isset($_SESSION["userid"])){
    $userid = $_SESSION["userid"];
}

$column = array(
    'area_id',
    'area_name',
    'status'
);

$query = "SELECT * FROM area_list_creation WHERE status=0 ";

if(isset($_POST['search']) && $_POST['search'] != "")
{

        // if($_POST['search']=="Active")
        // {
        //     $query .="and status=0 "; 
        // }
        // else if($_POST['search']=="Inactive")
        // {
        //     $query .="and status=1 ";
        // }

        // else{	
            $query .= "and
            (area_id LIKE '%".$_POST['search']."%' 
            OR area_name LIKE '%".$_POST['search']."%' ) ";
        // }
}
// print_r($query);die;

if (isset($_POST['order'])) {
    $query .= 'ORDER BY ' . $column[$_POST['order']['0']['column']] . ' ' . $_POST['order']['0']['dir'] . ' ';
} else {
    $query .= ' ';
}

$query1 = '';

if ($_POST['length'] != -1) {
    $query1 = 'LIMIT ' . $_POST['start'] . ', ' . $_POST['length'];
}

$statement = $connect->prepare($query);
$statement->execute();
$number_filter_row = $statement->rowCount();
$statement = $connect->prepare($query . $query1);
$statement->execute();
$result = $statement->fetchAll();
$data = array();

$sno = 1;
foreach ($result as $row) {
    $sub_array   = array();
    
    if($sno!="")
    {
        $sub_array[] = $sno;
    }

    $sub_array[] = $row['area_name'];

    $area_enable      = $row['area_enable'];
    $id   = $row['area_id'];
    
    if($area_enable == 0)
	{
    $action="<button onclick='enable($id)' disabled title='Edit details'class='btn btn-success' >Enable</button>&nbsp;&nbsp;
    <button onclick='disable($id)' title='Edit details' class='btn btn-danger'>Disable</button>";
	}
	elseif($area_enable == 1)
	{
    $action="<button onclick='enable($id)' title='Edit details'class='btn btn-success' >Enable</button>&nbsp;&nbsp;
        <button onclick='disable($id)' disabled title='Edit details' class='btn btn-danger'>Disable</button>";
	}
	
	// $action="<button onclick='enable($id)' title='Edit details'class='btn btn-success' >Enable</button>&nbsp;&nbsp;
    // <button onclick='disable($id)' title='Edit details' class='btn btn-danger'>Disable</button>";

	$sub_array[] = $action;
    $data[]      = $sub_array;
    $sno = $sno + 1;
}

function count_all_data($connect)
{
    $query     = "SELECT * FROM area_list_creation";
    $statement = $connect->prepare($query);
    $statement->execute();
    return $statement->rowCount();
}

$output = array(
    'draw' => intval($_POST['draw']),
    'recordsTotal' => count_all_data($connect),
    'recordsFiltered' => $number_filter_row,
    'data' => $data
);

echo json_encode($output);
?>
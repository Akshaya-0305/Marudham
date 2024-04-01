<?php
include('../ajaxconfig.php');
@session_start();

if(isset($_SESSION["userid"])){
    $userid = $_SESSION["userid"];
}

$column = array(
    'sub_area_id',
    'sub_area_name',
    'area_id_ref',
    'status'
);

$query = "SELECT * FROM  sub_area_list_creation WHERE status=0 ";

if(isset($_POST['search']) && $_POST['search'] != "")
{

        // if($_POST['search']=="Active")
        // {
        //     $query .="WHERE status=0 "; 
        // }
        // else if($_POST['search']=="Inactive")
        // {
        //     $query .="WHERE status=1 ";
        // }

        // else{	
            $query .= "and
            (sub_area_id LIKE '%".$_POST['search']."%' 
            OR sub_area_name LIKE '%".$_POST['search']."%'
            OR area_id_ref LIKE '%".$_POST['search']."%' ) ";
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
    $area_id_ref = $row['area_id_ref'];
    $qry = $con->query("SELECT * from area_list_creation where area_id = '".$area_id_ref."' and status = 0");
    $res = $qry->fetch_assoc();
    $area_chech = $res['area_enable'];

    $sub_array[] = $row['sub_area_name'];

    $area_id_ref = $row['area_id_ref'];
    $qry = $con->query("SELECT * from area_list_creation where status = 0 and area_id = '".$area_id_ref."' ");
    $ress = $qry->fetch_assoc();
    $sub_array[] = $ress['area_name'];

    
    $sub_area_enable      = $row['sub_area_enable'];
    $id   = $row['sub_area_id'];
    
    if($sub_area_enable == 0 and $area_chech == 0)//sub area enabled
	{
    $action="<button onclick='enable($id)' disabled title='Edit details'class='btn btn-success' >Enable</button>&nbsp;&nbsp;
    <button onclick='disable($id)' title='Edit details' class='btn btn-danger'>Disable</button>";
	}
	elseif($sub_area_enable == 1 and $area_chech == 0)//sub area disabled
	{
    $action="<button onclick='enable($id)'  title='Edit details'class='btn btn-success' >Enable</button>&nbsp;&nbsp;
        <button onclick='disable($id)' disabled title='Edit details' class='btn btn-danger'>Disable</button>";
	}
	elseif($sub_area_enable == 0 and $area_chech == 1)//sub area disabled
	{
    $action="
        <button onclick='disable($id)' disabled title='Edit details' class='btn btn-danger'>Disable</button>";
	}
	elseif($sub_area_enable == 1 and $area_chech == 1)//sub area disabled
	{
    $action="
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
    $query     = "SELECT * FROM  sub_area_list_creation";
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
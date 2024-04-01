<?php
include('../ajaxconfig.php');
@session_start();

if(isset($_SESSION["userid"])){
    $userid = $_SESSION["userid"];
}

$column = array(
    'area_creation_id',
    'area_name_id',
    'sub_area',
    'taluk',
    'district', 
    'state',
    'pincode',
    'status'
);

$query = "SELECT * FROM area_creation ";

if(isset($_POST['search'])&&$_POST['search'] != "")
{
    
        if($_POST['search']=="Active")
        {
            $query .="WHERE status=0 "; 
        }
        else if($_POST['search']=="Inactive")
        {
            $query .="WHERE status=1 ";
        }

        else{	
            $query .= "WHERE
            area_name_id LIKE '%".$_POST['search']."%' 
            OR sub_area LIKE '%".$_POST['search']."%' 
            OR taluk LIKE '%".$_POST['search']."%' 
            OR district LIKE '%".$_POST['search']."%' 
            OR state LIKE '%".$_POST['search']."%' 
            OR pincode LIKE '%".$_POST['search']."%' 
            OR status LIKE '%".$_POST['search']."%' ";
        }
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
    $area_name_id = $row['area_name_id'];
    $getareaQry = "SELECT * from area_list_creation where area_id = '".$area_name_id."' and status = 0 ";
    $res=$con->query($getareaQry);
    while($row1=$res->fetch_assoc())
    {
        $sub_array[] = $row1["area_name"];        
    }
    
    $sub_area_id = explode(',',$row['sub_area']);
    $sub_area_name = '';
    foreach($sub_area_id as $id){
        $getsubareaQry = "SELECT * from sub_area_list_creation where sub_area_id = '".$id."' and status = 0 ";
        $res=$con->query($getsubareaQry);
        $row1=$res->fetch_assoc();
        $sub_area_name .= $row1["sub_area_name"] . ', ';
    }
    $sub_area_name = rtrim($sub_area_name, ' , '); // will remove the last comma from string

    $sub_array[] = $sub_area_name;
    $sub_array[] = $row['taluk'];
    $sub_array[] = $row['district'];
    $sub_array[] = $row['state'];
    $sub_array[] = $row['pincode'];    
    // if($row['enable'] == 0){
    //     $sub_array[] = "<img src='img/check.jpg' width='20px' height='20px' alt='Enabled' />";
    // }else{
    //     $sub_array[] = "<img src='img/wrong.png' width='20px' height='20px' alt='Disabled' />";
    // }
    $status      = $row['status'];
    if($status == 1)
	{
	$sub_array[] = "<span style='width: 144px;'><span class='kt-badge  kt-badge--danger kt-badge--inline kt-badge--pill'>Inactive</span></span>";
	}
	else
	{
    $sub_array[] = "<span style='width: 144px;'><span class='kt-badge  kt-badge--success kt-badge--inline kt-badge--pill'>Active</span></span>";
	}
	$id   = $row['area_creation_id'];
	
	$action="<a href='area_creation&upd=$id' title='Edit details'><span class='icon-border_color'></span></a>&nbsp;&nbsp; 
	<a href='area_creation&del=$id' title='Delete details' class='delete_area'><span class='icon-trash-2'></span></a>";

	$sub_array[] = $action;
    $data[]      = $sub_array;
    $sno = $sno + 1;
}

function count_all_data($connect)
{
    $query     = "SELECT * FROM area_creation";
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
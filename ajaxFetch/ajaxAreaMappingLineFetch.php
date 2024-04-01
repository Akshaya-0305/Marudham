<?php
include('../ajaxconfig.php');
@session_start();

if(isset($_SESSION["userid"])){
    $userid = $_SESSION["userid"];
}

$column = array(
    'map_id',
    'line_name',
    'company_id',
    'branch_id',
    'area_id',
    'sub_area_id', 
    'status'
);

$query = "SELECT * FROM area_line_mapping ";

if(isset($_POST['search']) && $_POST['search']!="")
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
            map_id LIKE  '%".$_POST['search']."%'
            OR line_name LIKE '%".$_POST['search']."%'
            OR company_id LIKE '%".$_POST['search']."%'
            OR branch_id LIKE '%".$_POST['search']."%'
            OR area_id LIKE '%".$_POST['search']."%'
            OR sub_area_id LIKE '%".$_POST['search']."%'
            OR status LIKE '%".$_POST['search']."%' ";
        }
}

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
    
    $sub_array[] = $row['line_name'];
    
    //Company name Fetch
    $company_id = $row['company_id'];
    $getQry = "SELECT * from company_creation where company_id = '".$company_id."' and status = 0 ";
    $res=$con->query($getQry);
    while($row1=$res->fetch_assoc())
    {
        $sub_array[] = $row1["company_name"];        
    }

    //Branch name Fetch
    $branch_id = $row['branch_id'];
    $getbranchQry = "SELECT * from branch_creation where branch_id = '".$branch_id."' and status = 0 ";
    $res=$con->query($getbranchQry);
    while($row1=$res->fetch_assoc())
    {
        $sub_array[] = $row1["branch_name"];        
    }

    //Area name Fetch
    $area_name_id = explode(',',$row['area_id']);
    $area_name = '';
    foreach($area_name_id as $area_name_id1){
        $getareaQry = "SELECT * from area_list_creation where area_id = '".$area_name_id1."' and status = 0 ";
        $res=$con->query($getareaQry);
        while($row1=$res->fetch_assoc())
        {
            $area_name .= $row1["area_name"].','; 
        }
    }
    $area_name = rtrim($area_name, ' , '); // will remove the last comma from string
    $sub_array[] = $area_name;

    //Sub Area name Fetch
    $sub_area_id = explode(',',$row['sub_area_id']);
    $sub_area_name = '';
    if(sizeof($sub_area_id)>0){

        foreach($sub_area_id as $id){
            $getsubareaQry = "SELECT * from sub_area_list_creation where sub_area_id = '".$id."' and status = 0 ";
            $res=$con->query($getsubareaQry);
            if($res->num_rows>0){
                $row1=$res->fetch_assoc();
                $sub_area_name .= $row1["sub_area_name"] . ', ';
            }
        }
        $sub_area_name = rtrim($sub_area_name, ' , '); // will remove the last comma from string
    }
    $sub_array[] = $sub_area_name;
    
    
    $status      = $row['status'];
    if($status == 1)
	{
	$sub_array[] = "<span style='width: 144px;'><span class='kt-badge  kt-badge--danger kt-badge--inline kt-badge--pill'>Inactive</span></span>";
	}
	else
	{
    $sub_array[] = "<span style='width: 144px;'><span class='kt-badge  kt-badge--success kt-badge--inline kt-badge--pill'>Active</span></span>";
	}
	
	$id   = $row['map_id'];
	$action="<a href='area_mapping&upd=$id&type=line' title='Edit details'><span class='icon-border_color'></span></a>&nbsp;&nbsp; 
	<a href='area_mapping&del=$id&type=line' title='Delete details' class='delete_area_mapping'><span class='icon-trash-2'></span></a>";

	$sub_array[] = $action;
    $data[]      = $sub_array;
    $sno = $sno + 1;
}

function count_all_data($connect)
{
    $query     = "SELECT * FROM area_line_mapping";
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
<?php
@session_start();
include('..\ajaxconfig.php');

$column = array(
    'user_id',
    'role',
    'role_type',
    'fullname',
    'user_name',
    'company_id',
    'branch_id',
    'line_id',
    'group_id',
    'status',
);

$query = "SELECT * FROM user WHERE user_id != 1 ";
if(isset($_POST['search']) && $_POST['search'] != "")
{

        if($_POST['search']=="Active" or $_POST['search']=="active")
        {
            $query .="and status=0 ";
            
        }
        else if($_POST['search']=="Inactive" or $_POST['search']=="inactive")
        {
            $query .="and status=1 ";
        }

        else{   
            $query .= "
                and (role LIKE '%".$_POST['search']."%'
                OR role_type LIKE '%".$_POST['search']."%'
                OR fullname LIKE '%".$_POST['search']."%'
                OR user_name LIKE '%".$_POST['search']."%'
                OR company_id LIKE '%".$_POST['search']."%'
                OR branch_id LIKE '%".$_POST['search']."%'
                OR line_id LIKE '%".$_POST['search']."%'
                OR group_id LIKE '%".$_POST['search']."%') ";
        }
    // print_r($query);
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

    $sub_array[] = $sno;

    $role_id = $row['role'];
    if($role_id == '1'){$sub_array[] = 'Director';}
    else if($role_id == '2'){$sub_array[] = 'Agent';}
    else if($role_id == '3'){$sub_array[] = 'Staff';}

    $role_type_id = $row['role_type'];
    if($role_type_id == '11'and $role_id == '1'){$sub_array[] = 'Director';} else if( $role_type_id == '12' and $role_id == '1'){$sub_array[] = 'Executive Director';}
    else if($role_type_id == Null and $role_id == '2'){$sub_array[] = 'Agent'; }
    else if($role_type_id > 0 and $role_id == '3'){
        $getQry = "SELECT * from staff_type_creation where staff_type_id = '".$role_type_id."' and status = 0 ";
        $res=$con->query($getQry);
        $row1=$res->fetch_assoc();
        $sub_array[] = $row1["staff_type_name"];        
    }
    
    $sub_array[] = $row['fullname'];
    $sub_array[] = $row['user_name'];

    //Company name Fetch
    $company_id = $row['company_id'];
    $getQry = "SELECT * from company_creation where company_id = '".$company_id."' and status = 0 ";
    $res=$con->query($getQry);
    while($row1=$res->fetch_assoc())
    {
        $sub_array[] = $row1["company_name"];        
    }

    //Branch name Fetch
    $branch_id1 = explode(',',$row['branch_id']);
    $branch_names = array();
    foreach($branch_id1 as $branch_id){
        $getbranchQry = "SELECT * from branch_creation where branch_id = '".$branch_id."' and status = 0 ";
        $res=$con->query($getbranchQry);
        $row1=$res->fetch_assoc();
        $branch_names[] = $row1["branch_name"];
    }
    $branch_name = implode(',', $branch_names);
    $sub_array[] = $branch_name;

    //Line name Fetch
    if($row['line_id'] != null){
        $line_id1 = explode(',',$row['line_id']);
        $line_names = array();
        foreach($line_id1 as $line_id){
            $getbranchQry = "SELECT * from area_line_mapping where map_id = '".$line_id."' and status = 0 ";
            $res=$con->query($getbranchQry);
            $row1=$res->fetch_assoc();
            $line_names[] = $row1["line_name"]; 
        }
        $line_name = implode(',',$line_names);
    }else{
        $line_name = '';
    }
    $sub_array[] = $line_name;    

    //Group name Fetch
    if($row['group_id'] != null){
        $group_id1 = explode(',',$row['group_id']);
        $group_names = array();
        foreach($group_id1 as $group_id){
            $getbranchQry = "SELECT * from area_group_mapping where map_id = '".$group_id."' and status = 0 ";
            $res=$con->query($getbranchQry);
            $row1=$res->fetch_assoc();
            $group_names[] = $row1["group_name"];        
        }
        $group_name = implode(',',$group_names);
    }else{
        $group_name = '';
    }
    $sub_array[] = $group_name;

    $status      = $row['status'];

    if($status==1)
    {
    $sub_array[]="<span style='width: 144px;'><span class='kt-badge  kt-badge--danger kt-badge--inline kt-badge--pill'>Inactive</span></span>";
    }
    else
    {
    $sub_array[]="<span style='width: 144px;'><span class='kt-badge  kt-badge--success kt-badge--inline kt-badge--pill'>Active</span></span>";
    }
    $id          = $row['user_id'];
    
    $action="<a href='manage_user&upd=$id' title='Edit details'><span class='icon-border_color'></span></a>&nbsp;&nbsp; 
    <a href='manage_user&del=$id' title='Edit details' class='delete_user'><span class='icon-trash-2'></span></a>";

    $sub_array[] = $action;
    $data[]      = $sub_array;
    $sno = $sno+1;
}

function count_all_data($connect)
{
    $query     = "SELECT * FROM user";
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
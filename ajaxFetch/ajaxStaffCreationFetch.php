<?php
@session_start();
include('..\ajaxconfig.php');

$column = array(
    'staff_id',
    'staff_code',
    'staff_name',
    'staff_type',
    'place',
    'company_id',
    'department',
    'team',
    'designation',
    'status'
);

$query = "SELECT * FROM staff_creation ";
if(isset($_POST['search']) && $_POST['search'] != "")
{

        if($_POST['search']=="Active" or $_POST['search']=="active")
        {
            $query .="WHERE status=0 ";
            
        }
        else if($_POST['search']=="Inactive" or $_POST['search']=="inactive")
        {
            $query .="WHERE status=1 ";
        }

        else{   
            $query .= "WHERE
                staff_code LIKE '%".$_POST['search']."%'
                OR staff_name LIKE '%".$_POST['search']."%'
                OR staff_type LIKE '%".$_POST['search']."%'
                OR place LIKE '%".$_POST['search']."%'
                OR company_id LIKE '%".$_POST['search']."%'
                OR department LIKE '%".$_POST['search']."%'
                OR team LIKE '%".$_POST['search']."%'
                OR designation LIKE '%".$_POST['search']."%' ";
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
    
    $sub_array[] = $row['staff_code'];
    $sub_array[] = $row['staff_name'];
    

    //Staff Type Fetch
    $staff_type = $row['staff_type'];
    $getQry = "SELECT * from staff_type_creation where staff_type_id = '".$staff_type."' and status = 0 ";
    $res=$con->query($getQry);
    while($row1=$res->fetch_assoc())
    {
        $sub_array[] = $row1["staff_type_name"];        
    }
    
    $sub_array[] = $row['place'];

    //Company name Fetch
    $company_id = $row['company_id'];
    $getQry = "SELECT * from company_creation where company_id = '".$company_id."' and status = 0 ";
    $res=$con->query($getQry);
    while($row1=$res->fetch_assoc())
    {
        $sub_array[] = $row1["company_name"];        
    }


    
    $sub_array[] = $row['department'];
    $sub_array[] = $row['team'];
    $sub_array[] = $row['designation'];

    $status      = $row['status'];

    if($status==1)
    {
    $sub_array[]="<span style='width: 144px;'><span class='kt-badge  kt-badge--danger kt-badge--inline kt-badge--pill'>Inactive</span></span>";
    }
    else
    {
    $sub_array[]="<span style='width: 144px;'><span class='kt-badge  kt-badge--success kt-badge--inline kt-badge--pill'>Active</span></span>";
    }
    $id          = $row['staff_id'];
    
    $action="<a href='staff_creation&upd=$id' title='Edit details'><span class='icon-border_color'></span></a>&nbsp;&nbsp; 
    <a href='staff_creation&del=$id' title='Edit details' class='delete_staff'><span class='icon-trash-2'></span></a>";

    $sub_array[] = $action;
    $data[]      = $sub_array;
    $sno = $sno+1;
}

function count_all_data($connect)
{
    $query     = "SELECT * FROM staff_creation";
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
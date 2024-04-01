<?php
@session_start();
include('..\ajaxconfig.php');

$column = array(
    'dir_id',
    'company_id',
    // 'branch_id',
    'dir_code',
    'dir_name',
    'dir_type',
    'place',
    'taluk',
    'district',
    'mobile_no',
    'status',
);

$query = "SELECT * FROM director_creation ";
if (isset($_POST['search']) && $_POST['search'] != "") {

        if ($_POST['search'] == "Active") {
            $query .= "WHERE status=0 ";
        } else if ($_POST['search'] == "Inactive") {
            $query .= "WHERE status=1 ";
        }

        // OR branch_id LIKE '%".$_POST['search']."%'
        else {
            $query .= "WHERE
        dir_code LIKE '%" . $_POST['search'] . "%'
        OR dir_name LIKE '%" . $_POST['search'] . "%'
        OR dir_type LIKE '%" . $_POST['search'] . "%'
        OR company_id LIKE '%" . $_POST['search'] . "%'
        OR place LIKE '%" . $_POST['search'] . "%'
        OR taluk LIKE '%" . $_POST['search'] . "%'
        OR district LIKE '%" . $_POST['search'] . "%'
        OR mobile_no LIKE '%" . $_POST['search'] . "%'
        OR status LIKE '%" . $_POST['search'] . "%' ";
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

    $sub_array[] = $sno;


    //Company name Fetch
    $company_id = $row['company_id'];
    $getQry = "SELECT * from company_creation where company_id = '" . $company_id . "' and status = 0 ";
    $res = $con->query($getQry);
    while ($row1 = $res->fetch_assoc()) {
        $sub_array[] = $row1["company_name"];
    }

    // //Branch name Fetch
    // $branch_id = $row['branch_id'];
    // $getbranchQry = "SELECT * from branch_creation where branch_id = '".$branch_id."' and status = 0 ";
    // $res=$con->query($getbranchQry);
    // while($row1=$res->fetch_assoc())
    // {
    //     $sub_array[] = $row1["branch_name"];        
    // }

    $sub_array[] = $row['dir_code'];
    $sub_array[] = $row['dir_name'];

    if ($row['dir_type'] == '1') {
        $sub_array[] = 'Director';
    } else if ($row['dir_type'] == '2') {
        $sub_array[] = 'Executive Director';
    }

    $sub_array[] = $row['place'];
    $sub_array[] = $row['taluk'];
    $sub_array[] = $row['district'];
    $sub_array[] = $row['mobile_no'];

    $status      = $row['status'];

    if ($status == 1) {
        $sub_array[] = "<span style='width: 144px;'><span class='kt-badge  kt-badge--danger kt-badge--inline kt-badge--pill'>Inactive</span></span>";
    } else {
        $sub_array[] = "<span style='width: 144px;'><span class='kt-badge  kt-badge--success kt-badge--inline kt-badge--pill'>Active</span></span>";
    }
    $id          = $row['dir_id'];

    $action = "<a href='director_creation&upd=$id' title='Edit details'><span class='icon-border_color'></span></a>&nbsp;&nbsp; 
    <a href='director_creation&del=$id' title='Edit details' class='delete_dir'><span class='icon-trash-2'></span></a>";

    $sub_array[] = $action;
    $data[]      = $sub_array;
    $sno = $sno + 1;
}

function count_all_data($connect)
{
    $query     = "SELECT * FROM director_creation";
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

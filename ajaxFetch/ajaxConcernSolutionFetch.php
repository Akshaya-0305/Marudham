<?php
@session_start();
include('..\ajaxconfig.php');

if (isset($_SESSION["userid"])) {
    $userid = $_SESSION["userid"];
}
if ($userid != 1) {

    $userQry = $con->query("SELECT * FROM USER WHERE user_id = $userid ");
    while ($rowuser = $userQry->fetch_assoc()) {
        $group_id = $rowuser['group_id'];
        $line_id = $rowuser['line_id'];
        $staff_id = $rowuser['staff_id'];
    }

    $line_id = explode(',', $line_id);
    $sub_area_list = array();
    foreach ($line_id as $line) {
        $lineQry = $con->query("SELECT * FROM area_line_mapping where map_id = $line ");
        $row_sub = $lineQry->fetch_assoc();
        $sub_area_list[] = $row_sub['sub_area_id'];
    }
    $sub_area_ids = array();
    foreach ($sub_area_list as $subarray) {
        $sub_area_ids = array_merge($sub_area_ids, explode(',', $subarray));
    }
    $sub_area_list = array();
    $sub_area_list = implode(',', $sub_area_ids);
}

$column = array(
    'cp.cus_id',
    'cp.cus_id',
    'cp.cus_name',
    'cp.area_confirm_area',
    'cp.area_confirm_subarea',
    'cp.area_line',
    'cp.area_line',
    'cp.mobile1',
    'cp.status'
);

if ($userid == 1) {
    $query = 'SELECT * FROM `concern_creation` WHERE status != 2'; // 
} else {
    $query = "SELECT * FROM `concern_creation` WHERE  status != 2 && staff_assign_to = '" . strip_tags($staff_id) . "'"; // 
}
// echo $query;

if (isset($_POST['search']) && $_POST['search'] != "") {

    if (strtolower($_POST['search']) == 'pending') {$search1 = 'OR status = 0';}else if (strtolower($_POST['search']) == 'resolved') {$search1 = 'OR status = 1';}else{$search1 ='';}
    $query .= "
            and (com_code LIKE '%" . $_POST['search'] . "%'
            OR com_date LIKE '%" . date('Y-m-d',strtotime($_POST['search'])) . "%' 
            $search1 ) ";

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

    $sub_array[] = $row['com_code'];
    $sub_array[] = date('d-m-Y', strtotime($row['com_date']));

    $branch_id = $row['branch_name'];
    $qry = $mysqli->query("SELECT b.branch_name FROM branch_creation b  where b.branch_id = '" . $branch_id . "' ");
    $row1 = $qry->fetch_assoc();
    $sub_array[] = $row1['branch_name'];

    //Staff Name fetch
    $staff_id = $row['staff_assign_to'];
    $qry = $mysqli->query("SELECT staff_name FROM staff_creation where staff_id = $staff_id ");
    $row1 = $qry->fetch_assoc();
    $staff_name = $row1['staff_name'];

    $sub_array[] = $staff_name;

    //Concern Subject Name Fetch
    $com_sub_id = $row['com_sub'];
    $qry = $mysqli->query("SELECT concern_subject FROM concern_subject where concern_sub_id = $com_sub_id ");
    $row1 = $qry->fetch_assoc();
    $con_sub = $row1['concern_subject'];

    $sub_array[] = $con_sub;

    //Status
    $con_sts = $row['status'];
    if ($con_sts == 0) {
        $sub_array[] = 'Pending';
    }
    if ($con_sts == 1) {
        $sub_array[] = 'Resolved';
    }

    $id = $row['id'];

    if ($con_sts == 0) {
        $action = "<a href='concern_solution&upd=$id' title='Add Solution' >  <span class='icon-border_color' style='font-size: 12px;position: relative;top: 2px;'></span> </a>";
    } else if ($con_sts == 1) {
        $action = "<a href='concern_solution_view&upd=$id&pageId=2' title='View Solution' >  <span class='icon-eye' style='font-size: 12px;position: relative;top: 2px;'></span> </a>";
    }

    $sub_array[] = $action;

    $data[]      = $sub_array;
    $sno = $sno + 1;
}

function count_all_data($connect)
{
    $query     = "SELECT cp.cus_id as cp_cus_id,cp.cus_name,cp.area_confirm_area,cp.area_confirm_subarea,cp.area_line,cp.mobile1, ii.cus_id as ii_cus_id, ii.req_id FROM 
    acknowlegement_customer_profile cp JOIN in_issue ii ON cp.cus_id = ii.cus_id
    where ii.status = 0 and ii.cus_status = 21 GROUP BY ii.cus_id ";
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

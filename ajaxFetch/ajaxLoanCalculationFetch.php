<?php
include('../ajaxconfig.php');
@session_start();

if(isset($_SESSION["userid"])){
    $userid = $_SESSION["userid"];
}

$column = array(

    'loan_cal_id',
    'loan_category', 
    'sub_category', 
    'due_method',
    'due_type', 
    'profit_method',
    'calculate_method',
    // 'loan_limit',
    'status'
);

$query = "SELECT * FROM loan_calculation ";

if(isset($_POST['search']) && $_POST['search']!="");
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
            loan_category LIKE '%".$_POST['search']."%'
            OR sub_category LIKE '%".$_POST['search']."%'
            OR due_method LIKE '%".$_POST['search']."%'
            OR due_type LIKE '%".$_POST['search']."%'
            OR profit_method LIKE '%".$_POST['search']."%'
            OR calculate_method LIKE '%".$_POST['search']."%' ";
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

    $loan_cat_name_id = $row['loan_category'];
    $getqry = "SELECT * FROM loan_category_creation WHERE loan_category_creation_id ='".strip_tags($loan_cat_name_id)."' and status = 0";
    $res12 = $con->query($getqry);
    $row12 = $res12->fetch_assoc();
    $sub_array[] = $row12["loan_category_creation_name"];      

    $sub_array[] = $row['sub_category'];
    $sub_array[] = $row['due_method'];

    if($row['due_type']=='emi'){$sub_array[] = 'EMI';}else
    if($row['due_type']=='intrest'){$sub_array[] = 'Interest';}
    // if($row['due_type']=='emi,intrest'){$sub_array[] = 'EMI, Intrest';}

    if($row['profit_method']=='pre_intrest'){$sub_array[] = 'Pre Interest';}else
    if($row['profit_method']=='after_intrest'){$sub_array[] = 'After Interest';}else
    if($row['profit_method']=='pre_intrest,after_intrest'){$sub_array[] = 'Pre Interest, After Interest';}else{ $sub_array[] = ''; }

    $sub_array[] = ucwords($row['calculate_method']);     

    
    
    // $sub_array[] = moneyFormatIndia($row['loan_limit']);
    
    $status      = $row['status'];
    if($status == 1)
	{
	$sub_array[] = "<span style='width: 144px;'><span class='kt-badge  kt-badge--danger kt-badge--inline kt-badge--pill'>Inactive</span></span>";
	}
	else
	{
    $sub_array[] = "<span style='width: 144px;'><span class='kt-badge  kt-badge--success kt-badge--inline kt-badge--pill'>Active</span></span>";
	}
	$id   = $row['loan_cal_id'];
	
	$action="<a href='loan_calculation&upd=$id' title='Edit details'><span class='icon-border_color'></span></a>&nbsp;&nbsp; 
	<a href='loan_calculation&del=$id' title='Delete details' class='delete_loan_calculation'><span class='icon-trash-2'></span></a>";

	$sub_array[] = $action;
    $data[]      = $sub_array;
    $sno = $sno + 1;
}

//Format number in Indian Format
function moneyFormatIndia($num) {
    $explrestunits = "";
    if (strlen($num) > 3) {
        $lastthree = substr($num, strlen($num) - 3, strlen($num));
        $restunits = substr($num, 0, strlen($num) - 3);
        $restunits = (strlen($restunits) % 2 == 1) ? "0" . $restunits : $restunits;
        $expunit = str_split($restunits, 2);
        for ($i = 0; $i < sizeof($expunit); $i++) {
            if ($i == 0) {
                $explrestunits .= (int)$expunit[$i] . ",";
            } else {
                $explrestunits .= $expunit[$i] . ",";
            }
        }
        $thecash = $explrestunits . $lastthree;
    } else {
        $thecash = $num;
    }
    return $thecash;
}

function count_all_data($connect)
{
    $query     = "SELECT * FROM loan_calculation";
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
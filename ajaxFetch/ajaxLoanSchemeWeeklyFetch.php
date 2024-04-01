<?php
include('../ajaxconfig.php');
@session_start();

if(isset($_SESSION["userid"])){
    $userid = $_SESSION["userid"];
}

$column = array(
    'scheme_name',
    'loan_category',
    'sub_category', 
    'due_method',
    'intrest_rate',
    'due_period',
    'status'
);

$query = "SELECT * FROM loan_scheme WHERE due_method = 'weekly' ";

if(isset($_POST['search']) && $_POST['search']!="")
{

        if($_POST['search']=="Active")
        {
            $query .="and status=0 "; 
        }
        else if($_POST['search']=="Inactive")
        {
            $query .="and status=1 ";
        }

        else{	
            $query .= "
            and (scheme_name LIKE '%".$_POST['search']."%'
            OR loan_category LIKE '%".$_POST['search']."%'
            OR sub_category LIKE '%".$_POST['search']."%'
            OR due_method LIKE '%".$_POST['search']."%'
            OR intrest_rate LIKE '%".$_POST['search']."%'
            OR due_period LIKE '%".$_POST['search']."%'
            OR status LIKE '%".$_POST['search']."%') ";
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
    $sub_array[] = $row["scheme_name"]; 
    
    $loanCategoryName = $row['loan_category'];   
    $getqry = "SELECT * FROM loan_category_creation WHERE loan_category_creation_id ='".strip_tags($loanCategoryName)."' and status = 0";
    $res12 = $con->query($getqry);
    while($row12 = $res12->fetch_assoc())
    {
        $sub_array[] = $row12["loan_category_creation_name"];      
    }

    $sub_array[] = $row["sub_category"]; 

    //for Due method
    if( $row["due_method"] == 'monthly'){
        $sub_array[] = 'Monthly'; 
    }elseif( $row["due_method"] == 'weekly'){
        $sub_array[] = 'Weekly'; 
    }elseif( $row["due_method"] == 'daily'){
        $sub_array[] = 'Daily'; 
    }

    // //for profit method
    // if( $row["profit_method"] == 'pre_intrest'){
    //     $sub_array[] = 'Pre Interest'; 
    // }elseif( $row["profit_method"] == 'after_intrest'){
    //     $sub_array[] = 'After Interest'; 
    // }

    $sub_array[] = $row["intrest_rate"] . '%';        
    $sub_array[] = $row["due_period"];        
    
    $status      = $row['status'];
    if($status == 1)
	{
	$sub_array[] = "<span style='width: 144px;'><span class='kt-badge  kt-badge--danger kt-badge--inline kt-badge--pill'>Inactive</span></span>";
	}
	else
	{
    $sub_array[] = "<span style='width: 144px;'><span class='kt-badge  kt-badge--success kt-badge--inline kt-badge--pill'>Active</span></span>";
	}
	$id   = $row['scheme_id'];
	
	$action="<a href='loan_scheme&upd=$id&type=weekly' title='Edit details'><span class='icon-border_color'></span></a>&nbsp;&nbsp; 
	<a href='loan_scheme&del=$id&type=weekly' title='Delete details' class='delete_loan_scheme'><span class='icon-trash-2'></span></a>";

	$sub_array[] = $action;
    $data[]      = $sub_array;
    $sno = $sno + 1;
}

function count_all_data($connect)
{
    $query     = "SELECT * FROM loan_scheme";
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
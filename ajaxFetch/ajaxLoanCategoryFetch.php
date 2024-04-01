<?php
include('../ajaxconfig.php');
@session_start();

if(isset($_SESSION["userid"])){
    $userid = $_SESSION["userid"];
}

$column = array(
    'loan_category_id', 
    'loan_category_name',
    'sub_category_name', 
    'loan_limit', 
    'status' 
);

$query = "SELECT * FROM loan_category ";

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
            $query .= " WHERE
            loan_category_name LIKE  '%".$_POST['search']."%'
            OR loan_limit LIKE  '%".$_POST['search']."%'
            OR sub_category_name LIKE '%".$_POST['search']."%' ";
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

    // fetch event name
    $loanCategoryName = $row['loan_category_name'];   
    $getqry = "SELECT loan_category_creation_name FROM loan_category_creation WHERE loan_category_creation_id ='".strip_tags($loanCategoryName)."' and status = 0";
    $res12 = $con->query($getqry);
    while($row12 = $res12->fetch_assoc())
    {
        $loan_category_creation_name = $row12["loan_category_creation_name"];      
    }
    
    $sub_array[] = $loan_category_creation_name;
    $sub_array[] = $row['sub_category_name']; 
    $sub_array[] = moneyFormatIndia($row['loan_limit']); 
    $status      = $row['status'];
    if($status == 1)
	{
	$sub_array[] = "<span style='width: 144px;'><span class='kt-badge  kt-badge--danger kt-badge--inline kt-badge--pill'>Inactive</span></span>";
	}
	else
	{
    $sub_array[] = "<span style='width: 144px;'><span class='kt-badge  kt-badge--success kt-badge--inline kt-badge--pill'>Active</span></span>";
	}
	$id   = $row['loan_category_id'];
	
	$action="<a href='loan_category&upd=$id' title='Edit details'><span class='icon-border_color'></span></a>&nbsp;&nbsp; 
	<a href='loan_category&del=$id' title='Delete details' class='loan_category_delete'><span class='icon-trash-2'></span></a>";

	$sub_array[] = $action;
    $data[]      = $sub_array;
    $sno = $sno + 1;
}

function count_all_data($connect)
{
    $query     = "SELECT * FROM loan_category";
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

<?php
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


?>
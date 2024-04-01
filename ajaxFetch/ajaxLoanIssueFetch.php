<?php
@session_start();
include('..\ajaxconfig.php');

if(isset($_SESSION["userid"])){
    $userid = $_SESSION["userid"];
    $sql = $con->query("SELECT ag_id FROM user where user_id = '$userid'");
    $login_user_type = $sql->fetch_assoc()['ag_id'];
    if($login_user_type == null or $login_user_type == '') {$login_user_type = 0;}
}
if($userid != 1){
    
    $userQry = $con->query("SELECT * FROM USER WHERE user_id = $userid ");
    while($rowuser = $userQry->fetch_assoc()){
        $group_id = $rowuser['group_id'];
    }
    $group_id = explode(',',$group_id);
    $sub_area_list = array();
    foreach($group_id as $group){
        $groupQry = $con->query("SELECT * FROM area_group_mapping where map_id = $group ");
        $row_sub = $groupQry->fetch_assoc();
        $sub_area_list[] = $row_sub['sub_area_id'];
    }
    $sub_area_ids = array();
    foreach ($sub_area_list as $subarray) {
        $sub_area_ids = array_merge($sub_area_ids, explode(',',$subarray));
    }
    $sub_area_list = array();
    $sub_area_list = implode(',',$sub_area_ids);
}

$column = array(
    'req_id',
    'dor',
    'cus_id',
    'cus_name',
    'cus_name',//for branch
    'cus_name',//for group
    'cus_name',//for line
    'area',
    'sub_area',
    'loan_category',
    'sub_category',
    'loan_amt',
    'user_type',
    'user_name',
    'agent_id',
    'responsible',
    'cus_data',
    'cus_status',
    'status'
);

if($userid == 1){
    // $query = 'SELECT * FROM in_verification where status = 0 and (cus_status = 13 or cus_status = 14) '; // Move To Issue
    $query = "SELECT a.dor,a.cus_id,a.cus_name,a.area,a.sub_area,a.user_type,a.user_name,a.agent_id,a.responsible,a.cus_data,a.req_id,a.cus_status,a.req_id,b.loan_category,b.sub_category,b.loan_amt FROM in_verification a JOIN acknowlegement_loan_calculation b on a.req_id=b.req_id where a.status = 0 and (a.cus_status = 13 or a.cus_status = 14) "; // Move To Issue
}else{
  //  $query = "SELECT * FROM in_verification where status = 0 and (cus_status = 13 or cus_status = 14) and sub_area IN ($sub_area_list) ";
  $query = "SELECT a.dor,a.cus_id,a.cus_name,a.area,a.sub_area,a.user_type,a.user_name,a.agent_id,a.responsible,a.cus_data,a.req_id,a.cus_status,a.req_id,b.loan_category,b.sub_category,b.loan_amt FROM in_verification a JOIN acknowlegement_loan_calculation b on a.req_id=b.req_id where a.status = 0 and (a.cus_status = 13 or a.cus_status = 14) and a.sub_area IN ($sub_area_list) ";  //show only Approved Verification in Acknowledgement. // 13 Move to Issue. // 14 Move To Collection.
}

if(isset($_POST['search']) && $_POST['search'] != "")
{

        $query .= "
            and (a.req_id LIKE '%".$_POST['search']."%'
            OR a.dor LIKE '%".$_POST['search']."%'
            OR a.cus_id LIKE '%".$_POST['search']."%'
            OR a.cus_name LIKE '%".$_POST['search']."%'
            OR a.cus_name LIKE '%".$_POST['search']."%'
            OR a.cus_name LIKE '%".$_POST['search']."%'
            OR a.cus_name LIKE '%".$_POST['search']."%'
            OR a.area LIKE '%".$_POST['search']."%'
            OR a.sub_area LIKE '%".$_POST['search']."%'
            OR b.loan_category LIKE '%".$_POST['search']."%'
            OR b.sub_category LIKE '%".$_POST['search']."%'
            OR b.loan_amt LIKE '%".$_POST['search']."%'
            OR a.user_type LIKE '%".$_POST['search']."%'
            OR a.user_name LIKE '%".$_POST['search']."%'
            OR a.agent_id LIKE '%".$_POST['search']."%'
            OR a.responsible LIKE '%".$_POST['search']."%'
            OR a.cus_data LIKE '%".$_POST['search']."%'
            OR a.cus_status LIKE '%".$_POST['search']."%' ) ";
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
    
    $sub_array[] = date('d-m-Y',strtotime($row['dor']));
    
    // $cus_id = $row['cus_id'];
    // $cus_id = preg_replace('/\D/', '', $cus_id);
    // $cus_id = implode(' ', str_split($cus_id, 4));
    // $sub_array[] = $cus_id;

    $sub_array[] = $row['cus_id'];
    $sub_array[] = $row['cus_name'];
    
    //Area Name fetch
    $area_id = $row['area'];
    $qry = $mysqli->query("SELECT * FROM area_list_creation where area_id = $area_id ");
    $row1 = $qry->fetch_assoc();
    $area_name = $row1['area_name'];
    
    //Sub Area Name Fetch
    $sub_area_id = $row['sub_area'];
    $qry = $mysqli->query("SELECT * FROM sub_area_list_creation where sub_area_id = $sub_area_id ");
    $row1 = $qry->fetch_assoc();
    $sub_area_name = $row1['sub_area_name'];
    
    //Group name Fetch
    $qry = $mysqli->query("SELECT * FROM area_group_mapping where FIND_IN_SET($sub_area_id,sub_area_id)");
    $row1 = $qry->fetch_assoc();
    $group_name = $row1['group_name'];
    $branch_id = $row1['branch_id'];

    //Branch name Fetch
    $getbranchQry = "SELECT * from branch_creation where branch_id = '".$branch_id."' and status = 0 ";
    $res=$con->query($getbranchQry);
    $row1=$res->fetch_assoc();
    $branch_name = $row1["branch_name"];        

    //Line name Fetch
    $qry = $mysqli->query("SELECT * FROM area_line_mapping where FIND_IN_SET($sub_area_id,sub_area_id)");
    $row1 = $qry->fetch_assoc();
    $line_name = $row1['line_name'];

    $sub_array[] = $branch_name;
    $sub_array[] = $group_name;
    $sub_array[] = $line_name;
    $sub_array[] = $area_name;
    $sub_array[] = $sub_area_name;
    

    $loanCategoryName = $row['loan_category'];   
    $getqry = "SELECT * FROM loan_category_creation WHERE loan_category_creation_id ='".strip_tags($loanCategoryName)."' ";
    $res12 = $con->query($getqry);
    $row12 = $res12->fetch_assoc();
    $sub_array[] = $row12["loan_category_creation_name"];      

    $sub_array[] = $row['sub_category'];
    
    $sub_array[] = moneyFormatIndia($row['loan_amt']);
    $sub_array[] = $row['user_type'];
    $sub_array[] = $row['user_name'];
    
    $ag_id = $row['agent_id'];
    if($ag_id != ''){

        $qry = $mysqli->query("SELECT * FROM agent_creation where ag_id = $ag_id ");
        $row1 = $qry->fetch_assoc();
        $sub_array[] = $row1['ag_name'];
    }else{
        $sub_array[] = '';
    }

    if($row['responsible'] == '0'){$sub_array[] = 'Yes';}else{$sub_array[] = '';}

    $sub_array[] = $row['cus_data'];
    $id = $row['req_id'];
    
    $cus_status = $row['cus_status'];
    $loan_issued = $mysqli->query("SELECT balance_amount FROM `loan_issue` WHERE req_id='$id' order by id desc LIMIT 1 ");
    $loan_issued_db =  $loan_issued->fetch_assoc();

    if(empty($ag_id)){// only check balance amount if request is not on agent

        if($cus_status == '13'){
            
            if(isset($loan_issued_db['balance_amount']) && $loan_issued_db['balance_amount'] =='0'){
                $sub_array[] = "<button class='btn btn-outline-secondary complete_issue' value='$id'><span class = 'icon-arrow_forward'></span></button>";
            }else{
                $sub_array[] = 'In Issue';
            }
            
        }else if($cus_status == '14'){
            $sub_array[] = 'Issued';
        }
    }else{//else directly show move button to collection, then it will be taken care by cash tally screen
        if($cus_status == '14'){
            $sub_array[] = 'Issued';
        }else{
            $sub_array[] = "<button class='btn btn-outline-secondary complete_issue' value='$id'><span class = 'icon-arrow_forward'></span></button>";
        }
    }



    $id          = $row['req_id'];
    $user_type = $row['user_type'];
    $cus_id = $row['cus_id'];
    
    $action="<div class='dropdown'>
    <button class='btn btn-outline-secondary'><i class='fa'>&#xf107;</i></button>
    <div class='dropdown-content'>";

    if($cus_status == '13' and empty($ag_id)) { // check whether agent id is empty, if yes then show edit button, so that only 'issued to customer' entries only can edit
        $action .= "<a href='loan_issue&upd=$id' class='customer_profile' value='$id' > Edit Loan Issue </a>";
        // $action .= "<a href='loan_issue&can=$id' class='ack-cancel' value='$id' > Cancel </a>";
    }else if($cus_status == '14') {
        $action .= "<a href=''class='iss-remove' data-value='$id' > Remove </a>";
    }

    if($login_user_type == 0 or $userid == 1){
        $action .= "<a href='' data-value ='".$cus_id."' data-value1 = '$id' class='customer-status' data-toggle='modal' data-target='.customerstatus'>Customer Status</a>";
        // $action .= "<a href='' data-value ='".$cus_id."' data-value1 = '$id' class='loan-summary' data-toggle='modal' data-target='.loansummary'>Loan Summary</a>";
    }

    
    $action .= "</div></div>";
    
    $sub_array[] = $action;
    $data[]      = $sub_array;
    $sno = $sno+1;
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
    $query     = "SELECT * FROM in_verification";
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
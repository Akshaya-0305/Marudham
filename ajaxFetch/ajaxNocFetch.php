<?php
@session_start();
include('..\ajaxconfig.php');

if(isset($_SESSION["userid"])){
    $userid = $_SESSION["userid"];
}
if($userid != 1){
    
    $userQry = $con->query("SELECT * FROM USER WHERE user_id = $userid ");
    while($rowuser = $userQry->fetch_assoc()){
        $group_id = $rowuser['group_id'];
        $line_id = $rowuser['line_id'];
    }

    $line_id = explode(',',$line_id);
    $sub_area_list = array();
    foreach($line_id as $line){
        $lineQry = $con->query("SELECT * FROM area_line_mapping where map_id = $line ");
        $row_sub = $lineQry->fetch_assoc();
        $sub_area_list[] = $row_sub['sub_area_id'];
    }
    $sub_area_ids = array();
    foreach ($sub_area_list as $subarray) {
        $sub_area_ids = array_merge($sub_area_ids, explode(',',$subarray));
    }
    $sub_area_list = array();
    $sub_area_list = implode(',',$sub_area_ids);
}


class nocStatus
{
    public function getNocCompletedStatus($con, $id, $cus_id)
    {
        //this function is to find out whether all of the req id's documents are given to customer or not
        // also it will return values if the document is temporarly taken out for some purpose. they should mark as returned in respective screen and to give noc here
        $response = 0;

        $sql = $con->query("SELECT sd.* From signed_doc sd JOIN in_issue ii ON ii.req_id = sd.req_id where ii.cus_status = 21 and ii.cus_id = $cus_id and sd.noc_given !='1' ");
        $response = $response + $sql->num_rows;

        $sql = $con->query("SELECT cnl.* From cheque_no_list cnl JOIN in_issue ii ON ii.req_id = cnl.req_id where ii.cus_status = 21 and ii.cus_id = $cus_id and cnl.noc_given !='1' ");
        $response = $response + $sql->num_rows;

        $sql = $con->query("SELECT ackd.* From acknowlegement_documentation ackd JOIN in_issue ii ON ii.req_id = ackd.req_id where ii.cus_status = 21 and ii.cus_id = $cus_id and ackd.mortgage_process = 0 and ( ackd.mortgage_process_noc != '1' || (ackd.mortgage_document = 0 and ackd.mortgage_document_upd IS NOT NULL and ackd.mortgage_document_noc != '1' ) ) ");
        $response = $response + $sql->num_rows;

        $sql = $con->query("SELECT ackd.* From acknowlegement_documentation ackd JOIN in_issue ii ON ii.req_id = ackd.req_id where ii.cus_status = 21 and ii.cus_id = $cus_id and ackd.endorsement_process = 0 and ( (ackd.endorsement_process_noc != '1') || (ackd.en_RC = 0 && ackd.en_RC_noc != '1') || (ackd.en_Key = 0 && ackd.en_Key_noc != '1')) ");
        $response = $response + $sql->num_rows;

        $sql = $con->query("SELECT gi.* From gold_info gi JOIN in_issue ii ON ii.req_id = gi.req_id where ii.cus_status = 21 and ii.cus_id = $cus_id and gi.noc_given !='1' ");
        $response = $response + $sql->num_rows;

        $sql = $con->query("SELECT di.* From document_info di JOIN in_issue ii ON ii.req_id = di.req_id where ii.cus_status = 21 and ii.cus_id = $cus_id and di.doc_info_upload_noc !='1' ");
        $response = $response + $sql->num_rows;

        // echo $cus_id.' - '.$response.'***';
        return $response;
    }
}

$obj = new nocStatus;

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

if($userid == 1){
    $query = 'SELECT cp.cus_id as cp_cus_id,cp.cus_name,cp.area_confirm_area,cp.area_confirm_subarea,cp.area_line,cp.mobile1, ii.cus_id as ii_cus_id, ii.req_id FROM 
    acknowlegement_customer_profile cp JOIN in_issue ii ON cp.cus_id = ii.cus_id
    where ii.status = 0 and ii.cus_status = 21 GROUP BY ii.cus_id '; // Only Issued and all lines not relying on sub area
}else{
    $query = "SELECT cp.cus_id as cp_cus_id,cp.cus_name,cp.area_confirm_area,cp.area_confirm_subarea,cp.area_line,cp.mobile1, ii.cus_id as ii_cus_id, ii.req_id FROM 
    acknowlegement_customer_profile cp JOIN in_issue ii ON cp.cus_id = ii.cus_id
    where ii.status = 0 and ii.cus_status = 21 and cp.area_confirm_subarea IN ($sub_area_list) GROUP BY ii.cus_id ";//show only issued customers within the same lines of user. 
}

if(isset($_POST['search']) && $_POST['search'] != "")
{

    $query .= "
        and (cp.cus_id LIKE '%".$_POST['search']."%'
        OR cp.cus_name LIKE '%".$_POST['search']."%'
        OR cp.area_line LIKE '%".$_POST['search']."%'
        OR cp.mobile1 LIKE '%".$_POST['search']."%' ) ";
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
    
    $sub_array[] = $row['cp_cus_id'];
    $sub_array[] = $row['cus_name'];
    
    
    
    //Area Name fetch
    $area_id = $row['area_confirm_area'];
    $qry = $mysqli->query("SELECT * FROM area_list_creation where area_id = $area_id ");
    $row1 = $qry->fetch_assoc();
    $area_name = $row1['area_name'];
    
    $sub_array[] = $area_name;

    //Sub Area Name Fetch
    $sub_area_id = $row['area_confirm_subarea'];
    $qry = $mysqli->query("SELECT * FROM sub_area_list_creation where sub_area_id = $sub_area_id ");
    $row1 = $qry->fetch_assoc();
    $sub_area_name = $row1['sub_area_name'];
    
    $sub_array[] = $sub_area_name;
    
    $line_name = $row['area_line'];
    $qry = $mysqli->query("SELECT b.branch_name FROM branch_creation b JOIN area_line_mapping l ON l.branch_id = b.branch_id where l.line_name = '".$line_name."' ");
    $row1 = $qry->fetch_assoc();
    $sub_array[] = $row1['branch_name'];

    $sub_array[] = $row['area_line'];
    $sub_array[] = $row['mobile1'];
    
    $cus_id = $row['cp_cus_id'];
    $id          = $row['req_id'];

    $docToIssue = $obj->getNocCompletedStatus($con, $id, $cus_id);
    
    $action ="<div class='dropdown'>
    <button class='btn btn-outline-secondary'><i class='fa'>&#xf107;</i></button>
    <div class='dropdown-content'>";

        $action .="<a href='noc&upd=$id&cusidupd=$cus_id' title='Edit details' >NOC</a>";
        if($docToIssue == 0){
            //if this variable contains value 0 then all document are given to customer as noc
            $action .="<a href='' title='Remove details' class='remove-noc' data-reqid='$id' data-cusid='$cus_id' >Remove</a>";
            $action .="<a href='' title='NOC Letter' class='noc-letter' data-reqid='$id' data-cusid='$cus_id' >NOC Letter</a>";
        }
    
    $action .= "</div></div>";

    $sub_array[] = $action;
    $data[]      = $sub_array;
    $sno = $sno+1;
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

?>

<?php



?>
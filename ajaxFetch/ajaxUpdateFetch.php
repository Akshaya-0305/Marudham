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

if($userid == 1){
    $query = 'SELECT * FROM customer_register WHERE cus_status >= 13'; 
}else{
    $query = "SELECT * FROM customer_register  WHERE cus_status >= 13 && sub_area IN ($sub_area_list)";
}

if(isset($_POST['search']) && $_POST['search'] != "")
{

    $query .= "
        and (cus_id LIKE '%".$_POST['search']."%'
        OR customer_name LIKE '%".$_POST['search']."%'
        OR area_group LIKE '%".$_POST['search']."%'
        OR area_line LIKE '%".$_POST['search']."%'
        OR mobile1 LIKE '%".$_POST['search']."%' ) ";
}

$query .= " GROUP BY cus_id ";

$query1 = '';

if ($_POST['length'] != -1) {
    $query1 = ' LIMIT ' . $_POST['start'] . ', ' . $_POST['length'];
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
    $cus_id = $row['cus_id'];
    $sub_array[] = $cus_id;
    $sub_array[] = $row['customer_name'];
    
    $areaqry = $con->query("SELECT CASE 
    WHEN ( SELECT COUNT(*) FROM customer_profile WHERE cus_id = $cus_id ) > 0 
    THEN ( SELECT area_name FROM area_list_creation WHERE area_id = ( SELECT area_confirm_area FROM customer_profile WHERE cus_id = $cus_id ORDER BY `id` DESC LIMIT 1 ) ) 
    ELSE ( SELECT area_name FROM area_list_creation WHERE area_id = ( SELECT `area` FROM request_creation WHERE cus_id = $cus_id ORDER BY `req_id` DESC LIMIT 1 ) ) END AS `area_name`
    ");
    $sub_array[] = $areaqry->fetch_assoc()['area_name'];

    // $areaqry = $con->query("SELECT area_name FROM area_list_creation where area_id = '".$row['area']."' ");
    // $sub_array[] = $areaqry->fetch_assoc()['area_name'];
    
    // $subareaqry = $con->query("SELECT sub_area_name FROM sub_area_list_creation where sub_area_id = '".$row['sub_area']."' ");
    // $sub_array[] = $subareaqry->fetch_assoc()['sub_area_name'];
    
    $branchqry = $con->query("SELECT bc.branch_name FROM area_group_mapping agm JOIN branch_creation bc ON agm.branch_id = bc.branch_id where  FIND_IN_SET('".$row['area']."' , agm.area_id) ");
    $sub_array[] = $branchqry->fetch_assoc()['branch_name'];
    
    $lineqry = $con->query("SELECT CASE 
    WHEN ( SELECT COUNT(*) FROM customer_profile WHERE cus_id = $cus_id ) > 0 
    THEN ( SELECT line_name FROM area_line_mapping WHERE FIND_IN_SET( ( SELECT area_confirm_subarea FROM customer_profile WHERE cus_id = $cus_id ORDER BY `id` DESC LIMIT 1 ) , sub_area_id) ) 
    ELSE ( SELECT line_name FROM area_line_mapping WHERE FIND_IN_SET( ( SELECT sub_area FROM request_creation WHERE cus_id = $cus_id ORDER BY `req_id` DESC LIMIT 1 ), sub_area_id ) )
    END AS `line_name`
    ");
    // $lineqry = $con->query("SELECT line_name FROM area_line_mapping where  FIND_IN_SET('".$row['area']."' , area_id) ");
    $sub_array[] = $lineqry->fetch_assoc()['line_name'];
    
    $grpqry = $con->query("SELECT CASE 
    WHEN ( SELECT COUNT(*) FROM customer_profile WHERE cus_id = $cus_id ) > 0 
    THEN ( SELECT group_name FROM area_group_mapping WHERE FIND_IN_SET( ( SELECT area_confirm_subarea FROM customer_profile WHERE cus_id = $cus_id ORDER BY `id` DESC LIMIT 1 ) , sub_area_id) ) 
    ELSE ( SELECT group_name FROM area_group_mapping WHERE FIND_IN_SET( ( SELECT sub_area FROM request_creation WHERE cus_id = $cus_id ORDER BY `req_id` DESC LIMIT 1 ), sub_area_id ) )
    END AS `group_name`
    ");
    // $grpqry = $con->query("SELECT group_name FROM area_group_mapping where FIND_IN_SET('".$row['area']."' , area_id) ");
    $sub_array[] = $grpqry->fetch_assoc()['group_name'];

    if(getDocumentStatus($con,$cus_id) == false){
        $sub_array[] = 'Document Pending';
    }else{
        $sub_array[] = 'Document Completed';
    }

    $id          = $row['cus_id'];
    $cus_id      = $row['cus_id'];
// if($cus_id == '100010001000'){die;}
    $action = "<a href='update&upd=$id' title='Update'>  <span class='icon-border_color' style='font-size: 12px;position: relative;top: 2px;'></span> </a>";
    
    $sub_array[] = $action;
    $data[]      = $sub_array;
    $sno = $sno+1;
}

function count_all_data($connect)
{
    $query     = "SELECT * FROM customer_register";
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

function getDocumentStatus($con,$cus_id){
    
    $response1 = 'completed';

    // $sts_qry = $con->query("SELECT id,doc_Count FROM signed_doc_info where cus_id = '$cus_id' ");//echo "SELECT id,doc_Count FROM signed_doc_info where cus_id = '$cus_id' "; 
    // if($sts_qry->num_rows > 0){
    //     while($sts_row=$sts_qry->fetch_assoc()){
            
    //         $sts_qry1 = $con->query("SELECT * FROM signed_doc where cus_id = '$cus_id' and signed_doc_id='".$sts_row['id']."' "); //echo ' $sts_qry1->num_rows:',$sts_qry1->num_rows,' docCount:',$sts_row['doc_Count'],'---';
    //         if($sts_qry1->num_rows == $sts_row['doc_Count'] && $response1 != 'pending' ){ // check whether mentioned count of signed document has been collected from customer or not
    //             $response1 = 'completed';// if condition true then all documents are collected
    //             //completed
    //         }else{
    //             $response1= 'pending';
    //         }
    //     }
    // }
    // else{
    //     $response1 = 'completed';//if there is no cheque then direclty it will be considered as completed
    // }
    
    
    $response2 = 'completed';
    // $sts_qry = $con->query("SELECT id,cheque_count FROM cheque_info where cus_id = '$cus_id' ");
    // if($sts_qry->num_rows > 0){
        
    //     while($sts_row=$sts_qry->fetch_assoc()){
            
    //         $sts_qry1 = $con->query("SELECT * FROM cheque_upd where cus_id = '$cus_id' and cheque_table_id='".$sts_row['id']."' ");
    //         if($sts_qry1->num_rows == $sts_row['cheque_count'] && $response2 != 'pending'){ // check whether mentioned count of Cheque has been collected from customer or not
    //             $response2 = 'completed';// if condition true then all documents are collected
    //         }else{
    //             $response2 = 'pending';
    //         }
    //     }
    // }
    // else{
    //     $response2 = true;//if there is no cheque then direclty it will be considered as completed
    // }
    

    $response3 = 'completed';
    $sts_qry = $con->query("SELECT mortgage_process,mortgage_document_pending,endorsement_process,Rc_document_pending FROM acknowlegement_documentation where cus_id_doc = '$cus_id' ");
    // echo "SELECT mortgage_process,mortgage_document_pending,endorsement_process,Rc_document_pending FROM acknowlegement_documentation where cus_id_doc = '$cus_id' ";

    if($sts_qry->num_rows > 0){
        while($sts_row=$sts_qry->fetch_assoc()){ //check any one of document for mortgage or endorsement is pending then response will be pending
        
            if($sts_row['mortgage_process'] == '0'){
                if($sts_row['mortgage_document_pending'] == 'YES'){
                    $response3 = 'pending';
                }
                
            }
            if($sts_row['endorsement_process'] == '0'){
                if($sts_row['Rc_document_pending'] == 'YES'){
                    $response3 = 'pending';
                }
                
            }

        //     if($sts_row['mortgage_process'] == '0' ){

        //         // if($sts_row['mortgage_document_pending'] == 'YES' || $sts_row['Rc_document_pending'] == 'YES'){
                    
        //         // }elseif($sts_row['mortgage_document_pending'] == 'NO' || $sts_row['Rc_document_pending'] == 'NO'){
        //         //     $response3 = true;// if condition false then all documents are collected
        //         // }

        //         if($sts_row['mortgage_document_pending'] == 'NO' && $response3 == ""){
        //             //if mortgage document is not pending then set response to true means completed
        //             $response3 = true;
        //         }else{
        //             $response3 = false;
        //         }
        //     }elseif($response3 != false){
        //         $response3 = true;
        //     }
        //     if($sts_row['endorsement_process'] == '0'){
        //         if($sts_row['Rc_document_pending'] == 'NO'){
        //             //if mortgage document is not pending then set response to true means completed
        //             $response3 = true;
        //         }else{
        //             $response3 = false;
        //         }
        //     }else{
        //         $response3 = true;
        //     }
        //     // }else{
        //     //     $response3 = true;// if condition false then all documents are collected
        //     // }
        }
    }
    // else{
    //     $response3 = true;//if there is no cheque then direclty it will be considered as completed
    // }
    
    // var_dump($response3);
    

    $response4 = 'completed';
    // $sts_qry = $con->query("SELECT * FROM document_info where cus_id = '$cus_id' ");
    // // echo "SELECT * FROM document_info where cus_id = '$cus_id' ";

    // if($sts_qry->num_rows > 0){
    //     while($sts_row = $sts_qry->fetch_assoc()){

    //         if($sts_row['doc_upload'] == '' || $sts_row['doc_upload'] == null ){ // check any of document that are added in verification is not still uploaded
    //             $response4 = 'pending';
    //         }
    //         // else if($response4 != false){ // in this stage current row of doc has been submitted but need to check the response is pending. if yes it should not changed to completed
    //         //     $response4 = true;
    //         // }
    //     }
    // }
    // else{
    //     $response4 = 'completed';//if there is no cheque then direclty it will be considered as completed
    // }
    
    // var_dump($response4);
    

    if($response1 == 'completed' and $response2 == 'completed' and $response3 == 'completed' and $response4 == 'completed'){
        $response = true;
    }else{
        $response = false;
    }
    
    return $response;
}
?>
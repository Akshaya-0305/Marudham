<?php
@session_start();
include('..\ajaxconfig.php');

if(isset($_SESSION["userid"])){
    $userid = $_SESSION["userid"];
}
if($userid != 1){
    
    $userQry = $con->query("SELECT * FROM USER WHERE user_id = $userid ");
    while($rowuser = $userQry->fetch_assoc()){
        $doc_rec_access = $rowuser['doc_rec_access'];
    }

}


$query = "SELECT * FROM document_track WHERE insert_login_id = $userid and track_status != 5 ";

if($doc_rec_access == '0'){
    $query = "SELECT * FROM document_track where track_status != 5 ";
}

if(isset($_POST['search']) && $_POST['search'] != "")
{

    $qry = $con->query("SELECT cus_id from customer_register where customer_name LIKe '%".$_POST['search']."%' ");
    $search1 = $qry->fetch_assoc()['cus_id'];
    $query .= "
        and (cus_id LIKE '%".$_POST['search']."%' OR cus_id LIKE '%".$search1."%') ";
}

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
    
    $sub_array[] = date('d-m-Y',strtotime($row['created_date'])); //Date column
    $sub_array[] = $row['cus_id'];//cus id column

    $cus_id = $row['cus_id'];
    $req_id = $row['req_id'];
    $track_status = $row['track_status'];
    
    $qry = $con->query("SELECT customer_name from customer_register where cus_id = $cus_id");
    $cus_name = $qry->fetch_assoc()['customer_name'];
    $sub_array[] = $cus_name;//cus name column


    //query to get area id using req id
    $qry = $con->query("SELECT area, sub_area from customer_register where cus_id = $cus_id");
    $row1 = $qry->fetch_assoc();
    $area_id = $row1['area'];
    $sub_area_id = $row1['sub_area'];

    $branchqry = $con->query("SELECT bc.branch_name FROM area_group_mapping agm JOIN branch_creation bc ON agm.branch_id = bc.branch_id where  FIND_IN_SET('".$area_id."' , agm.area_id) ");
    $sub_array[] = $branchqry->fetch_assoc()['branch_name']; //Branch name column

    $areaqry = $con->query("SELECT area_name FROM area_list_creation where area_id = '".$area_id."' ");
    $sub_array[] = $areaqry->fetch_assoc()['area_name'];//area name column
    
    $subareaqry = $con->query("SELECT sub_area_name FROM sub_area_list_creation where sub_area_id = '".$sub_area_id."' ");
    $sub_array[] = $subareaqry->fetch_assoc()['sub_area_name'];//sub area name column
    
    
    $lineqry = $con->query("SELECT line_name FROM area_line_mapping where  FIND_IN_SET('".$area_id."' , area_id) ");
    $sub_array[] = $lineqry->fetch_assoc()['line_name'];//line name column
    
    $grpqry = $con->query("SELECT group_name FROM area_group_mapping where FIND_IN_SET('".$area_id."' , area_id) ");
    $sub_array[] = $grpqry->fetch_assoc()['group_name'];//group name column
    

    $track_status_obj = [
        '1'=>'Acknowledgement','2'=>'Acknowledgement','3'=>'NOC','4'=>'NOC'
    ];
    $sub_array[] = $track_status_obj[$track_status];//Document For Column


    if($track_status == '1'){//if 1 then raised from branch for submitting ack
        
        //then document keeper will be inser login id
        $doc_keeper = $row['insert_login_id'];

        $qry = $con->query("SELECT fullname FROM user WHERE user_id = $doc_keeper ");
        $sub_array[] = $qry->fetch_assoc()['fullname'];//document keeper column

    }else if($track_status == '2'){

        //if status id 2 means, received in main branch
        $sub_array[] = 'Main Branch';//document keeper column

    }else if($track_status == '3'){

        //if status is 3, then documents not yet moved from main branch for noc
        $sub_array[] = 'Main Branch';//document keeper column

    }elseif($track_status == '4'){

        //if status is 4 means then document sent to branch from main
        // $qry = $con->query("SELECT fullname FROM user WHERE user_id = $doc_keeper ");
        // $sub_array[] = $qry->fetch_assoc()['fullname'];//document keeper column

        $branchqry = $con->query("SELECT bc.branch_name FROM area_line_mapping lm JOIN branch_creation bc ON lm.branch_id = bc.branch_id where FIND_IN_SET('".$sub_area_id."' , lm.sub_area_id) ");
        $sub_array[] = $branchqry->fetch_assoc()['branch_name'] . " Branch"; //document keeper column

    }

    $id = $row['id'];//table id

    $action = '';
    $action .= "<button class='btn btn-info'><i class='icon-eye'></i></button>";
    if($doc_rec_access == '0'){
        $action .= "<button class='btn btn-success'>Receive</button>";
    }

    $action ="<div class='dropdown'>
    <button class='btn btn-outline-secondary'><i class='fa'>&#xf107;</i></button>
    <div class='dropdown-content'>";

    $action .="<a href='' title='View details' class='view-track' data-reqid='$req_id' data-cusid='$cus_id' data-cusname='$cus_name' data-toggle='modal' data-target='.viewDocModal'>View</a>";
    
    if($doc_rec_access == '0'){

        if($track_status == '1' and $userid != $row['insert_login_id']){//1 means submitted in ack
            //show receive track when sent from ack
            $action .="<a href='' title='Receive Documents' class='receive-track' data-id='$id' data-reqid='$req_id' >Receive</a>";

        }else if($track_status == '3'){//3 means to be sent for noc
            //show Mark Sent when Moveing from main branch to branch for noc
            $action .="<a href='' title='Mark Documents Sent' class='send-track' data-id='$id' data-reqid='$req_id'>Mark as Sent</a>";            
        }
    }

    if($track_status == '2' || $track_status == '4'){

        $action .= "<a href='' title='Remove Track' class='remove-track' data-id='$id' data-reqid='$req_id' >Remove Track</a>";
    }
    
    $action .= "</div></div>";
    
    $sub_array[] = $action;
    

    $data[]      = $sub_array;
    $sno = $sno+1;
}

function count_all_data($connect)
{
    $query     = "SELECT * FROM document_track";
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


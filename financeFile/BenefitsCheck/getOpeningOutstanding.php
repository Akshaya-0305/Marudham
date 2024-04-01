<?php

include ('../../ajaxconfig.php');

$user_id = ($_POST['user_id'] != '') ? $_POST['user_id'] : '';
if($user_id != ''){//to get user's sub area id based on user's branch assigned if user selected

    $userQry = $con->query("SELECT * FROM USER WHERE user_id = $user_id ");
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


$type = $_POST['type'];

if($type == 'today'){
    $where = " DATE(updated_date) <= CURRENT_DATE and cus_status IN (14,15,16,17) ";
    
    $condition = ($user_id != '') ? " and FIND_IN_SET(sub_area ,'".$sub_area_list."') " : '';//this condition will check user based request ids in in_verification table
    
    getDetials($con,$condition, $where);
    

}else if($type == 'day'){

    $from_date = $_POST['from_date'];$to_date = $_POST['to_date'];
    
    $where = " (DATE(updated_date) >= '$from_date' and DATE(updated_date) <= '$to_date') and cus_status IN (14,15,16,17) ";
    $condition = ($user_id != '') ? " and FIND_IN_SET(sub_area ,'".$sub_area_list."') " : '';//this condition will check user based request ids in in_verification table
    
    getDetials($con,$condition, $where);
    

}else if($type == 'month'){
    
    $month = date('m',strtotime($_POST['month']));
    if($month == 01){
        $month = 12;
    }else{
        $month = $month - 1;
    }
    if($month == 12){
        $year = date('Y',strtotime($_POST['month'])) - 1 ;
    }else{
        $year = date('Y',strtotime($_POST['month']));
    }
    
    $where = " (MONTH(updated_date) <= '$month' && YEAR(updated_date) <= '$year') and cus_status IN (14,15,16,17) ";
    $condition = ($user_id != '') ? " and FIND_IN_SET(sub_area ,'".$sub_area_list."') " : ''; //this condition will check user based request ids in in_verification table

    getDetials($con,$condition, $where);

}


function getDetials($con,$condition, $where){
    
    $total_outstanding = 0;//Total outstanding amount
    $collected_outstanding = 0;//collected outstanding amount

    
    $qry1 = $con->query("SELECT req_id from in_acknowledgement where $where ");// >13 means entries moved to collection from issue
    
    // $where = str_replace('>','',rtrim($where,'and cus_status IN (14,15,16,17)'));
    $pattern = '/and cus_status IN \(14,15,16,17\)/';
    $where = preg_replace($pattern, '', $where);

    //removeing customer status and greater than symbol fo collection table//replace will only work for day type
    //reason to use where condition in collection is , we only need collection on particular date for calculating outstanding amt

    while($row1 = $qry1->fetch_assoc()){
        
        $qry = $con->query("SELECT req_id from in_verification where req_id = '".$row1['req_id']."' $condition ");//will check based on user's branch if user selected
        //will show only interest amunt under user's branch not others also
        if($qry->num_rows > 0){

            $qry = $con->query("SELECT sum(tot_amt_cal) as tot_amt_cal from acknowlegement_loan_calculation where req_id = '".$row1['req_id']."' ");
            
            //fetching overall collection amount to be get from customers
            $row = $qry->fetch_assoc();
            $total_outstanding += intVal($row['tot_amt_cal'] ?? 0);

            $qry = $con->query("SELECT sum(due_amt_track) as due_amt_track,sum(princ_amt_track) as princ_amt_track from collection where req_id = '".$row1['req_id']."' and $where ");
            //getting collected amount till mentioned date
            $row = $qry->fetch_assoc();
            $collected_outstanding += intVal($row['due_amt_track'] ?? 0) + intVal($row['princ_amt_track'] ?? 0);
        }
    }

    $response['opening_outstanding'] = intval($total_outstanding) - intval($collected_outstanding);
    $response['opening_outstanding'] = moneyFormatIndia($response['opening_outstanding']);

    echo json_encode($response);
}

//Format number in Indian Format
function moneyFormatIndia($num) {
    $isNegative = false;
    if ($num < 0) {
        $isNegative = true;
        $num = abs($num);
    }

    $explrestunits = "";
    if (strlen((string)$num) > 3) {
        $lastthree = substr((string)$num, -3);
        $restunits = substr((string)$num, 0, -3);
        $restunits = (strlen($restunits) % 2 == 1) ? "0" . $restunits : $restunits;
        $expunit = str_split($restunits, 2);
        foreach ($expunit as $index => $value) {
            if ($index == 0) {
                $explrestunits .= (int)$value . ",";
            } else {
                $explrestunits .= $value . ",";
            }
        }
        $thecash = $explrestunits . $lastthree;
    } else {
        $thecash = $num;
    }

    return $isNegative ? "-" . $thecash : $thecash;
}
?>
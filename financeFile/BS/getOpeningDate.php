<?php
// session_start();
// $user_id = $_SESSION['userid'];

include('../../ajaxconfig.php');

$type = $_POST['type'];
$user_id = ($_POST['user_id'] != '') ? $_POST['user_id'] : '';

$records = array();


if($type == 'today'){

    $where = " date(ct1.cl_date) <= CURRENT_DATE() ";
    $where2 = " date(ct2.cl_date) <= CURRENT_DATE() ";

    if($user_id != ''){$where .= " and ct1.insert_login_id = $user_id " ; }//for user based

    getDetails($con, $where, $where2);

    // $qry1 = $con->query("SELECT closing_bal FROM cash_tally where insert_login_id = '$user_id' and date(cl_date) = CURRENT_DATE() ");

    // if($qry1->num_rows == '0'){
    //     // if this condition true, then today's cash tally has not been closed, so have to
    //     $qry = $con->query("SELECT closing_bal FROM cash_tally where insert_login_id = '$user_id' and date(cl_date) < CURRENT_DATE() ORDER BY date(cl_date) DESC"); // then fetch the last updated date
        
    //     if($qry->num_rows != 0){
    //         $row = $qry->fetch_assoc();
    //         $records['closing_bal'] = $row['closing_bal'];
    //     }else{
    //         $records['closing_bal'] = 0;
    //     }
    // }else{
    //     // if this condition true, then today's cash tally has been closed
    //     $row1 = $qry1->fetch_assoc();
    //     $records['closing_bal'] = $row1['closing_bal'];
    // }

}else if($type == 'day'){

    $from_date = $_POST['from_date'];$to_date = $_POST['to_date'];
    
    $where = " date(ct1.cl_date) <= DATE('$from_date') ";
    $where2 = " date(ct2.cl_date) <= DATE('$from_date') ";
    
    if($user_id != ''){$where .= " and ct1.insert_login_id = $user_id " ; }//for user based

    getDetails($con, $where, $where2);


    // $qry1 = $con->query("SELECT closing_bal FROM cash_tally where insert_login_id = '$user_id' and (date(cl_date) >= DATE($from_date) && date(cl_date) <= DATE($to_date)) ORDER BY date(cl_date) DESC"); // then fetch the last updated date
    // //this will check between two days
    // if($qry1->num_rows == '0'){ // if nothing between two dates then take before date
        
    //     $qry = $con->query("SELECT closing_bal FROM cash_tally where insert_login_id = '$user_id' and date(cl_date) < DATE($from_date) ORDER BY date(cl_date) DESC"); 
    //     // it will get the last date entered
        
    //     if($qry->num_rows != 0){
    //         $row = $qry->fetch_assoc();
    //         $records['closing_bal'] = $row['closing_bal'];
    //     }else{
    //         $records['closing_bal'] = 0;
    //     }
    // }else{
    //     // if this condition true, then today's cash tally has been closed
    //     $row1 = $qry1->fetch_assoc();
    //     $records['closing_bal'] = $row1['closing_bal'];
    // }

}else if($type == 'month'){

    $month = date('m',strtotime($_POST['month']));
    $year = date('Y',strtotime($_POST['month']));

    $where = " (month(ct1.cl_date) = $month && YEAR(ct1.cl_date) = '$year' ) ";
    $where2 = " (month(ct2.cl_date) = $month && YEAR(ct2.cl_date) = '$year' ) ";
    if($user_id != ''){$where .= " and ct1.insert_login_id = $user_id " ; }//for user based

    getDetails($con, $where, $where2);


    // $qry1 = $con->query("SELECT closing_bal FROM cash_tally where insert_login_id = '$user_id' and (month(cl_date) = $month && YEAR(cl_date) = '$year' ) ORDER BY date(cl_date) DESC"); // then fetch the last updated date
    // //this will check within month
    // if($qry1->num_rows == '0'){ // if nothing inside the month then take before month

    //     $qry = $con->query("SELECT closing_bal FROM cash_tally where insert_login_id = '$user_id' and (month(cl_date) = $month && YEAR(cl_date) = '$year') ORDER BY date(cl_date) DESC"); // then fetch the last updated date
            
    //     if($qry->num_rows != 0){
    //         $row = $qry->fetch_assoc();
    //         $records['closing_bal'] = $row['closing_bal'];
    //     }else{
    //         $records['closing_bal'] = 0;
    //     }
    // }else{
    //     // if this condition true, then today's cash tally has been closed
    //     $row1 = $qry1->fetch_assoc();
    //     $records['closing_bal'] = $row1['closing_bal'];
    // }

}

function getDetails($con, $where, $where2){
    
    $records['closing_bal'] = 0;

    $qry = $con->query("SELECT ct1.insert_login_id, ct1.cl_date AS last_entered_date, ct1.closing_bal
    FROM cash_tally ct1
    WHERE $where and NOT EXISTS (
        SELECT 1
        FROM cash_tally ct2
        WHERE ct1.insert_login_id = ct2.insert_login_id 
    AND ct1.cl_date < ct2.cl_date and $where2 ) "); // then fetch the last updated date

    if($qry->num_rows != 0){

        while($row = $qry->fetch_assoc()){

            $records['closing_bal'] = $records['closing_bal'] + intVal($row['closing_bal']);
        }
    }else{
        $records['closing_bal'] = 0;
    }

    $records['closing_bal'] = moneyFormatIndia($records['closing_bal']);

    echo json_encode($records);
}


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
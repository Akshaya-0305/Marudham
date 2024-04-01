<?php
// session_start();
// $userid = $_SESSION['userid'];

include ('../../ajaxconfig.php');

$type = $_POST['type'];
$user_id = ($_POST['user_id'] != '') ? $where = " and insert_login_id = '".$_POST['user_id']."' " : $where = '';//for user based

if($type == 'today'){
    
    $qry = $con->query("SELECT SUM(due_amt_track) as due_amt_track,SUM(princ_amt_track) as princ_amt_track,SUM(int_amt_track) as int_amt_track,
    SUM(penalty_track) as penalty_track,SUM(coll_charge_track) as coll_charge_track 
    FROM collection where DATE(coll_date) = CURRENT_DATE $where ");


    if($qry->num_rows > 0){
        $row = $qry->fetch_assoc();
        $response['collection'] = ($row['due_amt_track'] ?? 0 + $row['princ_amt_track'] ?? 0 + $row['int_amt_track'] ?? 0) + ($row['penalty_track'] ?? 0) + ($row['coll_charge_track'] ?? 0);
    }else{
        $response['collection'] = 0;
    }

}else if($type == 'day'){

    $from_date = $_POST['from_date'];$to_date = $_POST['to_date'];
    $qry = $con->query("SELECT SUM(due_amt_track) as due_amt_track,SUM(princ_amt_track) as princ_amt_track,SUM(int_amt_track) as int_amt_track,
    SUM(penalty_track) as penalty_track,SUM(coll_charge_track) as coll_charge_track
    from collection where (DATE(coll_date) >= '$from_date' && DATE(coll_date) <= '$to_date' ) $where ");

    if($qry->num_rows > 0){
        $row = $qry->fetch_assoc();
        $response['collection'] = ($row['due_amt_track'] ?? 0 + $row['princ_amt_track'] ?? 0 + $row['int_amt_track'] ?? 0) + ($row['penalty_track'] ?? 0) + ($row['coll_charge_track'] ?? 0);
    }else{
        $response['collection'] = 0;
    }

}else if($type == 'month'){
    
    $month = date('m',strtotime($_POST['month']));
    $year = date('Y',strtotime($_POST['month']));

    $qry = $con->query("SELECT SUM(due_amt_track) as due_amt_track,SUM(princ_amt_track) as princ_amt_track,SUM(int_amt_track) as int_amt_track,
    SUM(penalty_track) as penalty_track,SUM(coll_charge_track) as coll_charge_track
    from collection where (MONTH(coll_date) = '$month' and YEAR(coll_date) = $year) $where ");

    if($qry->num_rows > 0){
        $row = $qry->fetch_assoc();
        $response['collection'] = ($row['due_amt_track'] ?? 0 + $row['princ_amt_track'] ?? 0 + $row['int_amt_track'] ?? 0) + ($row['penalty_track'] ?? 0) + ($row['coll_charge_track'] ?? 0);
    }else{
        $response['collection'] = 0;
    }
}
$response['collection'] = moneyFormatIndia($response['collection']);

echo json_encode($response);


?>


<?php

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
<?php


include ('../../ajaxconfig.php');

$type = $_POST['type'];
$user_id = ($_POST['user_id'] != '') ? $where = " and insert_login_id = '".$_POST['user_id']."' " : $where = '';//for user based

$doc_charge = 0;
$proc_charge = 0;

if($type == 'today'){
    
    $qry1 = $con->query("SELECT req_id from in_acknowledgement where DATE(updated_date) = CURRENT_DATE and cus_status > 13 $where ");// >13 means entries moved to collection from issue
    
    if($qry1->num_rows > 0){
        while($row1 = $qry1->fetch_assoc()){
            
            $qry = $con->query("SELECT doc_charge_cal,proc_fee_cal from acknowlegement_loan_calculation where req_id = '".$row1['req_id']."' ");
            $row = $qry->fetch_assoc();
            $doc_charge += intVal($row['doc_charge_cal']);
            $proc_charge += intVal($row['proc_fee_cal']);
        }
        $response['doc_charge'] = $doc_charge;
        $response['proc_charge'] = $proc_charge;
    }else{
        $response['doc_charge'] = 0;
        $response['proc_charge'] = 0;
    }

}else if($type == 'day'){

    $from_date = $_POST['from_date'];$to_date = $_POST['to_date'];
    
    $qry1 = $con->query("SELECT req_id from in_acknowledgement where (DATE(updated_date) >= DATE('$from_date') && DATE(updated_date) <= DATE('$to_date')) and cus_status > 13 $where ");// >13 means entries moved to collection from issue
    
    if($qry1->num_rows > 0){
        while($row1 = $qry1->fetch_assoc()){
            
            $qry = $con->query("SELECT doc_charge_cal,proc_fee_cal from acknowlegement_loan_calculation where req_id = '".$row1['req_id']."' ");
            $row = $qry->fetch_assoc();
            $doc_charge += intVal($row['doc_charge_cal']);
            $proc_charge += intVal($row['proc_fee_cal']);
        }
        $response['doc_charge'] = $doc_charge;
        $response['proc_charge'] = $proc_charge;
    }else{
        $response['doc_charge'] = 0;
        $response['proc_charge'] = 0;
    }

}else if($type == 'month'){
    
    $month = date('m',strtotime($_POST['month']));
    $year = date('Y',strtotime($_POST['month']));

    $qry1 = $con->query("SELECT req_id from in_acknowledgement where (MONTH(updated_date) = '$month' && YEAR(updated_date) = '$year') and cus_status > 13 $where ");// >13 means entries moved to collection from issue
    
    if($qry1->num_rows > 0){
        while($row1 = $qry1->fetch_assoc()){
            
            $qry = $con->query("SELECT doc_charge_cal,proc_fee_cal from acknowlegement_loan_calculation where req_id = '".$row1['req_id']."' ");
            $row = $qry->fetch_assoc();
            $doc_charge += intVal($row['doc_charge_cal']);
            $proc_charge += intVal($row['proc_fee_cal']);
        }
        $response['doc_charge'] = $doc_charge;
        $response['proc_charge'] = $proc_charge;
    }else{
        $response['doc_charge'] = 0;
        $response['proc_charge'] = 0;
    }
}
$response['doc_charge'] = moneyFormatIndia($response['doc_charge']);
$response['proc_charge'] = moneyFormatIndia($response['proc_charge']);

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
<?php


include ('../../ajaxconfig.php');

$type = $_POST['type'];
$user_id = ($_POST['user_id'] != '') ? $_POST['user_id'] : '';


if($type == 'today'){

    $where = " DATE(created_date) = CURRENT_DATE  ";
    if($user_id != ''){$where .= " && insert_login_id = '".$user_id."' " ; }//for user based
    getDetails($con, $where);
        

}else if($type == 'day'){

    $from_date = $_POST['from_date'];$to_date = $_POST['to_date'];

    $where = " (DATE(created_date) >= DATE('".$from_date."') && DATE(created_date) <= DATE('".$to_date."')) ";
    if($user_id != ''){$where .= " && insert_login_id = '".$user_id."' " ; }//for user based

    getDetails($con, $where);

        
}else if($type == 'month'){
    
    $month = date('m',strtotime($_POST['month']));
    $year = date('Y',strtotime($_POST['month']));

    $where = " MONTH(created_date) = '".$month."' && YEAR(created_date) = '".$year."'  ";
    if($user_id != ''){$where .= " && insert_login_id = '".$user_id."' " ; }//for user based
    
    getDetails($con, $where);
    
}




function getDetails($con, $where){
    // Issued
    $qry = $con->query("SELECT SUM(amt) as amt FROM (
        SELECT netcash as amt FROM ct_db_hissued WHERE $where
        UNION ALL
        SELECT netcash as amt FROM ct_db_bissued WHERE $where
    ) AS combined_table");

    $row = $qry->fetch_assoc();
    $issued = $row['amt'] ?? 0;

    $response['issued'] = intval($issued);
    
    // Expense
    $qry = $con->query("SELECT SUM(amt) as amt FROM (
        SELECT amt FROM ct_db_hexpense WHERE $where
        UNION ALL
        SELECT amt FROM ct_db_bexpense WHERE $where
    ) AS combined_table");

    $row = $qry->fetch_assoc();
    $expense = $row['amt'] ?? 0;

    $response['expense'] = intval($expense);
    
    // Bank Deposit
    $qry = $con->query("SELECT SUM(amount) as amt FROM ct_db_bank_deposit WHERE $where ");

    $row = $qry->fetch_assoc();
    $bank_deposit = $row['amt'] ?? 0;

    $response['bank_deposit'] = intval($bank_deposit);
    
    // Cash Withdrawal
    $qry = $con->query("SELECT SUM(amt) as amt FROM ct_db_cash_withdraw WHERE $where ");

    $row = $qry->fetch_assoc();
    $cash_withdrawal = $row['amt'] ?? 0;

    $response['cash_withdrawal'] = intval($cash_withdrawal);


    $response['issued'] = moneyFormatIndia($response['issued']);
    $response['expense'] = moneyFormatIndia($response['expense']);
    $response['bank_deposit'] = moneyFormatIndia($response['bank_deposit']);
    $response['cash_withdrawal'] = moneyFormatIndia($response['cash_withdrawal']);

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
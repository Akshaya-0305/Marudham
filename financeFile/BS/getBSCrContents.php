<?php


include ('../../ajaxconfig.php');

$type = $_POST['type'];
$user_id = ($_POST['user_id'] != '') ? $_POST['user_id'] : '';


if($type == 'today'){

    $where = " DATE(created_date) = CURRENT_DATE ";
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

    $where = " MONTH(created_date) = '".$month."' && YEAR(created_date) = '".$year."' ";
    if($user_id != ''){$where .= " && insert_login_id = '".$user_id."' " ; }//for user based

    getDetails($con, $where);
    
}




function getDetails($con, $where){
    // other income
    $qry = $con->query("SELECT SUM(amt) as other_income FROM (
        SELECT amt FROM ct_cr_hoti WHERE $where
        UNION ALL
        SELECT amt FROM ct_cr_boti WHERE $where
    ) AS combined_table");

    $row = $qry->fetch_assoc();
    $other_income = $row['other_income'] ?? 0;

    $response['other_income'] = intval($other_income);

    // Bank Withdrawal
    $qry = $con->query("SELECT SUM(amt) as bank_withdrawal FROM ct_cr_bank_withdraw WHERE $where ");

    $row = $qry->fetch_assoc();
    $bank_withdrawal = $row['bank_withdrawal'] ?? 0;

    $response['bank_withdrawal'] = intval($bank_withdrawal);

    // Cash Deposit
    $qry = $con->query("SELECT SUM(amt) as cash_deposit FROM ct_cr_cash_deposit WHERE $where ");

    $row = $qry->fetch_assoc();
    $cash_deposit = $row['cash_deposit'] ?? 0;

    $response['cash_deposit'] = intval($cash_deposit);

    $response['other_income'] = moneyFormatIndia($response['other_income']);
    $response['bank_withdrawal'] = moneyFormatIndia($response['bank_withdrawal']);
    $response['cash_deposit'] = moneyFormatIndia($response['cash_deposit']);

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
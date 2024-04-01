<?php
session_start();
$user_id = $_SESSION['userid'];

$op_date = date('Y-m-d',strtotime($_POST['op_date']));
if($op_date == date('Y-m-d')){// check whether opening date is current date
    $closing_date = $op_date;
}else{// only if opening date is less than today's date, increase one date
    $closing_date = date('Y-m-d', strtotime($op_date ));
}

$bank_detail = $_POST['bank_detail'];

include('../../ajaxconfig.php');

$records = array();

$handCreditQry = $con->query("SELECT
    SUM(amt) AS hand_credits
    FROM (
        (SELECT COALESCE(SUM(rec_amt), 0) AS amt FROM ct_hand_collection WHERE date(created_date) = '$closing_date' and insert_login_id = '$user_id' ORDER BY created_date DESC LIMIT 1)
        UNION ALL
        (SELECT COALESCE(SUM(amt), 0) AS amt FROM ct_cr_bank_withdraw WHERE date(created_date) = '$closing_date' and insert_login_id = '$user_id' ORDER BY created_date DESC LIMIT 1)
        UNION ALL
        (SELECT COALESCE(SUM(amt), 0) AS amt FROM ct_cr_hoti WHERE date(created_date) = '$closing_date' and insert_login_id = '$user_id' ORDER BY created_date DESC LIMIT 1)
        UNION ALL
        (SELECT COALESCE(SUM(amt), 0) AS amt FROM ct_cr_hinvest WHERE date(created_date) = '$closing_date' and insert_login_id = '$user_id' ORDER BY created_date DESC LIMIT 1)
        UNION ALL
        (SELECT COALESCE(SUM(amt), 0) AS amt FROM ct_cr_hexchange WHERE date(created_date) = '$closing_date' and insert_login_id = '$user_id' ORDER BY created_date DESC LIMIT 1)
        UNION ALL
        (SELECT COALESCE(SUM(amt), 0) AS amt FROM ct_cr_hel WHERE date(created_date) = '$closing_date' and insert_login_id = '$user_id' ORDER BY created_date DESC LIMIT 1)
        UNION ALL
        (SELECT COALESCE(SUM(amt), 0) AS amt FROM ct_cr_hdeposit WHERE date(created_date) = '$closing_date' and insert_login_id = '$user_id' ORDER BY created_date DESC LIMIT 1)
    ) AS Hand_Credit_Closing
");

$handCredit = $handCreditQry->fetch_assoc()['hand_credits'];

$handDebitQry = $con->query("SELECT
    SUM(amt) AS hand_debits
    FROM (
        (SELECT COALESCE(SUM(amount), 0) AS amt FROM ct_db_bank_deposit WHERE date(created_date) = '$closing_date' and insert_login_id = '$user_id' ORDER BY created_date DESC LIMIT 1)
        UNION ALL
        (SELECT COALESCE(SUM(amt), 0) AS amt FROM ct_db_hinvest WHERE date(created_date) = '$closing_date' and insert_login_id = '$user_id' ORDER BY created_date DESC LIMIT 1)
        UNION ALL
        (SELECT COALESCE(SUM(amt), 0) AS amt FROM ct_db_hissued WHERE date(created_date) = '$closing_date' and insert_login_id = '$user_id' ORDER BY created_date DESC LIMIT 1)
        UNION ALL
        (SELECT COALESCE(SUM(amt), 0) AS amt FROM ct_db_hel WHERE date(created_date) = '$closing_date' and insert_login_id = '$user_id' ORDER BY created_date DESC LIMIT 1)
        UNION ALL
        (SELECT COALESCE(SUM(amt), 0) AS amt FROM ct_db_hexchange WHERE date(created_date) = '$closing_date' and insert_login_id = '$user_id' ORDER BY created_date DESC LIMIT 1)
        UNION ALL
        (SELECT COALESCE(SUM(amt), 0) AS amt FROM ct_db_hexpense WHERE date(created_date) = '$closing_date' and insert_login_id = '$user_id' ORDER BY created_date DESC LIMIT 1)
        UNION ALL
        (SELECT COALESCE(SUM(amt), 0) AS amt FROM ct_db_hdeposit WHERE date(created_date) = '$closing_date' and insert_login_id = '$user_id' ORDER BY created_date DESC LIMIT 1)
    ) AS Hand_Debit_Closing
");

$handDebit = $handDebitQry->fetch_assoc()['hand_debits'];

$records[0]['hand_closing'] = intVal($handCredit) - intVal($handDebit) ;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

$bank_details_arr = explode(',',$bank_detail);
$i=0; $bank_closing_all = 0;
	foreach($bank_details_arr as $val){
        $bankCreditQry = $con->query("SELECT
            SUM(amt) AS bank_credit
            FROM (
                (SELECT COALESCE(SUM(amt), 0) AS amt FROM ct_cr_cash_deposit WHERE date(created_date) = '$closing_date' and to_bank_id = '$val' and insert_login_id = '$user_id' ORDER BY created_date DESC LIMIT 1)
                UNION ALL
                (SELECT COALESCE(SUM(credited_amt), 0) AS amt FROM ct_bank_collection WHERE date(created_date) = '$closing_date' and bank_id = '$val' and insert_login_id = '$user_id' ORDER BY created_date DESC LIMIT 1)
                UNION ALL
                (SELECT COALESCE(SUM(amt), 0) AS amt FROM ct_cr_bdeposit WHERE date(created_date) = '$closing_date' and bank_id = '$val' and insert_login_id = '$user_id' ORDER BY created_date DESC LIMIT 1)
                UNION ALL
                (SELECT COALESCE(SUM(amt), 0) AS amt FROM ct_cr_bel WHERE date(created_date) = '$closing_date' and bank_id = '$val' and insert_login_id = '$user_id' ORDER BY created_date DESC LIMIT 1)
                UNION ALL
                (SELECT COALESCE(SUM(amt), 0) AS amt FROM ct_cr_bexchange WHERE date(created_date) = '$closing_date' and to_bank_id = '$val' and insert_login_id = '$user_id' ORDER BY created_date DESC LIMIT 1)
                UNION ALL
                (SELECT COALESCE(SUM(amt), 0) AS amt FROM ct_cr_binvest WHERE date(created_date) = '$closing_date' and bank_id = '$val' and insert_login_id = '$user_id' ORDER BY created_date DESC LIMIT 1)
                UNION ALL
                (SELECT COALESCE(SUM(amt), 0) AS amt FROM ct_cr_boti WHERE date(created_date) = '$closing_date' and to_bank_id = '$val' and insert_login_id = '$user_id' ORDER BY created_date DESC LIMIT 1)
            ) AS Bank_Credit_Closing
        ");

        $bankCredit = $bankCreditQry->fetch_assoc()['bank_credit'];

        $bankDebitQry = $con->query("SELECT
            SUM(amt) AS bank_debit
            FROM (
                (SELECT COALESCE(SUM(amt), 0) AS amt FROM ct_db_cash_withdraw WHERE date(created_date) = '$closing_date' and from_bank_id = '$val' and insert_login_id = '$user_id' ORDER BY created_date DESC LIMIT 1)
                UNION ALL
                (SELECT COALESCE(SUM(amt), 0) AS amt FROM ct_db_bdeposit WHERE date(created_date) = '$closing_date' and bank_id = '$val' and insert_login_id = '$user_id' ORDER BY created_date DESC LIMIT 1)
                UNION ALL
                (SELECT COALESCE(SUM(amt), 0) AS amt FROM ct_db_bel WHERE date(created_date) = '$closing_date' and bank_id = '$val' and insert_login_id = '$user_id' ORDER BY created_date DESC LIMIT 1)
                UNION ALL
                -- (SELECT COALESCE(SUM(amt), 0) AS amt FROM ct_db_exf WHERE date(created_date) = '$closing_date' and to_bank_id = '$val' and insert_login_id = '$user_id' ORDER BY created_date DESC LIMIT 1)
                -- UNION ALL
                (SELECT COALESCE(SUM(amt), 0) AS amt FROM ct_db_bexchange WHERE date(created_date) = '$closing_date' and from_acc_id = '$val' and insert_login_id = '$user_id' ORDER BY created_date DESC LIMIT 1)
                UNION ALL
                (SELECT COALESCE(SUM(amt), 0) AS amt FROM ct_db_bexpense WHERE date(created_date) = '$closing_date' and bank_id = '$val' and insert_login_id = '$user_id' ORDER BY created_date DESC LIMIT 1)
                UNION ALL
                (SELECT COALESCE(SUM(amt), 0) AS amt FROM ct_db_binvest WHERE date(created_date) = '$closing_date' and bank_id = '$val' and insert_login_id = '$user_id' ORDER BY created_date DESC LIMIT 1)
                UNION ALL
                (SELECT COALESCE(SUM(netcash), 0) AS amt FROM ct_db_bissued WHERE date(created_date) = '$closing_date' and li_bank_id = '$val' and insert_login_id = '$user_id' ORDER BY created_date DESC LIMIT 1)
            ) AS Bank_Credit_Closing
        ");

        $bankDebit = $bankDebitQry->fetch_assoc()['bank_debit'];
        
        $records[$i]['bank_closing'] = intVal($bankCredit) - intVal($bankDebit) ;
        $bank_closing_all = $bank_closing_all + $records[$i]['bank_closing'];
        $i++;
    }


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
$qry = $con->query("SELECT ag.ag_id FROM agent_creation ag JOIN user us ON FIND_IN_SET(ag.ag_id,us.agentforstaff) where us.user_id = '$user_id'");
//without while it will not give all the agent ids
while($rww = $qry->fetch_assoc()){
    $ag_ids[] = $rww["ag_id"];
}
$ag_ids = implode(',',$ag_ids);

$agentCollQry = $con->query("SELECT
    SUM(amt) AS agent_coll
    FROM (
        (SELECT COALESCE(SUM(total_paid_track), 0) AS amt FROM collection
        WHERE date(created_date) = '$closing_date' AND FIND_IN_SET(insert_login_id,'$ag_ids') ORDER BY created_date DESC LIMIT 1)
        
    ) AS Agent_Collection_Credit_Closing
");

$agentCollCredit = $agentCollQry->fetch_assoc()['agent_coll'];

$agentIssueQry = $con->query("SELECT
    SUM(amt) AS agent_issue
    FROM (
        (SELECT COALESCE(SUM(cash + cheque_value + transaction_value), 0) AS amt FROM loan_issue
        WHERE date(created_date) = '$closing_date' AND FIND_IN_SET(agent_id,'$ag_ids') ORDER BY created_date DESC LIMIT 1)
        
    ) AS Agent_Issue_Debit_Closing
");

$agentIssueDebit = $agentIssueQry->fetch_assoc()['agent_issue'];

$agent_CL_op = intVal($agentCollCredit) - intVal($agentIssueDebit);

//

$agentCreditQry = $con->query("SELECT
    SUM(amt) AS agent_credit
    FROM (
        (SELECT COALESCE(SUM(amt), 0) AS amt FROM ct_cr_hag WHERE date(created_date) = '$closing_date' AND FIND_IN_SET(ag_id,'$ag_ids') and insert_login_id = '$user_id' ORDER BY created_date DESC LIMIT 1)
        
    ) AS Agent_Credit_Closing
");

$agentCredit = $agentCreditQry->fetch_assoc()['agent_credit'];

$agentDebitQry = $con->query("SELECT
    SUM(amt) AS agent_debit
    FROM (
        (SELECT COALESCE(SUM(amt), 0) AS amt FROM ct_db_hag WHERE date(created_date) = '$closing_date' AND FIND_IN_SET(ag_id,'$ag_ids') and insert_login_id = '$user_id' ORDER BY created_date DESC LIMIT 1)
        
    ) AS Agent_Debit_Closing
");

$agentDebit = $agentDebitQry->fetch_assoc()['agent_debit'];

$agent_hand_op = intVal($agentCredit) - intVal($agentDebit);

//


$agentCreditQry = $con->query("SELECT
    SUM(amt) AS agent_credit
    FROM (
        (SELECT COALESCE(SUM(amt), 0) AS amt FROM ct_cr_bag WHERE date(created_date) = '$closing_date' AND FIND_IN_SET(ag_id,'$ag_ids') and insert_login_id = '$user_id' ORDER BY created_date DESC LIMIT 1)
        
    ) AS Agent_Credit_Closing
");

$agentCredit = $agentCreditQry->fetch_assoc()['agent_credit'];

$agentDebitQry = $con->query("SELECT
    SUM(amt) AS agent_debit
    FROM (
        (SELECT COALESCE(SUM(amt), 0) AS amt FROM ct_db_bag WHERE date(created_date) = '$closing_date' AND FIND_IN_SET(ag_id,'$ag_ids') and insert_login_id = '$user_id' ORDER BY created_date DESC LIMIT 1)
        
    ) AS Agent_Debit_Closing
");

$agentDebit = $agentDebitQry->fetch_assoc()['agent_debit'];

$agent_bank_op = intVal($agentCredit) - intVal($agentDebit);

//

$records[0]['agent_closing'] = $agent_hand_op + $agent_bank_op + $agent_CL_op;

$records[0]['closing_balance'] = $records[0]['hand_closing'] + $bank_closing_all + $records[0]['agent_closing'];

echo json_encode($records);


?>
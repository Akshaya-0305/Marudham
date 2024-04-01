<?php
session_start();
include '../ajaxconfig.php';

if (isset($_SESSION["userid"])) {
    $user_id = $_SESSION["userid"];
}

function moneyFormatIndia($num)
{
    $explrestunits = "";
    if (strlen($num) > 3) {
        $lastthree = substr($num, strlen($num) - 3, strlen($num));
        $restunits = substr($num, 0, strlen($num) - 3);
        $restunits = (strlen($restunits) % 2 == 1) ? "0" . $restunits : $restunits;
        $expunit = str_split($restunits, 2);
        for ($i = 0; $i < sizeof($expunit); $i++) {
            if ($i == 0) {
                $explrestunits .= (int)$expunit[$i] . ",";
            } else {
                $explrestunits .= $expunit[$i] . ",";
            }
        }
        $thecash = $explrestunits . $lastthree;
    } else {
        $thecash = $num;
    }
    return $thecash;
}
?>
<table class="table custom-table" id='dueChartListTable'>


    <?php
    $req_id = $_POST['req_id'];
    $cus_id = $_POST['cus_id'];
    $curDateChecker = true;
    if (isset($_POST['closed'])) {
        $closed = $_POST['closed'];
    } else {
        $closed = 'false';
    }
    $loanStart = $connect->query("SELECT alc.due_start_from,alc.maturity_month,alc.due_method_calc,alc.due_method_scheme FROM acknowlegement_loan_calculation alc WHERE alc.`req_id`= '$req_id' ");
    $loanFrom = $loanStart->fetch();
    //If Due method is Monthly, Calculate penalty by checking the month has ended or not
    $due_start_from = $loanFrom['due_start_from'];
    $maturity_month = $loanFrom['maturity_month'];


    if ($loanFrom['due_method_calc'] == 'Monthly' || $loanFrom['due_method_scheme'] == '1') {
        //If Due method is Monthly, Calculate penalty by checking the month has ended or not

        // Create a DateTime object from the given date
        $maturity_month = new DateTime($maturity_month);
        // Subtract one month from the date
        // $maturity_month->modify('-1 month');
        // Format the date as a string
        $maturity_month = $maturity_month->format('Y-m-d');

        $due_start_from = date('Y-m-d', strtotime($due_start_from));
        $maturity_month = date('Y-m-d', strtotime($maturity_month));
        $current_date = date('Y-m-d');

        $start_date_obj = DateTime::createFromFormat('Y-m-d', $due_start_from);
        $end_date_obj = DateTime::createFromFormat('Y-m-d', $maturity_month);
        $current_date_obj = DateTime::createFromFormat('Y-m-d', $current_date);
        $interval = new DateInterval('P1M'); // Create a one month interval
        //$count = 0;
        $i = 1;
        $dueMonth[] = $due_start_from;
        while ($start_date_obj < $end_date_obj) {
            $start_date_obj->add($interval);
            $dueMonth[] = $start_date_obj->format('Y-m-d');
        }
    } else
        if ($loanFrom['due_method_scheme'] == '2') {
        //If Due method is Weekly, Calculate penalty by checking the month has ended or not
        $current_date = date('Y-m-d');

        // Create a DateTime object from the given date
        $maturity_month = new DateTime($maturity_month);
        // Subtract one month from the date
        // $maturity_month->modify('-7 days');
        // Format the date as a string
        $maturity_month = $maturity_month->format('Y-m-d');

        $start_date_obj = DateTime::createFromFormat('Y-m-d', $due_start_from);
        $end_date_obj = DateTime::createFromFormat('Y-m-d', $maturity_month);
        $current_date_obj = DateTime::createFromFormat('Y-m-d', $current_date);

        $interval = new DateInterval('P1W'); // Create a one Week interval

        //$count = 0;
        $i = 1;
        $dueMonth[] = $due_start_from;
        while ($start_date_obj < $end_date_obj) {
            $start_date_obj->add($interval);
            $dueMonth[] = $start_date_obj->format('Y-m-d');
        }
    } else
        if ($loanFrom['due_method_scheme'] == '3') {
        //If Due method is Daily, Calculate penalty by checking the month has ended or not
        $current_date = date('Y-m-d');

        // Create a DateTime object from the given date
        $maturity_month = new DateTime($maturity_month);
        // Subtract one month from the date
        // $maturity_month->modify('-1 days');
        // Format the date as a string
        $maturity_month = $maturity_month->format('Y-m-d');

        $start_date_obj = DateTime::createFromFormat('Y-m-d', $due_start_from);
        $end_date_obj = DateTime::createFromFormat('Y-m-d', $maturity_month);
        $current_date_obj = DateTime::createFromFormat('Y-m-d', $current_date);

        $interval = new DateInterval('P1D'); // Create a one Week interval

        //$count = 0;
        $i = 1;
        $dueMonth[] = $due_start_from;
        while ($start_date_obj < $end_date_obj) {
            $start_date_obj->add($interval);
            $dueMonth[] = $start_date_obj->format('Y-m-d');
        }
    }
    // if($closed == 'true'){
    //     // $issueDate = $connect->query("SELECT li.loan_amt,ii.updated_date FROM in_issue ii JOIN loan_issue li ON li.req_id = ii.req_id  WHERE ii.req_id = '$req_id' and ii.cus_status = 20 order by li.id desc limit 1 ");
    //     $issueDate = $connect->query("SELECT alc.due_amt_cal,alc.int_amt_cal,alc.tot_amt_cal,alc.principal_amt_cal,ii.updated_date FROM in_issue ii JOIN acknowlegement_loan_calculation alc ON ii.req_id = alc.req_id  WHERE ii.req_id = '$req_id' and ii.cus_status = 20 order by alc.loan_cal_id desc limit 1 ");

    // }else{
    // $issueDate = $connect->query("SELECT li.loan_amt,ii.updated_date FROM in_issue ii JOIN loan_issue li ON li.req_id = ii.req_id  WHERE ii.req_id = '$req_id' and ii.cus_status = 14 order by li.id desc limit 1 ");
    $issueDate = $connect->query("SELECT alc.due_amt_cal,alc.int_amt_cal,alc.tot_amt_cal,alc.principal_amt_cal,ii.updated_date FROM in_issue ii JOIN acknowlegement_loan_calculation alc ON ii.req_id = alc.req_id  WHERE ii.req_id = '$req_id' and (ii.cus_status >= 14 ) order by alc.loan_cal_id desc limit 1 ");
    // }
    $loanIssue = $issueDate->fetch();
    //If Due method is Monthly, Calculate penalty by checking the month has ended or not
    if ($loanIssue['tot_amt_cal'] == '' || $loanIssue['tot_amt_cal'] == null) {
        //(For monthly interest total amount will not be there, so take principals)
        $loan_amt = intVal($loanIssue['principal_amt_cal']);
        $loan_type = 'interest';
    } else {
        $loan_amt = intVal($loanIssue['tot_amt_cal']);
        $loan_type = 'emi';
    }

    $due_amt_1 = $loanIssue['due_amt_cal'];

    if ($loan_type == 'interest') {
        $princ_amt_1 = $loanIssue['principal_amt_cal'];
        $due_amt_1 = $loanIssue['int_amt_cal'];
    }

    $issue_date = $loanIssue['updated_date'];
    ?>

    <thead>
        <tr>
            <th width="15"> Due No </th>
            <th width="8%"> Due Month </th>
            <th> Month </th>
            <?php if ($loan_type == 'emi') { ?>
                <th> Due Amount </th>
            <?php } ?>
            <?php if ($loan_type == 'interest') { ?>
                <th> Principal </th>
                <th> Interest </th>
            <?php } ?>
            <th> Pending </th>
            <th> Payable </th>
            <th> Collection Date </th>
            <?php if ($loan_type == 'emi') { ?>
                <th> Collection Amount </th>
            <?php } ?>
            <?php if ($loan_type == 'interest') { ?>
                <th> Principal Amount </th>
                <th> Interest Amount </th>
            <?php } ?>
            <th> Balance Amount </th>
            <th> Pre Closure </th>
            <th> Role </th>
            <th width="8%"> User ID </th>
            <th> Collection Method </th>
            <th> ACTION </th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td> </td>
            <td><?php
                if ($loanFrom['due_method_calc'] == 'Monthly' || $loanFrom['due_method_scheme'] == '1') {
                    //For Monthly.
                    echo date('m-Y', strtotime($issue_date));
                } else {
                    //For Weekly && Day.
                    echo date('d-m-Y', strtotime($issue_date));
                } ?></td>
            <td><?php echo date('M', strtotime($issue_date)); ?></td>
            <?php if ($loan_type == 'emi') { ?>
                <td> </td>
            <?php } ?>
            <?php if ($loan_type == 'interest') { ?>
                <td> </td>
                <td> </td>
            <?php } ?>
            <td></td>
            <td></td>
            <td></td>

            <!-- for collected amt -->
            <?php if ($loan_type == 'emi') { ?>
                <td> </td>
            <?php } ?>
            <?php if ($loan_type == 'interest') { ?>
                <td> </td>
                <td> </td>
            <?php } ?>

            <td><?php echo $loan_amt; ?></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
        </tr>
        <?php
        $issued = date('Y-m-d', strtotime($issue_date));
        if ($loanFrom['due_method_calc'] == 'Monthly' || $loanFrom['due_method_scheme'] == '1') {
            //Query for Monthly.
            $run = $connect->query("SELECT c.coll_code, c.due_amt,c.tot_amt, c.pending_amt, c.payable_amt, c.coll_date, c.trans_date, c.due_amt_track,c.princ_amt_track,c.int_amt_track, c.bal_amt, c.coll_charge_track, c.coll_location, c.pre_close_waiver, alc.due_start_from, alc.maturity_month, alc.due_method_calc, u.fullname, u.role
            FROM `collection` c
            LEFT JOIN acknowlegement_loan_calculation alc ON c.req_id = alc.req_id
            LEFT JOIN user u ON c.insert_login_id = u.user_id
            WHERE c.`req_id` = '$req_id' AND (c.due_amt_track != '' or c.pre_close_waiver!='')
            AND(
                (
                    ( MONTH(c.coll_date) >= MONTH('$issued') AND YEAR(c.coll_date) = YEAR('$issued') )
                    AND 
                    ( 
                        (
                            YEAR(c.coll_date) = YEAR('$due_start_from') AND MONTH(c.coll_date) < MONTH('$due_start_from')
                        ) OR (
                            YEAR(c.coll_date) < YEAR('$due_start_from')
                        )
                    )
                ) 
                OR
                (
                    ( MONTH(c.trans_date) >= MONTH('$issued') AND YEAR(c.trans_date) = YEAR('$issued') )
                    AND 
                    ( 
                        (
                            YEAR(c.trans_date) = YEAR('$due_start_from') AND MONTH(c.trans_date) < MONTH('$due_start_from')
                        ) OR (
                            YEAR(c.trans_date) < YEAR('$due_start_from')
                        )
                            AND c.trans_date != '0000-00-00'
                    )
                )
            )");
        } else
        if ($loanFrom['due_method_scheme'] == '2') {
            //Query For Weekly.
            $run = $connect->query("SELECT c.coll_code, c.due_amt, c.pending_amt, c.payable_amt, c.coll_date, c.trans_date, c.due_amt_track, c.bal_amt, c.coll_charge_track, c.coll_location, c.pre_close_waiver, alc.due_start_from, alc.maturity_month, alc.due_method_calc, u.fullname, u.role
            FROM `collection` c
            LEFT JOIN acknowlegement_loan_calculation alc ON c.req_id = alc.req_id
            LEFT JOIN user u ON c.insert_login_id = u.user_id
            WHERE c.`req_id` = '$req_id' AND (c.due_amt_track != '' or c.pre_close_waiver!='' OR c.princ_amt_track != '')
            AND (
                    (
                        (WEEK(c.coll_date) >= WEEK('$issued') AND YEAR(c.coll_date) = YEAR('$issued'))
                        AND 
                        (
                            (
                                YEAR(c.coll_date) = YEAR('$due_start_from') AND WEEK(c.coll_date) < WEEK('$due_start_from')
                            ) OR (
                                YEAR(c.coll_date) < YEAR('$due_start_from')
                            )
                        )
                    ) 
                    OR
                    (
                        (WEEK(c.trans_date) >= WEEK('$issued') AND YEAR(c.trans_date) = YEAR('$issued'))
                        AND 
                        (
                            (
                                YEAR(c.trans_date) = YEAR('$due_start_from') AND WEEK(c.trans_date) < WEEK('$due_start_from')
                            ) OR (
                                YEAR(c.trans_date) < YEAR('$due_start_from')
                            )
                            AND c.trans_date != '0000-00-00'

                        )
                    )
                )
            ");
        } else
        if ($loanFrom['due_method_scheme'] == '3') {
            //Query For Day.
            $run = $connect->query("SELECT c.coll_code, c.due_amt, c.pending_amt, c.payable_amt, c.coll_date, c.trans_date, c.due_amt_track, c.bal_amt, c.coll_charge_track, c.coll_location, c.pre_close_waiver, alc.due_start_from, alc.maturity_month, alc.due_method_calc, u.fullname, u.role
            FROM `collection` c
            LEFT JOIN acknowlegement_loan_calculation alc ON c.req_id = alc.req_id
            LEFT JOIN user u ON c.insert_login_id = u.user_id
            WHERE c.`req_id` = '$req_id' AND (c.due_amt_track != '' or c.pre_close_waiver!='')
            AND (
                (DATE(c.coll_date) >= DATE('$issued') AND DATE(c.coll_date) < DATE('$due_start_from') AND DATE(c.coll_date) != '0000-00-00' ) OR
                (DATE(c.trans_date) >= DATE('$issued') AND DATE(c.trans_date) < DATE('$due_start_from') AND DATE(c.trans_date) != '0000-00-00' )
            ) ");
        }

        //For showing data before due start date
        $due_amt_track = 0;
        $waiver = 0;
        $last_bal_amt=0;
        $bal_amt = 0;
        if ($run->rowCount() > 0) {
            while ($row = $run->fetch()) {
                $role = $row['role'];
                $collectionAmnt = intVal($row['due_amt_track']);
                $due_amt_track = $due_amt_track + intVal($row['due_amt_track']);
                $waiver = $waiver + intVal($row['pre_close_waiver']);
                if ($loan_type == 'interest') {
                    $PcollectionAmnt = intVal($row['princ_amt_track']);
                    $IcollectionAmnt = intVal($row['int_amt_track']);
                    if($last_bal_amt != 0){
                        $bal_amt = $last_bal_amt - $PcollectionAmnt - $waiver;
                    }else{
                    $bal_amt = $loan_amt - $PcollectionAmnt - $waiver;
                    }
                }else{
                    $bal_amt = $loan_amt - $due_amt_track - $waiver;
                }
        ?>
                <tr>
                    <td></td>
                    <td><?php
                        // if ($loanFrom['due_method_calc'] == 'Monthly' || $loanFrom['due_method_scheme'] == '1') {
                        //     //For Monthly.
                        //     echo date('m-Y', strtotime($row['coll_date']));
                        // } else {
                        //     //For Weekly && Day.
                        //     echo date('d-m-Y', strtotime($row['coll_date']));
                        // }
                        ?></td>
                    <td><?php //echo date('M', strtotime($row['coll_date'])); ?></td>

                    <?php if ($loan_type == 'emi') { ?>
                        <td><?php //echo $row['due_amt']; ?></td>
                    <?php } ?>
                    <?php if ($loan_type == 'interest') { ?>
                        <td><?php //echo $row['tot_amt']; ?></td>
                        <td><?php //echo $row['due_amt']; ?></td>
                    <?php } ?>

                    <td><?php $pendingMinusCollection = (intVal($row['pending_amt']));
                        // if ($pendingMinusCollection != '') {
                        //     echo $pendingMinusCollection;
                        // } else {
                        //     echo 0;
                        // } ?></td>
                    <td><?php $payableMinusCollection = (intVal($row['payable_amt']));
                        // if ($payableMinusCollection != '') {
                        //     echo $payableMinusCollection;
                        // } else {
                        //     echo 0;
                        // } ?></td>
                    <td><?php echo date('d-m-Y', strtotime($row['trans_date']!='0000-00-00'?$row['trans_date']:$row['coll_date'])); ?></td>

                    <!-- for collected amt -->
                    <?php if ($loan_type == 'emi') { ?>
                        <td>
                            <?php if ($row['due_amt_track'] > 0) {
                                echo $row['due_amt_track'];
                            } elseif ($row['pre_close_waiver'] > 0) {
                                echo $row['pre_close_waiver'];
                            } ?>
                        </td>
                    <?php } ?>

                    <?php if ($loan_type == 'interest') { ?>
                        <td>
                            <?php if ($PcollectionAmnt > 0) {
                                echo $PcollectionAmnt;
                            } elseif ($row['pre_close_waiver'] > 0) {
                                echo $row['pre_close_waiver'];
                            } ?>
                        </td>
                        <td>
                            <?php if ($IcollectionAmnt > 0) {
                                echo $IcollectionAmnt;
                            } ?>
                        </td>
                    <?php } ?>

                    <td><?php echo $bal_amt; ?></td>
                    <td><?php if ($row['pre_close_waiver'] > 0) {
                            echo $row['pre_close_waiver'];
                        } else {
                            echo '0';
                        } ?></td>
                    <td><?php if (isset($role) && $role == '1') {
                            echo 'Director';
                        } else if (isset($role) && $role == '2') {
                            echo 'Agent';
                        } else if (isset($role) && $role == '3') {
                            echo 'Staff';
                        } ?>
                    </td>
                    <td><?php echo $row['fullname']; ?></td>
                    <td><?php if ($row['coll_location'] == '1') {
                            echo 'By Self';
                        } elseif ($row['coll_location'] == '2') {
                            echo 'On Spot';
                        } elseif ($row['coll_location'] == '3') {
                            echo 'Bank Transfer';
                        } ?></td>
                    <td> <a class='print_due_coll' id="" value="<?php echo $row['coll_code']; ?>"> <i class="fa fa-print" aria-hidden="true"></i> </a> </td>
                </tr>

                <?php
                if ($loan_type == 'interest') {
                    $last_bal_amt = $bal_amt;
                }else{

                }
            }
        }

        //For showing collection after due start date
        $due_amt_track = 0;
        $waiver = 0;
        $jj = 0;
        $last_int_amt = $due_amt_1;
        if ($loan_type == 'interest') {
            $last_princ_amt = $last_bal_amt;
            // $bal_amt = $last_bal_amt;
        }else{
            $bal_amt = 0;
        }
        $lastCusdueMonth = '1970-00-00';
        foreach ($dueMonth as $cusDueMonth) {
            if ($loanFrom['due_method_calc'] == 'Monthly' || $loanFrom['due_method_scheme'] == '1') {
                //Query for Monthly.
                $run = $connect->query("SELECT c.coll_code,c.due_amt,c.tot_amt,c.pending_amt,c.payable_amt,c.coll_date, c.trans_date,c.due_amt_track,c.princ_amt_track,c.int_amt_track,c.bal_amt,c.coll_charge_track,c.coll_location,c.pre_close_waiver,alc.due_start_from,alc.maturity_month,alc.due_method_calc,u.fullname,u.role FROM `collection` c LEFT JOIN acknowlegement_loan_calculation alc on c.req_id = alc.req_id LEFT JOIN user u on c.insert_login_id = u.user_id WHERE (c.`req_id`= $req_id) and (c.due_amt_track != '' or c.princ_amt_track!='' or c.int_amt_track!='' or c.pre_close_waiver!='') && ((MONTH(coll_date)= MONTH('$cusDueMonth') || MONTH(trans_date)= MONTH('$cusDueMonth')) && (YEAR(coll_date)= YEAR('$cusDueMonth') || YEAR(trans_date)= YEAR('$cusDueMonth')) )");
            } elseif ($loanFrom['due_method_scheme'] == '2') {
                //Query For Weekly.
                $run = $connect->query("SELECT c.coll_code,c.due_amt,c.pending_amt,c.payable_amt,c.coll_date, c.trans_date,c.due_amt_track,c.bal_amt,c.coll_charge_track,c.coll_location,c.pre_close_waiver,alc.due_start_from,alc.maturity_month,alc.due_method_calc,u.fullname,u.role FROM `collection` c LEFT JOIN acknowlegement_loan_calculation alc on c.req_id = alc.req_id LEFT JOIN user u on c.insert_login_id = u.user_id WHERE (c.`req_id`= $req_id) and (c.due_amt_track != '' or c.pre_close_waiver!='') && ((WEEK(coll_date)= WEEK('$cusDueMonth') || WEEK(trans_date)= WEEK('$cusDueMonth')) && (YEAR(coll_date)= YEAR('$cusDueMonth') || YEAR(trans_date)= YEAR('$cusDueMonth')) )");
            } elseif ($loanFrom['due_method_scheme'] == '3') {
                //Query For Day.
                $run = $connect->query("SELECT c.coll_code,c.due_amt,c.pending_amt,c.payable_amt,c.coll_date, c.trans_date,c.due_amt_track,c.bal_amt,c.coll_charge_track,c.coll_location,c.pre_close_waiver,alc.due_start_from,alc.maturity_month,alc.due_method_calc,u.fullname,u.role FROM `collection` c LEFT JOIN acknowlegement_loan_calculation alc on c.req_id = alc.req_id LEFT JOIN user u on c.insert_login_id = u.user_id WHERE (c.`req_id`= $req_id) and (c.due_amt_track != '' or c.pre_close_waiver!='') && 
                ( 
                    ( DAY(coll_date)= DAY('$cusDueMonth') || DAY(trans_date)= DAY('$cusDueMonth') ) && 
                    ( MONTH(coll_date)= MONTH('$cusDueMonth') || MONTH(trans_date)= MONTH('$cusDueMonth') ) && 
                    ( YEAR(coll_date)= YEAR('$cusDueMonth') || YEAR(trans_date)= YEAR('$cusDueMonth') )
                )
                ");
            }

            if ($run->rowCount() > 0) {

                while ($row = $run->fetch()) { //if($jj == 0){$lastCusdueMonth = '00';$jj++;}else{$lastCusdueMonth =date('m',strtotime($lastCusdueMonth));}echo $lastCusdueMonth.',';
                    $role = $row['role'];
                    $due_amt_track = intVal($row['due_amt_track']);
                    if ($loanFrom['due_method_calc'] == 'Monthly' || $loanFrom['due_method_scheme'] == '1') {
                        $princ_amt_track = intVal($row['princ_amt_track']);
                        $int_amt_track = intVal($row['int_amt_track']);
                    }
                    // $waiver = $waiver + intVal($row['pre_close_waiver']);
                    $waiver = intVal($row['pre_close_waiver']);
                    if($loan_type == 'emi'){
                        $bal_amt = intVal($row['bal_amt']) - $due_amt_track - $waiver;
                    }else{
                        $bal_amt = intVal($last_princ_amt) - $due_amt_track - $waiver;
                    }

                ?>
                    <tr>
                        <?php 
                        if ($loanFrom['due_method_calc'] == 'Monthly' || $loanFrom['due_method_scheme'] == '1') {//this is for monthly loan to check lastcusduemonth comparision
                            if (date('Y-m', strtotime($lastCusdueMonth)) != date('Y-m', strtotime($row['coll_date']))) { 
                            // this condition is to check whether the same month has collection again. if yes the no need to show month name and due amount and serial number
                            ?>
                                <td><?php echo $i;
                                    $i++; ?></td>
                                <td><?php
                                    if ($loanFrom['due_method_calc'] == 'Monthly' || $loanFrom['due_method_scheme'] == '1') {
                                        //For Monthly.
                                        echo date('m-Y', strtotime($cusDueMonth));
                                    } else {
                                        //For Weekly && Day.
                                        echo date('d-m-Y', strtotime($cusDueMonth));
                                    }
                                    ?></td>
                                <td>
                                    <?php
                                    echo date('M', strtotime($cusDueMonth));
                                    ?>
                                </td>

                                <?php if ($loan_type == 'emi') { ?>
                                    <td><?php echo $row['due_amt']; ?></td>
                                <?php } ?>
                                <?php if($loan_type == 'interest'){ ?>
                                    <td><?php echo $last_princ_amt; ?></td>
                                    <td><?php echo $row['due_amt']; $last_int_amt = $row['due_amt'];?></td>
                                <?php } ?>


                                <?php } else { ?>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                <?php }
                        }else{//this is for weekly and daily loan to check lastcusduemonth comparision
                            if (date('Y-m-d', strtotime($lastCusdueMonth)) != date('Y-m-d', strtotime($row['coll_date']))) {
                            // this condition is to check whether the same month has collection again. if yes the no need to show month name and due amount and serial number
                            ?>
                                <td><?php echo $i;
                                    $i++; ?></td>
                                <td><?php
                                    if ($loanFrom['due_method_calc'] == 'Monthly' || $loanFrom['due_method_scheme'] == '1') {
                                        //For Monthly.
                                        echo date('m-Y', strtotime($cusDueMonth));
                                    } else {
                                        //For Weekly && Day.
                                        echo date('d-m-Y', strtotime($cusDueMonth));
                                    }
                                    ?></td>
                                <td>
                                    <?php
                                    echo date('M', strtotime($cusDueMonth));
                                    ?>
                                </td>
    
                                <?php if ($loan_type == 'emi') { ?>
                                    <td><?php echo $row['due_amt']; ?></td>
                                <?php } ?>
                                <?php if($loan_type == 'interest'){ ?>
                                    <td><?php echo $last_princ_amt; ?></td>
                                    <td><?php echo $row['due_amt']; $last_int_amt = $row['due_amt'];?></td>
                                <?php } ?>
    
    
                            <?php } else { ?>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                            <?php }
                        } ?>

                        <td><?php $pendingMinusCollection = (intVal($row['pending_amt']));
                            if ($pendingMinusCollection != '') {
                                echo $pendingMinusCollection;
                            } else {
                                echo 0;
                            } ?></td>
                        <td><?php $payableMinusCollection = (intVal($row['payable_amt']));
                            if ($payableMinusCollection != '') {
                                echo $payableMinusCollection;
                            } else {
                                echo 0;
                            } ?></td>
                        <td><?php echo date('d-m-Y', strtotime($row['trans_date']!='0000-00-00'?$row['trans_date']:$row['coll_date'])); ?></td>

                        <!-- for collected amt -->
                        <?php if ($loan_type == 'emi') { ?>
                            <td>
                                <?php if ($row['due_amt_track'] > 0) {
                                    echo $row['due_amt_track'];
                                } elseif ($row['pre_close_waiver'] > 0) {
                                    echo $row['pre_close_waiver'];
                                } ?>
                            </td>
                        <?php } ?>

                        <?php if ($loan_type == 'interest') { ?>
                            <td>
                                <?php if ($princ_amt_track > 0) {
                                    echo $princ_amt_track;
                                } elseif ($row['pre_close_waiver'] > 0) {
                                    echo $row['pre_close_waiver'];
                                } ?>
                            </td>
                            <td>
                                <?php if ($int_amt_track > 0) {
                                    echo $int_amt_track;
                                } ?>
                            </td>
                        <?php } ?>


                        <td><?php echo $bal_amt;
                            if ($loan_type == 'interest') {
                                $last_princ_amt = $bal_amt;
                            } ?></td>
                        <td><?php if ($row['pre_close_waiver'] > 0) {
                                echo $row['pre_close_waiver'];
                            } else {
                                echo '0';
                            } ?></td>
                        <td><?php if (isset($role) && $role == '1') {
                                echo 'Director';
                            } else if (isset($role) && $role == '2') {
                                echo 'Agent';
                            } else if (isset($role) && $role == '3') {
                                echo 'Staff';
                            } ?>
                        </td>
                        <td><?php echo $row['fullname']; ?></td>
                        <td><?php if ($row['coll_location'] == '1') {
                                echo 'By Self';
                            } elseif ($row['coll_location'] == '2') {
                                echo 'On Spot';
                            } elseif ($row['coll_location'] == '3') {
                                echo 'Bank Transfer';
                            } ?></td>
                        <td> <a class='print_due_coll' id="" value="<?php echo $row['coll_code']; ?>"> <i class="fa fa-print" aria-hidden="true"></i> </a> </td>
                    </tr>

                <?php $lastCusdueMonth = date('d-m-Y', strtotime($cusDueMonth)); //assign this cusDueMonth to check if coll date is already showed before
                }
            } else {
                ?>
                <tr>
                    <td><?php echo $i; ?></td>
                    <td><?php
                        if ($loanFrom['due_method_calc'] == 'Monthly' || $loanFrom['due_method_scheme'] == '1') {
                            //For Monthly.
                            // if($i == '1' and $loan_type == 'interest'){
                            //     echo date('m-Y', strtotime($cusDueMonth));
                            // }elseif($loan_type == 'interest'){
                            //     echo date('m-Y', strtotime($cusDueMonth.'-1 month'));
                            // }else{
                            echo date('m-Y', strtotime($cusDueMonth));
                            // }
                        } else {
                            //For Weekly && Day.
                            echo date('d-m-Y', strtotime($cusDueMonth));
                        } ?></td>
                    <td>
                        <?php
                        // if($i == '1' and $loan_type == 'interest'){
                        //     echo date('M', strtotime($cusDueMonth)); 
                        // }elseif($loan_type == 'interest'){
                        //     echo date('M', strtotime($cusDueMonth.'-1 month')); 
                        // }else{
                        echo date('M', strtotime($cusDueMonth));
                        // }
                        ?>
                    </td>

                    <?php if ($loan_type == 'emi') { ?>
                        <td><?php echo $due_amt_1; ?></td>
                    <?php } ?>
                    <?php if ($loan_type == 'interest') { ?>
                        <td><?php echo $last_princ_amt; ?></td>
                        <td><?php echo $last_int_amt; ?></td>
                    <?php } ?>

                    <?php
                    if ($loanFrom['due_method_calc'] == 'Monthly' || $loanFrom['due_method_scheme'] == '1') {
                        if (date('Y-m', strtotime($cusDueMonth)) <=  date('Y-m')) { ?>
                            <td>
                                <?php $response = getNextLoanDetails($con, $req_id, $cusDueMonth);
                                echo $response['pending']; ?>
                            </td>
                            <td>
                                <?php $response = getNextLoanDetails($con, $req_id, $cusDueMonth);
                                echo $response['payable']; ?>
                            </td>
                        <?php } else if (date('Y-m', strtotime($cusDueMonth)) >  date('Y-m') && $curDateChecker == true) { ?>
                            <td>
                                <?php $response = getNextLoanDetails($con, $req_id, $cusDueMonth);
                                //echo $response['pending']; ?>
                            </td>
                            <td>
                                <?php $response = getNextLoanDetails($con, $req_id, $cusDueMonth);
                                //echo $response['payable']; ?>
                            </td>
                        <?php
                            $curDateChecker = false; //set to false because, pending and payable only need one month after current month
                        } else {
                        ?>
                            <td></td>
                            <td></td>
                        <?php
                        }
                    } else {
                        if (date('Y-m-d', strtotime($cusDueMonth)) <=  date('Y-m-d')) { ?>
                            <td>
                                <?php $response = getNextLoanDetails($con, $req_id, $cusDueMonth);
                                echo $response['pending']; ?>
                            </td>
                            <td>
                                <?php $response = getNextLoanDetails($con, $req_id, $cusDueMonth);
                                echo $response['payable']; ?>
                            </td>
                        <?php } else if (date('Y-m-d', strtotime($cusDueMonth)) >  date('Y-m-d') && $curDateChecker == true) { ?>
                            <td>
                                <?php $response = getNextLoanDetails($con, $req_id, $cusDueMonth);
                                // echo $response['pending']; ?>
                            </td>
                            <td>
                                <?php $response = getNextLoanDetails($con, $req_id, $cusDueMonth);
                                // echo $response['payable']; ?>
                            </td>
                        <?php
                            $curDateChecker = false; //set to false because, pending and payable only need one month after current month
                        } else {
                        ?>
                            <td></td>
                            <td></td>
                    <?php
                        }
                    }
                    ?>

                    <td></td>
                    <!-- for collected amt -->
                    <?php if ($loan_type == 'emi') { ?>
                        <td> </td>
                    <?php } ?>
                    <?php if ($loan_type == 'interest') { ?>
                        <td> </td>
                        <td> </td>
                    <?php } ?>

                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>

            <?php
                $i++;
            }
        }

        $currentMonth = date('Y-m-d');
        if ($loanFrom['due_method_calc'] == 'Monthly' || $loanFrom['due_method_scheme'] == '1') {
            //Query for Monthly.
            $run = $connect->query("SELECT c.coll_code, c.due_amt, c.pending_amt, c.payable_amt, c.coll_date, c.trans_date, c.due_amt_track, c.princ_amt_track,c.int_amt_track, c.bal_amt, c.coll_charge_track, c.coll_location, c.pre_close_waiver, alc.due_start_from, alc.maturity_month, alc.due_method_calc, u.fullname, u.role
            FROM `collection` c
            LEFT JOIN acknowlegement_loan_calculation alc ON c.req_id = alc.req_id
            LEFT JOIN user u ON c.insert_login_id = u.user_id
            WHERE c.`req_id` = '$req_id' AND (c.due_amt_track != '' or c.pre_close_waiver!='')
            AND (
                (c.coll_date > '$maturity_month' AND c.coll_date <= '$currentMonth') OR
                (c.trans_date > '$maturity_month' AND c.coll_date <= '$currentMonth')
            )");
        } else
        if ($loanFrom['due_method_scheme'] == '2') {
            //Query For Weekly.
            $run = $connect->query("SELECT c.coll_code, c.due_amt, c.pending_amt, c.payable_amt, c.coll_date, c.trans_date, c.due_amt_track, c.bal_amt, c.coll_charge_track, c.coll_location, c.pre_close_waiver, alc.maturity_month, alc.maturity_month, alc.due_method_calc, u.fullname, u.role
            FROM `collection` c
            LEFT JOIN acknowlegement_loan_calculation alc ON c.req_id = alc.req_id
            LEFT JOIN user u ON c.insert_login_id = u.user_id
            WHERE c.`req_id` = '$req_id' AND (c.due_amt_track != '' or c.pre_close_waiver!='')
            AND (
                (c.coll_date > '$maturity_month' AND c.coll_date <= '$currentMonth'  ) OR
                (c.trans_date > '$maturity_month' AND c.coll_date <= '$currentMonth' )
            ) ");
        } else
        if ($loanFrom['due_method_scheme'] == '3') {
            //Query For Day.
            $run = $connect->query("SELECT c.coll_code, c.due_amt, c.pending_amt, c.payable_amt, c.coll_date, c.trans_date, c.due_amt_track, c.bal_amt, c.coll_charge_track, c.coll_location, c.pre_close_waiver, alc.maturity_month, alc.maturity_month, alc.due_method_calc, u.fullname, u.role
            FROM `collection` c
            LEFT JOIN acknowlegement_loan_calculation alc ON c.req_id = alc.req_id
            LEFT JOIN user u ON c.insert_login_id = u.user_id
            WHERE c.`req_id` = '$req_id' AND (c.due_amt_track != '' or c.pre_close_waiver!='')
            AND (
                (c.coll_date >  '$maturity_month' AND c.coll_date <= '$currentMonth') OR
                (c.trans_date > '$maturity_month' AND c.coll_date <= '$currentMonth')
            ) ");
        }

        if ($run->rowCount() > 0) {
            $due_amt_track = 0;
            $waiver = 0;
            while ($row = $run->fetch()) {
                $role = $row['role'];
                $collectionAmnt = intVal($row['due_amt_track']);
                $due_amt_track = intVal($row['due_amt_track']);
                $waiver = intVal($row['pre_close_waiver']);
                $bal_amt = $bal_amt - $due_amt_track - $waiver;
            ?>
                <tr>
                    <!-- <td> <?php echo $i; ?></td>
                    <td><?php
                        if ($loanFrom['due_method_calc'] == 'Monthly' || $loanFrom['due_method_scheme'] == '1') {
                            //For Monthly.
                            echo date('m-Y', strtotime($issue_date));
                        } else {
                            //For Weekly && Day.
                            echo date('d-m-Y', strtotime($row['trans_date']!='0000-00-00'?$row['trans_date']:$row['coll_date']));
                        }
                        ?></td>
                    <td><?php echo date('M', strtotime($issue_date)); ?></td>
                    <td><?php echo $row['due_amt']; ?></td> -->
                    <td></td>
                    <td></td>
                    <td></td>

                    <?php if ($loan_type == 'emi') { ?>
                        <td></td>
                    <?php } ?>
                    <?php if ($loan_type == 'interest') { ?>
                        <td></td>
                        <td></td>
                    <?php } ?>

                    <td><?php $pendingMinusCollection = (intVal($row['pending_amt']));
                        if ($pendingMinusCollection != '') {
                            echo $pendingMinusCollection;
                        } else {
                            echo 0;
                        } ?></td>
                    <td><?php $payableMinusCollection = (intVal($row['payable_amt']));
                        if ($payableMinusCollection != '') {
                            echo $payableMinusCollection;
                        } //else{echo 0;} 
                        ?></td>
                    <td><?php echo date('d-m-Y', strtotime($row['coll_date'])); ?></td>

                    <?php if ($loan_type == 'emi') { ?>
                        <td>
                            <?php if ($row['due_amt_track'] > 0) {
                                echo $row['due_amt_track'];
                            } elseif ($row['pre_close_waiver'] > 0) {
                                echo $row['pre_close_waiver'];
                            } ?>
                        </td>
                    <?php } ?>

                    <?php if ($loan_type == 'interest') { ?>
                        <td>
                            <?php if ($PcollectionAmnt > 0) {
                                echo $PcollectionAmnt;
                            } elseif ($row['pre_close_waiver'] > 0) {
                                echo $row['pre_close_waiver'];
                            } ?>
                        </td>
                        <td>
                            <?php if ($IcollectionAmnt > 0) {
                                echo $IcollectionAmnt;
                            } ?>
                        </td>
                    <?php } ?>

                    <td><?php echo $bal_amt; ?></td>
                    <td><?php if ($row['pre_close_waiver'] > 0) {
                            echo $row['pre_close_waiver'];
                        } else {
                            echo '0';
                        } ?></td>
                    <td><?php if (isset($role) && $role == '1') {
                            echo 'Director';
                        } else if (isset($role) && $role == '2') {
                            echo 'Agent';
                        } else if (isset($role) && $role == '3') {
                            echo 'Staff';
                        } ?>
                    </td>
                    <td><?php echo $row['fullname']; ?></td>
                    <td><?php if ($row['coll_location'] == '1') {
                            echo 'By Self';
                        } elseif ($row['coll_location'] == '2') {
                            echo 'On Spot';
                        } elseif ($row['coll_location'] == '3') {
                            echo 'Bank Transfer';
                        } ?></td>
                    <td> <a class='print_due_coll' id="" value="<?php echo $row['coll_code']; ?>"> <i class="fa fa-print" aria-hidden="true"></i> </a> </td>
                </tr>

        <?php
                $i++;
            }
        }
        ?>

    </tbody>
</table>

<!-- <script type="text/javascript">
    $(function() {
        $('#dueChartListTable').DataTable({
            'processing': true,
            'iDisplayLength': 11,
            "lengthMenu": [
                [11, 26, 51, -1],
                [10, 25, 50, "All"]
            ],
            // "createdRow": function(row, data, dataIndex) {
            //     $(row).find('td:first').html(dataIndex + 1);
            // },
            // "drawCallback": function(settings) {
            //     this.api().column(0).nodes().each(function(cell, i) {
            //         cell.innerHTML = i + 1;
            //     });
            // },
            dom: 'lBfrtip',
            buttons: [{
                    extend: 'excel',
                },
                {
                    extend: 'colvis',
                    collectionLayout: 'fixed four-column',
                }
            ],
        });
    });
</script> -->


<?php

function getNextLoanDetails($con, $req_id, $date)
{
    $loan_arr = array();
    $coll_arr = array();
    $response = array(); //Final array to return

    $result = $con->query("SELECT * FROM `acknowlegement_loan_calculation` WHERE req_id = $req_id ");
    if ($result->num_rows > 0) {
        $row = $result->fetch_assoc();
        $loan_arr = $row;

        if ($loan_arr['tot_amt_cal'] == '' || $loan_arr['tot_amt_cal'] == null) {
            //(For monthly interest total amount will not be there, so take principals)
            $response['total_amt'] = $loan_arr['principal_amt_cal'];
            $response['loan_type'] = 'interest';
            $loan_arr['loan_type'] = 'interest';
        } else {
            $response['total_amt'] = $loan_arr['tot_amt_cal'];
            $response['loan_type'] = 'emi';
            $loan_arr['loan_type'] = 'emi';
        }

        if ($loan_arr['due_amt_cal'] == '' || $loan_arr['due_amt_cal'] == null) {
            //(For monthly interest Due amount will not be there, so take interest)
            $response['due_amt'] = $loan_arr['int_amt_cal'];
        } else {
            $response['due_amt'] = $loan_arr['due_amt_cal']; //Due amount will remain same
        }
    }
    $coll_arr = array();
    $result = $con->query("SELECT * FROM `collection` WHERE req_id = $req_id ");
    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            $coll_arr[] = $row;
        }
        $total_paid = 0;
        $total_paid_princ = 0;
        $total_paid_int = 0;
        $pre_closure = 0;

        foreach ($coll_arr as $tot) {
            $total_paid += intVal($tot['due_amt_track']); //only calculate due amount not total paid value, because it will have penalty and coll charge also
            $pre_closure += intVal($tot['pre_close_waiver']); //get pre closure value to subract to get balance amount
            $total_paid_princ += intVal($tot['princ_amt_track']);
            $total_paid_int += intVal($tot['int_amt_track']);
        }
        //total paid amount will be all records again request id should be summed
        $response['total_paid'] = ($loan_arr['loan_type'] == 'emi') ? $total_paid : $total_paid_princ;
        $response['total_paid_int'] = $total_paid_int;
        $response['pre_closure'] = $pre_closure;

        //total amount subracted by total paid amount and subracted with pre closure amount will be balance to be paid
        $response['balance'] = $response['total_amt'] - $response['total_paid'] - $pre_closure;

        if ($loan_arr['loan_type'] == 'interest') {
            $response['due_amt'] = calculateNewInterestAmt($loan_arr, $response);
        }

        $response = calculateOthers($loan_arr, $response, $date, $con);
    } else {
        //If collection table dont have rows means there is no payment against that request, so total paid will be 0
        $response['total_paid'] = 0;
        $response['total_paid_int'] = 0;
        $response['pre_closure'] = 0;
        //If in collection table, there is no payment means balance amount still remains total amount
        $response['balance'] = $response['total_amt'];

        if ($loan_arr['loan_type'] == 'interest') {
            $response['due_amt'] = calculateNewInterestAmt($loan_arr, $response);
        }

        $response = calculateOthers($loan_arr, $response, $date, $con);
    }



    //To get the collection charges
    $result = $con->query("SELECT SUM(coll_charge) as coll_charge FROM `collection_charges` WHERE req_id = '" . $req_id . "' ");
    $row = $result->fetch_assoc();
    if ($row['coll_charge'] != null) {

        $coll_charges = $row['coll_charge'];

        $result = $con->query("SELECT SUM(coll_charge_track) as coll_charge_track,SUM(coll_charge_waiver) as coll_charge_waiver FROM `collection` WHERE req_id = '" . $req_id . "' ");
        if ($result->num_rows > 0) {
            $row = $result->fetch_assoc();
            $coll_charge_track = $row['coll_charge_track'];
            $coll_charge_waiver = $row['coll_charge_waiver'];
        } else {
            $coll_charge_track = 0;
            $coll_charge_waiver = 0;
        }

        $response['coll_charge'] = $coll_charges - $coll_charge_track - $coll_charge_waiver;
    } else {
        $response['coll_charge'] = 0;
    }

    return $response;
}
function calculateOthers($loan_arr, $response, $date, $con)
{

    if (isset($_POST['req_id'])) {
        $req_id = $_POST['req_id'];
    }
    // $req_id = '11';//***************************************************************************************************************************************************
    $due_start_from = $loan_arr['due_start_from'];
    $maturity_month = $loan_arr['maturity_month'];

    $tot_paid_tilldate = 0; $preclose_tilldate=0;


    $checkcollection = $con->query("SELECT SUM(`due_amt_track`) as totalPaidAmt FROM `collection` WHERE `req_id` = '$req_id'"); // To Find total paid amount till Now.
    $checkrow = $checkcollection->fetch_assoc();
    $totalPaidAmt = $checkrow['totalPaidAmt'] ?? 0; //null collation operator
    $checkack = $con->query("SELECT int_amt_cal,due_amt_cal FROM `acknowlegement_loan_calculation` WHERE `req_id` = '$req_id'"); // To Find Due Amount.
    $checkAckrow = $checkack->fetch_assoc();
    $int_amt_cal = $checkAckrow['int_amt_cal'];
    $due_amt = $checkAckrow['due_amt_cal'];

    if ($loan_arr['due_method_calc'] == 'Monthly' || $loan_arr['due_method_scheme'] == '1') {

        //Convert Date to Year and month, because with date, it will use exact date to loop months, instead of taking end of month
        $due_start_from = date('Y-m', strtotime($due_start_from));
        $maturity_month = date('Y-m', strtotime($maturity_month));

        // Create a DateTime object from the given date
        $maturity_month = new DateTime($maturity_month);
        // Subtract one month from the date
        // $maturity_month->modify('-1 month');
        // Format the date as a string
        $maturity_month = $maturity_month->format('Y-m');

        //If Due method is Monthly, Calculate penalty by checking the month has ended or not
        $current_date = date('Y-m', strtotime($date));

        $start_date_obj = DateTime::createFromFormat('Y-m', $due_start_from);
        $end_date_obj = DateTime::createFromFormat('Y-m', $maturity_month);
        $current_date_obj = DateTime::createFromFormat('Y-m', $current_date);

        $interval = new DateInterval('P1M'); // Create a one month interval

        // $qry = $con->query("DELETE FROM penalty_charges where req_id = '$req_id' and (penalty_date != '' or penalty_date != NULL ) ");
        //condition start
        $count = 0;
        $loandate_tillnow = 0;
        $countForPenalty = 0;

        $dueCharge = ($due_amt) ? $due_amt : $int_amt_cal;
        $start = DateTime::createFromFormat('Y-m', $due_start_from);
        $current = DateTime::createFromFormat('Y-m', $current_date);



        for ($i = $start; $i < $current; $start->add($interval)) {
            $loandate_tillnow += 1;
            $toPaytilldate = intval($loandate_tillnow) * intval($dueCharge);
        }

        while ($start_date_obj < $end_date_obj && $start_date_obj < $current_date_obj) { // To find loan date count till now from start date.
            $penalty_checking_date  = $start_date_obj->format('Y-m-d'); // This format is for query.. month , year function accept only if (Y-m-d).
            $penalty_date  = $start_date_obj->format('Y-m');
            $start_date_obj->add($interval);

            $checkcollection = $con->query("SELECT * FROM `collection` WHERE `req_id` = '$req_id' && ((MONTH(coll_date)= MONTH('$penalty_checking_date') || MONTH(trans_date)= MONTH('$penalty_checking_date')) && (YEAR(coll_date)= YEAR('$penalty_checking_date') || YEAR(trans_date)= YEAR('$penalty_checking_date')))");
            $collectioncount = mysqli_num_rows($checkcollection); // Checking whether the collection are inserted on date or not by using penalty_raised_date.

            if ($loan_arr['scheme_name'] == '' || $loan_arr['scheme_name'] == null) {
                $result = $con->query("SELECT overdue FROM `loan_calculation` WHERE loan_category = '" . $loan_arr['loan_category'] . "' and sub_category = '" . $loan_arr['sub_category'] . "' ");
            } else {
                $result = $con->query("SELECT overdue FROM `loan_scheme` WHERE loan_category = '" . $loan_arr['loan_category'] . "' and sub_category = '" . $loan_arr['sub_category'] . "' ");
            }
            $row = $result->fetch_assoc();
            $penalty_per = $row['overdue']; //get penalty percentage to insert
            $penalty = round(($response['due_amt'] * $penalty_per) / 100);


            if ($loan_arr['loan_type'] == 'interest' and $count == 0) {
                // if loan type is interest and when this loop for first month crossed then we need to calculate toPaytilldate again
                // coz for first month interest amount may vary depending on start date of due, so reduce one due amt from it and add the calculated first month interest to it
                $toPaytilldate = $toPaytilldate - $response['due_amt'] + getTillDateInterest($loan_arr, $response, $con, 'fullstartmonth', $date);
            }

            if ($totalPaidAmt < $toPaytilldate && $collectioncount == 0) {
                $checkPenalty = $con->query("SELECT * from penalty_charges where penalty_date = '$penalty_date' and req_id = '$req_id' ");
                if ($checkPenalty->num_rows == 0) {
                    if ($loan_arr['loan_type'] == 'emi') {
                        //if loan type is emi then directly apply penalty when month crossed and above conditions true
                        // $qry = $con->query("INSERT into penalty_charges (`req_id`,`penalty_date`, `penalty`, `created_date`) values ('$req_id','$penalty_date','$penalty',current_timestamp)");
                    } else if ($loan_arr['loan_type'] == 'interest' and  $count != 0) {
                        // if loan type is interest then apply penalty if the loop month is not first
                        // so penalty should not raise, coz a month interest is paid after the month end
                        // $qry = $con->query("INSERT into penalty_charges (`req_id`,`penalty_date`, `penalty`, `created_date`) values ('$req_id','$penalty_date','$penalty',current_timestamp)");
                    }
                }
                $countForPenalty++;
            }

            $count++; //Count represents how many months are exceeded
        }
        //condition END
        
        //this collection query for taking the paid amount until the looping date ($current_date) , to calculate dynamically for due chart
        $qry = $con->query("SELECT sum(due_amt_track) as due_amt_track, sum(pre_close_waiver) as pre_close_waiver from `collection` 
        where req_id = $req_id 
        AND 
        (
            (
                YEAR(trans_date) = YEAR('$current_date') AND MONTH(trans_date) <= MONTH('$current_date')
            ) OR (
                YEAR(trans_date) < YEAR('$current_date')
            )
        )
        OR
        (
            (
                YEAR(coll_date) = YEAR('$current_date') AND MONTH(coll_date) <= MONTH('$current_date')
            ) OR (
                YEAR(coll_date) < YEAR('$current_date')
            )
        ) ");
        if($qry->num_rows > 0){
        $rowss = $qry->fetch_assoc();
        $tot_paid_tilldate = intVal($rowss['due_amt_track']);
        $preclose_tilldate = intVal($rowss['pre_close_waiver']);
        }
        if ($count > 0) {


            if ($loan_arr['loan_type'] == 'interest') {

                $response['pending'] = (($response['due_amt'] * ($count)) - $response['due_amt'] + getTillDateInterest($loan_arr, $response, $con, 'fullstartmonth', $date)) - $response['total_paid_int'];
            } else {

                //if Due month exceeded due amount will be as pending with how many months are exceeded and subract pre closure amount if available
                $response['pending'] = ($response['due_amt'] * ($count)) - $tot_paid_tilldate - $preclose_tilldate;
            }

            // If due month exceeded
            if ($loan_arr['scheme_name'] == '' || $loan_arr['scheme_name'] == null) {
                $result = $con->query("SELECT overdue FROM `loan_calculation` WHERE loan_category = '" . $loan_arr['loan_category'] . "' and sub_category = '" . $loan_arr['sub_category'] . "' ");
            } else {
                $result = $con->query("SELECT overdue FROM `loan_scheme` WHERE loan_category = '" . $loan_arr['loan_category'] . "' and sub_category = '" . $loan_arr['sub_category'] . "' ");
            }
            $row = $result->fetch_assoc();
            $penalty_per = number_format($row['overdue'] * $countForPenalty); //Count represents how many months are exceeded//Number format if percentage exeeded decimals then pernalty may increase

            // to get overall penalty paid till now to show pending penalty amount
            $result = $con->query("SELECT SUM(penalty_track) as penalty,SUM(penalty_waiver) as penalty_waiver FROM `collection` WHERE req_id = '" . $req_id . "' ");
            $row = $result->fetch_assoc();
            if ($row['penalty'] == null) {
                $row['penalty'] = 0;
            }
            if ($row['penalty_waiver'] == null) {
                $row['penalty_waiver'] = 0;
            }
            //to get overall penalty raised till now for this req id
            $result1 = $con->query("SELECT SUM(penalty) as penalty FROM `penalty_charges` WHERE req_id = '" . $req_id . "' ");
            $row1 = $result1->fetch_assoc();
            if ($row1['penalty'] == null) {
                $penalty = 0;
            } else {
                $penalty = $row1['penalty'];
            }

            $response['penalty'] = $penalty - $row['penalty'] - $row['penalty_waiver'];


            //Payable amount will be pending amount added with current month due amount
            $response['payable'] = $response['due_amt'] + $response['pending'];


            if ($loan_arr['loan_type'] == 'interest') { // if loan type is interest then we need to calculate pending and payable again

                if ($count == 1) {
                    // if this condition true then, first month of the start date only has been ended
                    // so we need to calculate only the first month interest , not whole interest amount as payable
                    // if($response['total_paid'] != 0){
                    //     $response['payable'] = $response['total_paid'] - getTillDateInterest($loan_arr,$response,$con,'fullstartmonth') ;
                    // }else{
                    // if($response['total_paid_int'] != 0){
                    //     $response['payable'] = $response['total_paid_int'] - getTillDateInterest($loan_arr,$response,$con,'fullstartmonth') ;
                    // }else{
                    $response['payable'] = $response['pending'];
                    // }
                    // }

                    //pending amount will remain zero , coz usually we pay ended month's interest amount only in next month
                    //so when only one month is exceeded, that not the pending 
                    $response['pending'] =  0;
                } else {
                    //if this condition means, more than 1 month is crossed from start month
                    //pending amount will be calculated above for all other loan types as usual
                    //for interest type, we should not calculate due month multiplied by count of month crossed.
                    //in interest loan we need to calculate interest amount of first month by how many days are used in first month only
                    //so that, here subracted one month due amt and added first month's interest based on days spent there

                    // $response['pending'] =  $response['pending'] - $response['due_amt'] + getTillDateInterest($loan_arr,$response,$con,'fullstartmonth');

                    // if($response['total_paid_int'] != 0){
                    //     $response['payable'] =  abs($response['total_paid_int'] - $response['pending']);
                    // }else{
                    $response['payable'] =  $response['pending'];
                    // }

                    if ($count >= 2) {
                        $response['pending'] =  $response['pending'] - $response['due_amt'];
                    }
                }
            }

            if ($response['payable'] > $response['balance']) {
                //if payable is greater than balance then change it as balance amt coz dont collect more than balance
                //this case will occur when collection status becoms OD
                $response['payable'] = $response['balance'];
            }

            //in this calculate till date interest when month are crossed for current month
            $response['till_date_int'] = getTillDateInterest($loan_arr, $response, $con, 'from01', $date);
        } else {
            //If still current month is not ended, then pending will be same due amt // pending will be 0 if due date not exceeded
            $response['pending'] = 0; // $response['due_amt'] - $response['total_paid'] - $response['pre_closure'] ;
            //If still current month is not ended, then penalty will be 0
            $response['penalty'] = 0;
            //If still current month is not ended, then payable will be due amt
            $response['payable'] = $response['due_amt'] - $tot_paid_tilldate - $preclose_tilldate;

            if ($loan_arr['loan_type'] == 'interest') {
                $response['payable'] =  0;
            }

            //in this calculate till date interest when month are not crossed for due starting month
            $response['till_date_int'] = getTillDateInterest($loan_arr, $response, $con, 'forstartmonth', $date);
        }
    } else
    if ($loan_arr['due_method_scheme'] == '2') {

        //If Due method is Weekly, Calculate penalty by checking the month has ended or not
        $current_date = date('Y-m-d', strtotime($date));

        $start_date_obj = DateTime::createFromFormat('Y-m-d', $due_start_from);
        $end_date_obj = DateTime::createFromFormat('Y-m-d', $maturity_month);
        $current_date_obj = DateTime::createFromFormat('Y-m-d', $current_date);

        $interval = new DateInterval('P1W'); // Create a one Week interval

        // $qry = $con->query("DELETE FROM penalty_charges where req_id = '$req_id' and (penalty_date != '' or penalty_date != NULL ) ");
        //condition start
        $count = 0;
        $loandate_tillnow = 0;
        $countForPenalty = 0;

        $dueCharge = ($due_amt) ? $due_amt : $int_amt_cal;
        $start = DateTime::createFromFormat('Y-m-d', $due_start_from);
        $current = DateTime::createFromFormat('Y-m-d', $current_date);

        for ($i = $start; $i < $current; $start->add($interval)) {
            $loandate_tillnow += 1;
            $toPaytilldate = intval($loandate_tillnow) * intval($dueCharge);
        }

        while ($start_date_obj < $end_date_obj && $start_date_obj < $current_date_obj) { // To find loan date count till now from start date.

            $penalty_checking_date  = $start_date_obj->format('Y-m-d'); // This format is for query.. month , year function accept only if (Y-m-d).
            $start_date_obj->add($interval);
            
            $checkcollection = $con->query("SELECT * FROM `collection` WHERE `req_id` = '$req_id' && ((WEEK(coll_date)= WEEK('$penalty_checking_date') || WEEK(trans_date)= WEEK('$penalty_checking_date')) && (YEAR(coll_date)= YEAR('$penalty_checking_date') || YEAR(trans_date)= YEAR('$penalty_checking_date')))");
            $collectioncount = mysqli_num_rows($checkcollection); // Checking whether the collection are inserted on date or not by using penalty_raised_date.

            if ($loan_arr['scheme_name'] == '' || $loan_arr['scheme_name'] == null) {
                $result = $con->query("SELECT overdue FROM `loan_calculation` WHERE loan_category = '" . $loan_arr['loan_category'] . "' and sub_category = '" . $loan_arr['sub_category'] . "' ");
            } else {
                $result = $con->query("SELECT overdue FROM `loan_scheme` WHERE loan_category = '" . $loan_arr['loan_category'] . "' and sub_category = '" . $loan_arr['sub_category'] . "' ");
            }
            $row = $result->fetch_assoc();
            $penalty_per = $row['overdue']; //get penalty percentage to insert
            $penalty = round(($response['due_amt'] * $penalty_per) / 100);
            $count++; //Count represents how many months are exceeded

            if ($totalPaidAmt < $toPaytilldate && $collectioncount == 0) {
                $checkPenalty = $con->query("SELECT * from penalty_charges where penalty_date = '$penalty_checking_date' and req_id = '$req_id' ");
                if ($checkPenalty->num_rows == 0) {
                    // $qry = $con->query("INSERT into penalty_charges (`req_id`,`penalty_date`, `penalty`, `created_date`) values ('$req_id','$penalty_checking_date','$penalty',current_timestamp)");
                }
                $countForPenalty++;
            }
        }
        //condition END

        //this collection query for taking the paid amount until the looping date ($current_date) , to calculate dynamically for due chart
        $qry = $con->query("SELECT sum(due_amt_track) as due_amt_track, sum(pre_close_waiver) as pre_close_waiver from `collection` 
            where req_id = '$req_id' 
            AND
            (
                (
                    YEAR(trans_date) = YEAR($current_date) AND WEEK(trans_date) <= WEEK($current_date)
                ) OR (
                    YEAR(trans_date) < YEAR($current_date)
                )
            )
            OR
            (
                (
                    YEAR(coll_date) = YEAR($current_date) AND WEEK(coll_date) <= WEEK($current_date)
                ) OR (
                    YEAR(coll_date) < YEAR($current_date)
                )
            ) ");
        if($qry->num_rows > 0){
            $rowss = $qry->fetch_assoc();
            $tot_paid_tilldate = intVal($rowss['due_amt_track']);
            $preclose_tilldate = intVal($rowss['pre_close_waiver']);
        }
        if ($count > 0) {


            //if Due month exceeded due amount will be as pending with how many months are exceeded and subract pre closure amount if available
            $response['pending'] = ($response['due_amt'] * $count) - $tot_paid_tilldate - $preclose_tilldate;

            // If due month exceeded
            if ($loan_arr['scheme_name'] == '' || $loan_arr['scheme_name'] == null) {
                $result = $con->query("SELECT overdue FROM `loan_calculation` WHERE loan_category = '" . $loan_arr['loan_category'] . "' and sub_category = '" . $loan_arr['sub_category'] . "' ");
            } else {
                $result = $con->query("SELECT overdue FROM `loan_scheme` WHERE loan_category = '" . $loan_arr['loan_category'] . "' and sub_category = '" . $loan_arr['sub_category'] . "' ");
            }
            $row = $result->fetch_assoc();
            $penalty_per = number_format($row['overdue'] * $countForPenalty); //Count represents how many months are exceeded//Number format if percentage exeeded decimals then pernalty may increase

            // to get overall penalty paid till now to show pending penalty amount
            $result = $con->query("SELECT SUM(penalty_track) as penalty,SUM(penalty_waiver) as penalty_waiver FROM `collection` WHERE req_id = '" . $req_id . "' ");
            $row = $result->fetch_assoc();
            if ($row['penalty'] == null) {
                $row['penalty'] = 0;
            }
            if ($row['penalty_waiver'] == null) {
                $row['penalty_waiver'] = 0;
            }
            //to get overall penalty raised till now for this req id
            $result1 = $con->query("SELECT SUM(penalty) as penalty FROM `penalty_charges` WHERE req_id = '" . $req_id . "' ");
            $row1 = $result1->fetch_assoc();
            if ($row1['penalty'] == null) {
                $penalty = 0;
            } else {
                $penalty = $row1['penalty'];
            }

            // $penalty = intval((($response['due_amt'] * $penalty_per) / 100));

            $response['penalty'] = $penalty - $row['penalty'] - $row['penalty_waiver'];

            //Payable amount will be pending amount added with current month due amount
            $response['payable'] = $response['due_amt'] + $response['pending'];
            if ($response['payable'] > $response['balance']) {
                //if payable is greater than balance then change it as balance amt coz dont collect more than balance
                //this case will occur when collection status becoms OD
                $response['payable'] = $response['balance'];
            }
        } else {
            //If still current month is not ended, then pending will be same due amt // pending will be 0 if due date not exceeded
            $response['pending'] = 0; // $response['due_amt'] - $response['total_paid'] - $response['pre_closure'] ;
            //If still current month is not ended, then penalty will be 0
            $response['penalty'] = 0;
            //If still current month is not ended, then payable will be due amt
            $response['payable'] = $response['due_amt'] - $tot_paid_tilldate - $preclose_tilldate;
        }
    } elseif ($loan_arr['due_method_scheme'] == '3') {
        //If Due method is Daily, Calculate penalty by checking the month has ended or not
        $current_date = date('Y-m-d', strtotime($date));

        $start_date_obj = DateTime::createFromFormat('Y-m-d', $due_start_from);
        $end_date_obj = DateTime::createFromFormat('Y-m-d', $maturity_month);
        $current_date_obj = DateTime::createFromFormat('Y-m-d', $current_date);

        $interval = new DateInterval('P1D'); // Create a one Week interval

        // $qry = $con->query("DELETE FROM penalty_charges where req_id = '$req_id' and (penalty_date != '' or penalty_date != NULL ) ");

        //condition start
        $count = 0;
        $loandate_tillnow = 0;
        $countForPenalty = 0;

        $dueCharge = ($due_amt) ? $due_amt : $int_amt_cal;
        $start = DateTime::createFromFormat('Y-m-d', $due_start_from);
        $current = DateTime::createFromFormat('Y-m-d', $current_date);

        for ($i = $start; $i < $current; $start->add($interval)) {
            $loandate_tillnow += 1;
            $toPaytilldate = intval($loandate_tillnow) * intval($dueCharge);
        }

        while ($start_date_obj < $end_date_obj && $start_date_obj < $current_date_obj) { // To find loan date count till now from start date.
            $penalty_checking_date  = $start_date_obj->format('Y-m-d'); // This format is for query.. month , year function accept only if (Y-m-d).
            $start_date_obj->add($interval);

            $checkcollection = $con->query("SELECT * FROM `collection` WHERE `req_id` = '$req_id' && ((DAY(coll_date)= DAY('$penalty_checking_date') || DAY(trans_date)= DAY('$penalty_checking_date')) && (YEAR(coll_date)= YEAR('$penalty_checking_date') || YEAR(trans_date)= YEAR('$penalty_checking_date')))");
            $collectioncount = mysqli_num_rows($checkcollection); // Checking whether the collection are inserted on date or not by using penalty_raised_date.

            if ($loan_arr['scheme_name'] == '' || $loan_arr['scheme_name'] == null) {
                $result = $con->query("SELECT overdue FROM `loan_calculation` WHERE loan_category = '" . $loan_arr['loan_category'] . "' and sub_category = '" . $loan_arr['sub_category'] . "' ");
            } else {
                $result = $con->query("SELECT overdue FROM `loan_scheme` WHERE loan_category = '" . $loan_arr['loan_category'] . "' and sub_category = '" . $loan_arr['sub_category'] . "' ");
            }
            $row = $result->fetch_assoc();
            $penalty_per = $row['overdue']; //get penalty percentage to insert
            $penalty = round(($response['due_amt'] * $penalty_per) / 100);
            $count++; //Count represents how many months are exceeded

            if ($totalPaidAmt < $toPaytilldate && $collectioncount == 0) {
                $checkPenalty = $con->query("SELECT * from penalty_charges where penalty_date = '$penalty_checking_date' and req_id = '$req_id' ");
                if ($checkPenalty->num_rows == 0) {
                    // $qry = $con->query("INSERT into penalty_charges (`req_id`,`penalty_date`, `penalty`, `created_date`) values ('$req_id','$penalty_checking_date','$penalty',current_timestamp)");
                }
                $countForPenalty++;
            }
        }
        //condition END
        
        //this collection query for taking the paid amount until the looping date ($current_date) , to calculate dynamically for due chart
        $qry = $con->query("SELECT sum(due_amt_track) as due_amt_track, sum(pre_close_waiver) as pre_close_waiver from `collection` 
            where req_id = $req_id and (date(coll_date) <= date('$current_date') or date(trans_date) <= date('$current_date')) ");
        if($qry->num_rows > 0){
            $rowss = $qry->fetch_assoc();
            $tot_paid_tilldate = intVal($rowss['due_amt_track']);
            $preclose_tilldate = intVal($rowss['pre_close_waiver']);
        }
        if ($count > 0) {


            //if Due month exceeded due amount will be as pending with how many months are exceeded and subract pre closure amount if available
            $response['pending'] = ($response['due_amt'] * $count) - $tot_paid_tilldate - $preclose_tilldate;

            // If due month exceeded
            if ($loan_arr['scheme_name'] == '' || $loan_arr['scheme_name'] == null) {
                $result = $con->query("SELECT overdue FROM `loan_calculation` WHERE loan_category = '" . $loan_arr['loan_category'] . "' and sub_category = '" . $loan_arr['sub_category'] . "' ");
            } else {
                $result = $con->query("SELECT overdue FROM `loan_scheme` WHERE loan_category = '" . $loan_arr['loan_category'] . "' and sub_category = '" . $loan_arr['sub_category'] . "' ");
            }
            $row = $result->fetch_assoc();
            $penalty_per = number_format($row['overdue'] * $countForPenalty); //Count represents how many months are exceeded//Number format if percentage exeeded decimals then pernalty may increase

            // to get overall penalty paid till now to show pending penalty amount
            $result = $con->query("SELECT SUM(penalty_track) as penalty,SUM(penalty_waiver) as penalty_waiver FROM `collection` WHERE req_id = '" . $req_id . "' ");
            $row = $result->fetch_assoc();
            if ($row['penalty'] == null) {
                $row['penalty'] = 0;
            }
            if ($row['penalty_waiver'] == null) {
                $row['penalty_waiver'] = 0;
            }
            //to get overall penalty raised till now for this req id
            $result1 = $con->query("SELECT SUM(penalty) as penalty FROM `penalty_charges` WHERE req_id = '" . $req_id . "' ");
            $row1 = $result1->fetch_assoc();
            if ($row1['penalty'] == null) {
                $penalty = 0;
            } else {
                $penalty = $row1['penalty'];
            }

            // $penalty = intval((($response['due_amt'] * $penalty_per) / 100));

            $response['penalty'] = $penalty - $row['penalty'] - $row['penalty_waiver'];

            //Payable amount will be pending amount added with current month due amount
            $response['payable'] = $response['due_amt'] + $response['pending'];
            if ($response['payable'] > $response['balance']) {
                //if payable is greater than balance then change it as balance amt coz dont collect more than balance
                //this case will occur when collection status becoms OD
                $response['payable'] = $response['balance'];
            }
        } else {
            //If still current month is not ended, then pending will be same due amt// pending will be 0 if due date not exceeded
            $response['pending'] = 0; //$response['due_amt'] - $response['total_paid'] - $response['pre_closure'] ;
            //If still current month is not ended, then penalty will be 0
            $response['penalty'] = 0;
            //If still current month is not ended, then payable will be due amt
            $response['payable'] = $response['due_amt'] - $tot_paid_tilldate - $preclose_tilldate;
        }
    }

    if ($response['pending'] < 0) {
        $response['pending'] = 0;
    }
    if ($response['payable'] < 0) {
        $response['payable'] = 0;
    }
    return $response;
}

function calculateNewInterestAmt($loan_arr, $response)
{
    //to calculate current interest amount based on current balance value//bcoz interest will be calculated based on current balance amt only for interest loan
    $int = $response['balance'] * ($loan_arr['int_rate'] / 100);
    $curInterest = ceil($int / 5) * 5; //to increase Interest to nearest multiple of 5
    if ($curInterest < $int) {
        $curInterest += 5;
    }
    $response = $curInterest;

    return $response;
}

function getTillDateInterest($loan_arr, $response, $con, $data, $date)
{

    if ($data == 'from01') {
        //in this calculate till date interest when month are crossed for current month

        //to calculate till date interest if loan is interst based
        if ($loan_arr['loan_type'] == 'interest') {

            // Get the current month's count of days
            $currentMonthCount = date('t', strtotime($date));
            // divide current interest amt for one day of current month
            $amtperDay = $response['due_amt'] / intVal($currentMonthCount);

            $st_date = new DateTime(date('Y-m-01', strtotime($date))); // start date
            $tdate = new DateTime(date('Y-m-d', strtotime($date . '+1 day'))); //current date
            // $tdate = $tdate->modify('+1 day');//current date +1
            // Calculate the interval between the two dates
            $date_diff = $st_date->diff($tdate);
            // Get the number of days from the interval
            $numberOfDays = $date_diff->days;
            $response = $amtperDay * $numberOfDays;

            //to increase till date Interest to nearest multiple of 5
            $cur_amt = ceil($response / 5) * 5; //ceil will set the number to nearest upper integer//i.e ceil(121/5)*5 = 125
            if ($cur_amt < $response) {
                $cur_amt += 5;
            }
            $response = $cur_amt;
        }
    } else if ($data == 'forstartmonth') {
        //if condition is true then this is , 2 months has been completed.
        //so the pending amt will be only the first month's complete interest amount


        //to calculate till date interest if loan is interst based
        if ($loan_arr['loan_type'] == 'interest') {

            // Get the current month's count of days
            $currentMonthCount = date('t', strtotime($loan_arr['due_start_from']));
            // divide current interest amt for one day of current month
            $amtperDay = $response['due_amt'] / intVal($currentMonthCount);

            $st_date = new DateTime(date('Y-m-d', strtotime($loan_arr['due_start_from']))); // start date
            $tdate = new DateTime(date('Y-m-d', strtotime($date . '+1 day'))); //current date
            // $tdate = $tdate->modify('+1 day');//current date +1
            // Calculate the interval between the two dates
            $date_diff = $st_date->diff($tdate);
            // Get the number of days from the interval
            $numberOfDays = $date_diff->days;
            $response = $amtperDay * $numberOfDays;

            //to increase till date Interest to nearest multiple of 5
            $cur_amt = ceil($response / 5) * 5; //ceil will set the number to nearest upper integer//i.e ceil(121/5)*5 = 125
            if ($cur_amt < $response) {
                $cur_amt += 5;
            }
            $response = $cur_amt;

            //if today date is less than start date means make till date interest as 0 else it will show some amount as the different shows
            if ($tdate < $st_date) {
                $response = 0;
            }
        }
    } else if ($data == 'fullstartmonth') {
        //in this calculate till date interest when month are not crossed for due starting month

        //to calculate till date interest if loan is interst based
        if ($loan_arr['loan_type'] == 'interest') {

            // Get the current month's count of days
            $currentMonthCount = date('t', strtotime($loan_arr['due_start_from']));
            // divide current interest amt for one day of current month
            $amtperDay = $response['due_amt'] / intVal($currentMonthCount);

            $st_date = new DateTime(date('Y-m-d', strtotime($loan_arr['due_start_from']))); // start date
            $tdate = new DateTime(date('Y-m-t', strtotime($loan_arr['due_start_from']))); //current date
            // $tdate = $tdate->modify('+1 day');//current date +1
            // Calculate the interval between the two dates
            $date_diff = $st_date->diff($tdate);
            // Get the number of days from the interval
            $numberOfDays = $date_diff->days;
            $response = ceil($amtperDay * $numberOfDays);

            // //to increase till date Interest to nearest multiple of 5
            // $cur_amt = ceil($response / 5) * 5; //ceil will set the number to nearest upper integer//i.e ceil(121/5)*5 = 125
            // if ($cur_amt < $response) {
            //     $cur_amt += 5;
            // }
            // $response = $cur_amt;
        }
    }
    return $response;
}

?>
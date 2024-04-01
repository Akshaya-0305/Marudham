<?php

use PhpOffice\PhpSpreadsheet\Calculation\TextData\Format;

session_start();
include('../ajaxconfig.php');

if(isset($_SESSION['userid'])){
    $user_id = $_SESSION['userid'];
}

if(isset($_POST['req_id'])){
    $req_id = $_POST['req_id'];
}
// $req_id = '11';//****************************************************************************************************************************************
if(isset($_POST['cus_id'])){
    $cus_id = $_POST['cus_id'];
}

// Caution **** Dont Touch any code below..
//get Total amt from ack loan calculation (For monthly interest total amount will not be there, so take principals)*
//get Paid amt from collection table if nothing paid show 0*
//balance amount is Total amt - paid amt*
//get Due amt from ack loan calculation*
//get Pending amt from collection based on last entry against request id (Due amt - paid amt)
//get Payable amt by adding pending and due amount
//get penalty, if due date exceeded put the penalty percentage to the due amt
//get collection charges from collection charges table if exists else 0
$loan_arr = array();
$coll_arr = array();
$response = array(); //Final array to return

$result=$con->query("SELECT * FROM `acknowlegement_loan_calculation` WHERE req_id = $req_id ");
if($result->num_rows>0){
    $row = $result->fetch_assoc();
    $loan_arr = $row;

    if($loan_arr['tot_amt_cal'] == '' || $loan_arr['tot_amt_cal'] == null){
        //(For monthly interest total amount will not be there, so take principals)
        $response['total_amt'] = $loan_arr['principal_amt_cal'];
        $response['loan_type'] = 'interest';
        $loan_arr['loan_type'] = 'interest';
    }else{
        $response['total_amt'] = $loan_arr['tot_amt_cal'];
        $response['loan_type'] = 'emi';
        $loan_arr['loan_type'] = 'emi';
    }
    

    if($loan_arr['due_amt_cal'] == '' || $loan_arr['due_amt_cal'] == null){
        //(For monthly interest Due amount will not be there, so take interest)
        $response['due_amt'] = $loan_arr['int_amt_cal'];
    }else{
        $response['due_amt'] = $loan_arr['due_amt_cal']; //Due amount will remain same
    }

    
    $qry = $con->query("SELECT updated_date FROM `in_issue` WHERE req_id = $req_id ");
    $loan_arr['loan_date'] = date('Y-m-d',strtotime($qry->fetch_assoc()['updated_date']));
}
$coll_arr = array();
$result=$con->query("SELECT * FROM `collection` WHERE req_id = $req_id ");
if($result->num_rows>0){
    while($row = $result->fetch_assoc()){
        $coll_arr[] = $row;
    }
    $total_paid=0;
    $total_paid_princ=0;
    $total_paid_int=0;
    $pre_closure=0;

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

    if($loan_arr['loan_type'] == 'interest'){
        $response['due_amt_for1'] = $response['due_amt'];
        $response['due_amt'] = calculateNewInterestAmt($loan_arr['int_rate'],$response['balance']);
    }

    $response = calculateOthers($loan_arr,$response,$con);

    
}else{
    //If collection table dont have rows means there is no payment against that request, so total paid will be 0
    $response['total_paid'] = 0;
    $response['total_paid_int'] = 0;  
    $response['pre_closure'] = 0;
    //If in collection table, there is no payment means balance amount still remains total amount
    $response['balance'] = $response['total_amt'];

    if($loan_arr['loan_type'] == 'interest'){
        $response['due_amt_for1'] = $response['due_amt'];
        $response['due_amt'] = calculateNewInterestAmt($loan_arr['int_rate'],$response['balance']);
    }
    
    $response = calculateOthers($loan_arr,$response,$con); 
}



//To get the collection charges
$result=$con->query("SELECT SUM(coll_charge) as coll_charge FROM `collection_charges` WHERE req_id = '".$req_id."' ");
$row = $result->fetch_assoc();
if($row['coll_charge'] != null){
    
    $coll_charges = $row['coll_charge'];

    $result=$con->query("SELECT SUM(coll_charge_track) as coll_charge_track,SUM(coll_charge_waiver) as coll_charge_waiver FROM `collection` WHERE req_id = '".$req_id."' ");
    if($result->num_rows >0){
        $row = $result->fetch_assoc();
        $coll_charge_track = $row['coll_charge_track'];
        $coll_charge_waiver = $row['coll_charge_waiver'];
    }else{
        $coll_charge_track = 0;
        $coll_charge_waiver = 0;
    }

    $response['coll_charge'] = $coll_charges - $coll_charge_track - $coll_charge_waiver;
}else{
    $response['coll_charge'] = 0;
}

function calculateOthers($loan_arr,$response,$con){
    if(isset($_POST['req_id'])){
        $req_id = $_POST['req_id'];
    }
    // $req_id = '11';//***************************************************************************************************************************************************
    $due_start_from = $loan_arr['due_start_from'];
    $maturity_month = $loan_arr['maturity_month'];



    $checkcollection = $con->query("SELECT SUM(`due_amt_track`) as totalPaidAmt FROM `collection` WHERE `req_id` = '$req_id'"); // To Find total paid amount till Now.
    $checkrow = $checkcollection->fetch_assoc();
    $totalPaidAmt = $checkrow['totalPaidAmt'] ??0;//null collation operator
    $checkack = $con->query("SELECT int_amt_cal,due_amt_cal FROM `acknowlegement_loan_calculation` WHERE `req_id` = '$req_id'"); // To Find Due Amount.
    $checkAckrow = $checkack->fetch_assoc();
    $int_amt_cal = $checkAckrow['int_amt_cal'];
    $due_amt = $checkAckrow['due_amt_cal'];

    if($loan_arr['due_method_calc'] == 'Monthly' || $loan_arr['due_method_scheme'] == '1'){
        if($loan_arr['loan_type'] != 'interest'){
        //Convert Date to Year and month, because with date, it will use exact date to loop months, instead of taking end of month
        $due_start_from = date('Y-m',strtotime($due_start_from));
        $maturity_month = date('Y-m',strtotime($maturity_month));

        // Create a DateTime object from the given date
        $maturity_month = new DateTime($maturity_month);
        // Subtract one month from the date
        $maturity_month->modify('-1 month');
        // Format the date as a string
        $maturity_month = $maturity_month->format('Y-m');

        //If Due method is Monthly, Calculate penalty by checking the month has ended or not
        $current_date = date('Y-m');
        
        $start_date_obj = DateTime::createFromFormat('Y-m', $due_start_from);
        $end_date_obj = DateTime::createFromFormat('Y-m', $maturity_month);
        $current_date_obj = DateTime::createFromFormat('Y-m', $current_date);

        $interval = new DateInterval('P1M'); // Create a one month interval

        // $qry = $con->query("DELETE FROM penalty_charges where req_id = '$req_id' and (penalty_date != '' or penalty_date != NULL ) ");
            //condition start
            $count = 0;
            $loandate_tillnow = 0;
            $countForPenalty = 0;
            $penalty = 0;
            $dueCharge = ($due_amt) ? $due_amt : $int_amt_cal;
            $start = DateTime::createFromFormat('Y-m', $due_start_from);
            $current = DateTime::createFromFormat('Y-m', $current_date);

        

            for($i=$start; $i<$current;$start->add($interval) ){
                $loandate_tillnow += 1;
                $toPaytilldate = intval($loandate_tillnow) * intval($dueCharge);
            }
            

                while($start_date_obj < $end_date_obj && $start_date_obj < $current_date_obj){ // To find loan date count till now from start date.
                    $penalty_checking_date  = $start_date_obj->format('Y-m-d'); // This format is for query.. month , year function accept only if (Y-m-d).
                    $penalty_date  = $start_date_obj->format('Y-m');
                    
                    
                    $checkcollection =$con->query("SELECT * FROM `collection` WHERE `req_id` = '$req_id' && ((MONTH(coll_date)= MONTH('$penalty_checking_date') || MONTH(trans_date)= MONTH('$penalty_checking_date')) && (YEAR(coll_date)= YEAR('$penalty_checking_date') || YEAR(trans_date)= YEAR('$penalty_checking_date')))");
                    $collectioncount = mysqli_num_rows($checkcollection); // Checking whether the collection are inserted on date or not by using penalty_raised_date.
    
                    if($loan_arr['scheme_name'] == '' || $loan_arr['scheme_name'] == null ){
                        $result=$con->query("SELECT overdue FROM `loan_calculation` WHERE loan_category = '".$loan_arr['loan_category']."' and sub_category = '".$loan_arr['sub_category']."' ");
                    }else{
                        $result=$con->query("SELECT overdue FROM `loan_scheme` WHERE loan_category = '".$loan_arr['loan_category']."' and sub_category = '".$loan_arr['sub_category']."' ");
                    }
                    $row = $result->fetch_assoc();
                    $penalty_per = $row['overdue'] ; //get penalty percentage to insert
    
    
                    if($loan_arr['loan_type'] == 'interest' and $count == 0){ 
                        // if loan type is interest and when this loop for first month crossed then we need to calculate toPaytilldate again
                        // coz for first month interest amount may vary depending on start date of due, so reduce one due amt from it and add the calculated first month interest to it
                        $toPaytilldate = $toPaytilldate - $response['due_amt'] + getTillDateInterest($loan_arr,$response,$con,'fullstartmonth','');
    
                    }
                    if($loan_arr['loan_type'] == 'interest'){
                        $loan_arr[$count]['all_due_amt'] = getTillDateInterest($loan_arr, $start_date_obj, $con, 'foreachmonth',$count);
                    } 
                    
                    if($totalPaidAmt < $toPaytilldate && $collectioncount == 0 ){ 
                        $checkPenalty = $con->query("SELECT * from penalty_charges where penalty_date = '$penalty_date' and req_id = '$req_id' ");
                        if($checkPenalty->num_rows == 0){
                            $penalty = round( ( ($response['due_amt'] * $penalty_per) / 100) + $penalty );
                            if($loan_arr['loan_type'] == 'emi'){
                                //if loan type is emi then directly apply penalty when month crossed and above conditions true
                                $qry = $con->query("INSERT into penalty_charges (`req_id`,`penalty_date`, `penalty`, `created_date`) values ('$req_id','$penalty_date','$penalty',current_timestamp)");
                            }else if($loan_arr['loan_type'] == 'interest' and  $count != 0){
                                // if loan type is interest then apply penalty if the loop month is not first
                                // so penalty should not raise, coz a month interest is paid after the month end
                                $qry = $con->query("INSERT into penalty_charges (`req_id`,`penalty_date`, `penalty`, `created_date`) values ('$req_id','$penalty_date','$penalty',current_timestamp)");
                            }
                        }
                        $countForPenalty++;
                    } 
                    
                    $start_date_obj->add($interval); //increase one month to loop again
                    $count++; //Count represents how many months are exceeded
                }
               //condition END
            }else{

                calculateInterestLoan($con, $loan_arr,$response);
                
            }

        if($count>0){
            
            if($loan_arr['loan_type'] == 'interest'){
                
                $response['pending'] = (($response['due_amt'] * ($count)) - $response['due_amt'] + getTillDateInterest($loan_arr,$response,$con,'fullstartmonth','')) - $response['total_paid_int'] ; 
            }else{
                
                //if Due month exceeded due amount will be as pending with how many months are exceeded and subract pre closure amount if available
                $response['pending'] = ($response['due_amt'] * ($count)) - $response['total_paid'] - $response['pre_closure'] ; 
            }

            // If due month exceeded
            if($loan_arr['scheme_name'] == '' || $loan_arr['scheme_name'] == null ){
                $result=$con->query("SELECT overdue FROM `loan_calculation` WHERE loan_category = '".$loan_arr['loan_category']."' and sub_category = '".$loan_arr['sub_category']."' ");
            }else{
                $result=$con->query("SELECT overdue FROM `loan_scheme` WHERE loan_category = '".$loan_arr['loan_category']."' and sub_category = '".$loan_arr['sub_category']."' ");
            }
            $row = $result->fetch_assoc();
            $penalty_per = number_format($row['overdue'] * $countForPenalty); //Count represents how many months are exceeded//Number format if percentage exeeded decimals then pernalty may increase

            // to get overall penalty paid till now to show pending penalty amount
            $result=$con->query("SELECT SUM(penalty_track) as penalty,SUM(penalty_waiver) as penalty_waiver FROM `collection` WHERE req_id = '".$req_id."' ");
            $row = $result->fetch_assoc();
            if($row['penalty'] == null){
                $row['penalty'] = 0;
            }
            if($row['penalty_waiver'] == null){
                $row['penalty_waiver'] = 0;
            }
            //to get overall penalty raised till now for this req id
            $result1=$con->query("SELECT SUM(penalty) as penalty FROM `penalty_charges` WHERE req_id = '".$req_id."' ");
            $row1 = $result1->fetch_assoc();
            if($row1['penalty'] == null){
                $penalty = 0;
            }else{
                $penalty = $row1['penalty'];
            }

            $response['penalty'] = $penalty - $row['penalty'] - $row['penalty_waiver'];


            //Payable amount will be pending amount added with current month due amount
            $response['payable'] = $response['due_amt'] + $response['pending'];

                
            if($loan_arr['loan_type'] == 'interest'){ // if loan type is interest then we need to calculate pending and payable again

                if($count == 1){
                    // if this condition true then, first month of the start date only has been ended
                    // so we need to calculate only the first month interest , not whole interest amount as payable

                    $response['payable'] = $response['pending'] ;


                    //pending amount will remain zero , coz usually we pay ended month's interest amount only in next month
                    //so when only one month is exceeded, that not the pending 
                    $response['pending'] =  0;

                }else{

                        $response['payable'] =  $response['pending'];

                    if($count >= 2){

                        $response['pending'] =  $response['pending'] - $response['due_amt'] ;
                    
                    }
                }
            }
            
            if($response['payable'] > $response['balance']){
                //if payable is greater than balance then change it as balance amt coz dont collect more than balance
                //this case will occur when collection status becoms OD
                $response['payable'] = $response['balance']; 
            }
            
            //in this calculate till date interest when month are crossed for current month
            $response['till_date_int'] = getTillDateInterest($loan_arr,$response,$con,'from01','') ;
            

        }else{
            //If still current month is not ended, then pending will be same due amt // pending will be 0 if due date not exceeded
            $response['pending'] = 0;// $response['due_amt'] - $response['total_paid'] - $response['pre_closure'] ;
            //If still current month is not ended, then penalty will be 0
            $response['penalty'] = 0;
            //If still current month is not ended, then payable will be due amt
            $response['payable'] = $response['due_amt'] - $response['total_paid'] - $response['pre_closure'] ;

            if($loan_arr['loan_type'] == 'interest'){
                $response['payable'] =  0;
            }

            //in this calculate till date interest when month are not crossed for due starting month
            $response['till_date_int'] = getTillDateInterest($loan_arr,$response,$con,'forstartmonth','') ;
        }

    }else
    if($loan_arr['due_method_scheme'] == '2'){
        
        //If Due method is Weekly, Calculate penalty by checking the month has ended or not
        $current_date = date('Y-m-d');
        
        $start_date_obj = DateTime::createFromFormat('Y-m-d', $due_start_from);
        $end_date_obj = DateTime::createFromFormat('Y-m-d', $maturity_month);
        $current_date_obj = DateTime::createFromFormat('Y-m-d', $current_date);

        $interval = new DateInterval('P1W'); // Create a one Week interval

        // $qry = $con->query("DELETE FROM penalty_charges where req_id = '$req_id' and (penalty_date != '' or penalty_date != NULL ) ");
            //condition start
            $count = 0;
            $loandate_tillnow = 0;
            $countForPenalty = 0;
            $penalty = 0;

            $dueCharge = ($due_amt) ? $due_amt : $int_amt_cal;
            $start = DateTime::createFromFormat('Y-m-d', $due_start_from);
            $current = DateTime::createFromFormat('Y-m-d', $current_date);

            for($i=$start; $i<$current;$start->add($interval) ){
                $loandate_tillnow += 1;
                $toPaytilldate = intval($loandate_tillnow) * intval($dueCharge);
            }

            while($start_date_obj < $end_date_obj && $start_date_obj < $current_date_obj){ // To find loan date count till now from start date.
                
                $penalty_checking_date  = $start_date_obj->format('Y-m-d'); // This format is for query.. month , year function accept only if (Y-m-d).
                $start_date_obj->add($interval);
                            
                $checkcollection =$con->query("SELECT * FROM `collection` WHERE `req_id` = '$req_id' && ((WEEK(coll_date)= WEEK('$penalty_checking_date') || WEEK(trans_date)= WEEK('$penalty_checking_date')) && (YEAR(coll_date)= YEAR('$penalty_checking_date') || YEAR(trans_date)= YEAR('$penalty_checking_date')))");
                $collectioncount = mysqli_num_rows($checkcollection); // Checking whether the collection are inserted on date or not by using penalty_raised_date.

                if($loan_arr['scheme_name'] == '' || $loan_arr['scheme_name'] == null ){
                    $result=$con->query("SELECT overdue FROM `loan_calculation` WHERE loan_category = '".$loan_arr['loan_category']."' and sub_category = '".$loan_arr['sub_category']."' ");
                }else{
                    $result=$con->query("SELECT overdue FROM `loan_scheme` WHERE loan_category = '".$loan_arr['loan_category']."' and sub_category = '".$loan_arr['sub_category']."' ");
                }
                $row = $result->fetch_assoc();
                $penalty_per = $row['overdue'] ; //get penalty percentage to insert
                $count++; //Count represents how many months are exceeded
                
                if($totalPaidAmt < $toPaytilldate && $collectioncount == 0 ){
                    $checkPenalty = $con->query("SELECT * from penalty_charges where penalty_date = '$penalty_checking_date' and req_id = '$req_id' ");
                    if($checkPenalty->num_rows == 0){
                        $penalty = round( ( ($response['due_amt'] * $penalty_per) / 100) + $penalty );
                        $qry = $con->query("INSERT into penalty_charges (`req_id`,`penalty_date`, `penalty`, `created_date`) values ('$req_id','$penalty_checking_date','$penalty',current_timestamp)");
                    }
                    $countForPenalty++;
                } 
            }
           //condition END

        if($count>0){
            
            //if Due month exceeded due amount will be as pending with how many months are exceeded and subract pre closure amount if available
            $response['pending'] = ($response['due_amt'] * $count) - $response['total_paid'] - $response['pre_closure'] ; 

            // If due month exceeded
            if($loan_arr['scheme_name'] == '' || $loan_arr['scheme_name'] == null ){
                $result=$con->query("SELECT overdue FROM `loan_calculation` WHERE loan_category = '".$loan_arr['loan_category']."' and sub_category = '".$loan_arr['sub_category']."' ");
            }else{
                $result=$con->query("SELECT overdue FROM `loan_scheme` WHERE loan_category = '".$loan_arr['loan_category']."' and sub_category = '".$loan_arr['sub_category']."' ");
            }
            $row = $result->fetch_assoc();
            $penalty_per = number_format($row['overdue'] * $countForPenalty); //Count represents how many months are exceeded//Number format if percentage exeeded decimals then pernalty may increase

            // to get overall penalty paid till now to show pending penalty amount
            $result=$con->query("SELECT SUM(penalty_track) as penalty,SUM(penalty_waiver) as penalty_waiver FROM `collection` WHERE req_id = '".$req_id."' ");
            $row = $result->fetch_assoc();
            if($row['penalty'] == null){
                $row['penalty'] = 0;
            }
            if($row['penalty_waiver'] == null){
                $row['penalty_waiver'] = 0;
            }
            //to get overall penalty raised till now for this req id
            $result1=$con->query("SELECT SUM(penalty) as penalty FROM `penalty_charges` WHERE req_id = '".$req_id."' ");
            $row1 = $result1->fetch_assoc();
            if($row1['penalty'] == null){
                $penalty = 0;
            }else{
                $penalty = $row1['penalty'];
            }

            // $penalty = intval((($response['due_amt'] * $penalty_per) / 100));

            $response['penalty'] = $penalty - $row['penalty'] - $row['penalty_waiver'];

            //Payable amount will be pending amount added with current month due amount
            $response['payable'] = $response['due_amt'] + $response['pending'];
            if($response['payable'] > $response['balance']){
                //if payable is greater than balance then change it as balance amt coz dont collect more than balance
                //this case will occur when collection status becoms OD
                $response['payable'] = $response['balance']; 
            }

        }else{
            //If still current month is not ended, then pending will be same due amt // pending will be 0 if due date not exceeded
            $response['pending'] =0; // $response['due_amt'] - $response['total_paid'] - $response['pre_closure'] ;
            //If still current month is not ended, then penalty will be 0
            $response['penalty'] = 0;
            //If still current month is not ended, then payable will be due amt
            $response['payable'] = $response['due_amt'] - $response['total_paid'] - $response['pre_closure'] ;
        }

    }elseif($loan_arr['due_method_scheme'] == '3'){
        //If Due method is Daily, Calculate penalty by checking the month has ended or not
        $current_date = date('Y-m-d');
        
        $start_date_obj = DateTime::createFromFormat('Y-m-d', $due_start_from);
        $end_date_obj = DateTime::createFromFormat('Y-m-d', $maturity_month);
        $current_date_obj = DateTime::createFromFormat('Y-m-d', $current_date);
        
        $interval = new DateInterval('P1D'); // Create a one Week interval

        // $qry = $con->query("DELETE FROM penalty_charges where req_id = '$req_id' and (penalty_date != '' or penalty_date != NULL ) ");

            //condition start
            $count = 0;
            $loandate_tillnow = 0;
            $countForPenalty = 0;
            $penalty = 0;

            $dueCharge = ($due_amt) ? $due_amt : $int_amt_cal;
            $start = DateTime::createFromFormat('Y-m-d', $due_start_from);
            $current = DateTime::createFromFormat('Y-m-d', $current_date);

            for($i=$start; $i<$current;$start->add($interval) ){
                $loandate_tillnow += 1;
                $toPaytilldate = intval($loandate_tillnow) * intval($dueCharge);
            }

                while($start_date_obj < $end_date_obj && $start_date_obj < $current_date_obj){ // To find loan date count till now from start date.
                $penalty_checking_date  = $start_date_obj->format('Y-m-d'); // This format is for query.. month , year function accept only if (Y-m-d).
                $start_date_obj->add($interval);

                    $checkcollection =$con->query("SELECT * FROM `collection` WHERE `req_id` = '$req_id' && ((DAY(coll_date)= DAY('$penalty_checking_date') || DAY(trans_date)= DAY('$penalty_checking_date')) && (YEAR(coll_date)= YEAR('$penalty_checking_date') || YEAR(trans_date)= YEAR('$penalty_checking_date')))");
                    $collectioncount = mysqli_num_rows($checkcollection); // Checking whether the collection are inserted on date or not by using penalty_raised_date.

                if($loan_arr['scheme_name'] == '' || $loan_arr['scheme_name'] == null ){
                    $result=$con->query("SELECT overdue FROM `loan_calculation` WHERE loan_category = '".$loan_arr['loan_category']."' and sub_category = '".$loan_arr['sub_category']."' ");
                }else{
                    $result=$con->query("SELECT overdue FROM `loan_scheme` WHERE loan_category = '".$loan_arr['loan_category']."' and sub_category = '".$loan_arr['sub_category']."' ");
                }
                $row = $result->fetch_assoc();
                $penalty_per = $row['overdue'] ; //get penalty percentage to insert
                $count++; //Count represents how many months are exceeded
                
                if($totalPaidAmt < $toPaytilldate && $collectioncount == 0 ){ 
                    $checkPenalty = $con->query("SELECT * from penalty_charges where penalty_date = '$penalty_checking_date' and req_id = '$req_id' ");
                    if($checkPenalty->num_rows == 0){
                        $penalty = round( ( ($response['due_amt'] * $penalty_per) / 100) + $penalty );
                        $qry = $con->query("INSERT into penalty_charges (`req_id`,`penalty_date`, `penalty`, `created_date`) values ('$req_id','$penalty_checking_date','$penalty',current_timestamp)");
                    }
                    $countForPenalty++;
                } 
            }
            //condition END

        if($count>0){
            //if Due month exceeded due amount will be as pending with how many months are exceeded and subract pre closure amount if available
            $response['pending'] = ($response['due_amt'] * $count) - $response['total_paid'] - $response['pre_closure'] ; 

            // If due month exceeded
            if($loan_arr['scheme_name'] == '' || $loan_arr['scheme_name'] == null ){
                $result=$con->query("SELECT overdue FROM `loan_calculation` WHERE loan_category = '".$loan_arr['loan_category']."' and sub_category = '".$loan_arr['sub_category']."' ");
            }else{
                $result=$con->query("SELECT overdue FROM `loan_scheme` WHERE loan_category = '".$loan_arr['loan_category']."' and sub_category = '".$loan_arr['sub_category']."' ");
            }
            $row = $result->fetch_assoc();
            $penalty_per = number_format($row['overdue'] * $countForPenalty); //Count represents how many months are exceeded//Number format if percentage exeeded decimals then pernalty may increase
            
            // to get overall penalty paid till now to show pending penalty amount
            $result=$con->query("SELECT SUM(penalty_track) as penalty,SUM(penalty_waiver) as penalty_waiver FROM `collection` WHERE req_id = '".$req_id."' ");
            $row = $result->fetch_assoc();
            if($row['penalty'] == null){
                $row['penalty'] = 0;
            }
            if($row['penalty_waiver'] == null){
                $row['penalty_waiver'] = 0;
            }
            //to get overall penalty raised till now for this req id
            $result1=$con->query("SELECT SUM(penalty) as penalty FROM `penalty_charges` WHERE req_id = '".$req_id."' ");
            $row1 = $result1->fetch_assoc();
            if($row1['penalty'] == null){
                $penalty = 0;
            }else{
                $penalty = $row1['penalty'];
            }

            // $penalty = intval((($response['due_amt'] * $penalty_per) / 100));
            
            $response['penalty'] = $penalty - $row['penalty'] - $row['penalty_waiver'];

            //Payable amount will be pending amount added with current month due amount
            $response['payable'] = $response['due_amt'] + $response['pending'];
            if($response['payable'] > $response['balance']){
                //if payable is greater than balance then change it as balance amt coz dont collect more than balance
                //this case will occur when collection status becoms OD
                $response['payable'] = $response['balance']; 
            }

        }else{
            //If still current month is not ended, then pending will be same due amt// pending will be 0 if due date not exceeded
            $response['pending'] = 0;//$response['due_amt'] - $response['total_paid'] - $response['pre_closure'] ;
            //If still current month is not ended, then penalty will be 0
            $response['penalty'] = 0;
            //If still current month is not ended, then payable will be due amt
            $response['payable'] = $response['due_amt'] - $response['total_paid'] - $response['pre_closure'];
        }
    }

    if($response['pending'] < 0){
        $response['pending'] = 0; 
    }
    if($response['payable'] < 0){
        $response['payable'] = 0; 
    }
    return $response;
}

function calculateInterestLoan($con, $loan_arr,$response){

    if(isset($_POST['req_id'])){
        $req_id = $_POST['req_id'];
    }
    // $req_id = '11';//***************************************************************************************************************************************************
    $due_start_from = $loan_arr['due_start_from'];
    $maturity_month = $loan_arr['maturity_month'];



    $checkcollection = $con->query("SELECT SUM(`due_amt_track`) as totalPaidAmt FROM `collection` WHERE `req_id` = '$req_id'"); // To Find total paid amount till Now.
    $checkrow = $checkcollection->fetch_assoc();
    $totalPaidAmt = $checkrow['totalPaidAmt'] ??0;//null collation operator
    $checkack = $con->query("SELECT int_amt_cal,due_amt_cal FROM `acknowlegement_loan_calculation` WHERE `req_id` = '$req_id'"); // To Find Due Amount.
    $checkAckrow = $checkack->fetch_assoc();
    $int_amt_cal = $checkAckrow['int_amt_cal'];
    $due_amt = $checkAckrow['due_amt_cal'];

    //Convert Date to Year and month, because with date, it will use exact date to loop months, instead of taking end of month
    $due_start_from = date('Y-m',strtotime($due_start_from));
    $maturity_month = date('Y-m',strtotime($maturity_month));

    // Create a DateTime object from the given date
    $maturity_month = new DateTime($maturity_month);
    // Subtract one month from the date
    $maturity_month->modify('-1 month');
    // Format the date as a string
    $maturity_month = $maturity_month->format('Y-m');

    //If Due method is Monthly, Calculate penalty by checking the month has ended or not
    $current_date = date('Y-m');
    
    $start_date_obj = DateTime::createFromFormat('Y-m', $due_start_from);
    $end_date_obj = DateTime::createFromFormat('Y-m', $maturity_month);
    $current_date_obj = DateTime::createFromFormat('Y-m', $current_date);

    $interval = new DateInterval('P1M'); // Create a one month interval

    // $qry = $con->query("DELETE FROM penalty_charges where req_id = '$req_id' and (penalty_date != '' or penalty_date != NULL ) ");
        //condition start
        $count = 0;
        $loandate_tillnow = 0;
        $countForPenalty = 0;
        $penalty = 0;
        $dueCharge = ($due_amt) ? $due_amt : $int_amt_cal;
        $start = DateTime::createFromFormat('Y-m', $due_start_from);
        $current = DateTime::createFromFormat('Y-m', $current_date);

    

        for($i=$start; $i<$current;$start->add($interval) ){
            $loandate_tillnow += 1;
            $toPaytilldate = intval($loandate_tillnow) * intval($dueCharge);
        }
        

    while($start_date_obj<$end_date_obj && $start_date_obj <= $current_date_obj){

        $penalty_checking_date  = $start_date_obj->format('Y-m-d'); // This format is for query.. month , year function accept only if (Y-m-d).
        $penalty_date  = $start_date_obj->format('Y-m');
        
        
        $checkcollection =$con->query("SELECT * FROM `collection` WHERE `req_id` = '$req_id' && ((MONTH(coll_date)= MONTH('$penalty_checking_date') || MONTH(trans_date)= MONTH('$penalty_checking_date')) && (YEAR(coll_date)= YEAR('$penalty_checking_date') || YEAR(trans_date)= YEAR('$penalty_checking_date')))");
        $collectioncount = mysqli_num_rows($checkcollection); // Checking whether the collection are inserted on date or not by using penalty_raised_date.

        if($loan_arr['scheme_name'] == '' || $loan_arr['scheme_name'] == null ){
            $result=$con->query("SELECT overdue FROM `loan_calculation` WHERE loan_category = '".$loan_arr['loan_category']."' and sub_category = '".$loan_arr['sub_category']."' ");
        }else{
            $result=$con->query("SELECT overdue FROM `loan_scheme` WHERE loan_category = '".$loan_arr['loan_category']."' and sub_category = '".$loan_arr['sub_category']."' ");
        }
        $row = $result->fetch_assoc();
        $penalty_per = $row['overdue'] ; //get penalty percentage to insert


        if($totalPaidAmt < $toPaytilldate && $collectioncount == 0 ){ 
            $checkPenalty = $con->query("SELECT * from penalty_charges where penalty_date = '$penalty_date' and req_id = '$req_id' ");
            if($checkPenalty->num_rows == 0){
                $penalty = round( ( ($response['due_amt'] * $penalty_per) / 100) + $penalty );
                
                if($count != 0){
                    // if loan type is interest then apply penalty if the loop month is not first
                    // so penalty should not raise, coz a month interest is paid after the month end
                    $qry = $con->query("INSERT into penalty_charges (`req_id`,`penalty_date`, `penalty`, `created_date`) values ('$req_id','$penalty_date','$penalty',current_timestamp)");
                }
            }
            $countForPenalty++;
        } 
        
        $start_date_obj->add($interval); //increase one month to loop again
        $count++; //Count represents how many months are exceeded
    }

    if($count >0){
        $response['payable'] = payableCalculation($con,$loan_arr,$response);
        $response['till_date_int'] = getTillDateInterest($loan_arr,$response,$con,'curmonth','');
    }
}
function calculateNewInterestAmt($int_rate,$balance){
    //to calculate current interest amount based on current balance value//bcoz interest will be calculated based on current balance amt only for interest loan
    $int = $balance * ($int_rate/100);
    $curInterest = ceil($int / 5) * 5; //to increase Interest to nearest multiple of 5
    if ($curInterest < $int) {
        $curInterest += 5;
    }
    $response = $curInterest;

    return $response;
}
function payableCalculation($con,$loan_arr,$response){
    if(isset($_POST['req_id'])){
        $req_id = $_POST['req_id'];
    }
    $issued_date = new DateTime(date('Y-m-d',strtotime($loan_arr['loan_date'])));
    $cur_date = new DateTime(date('Y-m-d'));
    $last_month = clone $cur_date;
    $last_month->modify('-1 month');

    $result=0;
    $st_date = clone $issued_date;
    while($st_date->format('m') <= $last_month->format('m')){
        $end_date = clone $st_date;
        $end_date->modify('last day of this month');
        $dueperday = $response['due_amt'] / intval($end_date->format('t'));
        $result += (($st_date->diff($end_date))->days+1) * $dueperday;
        $st_date->modify('+1 month');
        $st_date->modify('first day of this month');
    }

    $qry = $con->query("SELECT SUM(int_amt_track) as tot_int_paid FROM collection where req_id=$req_id");
    $tot_int_paid = $qry->fetch_assoc()['tot_int_paid'];

    $result = $result - $tot_int_paid;

    return $result;
}
function getTillDateInterest($loan_arr,$response,$con,$data,$count){

    if($data == 'forstartmonth'){
        //if condition is true then this is , 2 months has been completed.
        //so the pending amt will be only the first month's complete interest amount


        //to calculate till date interest if loan is interst based
        if($loan_arr['loan_type'] == 'interest'){

            //get the loan isued month's date count
            $issued_date = new DateTime(date('Y-m-d',strtotime($loan_arr['loan_date'])));

            //current month's total date
            $cur_date = new DateTime(date('Y-m-d'));

            //due amount calculation per day
            $issue_month_due = $response['due_amt'] / intval($issued_date->format('t'));
            $cur_month_due = $response['due_amt'] / intval($cur_date->format('t'));


            if($issued_date->format('Y-m-t') < $cur_date->format('Y-m-d')){
                // Clone the loan start date and modify it to the last day of the month
                $loan_monthend_date = clone $issued_date;
                $loan_monthend_date->modify('last day of this month');

                // Clone today's date and modify it to the first day of the month
                $cur_monthst_date = clone $cur_date;
                $cur_monthst_date->modify('first day of this month');

                $result = (($issued_date->diff($loan_monthend_date))->days+1) * $issue_month_due;
                $result += (($cur_monthst_date->diff($cur_date))->days) * $cur_month_due;
            }else{
                // Clone the loan start date and modify it to the last day of the month
                $loan_monthend_date = clone $issued_date;
                $loan_monthend_date->modify('last day of this month');
                $result = (($issued_date->diff($cur_date))->days) * $issue_month_due;
            }
        

            //to increase till date Interest to nearest multiple of 5
            $cur_amt = ceil($result / 5) * 5; //ceil will set the number to nearest upper integer//i.e ceil(121/5)*5 = 125
            if ($cur_amt < $result) {
                $cur_amt += 5;
            }
            $result = $cur_amt;
        }
        return $result;

    }
    if($data == 'curmonth'){
        $cur_date = new DateTime(date('Y-m-d'));
        $cur_month_st = new DateTime(date('Y-m-01'));
        //due amount calculation per day
        $cur_month_due = $response['due_amt'] / intval($cur_date->format('t'));
        $result = (($cur_month_st->diff($cur_date))->days) * $cur_month_due;
        return $result;
    }
    // if($data == 'firstpayable'){
    //     $issued_date = new DateTime(date('Y-m-d',strtotime($loan_arr['loan_date'])));
    //     $cur_date = new DateTime(date('Y-m-d'));
    //     $last_month = clone $cur_date;
    //     $last_month->modify('-1 month');

    //     $result=0;
    //     $st_date = clone $issued_date;
    //     while($st_date->format('m') <= $last_month->format('m')){
    //         $end_date = clone $st_date;
    //         $end_date->modify('last day of this month');
    //         $dueperday = $response['due_amt'] / intval($end_date->format('t'));
    //         $result += (($st_date->diff($end_date))->days+1) * $dueperday;
    //         $st_date->modify('+1 month');
    //         $st_date->modify('first day of this month');
    //     }

    //     return $result;
    // }
    // if($data == 'from01'){
    //     //in this calculate till date interest when month are crossed for current month

    //     //to calculate till date interest if loan is interst based
    //     if($loan_arr['loan_type'] == 'interest'){
            
    //         // Get the current month's count of days
    //         $currentMonthCount = date('t');
    //         // divide current interest amt for one day of current month
    //         $amtperDay = $response['due_amt'] / intVal($currentMonthCount); 
            
    //         $st_date = new DateTime(date('Y-m-01')); // start date
    //         $tdate = new DateTime(date('Y-m-d').'+1 day');//current date
    //         // $tdate = $tdate->modify('+1 day');//current date +1
    //         // Calculate the interval between the two dates
    //         $date_diff = $st_date->diff($tdate);
    //         // Get the number of days from the interval
    //         $numberOfDays = $date_diff->days;
    //         $response = $amtperDay * $numberOfDays;
            
    //         //to increase till date Interest to nearest multiple of 5
    //         $cur_amt = ceil($response / 5) * 5; //ceil will set the number to nearest upper integer//i.e ceil(121/5)*5 = 125
    //         if ($cur_amt < $response) {
    //             $cur_amt += 5;
    //         }
    //         $response = $cur_amt;
    //     }


    // }else
     if($data == 'fullstartmonth'){
        //in this calculate till date interest when month are not crossed for due starting month

        //to calculate till date interest if loan is interst based
        if($loan_arr['loan_type'] == 'interest'){
            // Get the current month's count of days
            $currentMonthCount = date('t',strtotime($loan_arr['due_start_from']));
            // divide current interest amt for one day of current month
            $amtperDay = $response['due_amt_for1'] / intVal($currentMonthCount); 
            
            $st_date = new DateTime(date('Y-m-d',strtotime($loan_arr['due_start_from']))); // start date
            $tdate = new DateTime(date('Y-m-t',strtotime($loan_arr['due_start_from']))) ;//will take last date of mentioned date's month
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

    }else if($data == 'foreachmonth'){
        if(isset($_POST['req_id'])){
            $req_id = $_POST['req_id'];
        }

        $start_date = $response->format('Y-m-d');$end_date = $response->format('Y-m-t');
        if($count == 0){//if count is zero then take first collection entry to calc first month's due amt
            $sql = $con->query("SELECT bal_amt, princ_amt_track from collection where req_id = $req_id  ORDER BY coll_date ASC ");
            if($sql->num_rows){
                $row = $sql->fetch_assoc();
                $bal_amt = $row['bal_amt'];//this is the balance amt for first month
                
                //calculate interest for that month based on balance amt
                $interest = $bal_amt * ($loan_arr['int_rate']/100);

                // Get the current month's count of days
                $currentMonthCount = date('t',strtotime($start_date));
                $amtperDay = $interest / intVal($currentMonthCount); 
                
                $start_date = new DateTime($start_date); // start date
                $end_date = new DateTime($end_date) ;//last date of month
                $date_diff = $start_date->diff($end_date);
                $numberOfDays = $date_diff->days;
                $response = ceil($amtperDay * $numberOfDays);
            }
        }elseif($count > 0){
            //if count is one then take first collection entry to calc second month's due amt from start date to collection date first
            //then from that collection date to next collection date will be that particular date's due amt
            // else if only one entry or empty in the current month then take bal amt from next collection when available to calculate curr month's due
            //if various collection entry available then take as before said then sum all to get cur month's overall interest to show next month

            $sql = $con->query("SELECT bal_amt, princ_amt_track,date(coll_date) from collection where req_id = $req_id and (month(coll_date) = month('$start_date') and year(coll_date) = year('$start_date')) ORDER BY coll_date ASC ");
            if($sql->num_rows){
                $i=0;$response = 0;
                while($row = $sql->fetch_assoc()){
                    $bal_amt = $row['bal_amt'];//this is the balance amt for first month
                    $coll_date = $row['date(coll_date)'];

                    //calculate interest for that month based on balance amt
                    $interest = $bal_amt * ($loan_arr['int_rate']/100);

                    // Get the current month's count of days
                    $currentMonthCount = date('t',strtotime($start_date));
                    $amtperDay = $interest / intVal($currentMonthCount); 
                    
                    if($i==0){
                        // set start date as first date of month, coz first time should calculate for month's start point to coll date
                        $start_date = new DateTime(date('Y-m-01',strtotime($start_date))); 
                    }else{
                        // change start date as collection date , coz we dont need to calculate due from start of month
                        $start_date = new DateTime(date('Y-m-d',strtotime($start_date))); 
                    }

                    $end_date = new DateTime($coll_date) ;//setting collection date as end date to calculate interst from day 1 to collection date
                    $date_diff = $start_date->diff($end_date);
                    $numberOfDays = $date_diff->days;
                    $response = $response + ceil($amtperDay * $numberOfDays);

                    $start_date = $coll_date;//changing start date as coll date, coz next period until next collection due will be changed 

                    $i++;
                }
                //when loop completed then calculate rest of the month's due amt by taking next collection entry's bal amt. validate that with last collection date above
                $sql = $con->query("SELECT bal_amt, princ_amt_track,date(coll_date) from collection where req_id = $req_id and month(coll_date) > month('$start_date')  ORDER BY coll_date ASC ");
                if($sql->num_rows){
                    $row = $sql->fetch_assoc();
                    $bal_amt = $row['bal_amt'];
                    $coll_date = $row['date(coll_date)'];
                    
                    //calculate interest for that month based on balance amt
                    $interest = $bal_amt * ($loan_arr['int_rate']/100);
                    // Get the current month's count of days
                    $currentMonthCount = date('t',strtotime($start_date));
                    $amtperDay = $interest / intVal($currentMonthCount); 
                    // change start date as collection date , coz we dont need to calculate due from start of month
                    $end_date = new DateTime(date('Y-m-t',strtotime($start_date))) ;//setting end date as start month's end date
                    $start_date = new DateTime(date('Y-m-d',strtotime($start_date))); // taking last collection date from above loop
                    $date_diff = $start_date->diff($end_date);
                    $numberOfDays = $date_diff->days;
                    // echo ceil($amtperDay * $numberOfDays);die;
                    $response = $response + ceil($amtperDay * $numberOfDays);
                }
            }
        
        }

    }
    return $response;
}

echo json_encode($response);
?>
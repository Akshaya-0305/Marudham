<?php
@session_start();
include '../ajaxconfig.php';

if(isset($_POST["coll_id"])){
	$coll_id=$_POST["coll_id"];
}
// $coll_id='COL-106';

// $qry=$con->query("SELECT * FROM `collection` WHERE coll_code='".strip_tags($coll_id)."' ");
// $row=$qry->fetch_assoc();
// foreach($row as $key => $val){
// 	$$key = $val; 
// }

// $sql = $con->query("SELECT 
// 		alm.line_name
// 		FROM `acknowlegement_customer_profile` cp
// 		JOIN area_line_mapping alm ON FIND_IN_SET(cp.area_confirm_subarea,alm.sub_area_id)
// 		WHERE cp.req_id='".strip_tags($req_id)."' ");
// $rowSql=$sql->fetch_assoc();
// $line_name = $rowSql['line_name'];

// $sql = $con->query("SELECT 
// 		alc.due_type,lcc.loan_category_creation_name, ii.loan_id
// 		FROM `acknowlegement_loan_calculation` alc
// 		LEFT JOIN loan_category_creation lcc ON alc.loan_category = lcc.loan_category_creation_id
// 		left JOIN in_issue ii ON alc.req_id = ii.req_id
// 		WHERE alc.req_id='".strip_tags($req_id)."' ");
// $rowSql=$sql->fetch_assoc();
// $loan_category = $rowSql['loan_category_creation_name'];
// $loan_id = $rowSql['loan_id'];

// if($rowSql['due_type'] == 'Interest' ){
// 	$loan_type='interest';
// }else{
// 	$loan_type='emi';
// }

$qry = $con->query("SELECT * FROM `collection` WHERE coll_code='" . strip_tags($coll_id) . "'");
$row = $qry->fetch_assoc();

extract($row); // Extracts the array values into variables

$sql = $con->query("SELECT alm.line_name FROM `acknowlegement_customer_profile` cp JOIN area_line_mapping alm ON FIND_IN_SET(cp.area_confirm_subarea,alm.sub_area_id) WHERE cp.req_id='" . strip_tags($req_id) . "'");
$rowSql = $sql->fetch_assoc();
$line_name = $rowSql['line_name'];

$sql = $con->query("SELECT alc.due_type, lcc.loan_category_creation_name, ii.loan_id FROM `acknowlegement_loan_calculation` alc LEFT JOIN loan_category_creation lcc ON alc.loan_category = lcc.loan_category_creation_id LEFT JOIN in_issue ii ON alc.req_id = ii.req_id WHERE alc.req_id='" . strip_tags($req_id) . "'");
$rowSql = $sql->fetch_assoc();
$loan_category = $rowSql['loan_category_creation_name'];
$loan_id = $rowSql['loan_id'];


$due_amt_track = intVal($due_amt_track!=''?$due_amt_track:0);
$penalty_track = intVal($penalty_track!=''?$penalty_track:0);
$coll_charge_track = intVal($coll_charge_track!=''?$coll_charge_track:0);
$net_received = $due_amt_track + $penalty_track + $coll_charge_track;
$due_balance = ($due_amt - $due_amt_track) < 0 ? 0: $due_amt - $due_amt_track;
$loan_balance = getBalance($con,$req_id,$coll_date);


?>


<div class="frame" id="dettable" style="position: relative; width: 302px; height: 500px; background-color: #ffffff;">
    <div class="overlap-group">
        <div class="captions" style="position: absolute; width: 112px; height: 278px; top: 150px; left: 45px;font-size: 12px">
			<!-- <div class="text-wrapper" style="position: absolute; top: 0; left: 30px; font-family: 'Times New Roman-Regular', Helvetica; font-weight: 400; color: #000000; font-size: 12px; text-align: center; letter-spacing: 0; line-height: normal; white-space: nowrap;">Receipt No:</div> -->
			<!-- Other text-wrapper elements -->
			<b><div class="text-wrapper" style="text-align:right;" >Receipt No :</div></b>
			<div class="div"style="text-align:right;" >Date / Time :</div>
			<div class="text-wrapper-2"style="text-align:right;" >Line / Area :</div>
			<div class="text-wrapper-3"style="text-align:right;" >Customer ID :</div>
			<b><div class="text-wrapper-4"style="text-align:right;" >Customer Name :</div></b>
			<div class="text-wrapper-6"style="text-align:right;" >Loan Category :</div>
			<div class="text-wrapper-6"style="text-align:right;" >Loan No :</div>
			<div class="text-wrapper-7"style="text-align:right;" >Due Receipt :</div>
			<div class="text-wrapper-8"style="text-align:right;" >Penalty :</div>
			<div class="text-wrapper-9"style="text-align:right;" >Fine :</div><br>
			<b><div class="text-wrapper-10"style="text-align:right;" >Net Received :</div></b><br>
			<div class="text-wrapper-11"style="text-align:right;" >Due Balance :</div>
			<div class="text-wrapper-12"style="text-align:right;" >Loan Balance :</div>
		</div>
		<div class="data" style="position: absolute; width: 128px; height: 278px; top: 150px; left: 158px;font-size: 12px">
			<!-- <div class="text-wrapper-12" style="position: absolute; top: 0; left: 0; font-family: 'Times New Roman-Regular', Helvetica; font-weight: 400; color: #000000; font-size: 12px; text-align: center; letter-spacing: 0; line-height: normal; white-space: nowrap;">COL-101</div> -->
			<!-- Other text-wrapper elements -->
			<b><div class="text-wrapper-13" style="margin-left: 5px;"><?php echo $coll_code; ?></div></b>
			<div class="text-wrapper-14" style="margin-left: 5px;"><?php echo date('d-m-Y H:s A',strtotime($coll_date)); ?></div>
			<div class="text-wrapper-15" style="margin-left: 5px;"><?php echo $line_name; ?></div>
			<div class="text-wrapper-16" style="margin-left: 5px;"><?php echo $cus_id; ?></div>
			<b><div class="text-wrapper-17" style="margin-left: 5px;"><?php echo $cus_name;?></div></b>
			<div class="text-wrapper-18" style="margin-left: 5px;"><?php echo $loan_category; ?></div>
			<div class="text-wrapper-19" style="margin-left: 5px;"><?php echo $loan_id; ?></div>
			<div class="text-wrapper-20" style="margin-left: 5px;"><?php echo moneyFormatIndia($due_amt_track); ?></div>
			<div class="text-wrapper-21" style="margin-left: 5px;"><?php echo moneyFormatIndia($penalty_track); ?></div>
			<div class="text-wrapper-22" style="margin-left: 5px;"><?php echo moneyFormatIndia($coll_charge_track); ?></div><br>
			<b><div class="text-wrapper-23" style="margin-left: 5px;"><?php echo moneyFormatIndia($net_received) ; ?></div></b><br>
			<div class="text-wrapper-24" style="margin-left: 5px;"><?php echo moneyFormatIndia($due_balance); ?></div>
			<div class="text-wrapper-25" style="margin-left: 5px;"><?php echo moneyFormatIndia($loan_balance);?></div>
		</div>
	</div>
    <img class="group" alt="Marudham Capitals" src="img/group-9.png" style="position: absolute; width: 224px; height: 91px; top: 34px; left: 44px;" />
</div>



<button type="button" name="printpurchase" onclick="poprint()" id="printpurchase" class="btn btn-primary">Print</button>

<script type="text/javascript">

function poprint(){
	var Bill = document.getElementById("dettable").innerHTML;
	var printWindow = window.open('', '','height=1000;weight=1000;');
	printWindow.document.write('<html><head></head><body>');
	printWindow.document.write(Bill);
	printWindow.document.write('</body></html>');
	printWindow.document.close();
	printWindow.print();
	printWindow.close();
 }
 setTimeout(() => {
	 document.getElementById("printpurchase").click();
	
 }, 1500);
 
</script>

<?php
function moneyFormatIndia($num){
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

function getBalance($con, $req_id,$coll_date){
    $result=$con->query("SELECT * FROM `acknowlegement_loan_calculation` WHERE req_id = $req_id ");
    if($result->num_rows>0){
        $row = $result->fetch_assoc();
        $loan_arr = $row;

        if($loan_arr['tot_amt_cal'] == '' || $loan_arr['tot_amt_cal'] == null){
            //(For monthly interest total amount will not be there, so take principals)
            $response['total_amt'] = intVal($loan_arr['principal_amt_cal']);
            $response['loan_type'] = 'interest';
            $loan_arr['loan_type'] = 'interest';
        }else{
            $response['total_amt'] = intVal($loan_arr['tot_amt_cal']);
            $response['loan_type'] = 'emi';
            $loan_arr['loan_type'] = 'emi';
        }
        
    }
    $coll_arr= array();
    $result=$con->query("SELECT * FROM `collection` WHERE req_id ='".$req_id."' and date(coll_date) <= date('".$coll_date."') ");
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
            $total_paid_princ += intVal($tot['princ_amt_track']); 
            $total_paid_int += intVal($tot['int_amt_track']); 
            $pre_closure += intVal($tot['pre_close_waiver']); //get pre closure value to subract to get balance amount
        }
        //total paid amount will be all records again request id should be summed
        $response['total_paid'] = ($loan_arr['loan_type'] == 'emi') ? $total_paid : $total_paid_princ; 
        $response['total_paid_int'] = $total_paid_int;  
        

        $response['balance'] = $response['total_amt'] - $response['total_paid'] - $pre_closure;

    }else{
        $response['balance'] = $response['total_amt'];
    }
    

    return $response['balance'];
    
}
?>
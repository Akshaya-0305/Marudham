
<?php
@session_start();
include('../../ajaxconfig.php');

if(isset($_SESSION["userid"])){
    $userid = $_SESSION["userid"];
}

if($userid != 1){
    
    $userQry = $con->query("SELECT * FROM USER WHERE user_id = $userid ");
    while($rowuser = $userQry->fetch_assoc()){
        $group_id = $rowuser['group_id'];
        $line_id = $rowuser['line_id'];
    }

    $line_id = explode(',',$line_id);
    $sub_area_list = array();
    foreach($line_id as $line){
        $lineQry = $con->query("SELECT * FROM area_line_mapping where map_id = $line ");
        $row_sub = $lineQry->fetch_assoc();
        $sub_area_list[] = $row_sub['sub_area_id'];
    }
    $sub_area_ids = array();
    foreach ($sub_area_list as $subarray) {
        $sub_area_ids = array_merge($sub_area_ids, explode(',',$subarray));
    }
    $sub_area_list = array();
    $sub_area_list = implode(',',$sub_area_ids);
}


if(isset($_POST['cus_id'])){
    $cus_id_arr = json_decode($_POST['cus_id'],true);
}
if(isset($_POST['req_of_cus'])){
    $req_of_cus = json_decode($_POST['req_of_cus'],true);
}
if( isset($_POST['follow_cus_sts'])){
    $follow_cus_sts = json_decode($_POST['follow_cus_sts'],true);
}
if( isset($_POST['payable'])){
    $payable = json_decode($_POST['payable'],true);
    $negativeIndexes = [];

    if (is_array($payable)) {
        foreach ($payable as $index => $value) {
            if ($value <= 0) {
                $negativeIndexes[] = $index;
            }
        }
    }

    // $negativeIndexes now contains the indexes of elements with values 0 or less than 0
    // print_r($negativeIndexes);

   // Remove the values at the negative indexes in the req_of_cus
    foreach ($negativeIndexes as $index) {
        if (isset($req_of_cus[$index])) {
            unset($req_of_cus[$index]);
        }
    }

    // Re-index the array to reorder the keys after unset
    $req_of_cus = array_values($req_of_cus);

    // print_r($req_of_cus);
}



$query = "SELECT cp.cus_id as cp_cus_id,cp.cus_name,cp.area_confirm_area,cp.area_confirm_subarea,cp.area_line,cp.mobile1, ii.cus_id as ii_cus_id, ii.req_id FROM 
acknowlegement_customer_profile cp JOIN in_issue ii ON cp.cus_id = ii.cus_id
where ii.status = 0 and (ii.cus_status >= 14 and ii.cus_status <= 17) and cp.area_confirm_subarea IN ($sub_area_list) and cp.req_id IN (".implode(',',$req_of_cus).") GROUP BY ii.cus_id ";// 14 and 17 means collection entries, 17 removed from issue list
//this will only take selected req_ids which is payable > 0

$statement = $connect->prepare($query);
$statement->execute();
$result = $statement->fetchAll();
?>
<table id='due_followup_table' class="table custom-table">
    <thead>
        <tr>
            <th width="50">S.No.</th>
            <th>Customer ID</th>
            <th>Customer Name</th>
            <th>Area</th>
            <th>Sub Area</th>
            <th>Branch</th>
            <th>Line</th>
            <th>Mobile</th>
            <th>Sub Status</th>
            <th>Action</th>
            <th>Last Paid Date</th>
            <th>Hint</th>
            <th>Communication Error</th>
            <th>Commitment Date</th>
        </tr>
    </thead>
    <tbody>

    <?php
    $sno = 1;
    foreach ($result as $row) {
        $cus_id = $row['cp_cus_id'];
        
        $index = array_search($cus_id,$cus_id_arr);//this will find the matching index of the value given inside array
        // if($index !== false && $follow_cus_sts[$index] != 'Legal'){ //dont allow customer name which are with legal status

            ?>
            <tr>
                <td> <?php echo $sno; ?> </td><?php
                
                ?> <td> <?php echo $row['cp_cus_id']; ?> </td><?php
                ?> <td> <?php echo $row['cus_name']; ?> </td><?php
                
                
                
                //Area Name fetch
                $area_id = $row['area_confirm_area'];
                $qry = $mysqli->query("SELECT * FROM area_list_creation where area_id = $area_id ");
                $row1 = $qry->fetch_assoc();
                $area_name = $row1['area_name'];
                
                ?> <td> <?php echo $area_name; ?> </td><?php

                //Sub Area Name Fetch
                $sub_area_id = $row['area_confirm_subarea'];
                $qry = $mysqli->query("SELECT * FROM sub_area_list_creation where sub_area_id = $sub_area_id ");
                $row1 = $qry->fetch_assoc();
                $sub_area_name = $row1['sub_area_name'];
                
                ?> <td> <?php echo $sub_area_name; ?> </td><?php
                
                $line_name = $row['area_line'];
                $qry = $mysqli->query("SELECT b.branch_name FROM branch_creation b JOIN area_line_mapping l ON l.branch_id = b.branch_id where l.line_name = '".$line_name."' ");
                $row1 = $qry->fetch_assoc();
                ?> <td> <?php echo $row1['branch_name']; ?> </td>
                
                <td> <?php echo $row['area_line']; ?> </td>
                <td> <?php echo $row['mobile1']; ?> </td>

                <?php
                    $cus_id = $row['cp_cus_id'];
                    $id = $row['req_id'];
                    
                    $index = array_search($cus_id,$cus_id_arr);//this will find the matching index of the value given inside array
                    if($index !== false){
                        //pass the index to the follow_cus_sts array to find his exact status
                        ?>
                            <td> <?php echo $follow_cus_sts[$index]; ?> </td>
                        <?php
                    }
                    
                    
                    
                ?>

                <?php
                    $action="<a href='due_followup&upd=$id&cusidupd=$cus_id' title='Edit details' ><button class='btn btn-success' style='background-color:#009688;'>View Loans</button></a>";
                ?> 
                <td> <?php echo $action; ?> </td>
                
                <?php
                    $collDate = $mysqli->query("SELECT 
                    DAY(coll_date) as coll_date,
                    CASE 
                        WHEN DAYOFMONTH(coll_date) BETWEEN 26 AND 31 THEN '26-30'
                        WHEN DAYOFMONTH(coll_date) BETWEEN 21 AND 25 THEN '21-25'
                        WHEN DAYOFMONTH(coll_date) BETWEEN 16 AND 20 THEN '16-20'
                        WHEN DAYOFMONTH(coll_date) BETWEEN 11 AND 15 THEN '11-15'
                        ELSE ''
                    END AS date_range
                    FROM collection WHERE `cus_id`='$cus_id' ORDER by coll_id DESC limit 1");
                    $coll_date_qry = $collDate->fetch_assoc();
                    if(mysqli_num_rows($collDate)>0){
                        $date_range = $coll_date_qry['date_range'];
                    }else{
                        $date_range = '';
                    }
                ?> 
                
                <td> <?php echo $date_range; ?> </td>
                
                <?php
                    $sql = $con->query("SELECT comm_date, hint, comm_err from commitment where cus_id = '".$row['cp_cus_id']."' order by id desc limit 1 ");
                    if(mysqli_num_rows($sql)>0){
                        $row1 = $sql->fetch_assoc();
                        ?> <td> <?php echo $row1['hint']; ?> </td><?php
                        ?> <td> <?php echo $row1['comm_err']=='1'?'Yes':($row1['comm_err']=='2'?'No':'Clear'); ?> </td><?php
                        ?> <td> <?php echo $row1['comm_date']!='0000-00-00' ? date('d-m-Y',strtotime($row1['comm_date'])) : ''; ?> </td><?php
                    }else{
                        ?> <td> <?php echo ''; ?> </td><?php
                        ?> <td> <?php echo ''; ?> </td><?php
                        ?> <td> <?php echo ''; ?> </td><?php
                    }
                ?>
            </tr>
        <?php
            $sno = $sno+1;
        // }
    }
    ?>

    </tbody>
</table>


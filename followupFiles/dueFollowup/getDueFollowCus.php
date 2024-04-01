<?php

include('../../ajaxconfig.php');


$query = $con->query("SELECT cp.cus_id as cp_cus_id,cp.cus_name,cp.area_confirm_area,cp.area_confirm_subarea,cp.area_line,cp.mobile1, ii.cus_id as ii_cus_id, ii.req_id FROM 
acknowlegement_customer_profile cp JOIN in_issue ii ON cp.cus_id = ii.cus_id
where ii.status = 0 and (ii.cus_status >= 14 and ii.cus_status <= 17)  GROUP BY ii.cus_id " ) ;// 14 and 17 means collection entries, 17 removed from issue list

$response = array();
while( $row = $query->fetch_assoc()) {
    array_push($response, $row['cp_cus_id']);
}

echo json_encode($response);
?>
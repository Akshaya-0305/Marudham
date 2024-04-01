<?php
include('../ajaxconfig.php');


$selectQry = "SELECT * FROM loan_scheme WHERE 1 and status = 0 "; 
$res = $con->query($selectQry) or die("Error in Get All Records".$con->error);
$detailrecords = array();
if ($con->affected_rows>0)
{$i=0;
    while($row = $res->fetch_object()){	
        $detailrecords[$i]['scheme_id']      = $row->scheme_id; 
        $detailrecords[$i]['scheme_name']      = $row->scheme_name; 
        $i++;
    }
}
return $detailrecords;
?>
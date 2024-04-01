<?php
// error_reporting(0);
include("../ajaxconfig.php");
@session_start();
if(isset($_SESSION["userid"])){
    $userid = $_SESSION["userid"];
}
require_once('../vendor/csvreader/php-excel-reader/excel_reader2.php');
require_once('../vendor/csvreader/SpreadsheetReader.php');
if(isset($_FILES["file"]["type"])){
    $allowedFileType = ['application/vnd.ms-excel','text/xls','text/xlsx','application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'];
    if(in_array($_FILES["file"]["type"],$allowedFileType)){
        
        
        $targetPath = '../uploads/area_creation/'.$_FILES['file']['name'];
        move_uploaded_file($_FILES['file']['tmp_name'], $targetPath);

        $Reader = new SpreadsheetReader($targetPath);
        $sheetCount = count($Reader->sheets()); 
        
        for($i=0;$i<$sheetCount;$i++)
        {
            $Reader->ChangeSheet($i);
            foreach ($Reader as $Row){ 

                $state = "";
                if(isset($Row[0])) {
                    $state = mysqli_real_escape_string($con,$Row[0]); 
                }
                
                $district = "";
                if(isset($Row[1])) {
                    $district = mysqli_real_escape_string($con,$Row[1]); 
                }
                
                $taluk = "";
                if(isset($Row[2])) {
                    $taluk = mysqli_real_escape_string($con,$Row[2]); 
                }
                
                $area = "";
                $area_list_creation_id='';
                $last_insert_id =0;
                if(isset($Row[3])) {
                    $area = mysqli_real_escape_string($con,$Row[3]); 
                    $query = "SELECT * FROM area_list_creation where area_name = '".$area."' and status = 0";
                    $result1 = $con->query($query) or die("Error ");
                    if($con->affected_rows > 0){
                        $row = $result1->fetch_assoc();
                        $area_list_creation_id = $row["area_id"];
                    }else{
                        $query = "INSERT into area_list_creation (area_name) values('".strip_tags($area)."')";
                        $result1 = $con->query($query) or die("Error ");
                        $last_insert_id = $con->insert_id;
                        $area_list_creation_id = $con->insert_id;
                    }
                }
                
                $subarea = "";
                $sub_area_list_creation_id='';
                if(isset($Row[4])) {
                    $subarea = mysqli_real_escape_string($con,$Row[4]); 
                    if($subarea !=''){
                        $query = "SELECT * FROM sub_area_list_creation where sub_area_name = '".$subarea."' and status = 0";
                        $result1 = $con->query($query) or die("Error ");
                        if($last_insert_id == 0 and $con->affected_rows >0){
                            $row = $result1->fetch_assoc();
                            $sub_area_list_creation_id = $row["sub_area_id"];
                        }else{
                            $query = "INSERT into sub_area_list_creation (sub_area_name,area_id_ref) values('".strip_tags($subarea)."','".$last_insert_id."')";
                            $result1 = $con->query($query) or die("Error ");
                            $sub_area_list_creation_id = $con->insert_id;
                        }
                    }
                    
                }

                $pincode = "";
                if(isset($Row[5])) {
                    $pincode = mysqli_real_escape_string($con,$Row[5]); 
                }

                
                
                if($i==0 && $state!="State" && $district != "District" && $taluk != "Taluk" && $area !="" && $subarea !="" && $pincode !="" )
                { 
                    $insert=$con->query("INSERT INTO area_creation(area_name_id, sub_area, taluk, district,state,pincode,created_date,insert_login_id) 
                    VALUES('".strip_tags($area_list_creation_id)."', '".strip_tags($sub_area_list_creation_id)."', '".strip_tags($taluk)."',
                    '".strip_tags($district)."','".strip_tags($state)."','".strip_tags($pincode)."', current_timestamp(), '".$userid."')");
                }
            }
        }
        
        if(!empty($insert)) {
        $message = 0;
        }
        else{
        $message = 1;
        }
    }
}else{
    $message = 1;
}
    echo $message;
    ?>

    


<?php

include 'bulkUploadClass.php';
require_once('../vendor/csvreader/php-excel-reader/excel_reader2.php');
require_once('../vendor/csvreader/SpreadsheetReader.php');

$obj = new bulkUploadClass;
$userData = $obj->getUserDetails($con);

$allowedFileType = ['application/vnd.ms-excel', 'text/xls', 'text/xlsx', 'text/csv', 'text/xml', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'];
if (in_array($_FILES["excelFile"]["type"], $allowedFileType)) {

    $excelfolder = $obj->uploadFiletoFolder();

    $Reader = new SpreadsheetReader($excelfolder);
    $sheetCount = count($Reader->sheets());

    for ($i = 0; $i < $sheetCount; $i++) {
        $Reader->ChangeSheet($i);
        $rowChange = 0;
        foreach ($Reader as $Row) {

            if ($rowChange != 0) { // omitted 0 to avoid headers

                $data = $obj->fetchAllRowData($con, $Row);
                $data['req_code'] = $obj->getRequestCode($con);
                $data['doc_code'] = $obj->getDocumentCode($con);
                $data['loan_id'] = $obj->getLoanCode($con);
                $data['area_id'] = $obj->getAreaId($con, $data['area']);
                $data['sub_area_id'] = $obj->getSubAreaId($con, $data['sub_area']);
                $data['loan_cat_id'] = $obj->getLoanCategoryId($con, $data['loan_category']);
                $data['sub_categoryCheck'] = $obj->checkSubCategory($con, $data['sub_category']);
                $data['group_name'] = $obj->getAreaGroup($con, $data['sub_area_id']) == $data['area_group'] ? $data['area_group'] : 'Invalid';
                $data['line_name'] = $obj->getAreaLine($con, $data['sub_area_id']) == $data['area_line'] ? $data['area_line'] : 'Invalid';
                $data['agent_id'] = $obj->checkAgent($con, $data['agent_id']);
                $checkCustomerData = $obj->checkCustomerData($con, $data['cus_id']);
                $data['cus_data'] = $checkCustomerData['cus_data'];
                $data['cus_reg_id'] = $checkCustomerData['cus_reg_id'];
                $data['scheme_id'] = $obj->getSchemeId($con, $data['scheme_name']);
                $data['cus_status'] = '14';

                $err_columns = $obj->handleError($data);
                if (empty($err_columns)) {

                    $req_id = $obj->raiseRequest($con, $data, $userData);
                    $obj->verificationTables($con, $data, $userData, $req_id);
                    $obj->approvalTables($con, $req_id);
                    $obj->acknowledgementTables($con,$data, $req_id,$userData);
                    $obj->loanIssueTables($con, $data, $userData, $req_id);

                    // echo $insertQry;
                } else {
                    $errtxt = "Please Check the input given in Serial No: " . ($rowChange) . " on below. <br><br>";
                    $errtxt .= "<ul>";
                    foreach ($err_columns as $columns) {
                        $errtxt .= "<li>$columns</li>";
                    }
                    $errtxt .= "</ul><br>";
                    $errtxt .= "Insertion completed till Seiral No: " . ($rowChange - 1);   
                    echo $errtxt;
                    exit();
                }
            }

            $rowChange++;
        }
    }
    $message = 'Bulk Upload Completed.';
} else {
    $message = 'File is not in Excel Format.';
}

echo $message;

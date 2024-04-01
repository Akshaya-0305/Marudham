<?php

class verificaitonClass
{
    public $user_id;
    function __construct($user_id)
    {
        $this->user_id = $user_id;
    }
    function getverificaitonCounts($con)
    {
        $response = array();
        $today = date('Y-m-d');
        $sub_area_list = $_POST['sub_area_list'];

        $tot_in_ver = "SELECT COUNT(*) as tot_in_ver from request_creation where (cus_status >= 1 and cus_status NOT IN(4,8) ) ";
        $today_in_ver = "SELECT COUNT(*) as tot_in_ver from request_creation where cus_status IN(1,10,11,12) and date(updated_date) = '$today' ";
        $tot_issue = "SELECT COUNT(*) as tot_issue FROM request_creation req JOIN customer_profile cp ON cp.req_id = req.req_id WHERE req.cus_status >= 14 ";
        $today_issue = "SELECT COUNT(*) as today_issue FROM request_creation req JOIN customer_profile cp ON cp.req_id = req.req_id WHERE req.cus_status >= 14 and date(req.updated_date) = '$today' ";
        $tot_balance = "SELECT COUNT(*) as tot_balance from request_creation where (cus_status < 14 and cus_status >= 1 and cus_status NOT IN(4, 5, 6, 7, 8, 9, 10, 11, 12) )  ";
        $today_balance = "SELECT COUNT(*) as today_balance from request_creation where cus_status IN(1,10,11,12) and date(updated_date) = '$today'  ";
        $tot_cancel = "SELECT COUNT(*) as tot_cancel from request_creation where cus_status = 5 ";
        $today_cancel = "SELECT COUNT(*) as today_cancel from request_creation where cus_status = 5 and date(updated_date) = '$today' ";
        $tot_revoke = "SELECT COUNT(*) as tot_revoke from request_creation where cus_status = 9 ";
        $today_revoke = "SELECT COUNT(*) as today_revoke from request_creation where cus_status = 9 and date(updated_date) = '$today' ";
        $tot_new = "SELECT COUNT(*) as tot_new from request_creation where (cus_status < 14 and cus_status >= 1 and cus_status NOT IN(4, 5, 6, 7, 8, 9, 10, 11, 12) ) and cus_data = 'New' ";
        $today_new = "SELECT COUNT(*) as today_new from request_creation where cus_status = 1 and cus_data = 'New' and date(updated_date) = '$today' ";
        $tot_existing = "SELECT COUNT(*) as tot_existing from request_creation where (cus_status < 14 and cus_status >= 1 and cus_status NOT IN(4, 5, 6, 7, 8, 9, 10, 11, 12) ) and cus_data = 'Existing' ";
        $today_existing = "SELECT COUNT(*) as today_existing from request_creation where cus_status = 1 and cus_data = 'Existing' and date(updated_date) = '$today' ";

        if (empty($sub_area_list)) {
            $sub_area_list = $this->getUserGroupBasedSubArea($con, $this->user_id);
        }

        $tot_in_ver .= " AND sub_area IN ($sub_area_list) ";
        $today_in_ver .= " AND sub_area IN ($sub_area_list) ";
        $tot_issue .= " AND ( CASE WHEN cp.area_confirm_subarea IS NOT NULL THEN cp.area_confirm_subarea IN ($sub_area_list) ELSE TRUE END )";
        $today_issue .= " AND ( CASE WHEN cp.area_confirm_subarea IS NOT NULL THEN cp.area_confirm_subarea IN ($sub_area_list) ELSE TRUE END )";
        $tot_balance .= " AND sub_area IN ($sub_area_list) ";
        $today_balance .= " AND sub_area IN ($sub_area_list) ";
        $tot_cancel .= " AND sub_area IN ($sub_area_list) ";
        $today_cancel .= " AND sub_area IN ($sub_area_list) ";
        $tot_revoke .= " AND sub_area IN ($sub_area_list) ";
        $today_revoke .= " AND sub_area IN ($sub_area_list) ";
        $tot_new .= " AND sub_area IN ($sub_area_list) ";
        $today_new .= " AND sub_area IN ($sub_area_list) ";
        $tot_existing .= " AND sub_area IN ($sub_area_list) ";
        $today_existing .= " AND sub_area IN ($sub_area_list) ";


        $tot_in_verQry = $con->query($tot_in_ver);
        $today_in_verQry = $con->query($today_in_ver);
        $tot_issueQry = $con->query($tot_issue);
        $today_issueQry = $con->query($today_issue);
        $tot_balanceQry = $con->query($tot_balance);
        $today_balanceQry = $con->query($today_balance);
        $tot_cancelQry = $con->query($tot_cancel);
        $today_cancelQry = $con->query($today_cancel);
        $tot_revokeQry = $con->query($tot_revoke);
        $today_revokeQry = $con->query($today_revoke);
        $tot_newQry = $con->query($tot_new);
        $today_newQry = $con->query($today_new);
        $tot_existingQry = $con->query($tot_existing);
        $today_existingQry = $con->query($today_existing);

        $response['tot_in_ver'] = $tot_in_verQry->fetch_assoc()['tot_in_ver'];
        $response['today_in_ver'] = $today_in_verQry->fetch_assoc()['tot_in_ver'];
        $response['tot_issue'] = $tot_issueQry->fetch_assoc()['tot_issue'];
        $response['today_issue'] = $today_issueQry->fetch_assoc()['today_issue'];
        $response['tot_balance'] = $tot_balanceQry->fetch_assoc()['tot_balance'];
        $response['today_balance'] = $today_balanceQry->fetch_assoc()['today_balance'];
        $response['tot_cancel'] = $tot_cancelQry->fetch_assoc()['tot_cancel'];
        $response['today_cancel'] = $today_cancelQry->fetch_assoc()['today_cancel'];
        $response['tot_revoke'] = $tot_revokeQry->fetch_assoc()['tot_revoke'];
        $response['today_revoke'] = $today_revokeQry->fetch_assoc()['today_revoke'];
        $response['tot_new'] = $tot_newQry->fetch_assoc()['tot_new'];
        $response['today_new'] = $today_newQry->fetch_assoc()['today_new'];
        $response['tot_existing'] = $tot_existingQry->fetch_assoc()['tot_existing'];
        $response['today_existing'] = $today_existingQry->fetch_assoc()['today_existing'];

        return $response;
    }

    function getUserGroupBasedSubArea($con, $user_id)
    {
        $sub_area_list = array();

        $userQry = $con->query("SELECT * FROM USER WHERE user_id = $user_id ");
        while ($rowuser = $userQry->fetch_assoc()) {
            $group_id = $rowuser['group_id'];
        }
        $group_id = explode(',', $group_id);
        foreach ($group_id as $group) {
            $groupQry = $con->query("SELECT * FROM area_group_mapping where map_id = $group ");
            $row_sub = $groupQry->fetch_assoc();
            $sub_area_list[] = $row_sub['sub_area_id'];
        }
        $sub_area_ids = array();
        foreach ($sub_area_list as $subarray) {
            $sub_area_ids = array_merge($sub_area_ids, explode(',', $subarray));
        }
        $sub_area_list = array();
        $sub_area_list = implode(',', $sub_area_ids);

        return $sub_area_list;
    }
}

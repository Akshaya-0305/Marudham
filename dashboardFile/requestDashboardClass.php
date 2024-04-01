<?php

class RequestClass
{
    public $user_id;

    public function __construct($user_id)
    {
        $this->user_id = $user_id;
    }
    function getRequestCounts($con)
    {

        $response = array();
        $today = date('Y-m-d');
        $sub_area_list = $_POST['sub_area_list'];

        //all the above queries without $con->query(). just query as string like $req_query = "SELECT count(*) as tot_req FROM request_creation WHERE insert_login_id = '$this->user_id' "
        $req_query = "SELECT count(*) as tot_req FROM request_creation WHERE 1 ";
        $issue_query = "SELECT count(*) as tot_issue FROM request_creation WHERE cus_status >= 14 ";
        $balance_query = "SELECT count(*) as tot_balance FROM request_creation WHERE (cus_status < 14 and cus_status NOT IN(4, 5, 6, 7, 8, 9) ) ";
        $cancel_query = "SELECT count(*) as tot_cancel FROM request_creation WHERE cus_status = 4 ";
        $revoke_query = "SELECT count(*) as tot_revoke FROM request_creation WHERE cus_status = 8 ";
        $new_query = "SELECT count(*) as tot_new FROM request_creation WHERE cus_data = 'New' ";
        $existing_query = "SELECT count(*) as tot_existing FROM request_creation WHERE cus_data = 'Existing' ";
        $today_req_query = "SELECT count(*) as today_req FROM request_creation WHERE date(created_date) = '$today' ";
        $today_issue_query = "SELECT count(*) as today_issue FROM request_creation WHERE cus_status >= 14 AND date(created_date) = '$today' ";
        $today_balance_query = "SELECT count(*) as today_balance FROM request_creation WHERE (cus_status < 14 and cus_status NOT IN(4, 5, 6, 7, 8, 9)) AND date(created_date) = '$today'";
        $today_cancel_query = "SELECT count(*) as today_cancel FROM request_creation WHERE cus_status = 4 AND date(created_date) = '$today' ";
        $today_revoke_query = "SELECT count(*) as today_revoke FROM request_creation WHERE cus_status = 8 AND date(created_date) = '$today' ";
        $today_new_query = "SELECT count(*) as today_new FROM request_creation WHERE cus_data = 'New' AND date(created_date) = '$today' ";
        $today_existing_query = "SELECT count(*) as today_existing FROM request_creation WHERE cus_data = 'Existing' AND date(created_date) = '$today' ";

        //now i shoud add sub_area IN ($sub_area_list) in where clause to the above queries

        if (!empty($sub_area_list)) {
            //if the sub area list is empty then no need to add it to the query
            $req_query .= " AND sub_area IN ($sub_area_list) ";
            $issue_query .= " AND sub_area IN ($sub_area_list) ";
            $balance_query .= " AND sub_area IN ($sub_area_list) ";
            $cancel_query .= " AND sub_area IN ($sub_area_list) ";
            $revoke_query .= " AND sub_area IN ($sub_area_list) ";
            $new_query .= " AND sub_area IN ($sub_area_list) ";
            $existing_query .= " AND sub_area IN ($sub_area_list) ";
            $today_req_query .= " AND sub_area IN ($sub_area_list) ";
            $today_issue_query .= " AND sub_area IN ($sub_area_list) ";
            $today_balance_query .= " AND sub_area IN ($sub_area_list) ";
            $today_cancel_query .= " AND sub_area IN ($sub_area_list) ";
            $today_revoke_query .= " AND sub_area IN ($sub_area_list) ";
            $today_new_query .= " AND sub_area IN ($sub_area_list) ";
            $today_existing_query .= " AND sub_area IN ($sub_area_list) ";
        } else {
            //add insert_login_id = '$this->user_id' in where clause to the above queries
            $req_query .= " AND insert_login_id = '$this->user_id' ";
            $issue_query .= " AND insert_login_id = '$this->user_id' ";
            $balance_query .= " AND insert_login_id = '$this->user_id' ";
            $cancel_query .= " AND insert_login_id = '$this->user_id' ";
            $revoke_query .= " AND insert_login_id = '$this->user_id' ";
            $new_query .= " AND insert_login_id = '$this->user_id' ";
            $existing_query .= " AND insert_login_id = '$this->user_id' ";
            $today_req_query .= " AND insert_login_id = '$this->user_id' ";
            $today_issue_query .= " AND insert_login_id = '$this->user_id' ";
            $today_balance_query .= " AND insert_login_id = '$this->user_id' ";
            $today_cancel_query .= " AND insert_login_id = '$this->user_id' ";
            $today_revoke_query .= " AND insert_login_id = '$this->user_id' ";
            $today_new_query .= " AND insert_login_id = '$this->user_id' ";
            $today_existing_query .= " AND insert_login_id = '$this->user_id' ";
        }
        //now run the above queries and store it like before in reponse variable
        $qry = $con->query($req_query);
        $response['tot_req'] = $qry->fetch_assoc()['tot_req'];
        $qry = $con->query($today_req_query);
        $response['today_req'] = $qry->fetch_assoc()['today_req'];
        $qry = $con->query($issue_query);
        $response['tot_issue'] = $qry->fetch_assoc()['tot_issue'];
        $qry = $con->query($today_issue_query);
        $response['today_issue'] = $qry->fetch_assoc()['today_issue'];
        $qry = $con->query($balance_query);
        $response['tot_balance'] = $qry->fetch_assoc()['tot_balance'];
        $qry = $con->query($today_balance_query);
        $response['today_balance'] = $qry->fetch_assoc()['today_balance'];
        $qry = $con->query($cancel_query);
        $response['tot_cancel'] = $qry->fetch_assoc()['tot_cancel'];
        $qry = $con->query($today_cancel_query);
        $response['today_cancel'] = $qry->fetch_assoc()['today_cancel'];
        $qry = $con->query($revoke_query);
        $response['tot_revoke'] = $qry->fetch_assoc()['tot_revoke'];
        $qry = $con->query($today_revoke_query);
        $response['today_revoke'] = $qry->fetch_assoc()['today_revoke'];
        $qry = $con->query($new_query);
        $response['tot_new'] = $qry->fetch_assoc()['tot_new'];
        $qry = $con->query($today_new_query);
        $response['today_new'] = $qry->fetch_assoc()['today_new'];
        $qry = $con->query($existing_query);
        $response['tot_existing'] = $qry->fetch_assoc()['tot_existing'];
        $qry = $con->query($today_existing_query);
        $response['today_existing'] = $qry->fetch_assoc()['today_existing'];

        return $response;
    }
}

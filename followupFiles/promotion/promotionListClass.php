<?php
session_start();
class promotionListClass
{
    private $sub_area_list = array();
    public function __construct($con)
    {
        $userid = $_SESSION["userid"];
        if ($userid != 1) {

            $userQry = $con->query("SELECT * FROM USER WHERE user_id = $userid ");
            while ($rowuser = $userQry->fetch_assoc()) {
                $group_id = $rowuser['group_id'];
            }
            $group_id = explode(',', $group_id);
            $sub_area_list = array();
            foreach ($group_id as $group) {
                $groupQry = $con->query("SELECT * FROM area_group_mapping where map_id = $group ");
                $row_sub = $groupQry->fetch_assoc();
                $sub_area_list[] = $row_sub['sub_area_id'];
            }
            $sub_area_ids = array();
            foreach ($sub_area_list as $subarray) {
                $sub_area_ids = array_merge($sub_area_ids, explode(',', $subarray));
            }
            $this->sub_area_list = implode(',', $sub_area_ids);
        }
    }
    function getdetails($con, $type)
    {
        $arr = array();

        if ($type == 'existing') {
            //only closed customers who dont have any loans in current.

            $sql = $con->query("SELECT cs.cus_id,cs.consider_level,cs.updated_date FROM closed_status cs JOIN acknowlegement_customer_profile cp ON cs.req_id = cp.req_id WHERE cs.cus_sts >= '20' and cp.area_confirm_subarea IN ($this->sub_area_list) ");

            while ($row = $sql->fetch_assoc()) {

                $last_closed_date = date('Y-m-d', strtotime($row['updated_date']));

                $check_req = $con->query("SELECT req_id from request_creation where (cus_status NOT between 4 and 9) and cus_status < 20 and cus_id = '" . $row['cus_id'] . "' ORDER By req_id DESC LIMIT 1 ");
                if ($check_req->num_rows == 0) {
                    $arr[] = array('cus_id' => $row['cus_id'], 'sub_status' => $row['cus_status'], 'last_updated_date' => $last_closed_date);
                }

                // $qry1 = $con->query("SELECT cus_id FROM in_issue WHERE (cus_status < '20' and cus_status NOT IN (4, 5, 6, 7, 8, 9)) AND cus_id ='" . $row['cus_id'] . "' ");

                // $qry2 = $con->query("SELECT cus_id FROM request_creation WHERE (cus_status < '20' and cus_status NOT IN (4, 5, 6, 7, 8, 9)) AND cus_id ='" . $row['cus_id'] . "' ");

                // if ($qry1->num_rows == 0 && $qry2->num_rows == 0) {
                //     //means customer is in request / loan process
                //     //take customer promotion chart

                //     $sql1 = $con->query("SELECT updated_date FROM request_creation WHERE (cus_status >= 4 and cus_status <= 9 ) and cus_id = '" . $row['cus_id'] . "' ORDER BY req_id DESC LIMIT 1 ");
                //     if ($sql1->num_rows > 0) {
                //         //this condition will filter only if the closed date is higher than the other dates of customer
                //         $last_updated_date = date('Y-m-d', strtotime($sql1->fetch_assoc()['updated_date']));

                //         if ($last_closed_date > $last_updated_date) {
                //             $arr[] = array('cus_id' => $row['cus_id'], 'sub_status' => $row['consider_level'],'last_updated_date'=>$last_updated_date);
                //         }
                //     } else {
                //         $arr[] = array('cus_id' => $row['cus_id'], 'sub_status' => $row['consider_level'],'last_updated_date'=>$last_closed_date);
                //     }
                // }
            }
        } else {

            $sql = $con->query("SELECT req.* FROM request_creation req WHERE (req.cus_status >= 4 AND req.cus_status <= 9) AND (req.sub_area IN ( " . $this->sub_area_list . " ) or  (select area_confirm_subarea from customer_profile where req_id = req.req_id) IN ( " . $this->sub_area_list . " ) ) Group By req.cus_id");
            while ($row = $sql->fetch_assoc()) {

                $last_updated_date = date('Y-m-d', strtotime($row['updated_date']));
                $last_closed_date = '';

                $check_req = $con->query("SELECT req_id from request_creation where (cus_status NOT between 4 and 9) and cus_status < 20 and cus_id = '" . $row['cus_id'] . "' ORDER By req_id DESC LIMIT 1 ");
                if ($check_req->num_rows == 0) {
                    $arr[] = array('cus_id' => $row['cus_id'], 'sub_status' => $row['cus_status'], 'last_updated_date' => $last_updated_date);
                }

                // $sql1 = $con->query("SELECT created_date FROM closed_status WHERE cus_sts >= 20 and cus_id ='" . $row['cus_id'] . "' ORDER BY id DESC LIMIT 1");
                // $sql2 = $con->query("SELECT updated_date FROM request_creation WHERE NOT(cus_status >= 4 AND cus_status <= 9) and cus_id ='" . $row['cus_id'] . "' ORDER BY req_id DESC LIMIT 1");
                // if ($sql1->num_rows > 0) {

                //     //this condition will filter only if the revoked/cancelled date is higher than the closed date of customer
                //     $last_closed_date = date('Y-m-d', strtotime($sql1->fetch_assoc()['created_date']));

                //     if ($last_updated_date > $last_closed_date) {
                //         $arr[] = array('cus_id' => $row['cus_id'], 'sub_status' => $row['cus_status'],'last_updated_date'=>$last_closed_date);
                //     }
                // } elseif ($sql2->num_rows > 0) {
                //     //this condition will filter only if the revoked/cancelled date is higher than the recent request date of customer 
                //     //which will avoid showing the customer who has other requests other than 
                //     $last_requested_date = date('Y-m-d', strtotime($sql2->fetch_assoc()['updated_date']));

                //     if ($last_updated_date > $last_requested_date) {
                //         $arr[] = array('cus_id' => $row['cus_id'], 'sub_status' => $row['cus_status'],'last_updated_date'=>$last_requested_date);
                //     }
                // } else {

                //     $arr[] = array('cus_id' => $row['cus_id'], 'sub_status' => $row['cus_status'],'last_updated_date'=>$last_updated_date);
                // }

            }
        }
        return $arr;
    }

    function getCustomerPromotionType($con, $cus_id)
    {
        $response = '';

        $sql = $con->query("SELECT cs.cus_id,cs.consider_level,cs.updated_date FROM closed_status cs JOIN acknowlegement_customer_profile cp ON cs.req_id = cp.req_id WHERE cs.cus_sts >= '20' and cp.area_confirm_subarea IN ($this->sub_area_list) and cs.cus_id = '$cus_id' ");

        while ($row = $sql->fetch_assoc()) {

            $check_req = $con->query("SELECT req_id from request_creation where (cus_status NOT between 4 and 9) and cus_status < 20 and cus_id = '" . $row['cus_id'] . "' ORDER By req_id DESC LIMIT 1 ");
            if ($check_req->num_rows == 0) {
                $response = 'Existing';
            }
        }


        $sql = $con->query("SELECT req.* FROM request_creation req WHERE (req.cus_status >= 4 AND req.cus_status <= 9) AND (req.sub_area IN ( " . $this->sub_area_list . " ) or  (select area_confirm_subarea from customer_profile where req_id = req.req_id) IN ( " . $this->sub_area_list . " ) ) and req.cus_id = '$cus_id' ");

        while ($row = $sql->fetch_assoc()) {

            $check_req = $con->query("SELECT req_id from request_creation where (cus_status NOT between 4 and 9) and cus_status < 20 and cus_id = '" . $row['cus_id'] . "' ORDER By req_id DESC LIMIT 1 ");
            if ($check_req->num_rows == 0) {
                $response = 'Repromotion';
            }
        }


        return $response;
    }
}

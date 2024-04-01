<?php
include '../ajaxconfig.php';

class branchProcess
{
    public $branch_id;

    function getBranchList($user_id)
    {
        global $con;
        $qry = $con->query("SELECT bc.branch_id, bc.branch_name from branch_creation bc JOIN user u ON FIND_IN_SET (bc.branch_id, u.branch_id) where u.user_id = '$user_id' ");
        while ($row = $qry->fetch_assoc()) {
            $response[] = $row;
        }


        return $response;
    }

    function getSubAreaList($branch_id, $user_id)
    {
        global $con;

        $sub_area_list = array();

        if ($branch_id == 0) { //if 0, then need to show all branches's sub area

            $branch_list = $this->getBranchList($user_id); //calling this function because we need all branches allocated for the user to show all branch sub area
            foreach ($branch_list as $branch) {
                $qry = $con->query("SELECT sub_area_id FROM area_group_mapping where branch_id = '" . $branch['branch_id'] . "' ");
                while ($row = $qry->fetch_assoc()) {

                    $sub_area_list[] = $row['sub_area_id'];
                }
            }
        } else {
            //for particulat branch just show branch based sub area's count only
            $qry = $con->query("SELECT sub_area_id FROM area_group_mapping where branch_id = $branch_id ");
            while ($row = $qry->fetch_assoc()) {

                $sub_area_list[] = $row['sub_area_id'];
            }
        }

        $sub_area_ids = array();
        foreach ($sub_area_list as $subarray) {
            //store each sub area list into single sub area array
            $sub_area_ids = array_merge($sub_area_ids, explode(',', $subarray));
        }
        $sub_area_list = implode(',', $sub_area_ids);
        //check if sub area list is empty or not
        if (!empty($sub_area_list)) {
            return $sub_area_list;
        }else{
            return 'Error';
        }
    }
}

<?php
session_start();
include '../ajaxconfig.php';
include '../dashboardFile/acknowledgmentDashboardClass.php';

$user_id = $_SESSION['userid'];

$acknowledgmentClass = new acknowledgmentClass($user_id);

$response = $acknowledgmentClass->getAcknowledgmentCounts($con);

echo json_encode($response);
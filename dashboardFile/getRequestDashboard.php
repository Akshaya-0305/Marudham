<?php
session_start();
include '../ajaxconfig.php';
include '../dashboardFile/requestDashboardClass.php';

$user_id = $_SESSION['userid'];

$requestClass = new requestClass($user_id);

$response = $requestClass->getRequestCounts($con);

echo json_encode($response);
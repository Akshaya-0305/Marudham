<?php
session_start();
include '../ajaxconfig.php';
include '../dashboardFile/loanIssueDashboardClass.php';

$user_id = $_SESSION['userid'];

$LoanIssueClass = new LoanIssueClass($user_id);

$response = $LoanIssueClass->getLoanIssueCounts($con);

echo json_encode($response);
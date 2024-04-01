<?php
$timeZoneQry = "SET time_zone = '+5:30' ";


$con = mysqli_connect("localhost", "root", "", "marudham") or die("Error in database connection" . mysqli_error($mysqli));
mysqli_set_charset($con, "utf8");
$con->query($timeZoneQry);

$host = "localhost";
$db_user = "root";
$db_pass = "";
$dbname = "marudham";
$connect = new PDO("mysql:host=$host; dbname=$dbname", $db_user, $db_pass);
$connect->exec($timeZoneQry);

$mysqli = mysqli_connect("localhost", "root", "", "marudham");
mysqli_set_charset($mysqli, "utf8");
$mysqli->query($timeZoneQry);



date_default_timezone_set('Asia/Kolkata');

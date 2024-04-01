<?php
date_default_timezone_set('Asia/Calcutta');
@session_start();
include("api/iedit-config.php");

session_destroy();   
echo "<script>location.href='https://localhost/marudham/'</script>"; 

?>
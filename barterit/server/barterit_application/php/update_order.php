<?php
if (!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}

include_once("dbconnect.php");

$prid = $_POST['orderid'];
$prlat = $_POST['latitude'];
$prlong = $_POST['longitude'];
$prstate = $_POST['state'];
$prlocality = $_POST['locality'];

$sqlupdate = "UPDATE `apps_orders` SET `order_lat`='$prlat',`order_lng`='$prlong',`order_state`='$prstate',`order_locality`='$prlocality' WHERE `order_id`='$prid'";

if ($conn->query($sqlupdate) === TRUE) {
	$response = array('status' => 'success', 'data' => null);
    sendJsonResponse($response);
}else{
	$response = array('status' => 'failed', 'data' => null);
	sendJsonResponse($response);
}

function sendJsonResponse($sentArray)
{
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}

?>
<?php
if (!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}
if (isset($_POST['image'])) {
    $image = $_POST['image'];
    $userid = $_POST['userid'];
    
    $decoded_string = base64_decode($image);
	$path = '../assets/profile/'.$userid.'.png';
	file_put_contents($path, $decoded_string);
	$response = array('status' => 'success', 'data' => null);
    sendJsonResponse($response);
    // $decoded_string = base64_decode($encoded_string);
    // $path = '../assets/profileimages/' . $userid . '.png';
    // if (file_put_contents($path, $decoded_string)){
    //     $response = array('status' => 'success', 'data' => null);
    //     sendJsonResponse($response);
    // }else{
    //     $response = array('status' => 'failed', 'data' => null);
    //     sendJsonResponse($response);
    // }
    die();
}
if (isset($_POST['phone'])) {
    $phone = $_POST['phone'];
    $userid = $_POST['userid'];
    $sqlupdate = "UPDATE `apps_user` SET `user_phone` ='$phone' WHERE `user_id` ='$userid'";
    databaseUpdate($sqlupdate);
    die();
}
if (isset($_POST['password'])) {
    $pass = sha1($_POST['oldpass']);
    $password = sha1($_POST['password']);
    $userid = $_POST['userid'];
    $sqlupdate = "UPDATE `apps_user` SET `user_pass` ='$password' WHERE `user_id` = '$userid' AND `user_pass` = '$pass'";
    databaseUpdate($sqlupdate);
    die();
}
if (isset($_POST['name'])) {
    $name = $_POST['name'];
    $userid = $_POST['userid'];
    $sqlupdate = "UPDATE `apps_user` SET `user_name` ='$name' WHERE `user_id` ='$userid'";
    databaseUpdate($sqlupdate);
    die();
}
function databaseUpdate($sql){
    include_once("dbconnect.php");
    if ($conn->query($sql) === TRUE) {
        $response = array('status' => 'success', 'data' => null);
        sendJsonResponse($response);
    } else {
        $response = array('status' => 'failed', 'data' => null);
        sendJsonResponse($response);
    }
}
function sendJsonResponse($sentArray)
{
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}
?>
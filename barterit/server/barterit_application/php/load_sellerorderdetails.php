<?php
if (!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}

include_once("dbconnect.php");

if (isset($_POST['sellerid']) && isset($_POST['orderbill'])){
	$sellerid = $_POST['sellerid'];	
	$orderbill = $_POST['orderbill'];
	$sqlorderdetails = "SELECT * FROM `apps_orderdetails` INNER JOIN `apps_items` ON apps_orderdetails.item_id = apps_items.item_id WHERE apps_orderdetails.seller_id = '$sellerid' AND apps_orderdetails.order_bill = '$orderbill'";
}

$result = $conn->query($sqlorderdetails);
if ($result->num_rows > 0) {
    $oderdetails["orderdetails"] = array();
	while ($row = $result->fetch_assoc()) {
        $orderdetailslist = array();
        $orderdetailslist['orderdetail_id'] = $row['orderdetail_id'];
        $orderdetailslist['order_bill'] = $row['order_bill'];
        $orderdetailslist['item_id'] = $row['item_id'];
        $orderdetailslist['item_name'] = $row['item_name'];
        $orderdetailslist['orderdetail_qty'] = $row['orderdetail_qty'];
        $orderdetailslist['orderdetail_paid'] = $row['orderdetail_paid'];
        $orderdetailslist['buyer_id'] = $row['buyer_id'];
        $orderdetailslist['seller_id'] = $row['seller_id'];
        $orderdetailslist['orderdetail_date'] = $row['orderdetail_date'];
        array_push($oderdetails["orderdetails"] ,$orderdetailslist);
    }
    $response = array('status' => 'success', 'data' => $oderdetails);
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
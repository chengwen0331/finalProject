<?php
//error_reporting(0);
include_once("dbconnect.php");
$userid = $_POST['userid'];
$phone = $_POST['phone'];
$amount = $_POST['amount'];
$email = $_POST['email'];
$name = $_POST['name'];
$paidstatus = $_POST['paidstatus'];
$response = array('status' => 'unknown', 'data' => $paidstatus);

$receiptid = rand(10000, 99999);

if ($paidstatus == "Success") { //payment success
    $sqlcart = "SELECT * FROM `apps_carts` WHERE user_id = '$userid' ORDER BY seller_id ASC";
    $result = $conn->query($sqlcart);
    $seller = "";
    $singleorder = 0;
    $i = 0;
    $numofrows = $result->num_rows;
    if ($result->num_rows > 0) {
        $response = array('status' => 'success', 'data' => null);
        while ($row = $result->fetch_assoc()) {
            $seller_id = $row['seller_id'];
            $itemid = $row['item_id'];
            $orderqty = $row['cart_qty'];
            $order_paid = $row['cart_price'];

            if ($i == 0) {
                $seller = $seller_id;
            }

            if ($seller == $seller_id) {
                $singleorder = $singleorder + $order_paid;
            } else {
                $sqlorder = "INSERT INTO `apps_orders`( `order_bill`, `order_paid`, `buyer_id`, `seller_id`, `order_status`) VALUES ('$receiptid','$singleorder','$userid','$seller','New')";
                $conn->query($sqlorder);
                $seller = $seller_id;
                $singleorder = $order_paid;
            }

            if ($i == ($numofrows - 1)) {
                $singleorder = $singleorder;
                $sqlorder = "INSERT INTO `apps_orders`( `order_bill`, `order_paid`, `buyer_id`, `seller_id`, `order_status`) VALUES ('$receiptid','$singleorder','$userid','$seller','New')";
                $conn->query($sqlorder);
            }
            $i++;

            $sqlorderdetails = "INSERT INTO `apps_orderdetails`(`order_bill`, `item_id`, `orderdetail_qty`, `orderdetail_paid`, `buyer_id`, `seller_id`) VALUES ('$receiptid','$itemid','$orderqty','$order_paid','$userid','$seller_id')";
            $conn->query($sqlorderdetails);
            $sqlupdatecatchqty = "UPDATE `apps_items` SET `item_qty`= (item_qty - $orderqty) WHERE `item_id` = '$itemid'";
            $conn->query($sqlupdatecatchqty);
        }
        $sqldeletecart = "DELETE FROM `apps_carts` WHERE user_id = '$userid'";
        $conn->query($sqldeletecart);
    }

    sendJsonResponse($response);
} else {
    $response = array('status' => 'failed', 'data' => $userid);
    sendJsonResponse($response);
}

function sendJsonResponse($sentArray)
{
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}


?>
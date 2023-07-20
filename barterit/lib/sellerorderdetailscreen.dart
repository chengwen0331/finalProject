import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:barterit/model/myconfig.dart';
import 'package:barterit/model/order.dart';
import 'package:barterit/model/orderdetails.dart';
import 'package:barterit/model/user.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;


class SellerOrderDetailsScreen extends StatefulWidget {
  final Order order;
  
  const SellerOrderDetailsScreen({super.key, required this.order});

  @override
  State<SellerOrderDetailsScreen> createState() =>
      _SellerOrderDetailsScreenState();
}

class _SellerOrderDetailsScreenState extends State<SellerOrderDetailsScreen> {
  List<OrderDetails> orderdetailsList = <OrderDetails>[];
  late double screenHeight, screenWidth;
  String selectStatus = "New";
  var val = 50;
  // ignore: prefer_typing_uninitialized_variables
  late Position _currentPosition;
  var pickupLatLng;
  String curaddress = "";
  String curstate = "";
  String prlat = "";
  String prlong = "";
    final TextEditingController _prstateEditingController =
      TextEditingController();
  final TextEditingController _prlocalEditingController =
      TextEditingController();
  List<String> statusList = ["New", "Processing", "Ready", "Completed"];
  late User user = User(
      id: "na",
      name: "na",
      email: "na",
      phone: "na",
      datereg: "na",
      password: "na",
      otp: "na");
  String picuploc = "Not selected";
  var _pickupPosition;

  @override
  void initState() {
    super.initState();
    loadbuyer();
    loadorderdetails();
    selectStatus = widget.order.orderStatus.toString();
    /*if (widget.order.orderLat.toString() == "") {
      picuploc = "Not selected";
    } else {
      picuploc = "Selected";
      pickupLatLng = LatLng(double.parse(widget.order.orderLat.toString()),
          double.parse(widget.order.orderLng.toString()));
    }*/
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    String? orderDate = widget.order.orderDate;
                            String datePart = orderDate?.substring(0, 10) ?? 'Unknown';
    return Scaffold(
      appBar: AppBar(title: const Text("Order Details"),
      backgroundColor: Colors.amber,
      actions: [
        IconButton(
          onPressed: () {
            // Handle messenger action
          },
          icon: const Icon(Icons.chat, color: Colors.black,),
        ), 
        ]),
      body: Column(children: [
        Flexible(
          flex: 5,
          //height: screenHeight / 5.5,
          child: Card(
              child: Row(
            children: [
              Container(
                margin: const EdgeInsets.all(4),
                width: screenWidth * 0.3,
                child:Container(
                                            margin: const EdgeInsets.all(4),
                                            width: screenWidth * 0.25,
                                            child: CachedNetworkImage(
                                              imageUrl: "${MyConfig().SERVER}/barterit_application/assets/profile/${user.id}.png?v=$val",
                                              placeholder: (context, url) => const LinearProgressIndicator(),
                                              errorWidget: (context, url, error) => Image.network(
                                                "${MyConfig().SERVER}/barterit_application/assets/profile/0.png",
                                                scale: 2,
                                              ),
                                            ),
                                          ),
              ),
              Column(
                children: [
                  user.id == "na"
                      ? const Center(
                          child: Text("Loading..."),
                        )
                      : Padding(
                          padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Buyer Name: ${user.name}",
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold)),
                              Text("Phone: ${user.phone}",
                                  style: const TextStyle(
                                    fontSize: 14,
                                  )),
                              Text("Order ID: ${widget.order.orderId}",
                                  style: const TextStyle(
                                    fontSize: 14,
                                  )),
                              Text(
                                "Total Paid: RM ${double.parse(widget.order.orderPaid.toString()).toStringAsFixed(2)}",
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                "Order Date: $datePart",
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              Text("Status: ${widget.order.orderStatus}",
                                  style: const TextStyle(
                                    fontSize: 14,
                                  )),
                            ],
                          ),
                        )
                ],
              )
            ],
          )),
        ),
        /*Container(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    onPressed: () {
                      pickupDialog();
                    },
                    child: const Text("Select Pickup Location")),
                Text(picuploc)
              ],
            )),*/
        orderdetailsList.isEmpty
            ? Container()
            : Expanded(
                flex: 7,
                child: ListView.builder(
                    itemCount: orderdetailsList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(children: [
                            CachedNetworkImage(
                              width: screenWidth / 3,
                              fit: BoxFit.cover,
                              imageUrl:
                                  "${MyConfig().SERVER}/barterit_application/assets/items/${orderdetailsList[index].itemId}_1.png",
                              placeholder: (context, url) =>
                                  const LinearProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    orderdetailsList[index]
                                        .itemName
                                        .toString(),
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "Quantity: ${orderdetailsList[index].orderdetailQty}",
                                    style: const TextStyle(
                                        fontSize: 12,),
                                  ),
                                  Text(
                                    "Total Paid: RM ${double.parse(orderdetailsList[index].orderdetailPaid.toString()).toStringAsFixed(2)}",
                                    style: const TextStyle(
                                        fontSize: 12,),
                                  ),
                                ],
                              ),
                            )
                          ]),
                        ),
                      );
                    })
              ),
        SizedBox(
  // color: Colors.red,
          width: screenWidth,
          height: screenHeight * 0.23,
          child: Card(
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text("Set Order Status: ",
            style: TextStyle(
                                fontSize: 16,
                              ),
            ),
            DropdownButton(
              itemHeight: 50,
              value: selectStatus,
              onChanged: (newValue) {
                setState(() {
                  selectStatus = newValue.toString();
                });
              },
              items: statusList.map((selectStatus) {
                return DropdownMenuItem(
                  value: selectStatus,
                  child: Text(
                    selectStatus,
                    style: TextStyle(
                                fontSize: 16,
                              ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
        SizedBox(
                      width: screenWidth / 1.2,
                      //height: 50,
                      child: Container(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: ElevatedButton(
                          onPressed: () {
                            submitStatus(selectStatus);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.amber,
                          ),
                          child: const Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Submit",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )

      ],
    ),
  ),
        )

      ]),
    );
  }

  void loadorderdetails() {
    http.post(
        Uri.parse(
            "${MyConfig().SERVER}/barterit_application/php/load_sellerorderdetails.php"),
        body: {
          "sellerid": widget.order.sellerId,
          "orderbill": widget.order.orderBill
        }).then((response) {
      log(response.body);
      //orderList.clear();
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        if (jsondata['status'] == "success") {
          var extractdata = jsondata['data'];
          extractdata['orderdetails'].forEach((v) {
            orderdetailsList.add(OrderDetails.fromJson(v));
          });
        } else {
          // status = "Please register an account first";
          // setState(() {});
        }
        setState(() {});
      }
    });
  }

  void loadbuyer() {
    http.post(Uri.parse("${MyConfig().SERVER}/barterit_application/php/load_user.php"),
        body: {
          "userid": widget.order.buyerId,
        }).then((response) {
      // log(response.body);
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        if (jsondata['status'] == 'success') {
          user = User.fromJson(jsondata['data']);
        }
      }
      setState(() {});
    });
  }

  void submitStatus(String st) {
    http.post(
        Uri.parse("${MyConfig().SERVER}/barterit_application/php/set_orderstatus.php"),
        body: {"orderid": widget.order.orderId, "status": st}).then((response) {
      log(response.body);
      //orderList.clear();
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        if (jsondata['status'] == "success") {
        } else {}
        widget.order.orderStatus = st;
        selectStatus = st;
        setState(() {});
        ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Update Success")));
      }
    });
  }

}
import 'dart:convert';
import 'package:barterit/model/myconfig.dart';
import 'package:barterit/model/order.dart';
import 'package:barterit/model/user.dart';
import 'package:barterit/sellerorderdetailscreen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;


class SellerOrderScreen extends StatefulWidget {
  final User user;
  const SellerOrderScreen({super.key, required this.user});

  @override
  State<SellerOrderScreen> createState() => _SellerOrderScreenState();
}

class _SellerOrderScreenState extends State<SellerOrderScreen> {
  String status = "Loading...";
  List<Order> orderList = <Order>[];
  var val = 50;
  late double screenHeight, screenWidth, cardwitdh;

  @override
  void initState() {
    super.initState();
    loadsellerorders();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: const Text("Order/s"),
      backgroundColor: Colors.amber,
      actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications),
            color:Colors.black,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
            color:Colors.black,
          ),
        ],),
      body: Container(
        child: orderList.isEmpty
            ? const Center(
              child: Text("No Data", style:TextStyle(fontSize: 15)),
            )
            : Column(
                children: [
                  /*SizedBox(
                    width: screenWidth,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
                      child: Row(
                        children: [
                          Flexible(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.all(4),
                                            width: screenWidth * 0.25,
                                            child: CachedNetworkImage(
                                              imageUrl: "${MyConfig().SERVER}/barterit_application/assets/profile/${widget.user.id}.png?v=$val",
                                              placeholder: (context, url) => const LinearProgressIndicator(),
                                              errorWidget: (context, url, error) => Image.network(
                                                "${MyConfig().SERVER}/barterit_application/assets/profile/0.png",
                                                scale: 2,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            "Order by: ${widget.user.name}",
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            "Phone Number: ${widget.user.phone}",
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),*/
                  const SizedBox(height:10),
                  //const Text("Your Current Order"),
                  Expanded(
                      child: ListView.builder(
                          itemCount: orderList.length,
                          itemBuilder: (context, index) {
                            String? orderDate = orderList[index].orderDate;
                            String datePart = orderDate?.substring(0, 10) ?? 'Unknown';
                            return Card(
                            child:ListTile(
                              onTap: () async {
                                Order myorder =
                                    Order.fromJson(orderList[index].toJson());
                                await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (content) =>
                                            SellerOrderDetailsScreen(
                                              order: myorder,
                                              
                                            )));
                                loadsellerorders();
                              },
                              /*leading: CircleAvatar(
                                  child: Text((index + 1).toString())),*/
                              leading: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Text(
                                    (index + 1).toString(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),

                              title: Text(
                                  "Receipt: ${orderList[index].orderBill}",
                                  style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                  ),
                              //trailing: const Icon(Icons.arrow_forward),
                              trailing: CircleAvatar(
                                backgroundColor: Colors.grey,
                                child: Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                ),
                              ),
                              subtitle: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            "Order ID: ${orderList[index].orderId}",
                                            style: const TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold),),
                                        Text(
                                          "Total Payment: RM ${double.parse(orderList[index].orderPaid.toString()).toStringAsFixed(2)}",
                                          style: const TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold),
                                              ),
                                        Text(
                                          "Order Date: $datePart",
                                          style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),

                                        Text(
                                            "Order Status: ${orderList[index].orderStatus}",
                                            style: const TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold),)
                                      ]),
                                  Column(
                                    children: [
                                      
                                      const Text("")
                                    ],
                                  )
                                ],
                              ),
                            ));
                          })),
                ],
              ),
      ),
    );
    
  }

  //  Text(orderList[index].orderBill.toString()),
  //                               Text(orderList[index].orderStatus.toString()),
  //                               Text(orderList[index].orderPaid.toString()),

  void loadsellerorders() {
    http.post(
        Uri.parse("${MyConfig().SERVER}/barterit_application/php/load_sellerorder.php"),
        body: {"sellerid": widget.user.id}).then((response) {
      // log(response.body);
      //orderList.clear();
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        if (jsondata['status'] == "success") {
          orderList.clear();
          var extractdata = jsondata['data'];
          extractdata['orders'].forEach((v) {
            orderList.add(Order.fromJson(v));
          });
        } else {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("No order found")));
                  return;
          // status = "Please register an account first";
          // setState(() {});
        }
        setState(() {});
      }
    });
  }
}
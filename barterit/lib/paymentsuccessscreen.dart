import 'dart:async';
import 'dart:convert';

import 'package:barterit/model/myconfig.dart';
import 'package:barterit/model/order.dart';
import 'package:barterit/model/user.dart';
import 'package:barterit/simulatorscreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PaymentSuccessScreen extends StatefulWidget {
  final User user;
  //final Order order;
  final double totalprice;

  const PaymentSuccessScreen({super.key, required this.user, required this.totalprice});

  @override
  State<PaymentSuccessScreen> createState() => _PaymentSuccessScreenState();
}

class _PaymentSuccessScreenState extends State<PaymentSuccessScreen> {
  late double screenHeight, screenWidth, cardwitdh;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    late Order order;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Bill"),
          backgroundColor: Colors.amber,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pop(context);
                
              },
              icon: const Icon(
                Icons.clear,
                //color: Colors.red,
              ),
            ),]
        ),
        body: SingleChildScrollView(
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
            padding: const EdgeInsets.all(8),
            child:const Center(
            child: Text(
              "Receipt",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ))),
            const Padding(
                                    padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                                    child: Divider(
                                      color: Color.fromARGB(255, 166, 169, 171),
                                      height: 2,
                                      thickness: 2.0,
                                    ),
                                  ),
            const SizedBox(height: 8),
            const Padding(
              padding: EdgeInsets.only(left: 10), // Add left padding here
              child: Text(
                "Description:",
                style: TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              child:Padding(
                padding: const EdgeInsets.all(8.0),
              child: Table(
                border: TableBorder.all(color: Colors.black),
                columnWidths: const {
                  0: FlexColumnWidth(1.5),
                  1: FlexColumnWidth(2.5),
                },
                children: [
                  TableRow(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Name",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "${widget.user.name}",
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Email",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "${widget.user.email}",
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Phone",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "${widget.user.phone}",
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                     const  Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Amount",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "RM${widget.totalprice.toStringAsFixed(2)}",
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  const TableRow(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Paid Status",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Paid",
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ],
              ),)
            ),                  
          ],

        )));
    
  }
}
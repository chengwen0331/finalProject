import 'dart:async';
import 'dart:convert';

import 'package:barterit/model/myconfig.dart';
import 'package:barterit/model/user.dart';
import 'package:barterit/simulatorscreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BillScreen extends StatefulWidget {
  final User user;
  
  final double totalprice;

  const BillScreen({super.key, required this.user, required this.totalprice});

  @override
  State<BillScreen> createState() => _BillScreenState();
}

class _BillScreenState extends State<BillScreen> {
  int? value = 0;
  String selectedType = "Online Banking";
  List<String> paymentlist = [
    'Online Banking',
    'Paypal',
    'Credit Card / Debit Card',
    'Billplz',
  ];
  late double screenHeight, screenWidth, cardwitdh;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Bill"),
          backgroundColor: Colors.amber,
        ),
        body: SingleChildScrollView(
        child:Column(
          children: [
            Container(
            padding: const EdgeInsets.all(8),
            child:const Center(
            child: Text(
              "Barterit",
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
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Payment for order by:",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Name: ${widget.user.name}",
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "Email: ${widget.user.email}",
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "Mobile Number: ${widget.user.phone}",
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "Total Payment: RM${widget.totalprice.toStringAsFixed(2)}",
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
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Payment Information:",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 5),
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Barterit Bank Account: 789654123012",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 5),
          
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Payment method:",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            
            SizedBox(
                          height: 50,
                          child: Container(
                          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: DropdownButton(
                            value: selectedType,
                            onChanged: (newValue) {
                              setState(() {
                                selectedType = newValue!;
                                print(selectedType);
                              });
                            },
                            items: paymentlist.map((selectedType) {
                              return DropdownMenuItem(
                                value: selectedType,
                                child: Text(
                                  selectedType,
                                ),
                              );
                            }).toList(),
                            dropdownColor: Colors.grey[200],
                          ),
            )),
            const SizedBox(height: 10),
            SizedBox(
                      width: screenWidth / 1.2,
                      height: 50,
                      child: Container(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: ElevatedButton(
                          onPressed: () {
                            paymentDialog();
                            
                            
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.amber,
                          ),
                          child: const Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Pay",
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  
          ],

        )));
    
  }

  void paymentDialog() {

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          title: const Text(
            "Place Order?",
            style: TextStyle(),
          ),
          content: const Text("Are you sure?", style: TextStyle()),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Yes",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (content) => SimulatorScreen(
                                        user: widget.user,
                                        totalprice:widget.totalprice,
                                      )));
                                      
              },
            ),
            TextButton(
              child: const Text(
                "No",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
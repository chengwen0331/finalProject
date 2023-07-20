import 'dart:async';
import 'dart:convert';

import 'package:barterit/explorescreen.dart';
import 'package:barterit/model/myconfig.dart';
import 'package:barterit/model/order.dart';
import 'package:barterit/model/user.dart';
import 'package:barterit/paymentsuccessscreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SimulatorScreen extends StatefulWidget {
  final User user;
  
  final double totalprice;

  const SimulatorScreen({super.key, required this.user, required this.totalprice});

  @override
  State<SimulatorScreen> createState() => _SimulatorScreenState();
}

class _SimulatorScreenState extends State<SimulatorScreen> {
  late String paidstatus = "Success";
  late double screenHeight, screenWidth, cardwitdh;
  late Order order;
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
              "Barterit Payment Simulator",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ))),
            const Padding(
                                    padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                                    child: Divider(
                                      color: Color.fromARGB(255, 166, 169, 171),
                                      height: 2,
                                      thickness: 2.0,
                                    ),
                                  ),
            //const SizedBox(height: 5),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Total Payment: RM${widget.totalprice.toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
                      width: screenWidth / 1.2,
                      height: 50,
                      child: Container(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: ElevatedButton(
                          onPressed: () {
                            updatePayment(paidstatus);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (content) => PaymentSuccessScreen(
                                        user: widget.user,
                                        totalprice:widget.totalprice,
                                      )));
                                      
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 234, 92, 82),
                          ),
                          child: const Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Successful Payment",
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: screenWidth / 1.2,
                      height: 50,
                      child: Container(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: ElevatedButton(
                          onPressed: () {
                            paidstatus = "Failed";
                            updatePayment(paidstatus);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 30, 114, 72),
                          ),
                          child: const Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Failed Payment",
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

  void updatePayment(String paidstatus) {
  String status = paidstatus;
  http
      .post(Uri.parse("${MyConfig().SERVER}/barterit_application/php/payment_update.php"),
          body: {
            "userid": widget.user.id.toString(),
            "phone": widget.user.phone.toString(),
            "amount": widget.totalprice.toStringAsFixed(2),
            "email": widget.user.email.toString(),
            "name": widget.user.name.toString(),
            "paidstatus": status,
          })
      .then((response) {
    print(response.body);
    if (response.statusCode == 200) {
      var jsondata = jsonDecode(response.body);
      if (jsondata['status'] == 'success') {
        print(response.statusCode);

      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Payment Failed")));
        Navigator.pop(context);
      }
      //Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Payment Failed")));
      Navigator.pop(context);
    }
  });
}

}



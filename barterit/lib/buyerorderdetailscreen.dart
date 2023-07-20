// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';
import 'dart:developer';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:barterit/model/myconfig.dart';
import 'package:barterit/model/order.dart';
import 'package:barterit/model/user.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

import 'model/orderdetails.dart';

class BuyerOrderDetailsScreen extends StatefulWidget {
  final Order order;
  const BuyerOrderDetailsScreen({super.key, required this.order});

  @override
  State<BuyerOrderDetailsScreen> createState() =>
      _BuyerOrderDetailsScreenState();
}

// ignore: duplicate_ignore
class _BuyerOrderDetailsScreenState extends State<BuyerOrderDetailsScreen> {
  List<OrderDetails> orderdetailsList = <OrderDetails>[];
  late double screenHeight, screenWidth;
  String selectStatus = "Ready";
  //Set<Marker> markers = {};
late Position _currentPosition;

  String curaddress = "";
  String curstate = "";
  String prlat = "";
  String prlong = "";
    final TextEditingController _prstateEditingController =
      TextEditingController();
  final TextEditingController _prlocalEditingController =
      TextEditingController();
  List<String> statusList = [
    "New",
    "Processing",
    "Ready",
    "Completed",
  ];
  late User user = User(
      id: "na",
      name: "na",
      email: "na",
      phone: "na",
      datereg: "na",
      password: "na",
      otp: "na");
  var pickupLatLng;
  String picuploc = "Not selected";

  @override
  void initState() {
    super.initState();
    loadbuyer();
    loadorderdetails();
    _determinePosition();
    selectStatus = widget.order.orderStatus.toString();
    prlat = widget.order.orderLat.toString();
    prlong = widget.order.orderLng.toString();
    /*if (widget.order.orderLat.toString() == "") {
      picuploc = "Not selected";
      _pickupPosition = const CameraPosition(
        target: LatLng(6.4301523, 100.4287586),
        zoom: 12.4746,
      );
    } else {
      picuploc = "Selected";
      pickupLatLng = LatLng(double.parse(widget.order.orderLat.toString()),
          double.parse(widget.order.orderLng.toString()));
      _pickupPosition = CameraPosition(
        target: pickupLatLng,
        zoom: 18.4746,
      );
      MarkerId markerId1 = const MarkerId("1");
      markers.clear();
      markers.add(Marker(
        markerId: markerId1,
        position: pickupLatLng,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      ));
    }*/
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: const Text("Order Details"),
      backgroundColor: Colors.amber,
      actions: [
          IconButton(
            onPressed: () {
              _determinePosition();
            
            },
            icon: const Icon(Icons.location_pin,
            color: Colors.black,
                  size: 25,),
          ),
          IconButton(
          onPressed: () {
            // Handle messenger action
          },
          icon: const Icon(Icons.chat, color: Colors.black,),
        ), 
      ]
      ),
      body: Column(children: [
        SizedBox(
          //flex: 3,
          height: screenHeight / 3,
          child: Card(
              //child: Row(
            child:Column(
                children: [
                  user.id == "na"
                      ? const Center(
                          child: Text("Loading..."),
                        )
                      : Padding(
                          padding: const EdgeInsets.fromLTRB(10, 16, 10, 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Table(
                                  columnWidths: const {
                                    0: FlexColumnWidth(5),
                                    1: FlexColumnWidth(5),
                                  },
                                  children: [
                                    TableRow(children: [
                                      const TableCell(
                                        child: Text(
                                          "Order ID:",
                                          style: TextStyle(fontSize: 15,fontWeight: FontWeight.w900),
                                        ),
                                      ),
                                      TableCell(
                                        child: Text(
                                        "${widget.order.orderId}",
                                    style: const TextStyle(fontSize: 15),
                                          ),
                                        )
                                      ]),
                                      TableRow(children: [
                                      const TableCell(
                                        child: Text( 
                                          "Total Paid:",
                                          style: TextStyle(fontSize: 15,fontWeight: FontWeight.w900),
                                        ),
                                      ),
                                      TableCell(
                                        child: Text(
                                        "RM ${double.parse(widget.order.orderPaid.toString()).toStringAsFixed(2)}",
                                    style: const TextStyle(fontSize: 15),
                                          ),
                                        )
                                      ]),
                                      TableRow(children: [
                                      const TableCell(
                                        child: Text( 
                                          "Order Status:",
                                          style: TextStyle(fontSize: 15,fontWeight: FontWeight.w900),
                                        ),
                                      ),
                                      TableCell(
                                        child: Text(
                                        "${widget.order.orderStatus}",
                                    style: const TextStyle(fontSize: 15),
                                          ),
                                        )
                                      ]),
                                      TableRow(children: [
                                      const TableCell(
                                        child: Text( 
                                          "Fulfillment Status:",
                                          style: TextStyle(fontSize: 15,fontWeight: FontWeight.w900),
                                        ),
                                      ),
                                      TableCell(
                                        child: Text(
                                        "${widget.order.orderStatus == 'Completed' ? 'Fulfilled' : 'Unfulfilled'}",
                                    style: const TextStyle(fontSize: 15),
                                          ),
                                        )
                                      ]),
                                      TableRow(
                                        children: [
                                          const TableCell(
                                            child: Text(
                                              "Pickup Location:",
                                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w900),
                                            ),
                                          ),
                                          TableCell(
                                            child: Text(
                                              (widget.order.orderLat?.isEmpty == false || widget.order.orderLng?.isEmpty == false)
                                                  //? "Not selected"
                                                  ? "${widget.order.orderLocality}, ${widget.order.orderState}\n(${widget.order.orderLat}/\n${widget.order.orderLng})"
                                              
                                              : picuploc
                                            ),
                                          ),
                                        ],
                                      ),
                                      ]),
                            ],
                          ),
                        )
                ],
              )
            
          ),
        ),
        /*Container(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    onPressed: () {
                      if (picuploc == "Selected") {
                        loadMapDialog();
                      } else {
                        Fluttertoast.showToast(
                            msg: "Location not available",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            fontSize: 16.0);
                      }
                    },
                    child: const Text("See Pickup Location")),
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
          height: screenHeight * 0.1,
          child: Card(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text("Set order status as completed"),
                  // DropdownButton(
                  //   itemHeight: 60,
                  //   value: selectStatus,
                  //   onChanged: (newValue) {
                  //     setState(() {
                  //       selectStatus = newValue.toString();
                  //     });
                  //   },
                  //   items: statusList.map((selectStatus) {
                  //     return DropdownMenuItem(
                  //       value: selectStatus,
                  //       child: Text(
                  //         selectStatus,
                  //       ),
                  //     );
                  //   }).toList(),
                  // ),
                  ElevatedButton(
                      onPressed: () {
                        submitStatus("Completed");
                      },
                      style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.amber,
                          ),
                      child: const Text("Submit",
                      style: TextStyle(
                          fontSize: 16,),))
                ]),
          ),
        )
      ]),
    );
  }

  void loadorderdetails() {
    http.post(
        Uri.parse(
            "${MyConfig().SERVER}/barterit_application/php/load_buyerorderdetails.php"),
        body: {
          "buyerid": widget.order.buyerId,
          "orderbill": widget.order.orderBill,
          "sellerid": widget.order.sellerId
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
      log(response.body);
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

  /*void loadMapDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text("Select your pickup location"),
              content: GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: _pickupPosition,
                markers: markers.toSet(),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                ),
                TextButton(
                  onPressed: () {
                    if (pickupLatLng == null) {
                      Fluttertoast.showToast(
                          msg: "Please select pickup location from map",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          fontSize: 16.0);
                      return;
                    } else {
                      Navigator.pop(context);
                      picuploc = "Selected";
                    }
                  },
                  child: const Text("Select"),
                ),
              ],
            );
          },
        );
      },
    ).then((val) {
      setState(() {});
    });
  }*/

  void updateAddress() {
    String state = _prstateEditingController.text;
    String locality = _prlocalEditingController.text;

    http.post(Uri.parse("${MyConfig().SERVER}/barterit_application/php/update_order.php"),
        body: {
          "orderid": widget.order.orderId.toString(),
          "latitude": prlat,
          "longitude": prlong,
          "state": state,
          "locality": locality,
        }).then((response) {
      print(response.body);
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        if (jsondata['status'] == 'success') {
          //ScaffoldMessenger.of(context)
              //.showSnackBar(const SnackBar(content: Text("Update Success")));
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Update Failed")));
        }
        //Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Update Failed")));
        //Navigator.pop(context);
      }
    });
  }

  void _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied.');
    }
    _currentPosition = await Geolocator.getCurrentPosition();

    _getAddress(_currentPosition);
    //return await Geolocator.getCurrentPosition();
  }

  _getAddress(Position pos) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(pos.latitude, pos.longitude);
    if (placemarks.isEmpty) {
      _prlocalEditingController.text = "Changlun";
      _prstateEditingController.text = "Kedah";
      prlat = "6.443455345";
      prlong = "100.05488449";
      
    } else {
      _prlocalEditingController.text = placemarks[0].locality.toString();
      _prstateEditingController.text =
          placemarks[0].administrativeArea.toString(); //put 0 because the previous record will be replaced
      prlat = _currentPosition.latitude.toString();
      prlong = _currentPosition.longitude.toString();
    }
    setState(() {
      //Navigator.of(context).pop();
                updateAddress();
    });
  }

  
}
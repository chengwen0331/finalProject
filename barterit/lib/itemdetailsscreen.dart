
import 'dart:convert';
import 'dart:developer';

import 'package:barterit/buyercartscreen.dart';
import 'package:barterit/model/item.dart';
import 'package:barterit/model/myconfig.dart';
import 'package:barterit/model/user.dart';
//import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;

class ItemDetailsScreen extends StatefulWidget {
  final Item useritem;
  final User user;
  const ItemDetailsScreen(
      {super.key, required this.useritem, required this.user});

  @override
  State<ItemDetailsScreen> createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen> {
  final df = DateFormat('dd-MM-yyyy hh:mm a');
  late double screenHeight, screenWidth, cardwitdh;
  final CarouselController carouselController = CarouselController();
  List<Item> itemList = <Item>[];
  int currenIndex = 0;
  int cartqty = 0;
  int qty = 0;
  int userqty = 1;
  double totalprice = 0.0;
  double singleprice = 0.0;

  @override
  void initState() {
    super.initState();
    _loadExploreItems();
    qty = int.parse(widget.useritem.itemQty.toString());
    totalprice = double.parse(widget.useritem.itemPrice.toString());
    singleprice = double.parse(widget.useritem.itemPrice.toString());
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    List<String?> selectedImages = [
      "${MyConfig().SERVER}/barterit_application/assets/items/${widget.useritem.itemId}_1.png",
      "${MyConfig().SERVER}/barterit_application/assets/items/${widget.useritem.itemId}_2.png",
      "${MyConfig().SERVER}/barterit_application/assets/items/${widget.useritem.itemId}_3.png",
    ];
    var pathAsset = "assets/camera.png";
    List<String> pathAssets = [
      "assets/camera.png",
      "assets/camera.png",
      "assets/camera.png",
    ];
    return Scaffold(
      appBar: AppBar(title: const Text("Item Details"),
      backgroundColor: Colors.amber,
      actions: [
        IconButton(
          onPressed: () {
            // wishlist function
          },
          icon: const Icon(
            Icons.favorite,
            color: Colors.red,
          ),
        ),
        TextButton.icon(
            onPressed: () async {
              if (cartqty > 0) {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (content) => BuyerCartScreen(
                      user: widget.user,
                    ),
                  ),
                );
                _loadExploreItems();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("No item in cart")),
                );
              }
            },
            icon: Stack(
              children: [
                const Icon(
                  Icons.shopping_cart,
                  color: Colors.black,
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Transform.translate(
                    offset: const Offset(8, -8),
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        cartqty.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            label: const Text(''),
          ) 
      ],),
      body: Column(children: [
          Flexible(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 6),
                child: ListView(
                  shrinkWrap: true,
                  //physics: NeverScrollableScrollPhysics(),
                children: [
                  Stack(
                    children: [
                      CarouselSlider(
                        options: CarouselOptions(
                          scrollPhysics: const BouncingScrollPhysics(),
                          autoPlay: true,
                          viewportFraction: 1.0,
                          onPageChanged: (index, reason) {
                            setState(() {
                              currenIndex = index;
                            });
                          },
                        ),
                        carouselController: carouselController,
                        items: [
                          for (var i = 0; i < selectedImages.length; i++)
                            
                              SizedBox(
                                width: double.infinity,
                              child: AspectRatio(
                                aspectRatio: screenWidth / screenHeight,
                                child: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: selectedImages[i] != null
                                        ? NetworkImage(selectedImages[i]!) as ImageProvider<Object>
                                        : AssetImage(pathAssets[i]) as ImageProvider<Object>,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),)
                            
                        ],
                      ),
                      Positioned(
                        bottom: 10,
                        left: 0,
                        right: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: selectedImages.asMap().entries.map((entry) {
                            return GestureDetector(
                              onTap: () => carouselController.animateToPage(entry.key),
                              child: Container(
                                width: currenIndex == entry.key ? 17 : 7,
                                height: 7.0,
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 3.0,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: currenIndex == entry.key
                                      ? Colors.red
                                      : Colors.teal,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ],              
            ),
          )
        ),
        Container(
            padding: const EdgeInsets.all(8),
            child: Text(
              widget.useritem.itemName.toString(),
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )),
        Expanded(
          child: Container(
            padding: const EdgeInsets.fromLTRB(16, 5, 16, 5),
            child: Table(
              columnWidths: const {
                0: FlexColumnWidth(5),
                1: FlexColumnWidth(5),
              },
              children: [
                TableRow(children: [
                  const TableCell(
                    child: Text(
                      "Description",
                      style: TextStyle(fontWeight: FontWeight.w900),
                    ),
                  ),
                  TableCell(
                    child: Text(
                      widget.useritem.itemDesc.toString(),
                    ),
                  )
                ]),
                TableRow(children: [
                  const TableCell(
                    child: Text(
                      "Item Category",
                      style: TextStyle(fontWeight: FontWeight.w900),
                    ),
                  ),
                  TableCell(
                    child: Text(
                      widget.useritem.itemType.toString(),
                    ),
                  )
                ]),
                TableRow(children: [
                  const TableCell(
                    child: Text(
                      "Quantity",
                      style: TextStyle(fontWeight: FontWeight.w900),
                    ),
                  ),
                  TableCell(
                    child: Text(
                      widget.useritem.itemQty.toString(),
                    ),
                  )
                ]),
                TableRow(children: [
                  const TableCell(
                    child: Text(
                      "Original Price",
                      style: TextStyle(fontWeight: FontWeight.w900),
                    ),
                  ),
                  TableCell(
                    child: Text(
                      "RM ${double.parse(widget.useritem.itemPrice.toString()).toStringAsFixed(2)}",
                    ),
                  )
                ]),
                TableRow(children: [
                  const TableCell(
                    child: Text(
                      "Location",
                      style: TextStyle(fontWeight: FontWeight.w900),
                    ),
                  ),
                  TableCell(
                    child: Text(
                      "${widget.useritem.itemLocality}/${widget.useritem.itemState}",
                    ),
                  )
                ]),
              ],
            ),
          ),
        ),
        const SizedBox(height: 25,),
        Container(
          padding: const EdgeInsets.all(6),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(4),
              ),
              child: IconButton(
                onPressed: () {
                  if (userqty <= 1) {
                    userqty = 1;
                    totalprice = singleprice * userqty;
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Quantity cannot less than 1")));
                  return;
                  } else {
                    userqty = userqty - 1;
                    totalprice = singleprice * userqty;
                  }
                  setState(() {});
                },
                icon: const Icon(Icons.remove),
              ),
            ),
            Text(
              userqty.toString(),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(4),
              ),
              child: IconButton(
                onPressed: () {
                  if (userqty >= qty) {
                    userqty = qty;
                    totalprice = singleprice * userqty;
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Quantity exceeds availability")));
                  return;
                  } else {
                    userqty = userqty + 1;
                    totalprice = singleprice * userqty;
                  }
                  setState(() {});
                },
                icon: const Icon(Icons.add),
              ),
            ),
          ]),
        ),
        Text(
          "RM ${totalprice.toStringAsFixed(2)}",
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        ElevatedButton(
            onPressed: () {
              addtocartdialog();
            },
            style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.amber,
                          ),
            child: const Text("Add to Cart")),
      ]),
    );
  }
  
  void addtocartdialog() {
    if (widget.user.id.toString() == "na") {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please register to add item to cart")));
      return;
    }
    if (widget.user.id.toString() == widget.useritem.userId.toString()) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("User cannot add own item")));
      return;
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          title: const Text(
            "Add to cart?",
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
                addtocart();
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

  void addtocart() {
    http.post(Uri.parse("${MyConfig().SERVER}/barterit_application/php/addtocart.php"),
        body: {
          "item_id": widget.useritem.itemId.toString(),
          "cart_qty": userqty.toString(),
          "cart_price": totalprice.toString(),
          "userid": widget.user.id,
          "sellerid": widget.useritem.userId
        }).then((response) {
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        if (jsondata['status'] == 'success') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Add item to cart successfully")));
          return;          
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Add item to cart unsuccessfully")));
          return; 
        }
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Add item to cart unsuccessfully")));
          return; 
        Navigator.pop(context);
      }
    });
  }

  void _loadExploreItems() {

    http.post(Uri.parse("${MyConfig().SERVER}/barterit_application/php/load_items.php"),
        body: {
          //"userid": widget.user.id,
          "cartuserid": widget.user.id,
          //"pageno": pg.toString()
        }).then((response) {
      log(response.body);
      itemList.clear();
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        if (jsondata['status'] == "success") {         
          var extractdata = jsondata['data'];
          cartqty = int.parse(jsondata['cartqty'].toString());
          //cartqty = jsondata['cartqty'] != null ? int.tryParse(jsondata['cartqty'].toString()) ?? 0 : 0;
          extractdata['items'].forEach((v) {
            itemList.add(Item.fromJson(v));
          });
          print(itemList[0].itemName);
        }
        setState(() {});
      }
    });
  }
}
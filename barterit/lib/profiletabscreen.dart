import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:barterit/buyerorderscreen.dart';
import 'package:barterit/loginscreen.dart';
import 'package:barterit/model/myconfig.dart';
import 'package:barterit/model/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class ProfileTabScreen extends StatefulWidget {
  final User user;

  const ProfileTabScreen({super.key, required this.user});

  @override
  State<ProfileTabScreen> createState() => _ProfileTabScreenState();
}

class _ProfileTabScreenState extends State<ProfileTabScreen> {
  late List<Widget> tabchildren;
  String maintitle = "Profile";
  late double screenHeight, screenWidth;
  File? _image;
  Random random = Random();
  var val = 50;
  bool isDisable = false;

  @override
    void initState() {
      super.initState();
      print("Profile");
    }

  @override
  void dispose() {
    super.dispose();
    print("dispose");
    if (widget.user.id == "na") {
      isDisable = true;
    } else {
      isDisable = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Column(children: [
          /*Container(
            color: Color.fromARGB(255, 255, 250, 202),
            padding: const EdgeInsets.all(8),
            height: screenHeight * 0.25,
            width: screenWidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center, 
              children: [
                Container(
            margin: const EdgeInsets.all(4),
            width: screenWidth * 0.23,
            child: Image.asset(
              "assets/profile.png",
            ),
                ),
                Flexible(
                flex: 6,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(widget.user.name.toString(),
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(0, 2, 0, 8),
                      child: Divider(
                        color: Colors.blueGrey,
                        height: 2,
                        thickness: 2.0,
                      ),
                    ),
                    Table(
                      columnWidths: const {
                        0: FractionColumnWidth(0.3),
                        1: FractionColumnWidth(0.7)
                      },
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      children: [
                        TableRow(children: [
                          const Icon(Icons.email, size:18),
                          Text(widget.user.email.toString(), style:const TextStyle(fontSize:12, fontWeight: FontWeight.bold)),
                        ]),
                      TableRow(children: [
                          const Icon(Icons.phone, size:18),
                          Text(widget.user.phone.toString(), style:const TextStyle(fontSize:12, fontWeight: FontWeight.bold)),
                        ]),
                
                      ],
                    ),
                  ],
                ))
              ]),
          ),*/
          Container(
            //color: Color.fromARGB(255, 255, 250, 202),
            padding: const EdgeInsets.all(8),
            height: screenHeight * 0.25,
            width: screenWidth,
            child: Card(
              //color: Color.fromARGB(255, 255, 250, 202),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                GestureDetector(
                  onTap: isDisable ? null : _updateImageDialog,
                  child: Container(
                    margin: const EdgeInsets.all(4),
                    width: screenWidth * 0.25,
                    child: CachedNetworkImage(
                        imageUrl:
                            "${MyConfig().SERVER}/barterit_application/assets/profile/${widget.user.id}.png?v=$val",
                        placeholder: (context, url) =>
                            const LinearProgressIndicator(),
                        errorWidget: (context, url, error) => Image.network(
                              "${MyConfig().SERVER}/barterit_application/assets/profile/0.png",
                              scale: 2,
                            )),
                  ),
                ),
                Expanded(
                    flex: 6,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        widget.user.name.toString() == "na"
                            ? Column(
                                children: [
                                  Text(
                                    "Not Available",
                                    style: TextStyle(fontSize: 24),
                                  ),
                                  Divider(),
                                  Text("Not Available"),
                                  Text("Not Available"),
                                  Text("Not Available"),
                                ],
                              )
                            : Column(
                                children: [
                                  Text(
                                    widget.user.name.toString(),
                                    style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.fromLTRB(0, 2, 0, 8),
                                    child: Divider(
                                      color: Color.fromARGB(255, 166, 169, 171),
                                      height: 2,
                                      thickness: 2.0,
                                    ),
                                  ),
                                  //const Divider(),
                                  Table(
                                    columnWidths: const {
                                      0: FractionColumnWidth(0.3),
                                      1: FractionColumnWidth(0.7)
                                    },
                                    defaultVerticalAlignment:
                                        TableCellVerticalAlignment.middle,
                                    children: [
                                      TableRow(children: [
                                        const Icon(Icons.email, size:18),
                                        Text(widget.user.email.toString(), style:const TextStyle(fontSize:15, fontWeight: FontWeight.bold)),
                                      ]),
                                    TableRow(children: [
                                        const Icon(Icons.phone, size:18),
                                        Text(widget.user.phone.toString(), style:const TextStyle(fontSize:15, fontWeight: FontWeight.bold)),
                                      ]),
                              
                                    ],
                                  ),
                                ],
                              )
                      ],
                    )),
              ]),
            ),
          ),
          Container(
            width: screenWidth,
            alignment: Alignment.center,
            color: Colors.amberAccent,
            child: const Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Text("PROFILE SETTINGS",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  )),
            ),
          ),
          Expanded(
                      child: ListView(
                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                          shrinkWrap: true,
                          children: [
                        MaterialButton(
                          onPressed: () => {_updateProfileDialog(1)},
                          child: const Text("UPDATE NAME"),
                        ),
                        const Divider(
                          height: 2,
                        ),
                        MaterialButton(
                          onPressed: () => {_updateProfileDialog(2)},
                          child: const Text("UPDATE PHONE"),
                        ),
                        const Divider(
                          height: 2,
                        ),
                        MaterialButton(
                          onPressed: () => {_updateProfileDialog(3)},
                          child: const Text("UPDATE PASSWORD"),
                        ),
                        const Divider(
                          height: 2,
                        ),
                        MaterialButton(
                          onPressed: () {},
                          child: const Text("MY WISHLIST"),
                        ),
                        const Divider(
                          height: 2,
                        ),
                        MaterialButton(
                          onPressed: () async {
                            if (widget.user.id.toString() == "na") {
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                  content: Text("Please login/register an account")));
                              return;
                            }
                            await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (content) => BuyerOrderScreen(
                                          user: widget.user,
                                        )));
                                        },
                          child: const Text("MY ORDER"),
                        ),
                        const Divider(
                          height: 2,
                        ),
                        MaterialButton(
                          minWidth: screenWidth / 6,
                          height: 50,
                          elevation: 10,
                          onPressed: onLogout,
                          color: Colors.amberAccent,
                          textColor: Colors.black,
                          child: const Text(
                            'LOGOUT',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),

                      ]
              )
            ),
          
        ]),
      ),
    );
  }

  _updateImageDialog() {
    if (widget.user.id == "0") {
      Fluttertoast.showToast(
          msg: "Please login/register",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
      return;
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                "Select image from",
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextButton.icon(
                onPressed: () {
                  Navigator.of(context).pop();
                  _galleryPicker();
                },
                icon: const Icon(Icons.browse_gallery),
                label: const Text("Gallery"),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Expanded(
                    child: Divider(),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      "OR",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: Divider(),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              TextButton.icon(
                onPressed: () {
                  Navigator.of(context).pop();
                  _cameraPicker();
                },
                icon: const Icon(Icons.camera_alt),
                label: const Text("Camera"),
              ),
            ],
          ),
        );

      },
    );
  }

  Future<void> _galleryPicker() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 1200,
      maxWidth: 800,
    );
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      cropImage();
    }
  }

  Future<void> _cameraPicker() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 1200,
      maxWidth: 800,
    );
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      cropImage();
    }
  }

  Future<void> cropImage() async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: _image!.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
    );
    if (croppedFile != null) {
      File imageFile = File(croppedFile.path);
      _image = imageFile;
      _updateProfileImage();
      setState(() {});
    }
  }

  Future<void> _updateProfileImage() async {
    if (_image == null) {
      Fluttertoast.showToast(
          msg: "No image available",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
      return;
    }
    File imageFile = File(_image!.path);
    print(imageFile);
    String base64Image = base64Encode(imageFile.readAsBytesSync());
    // print(base64Image);
    http.post(
        Uri.parse("${MyConfig().SERVER}/barterit_application/php/update_profile.php"),
        body: {
          "userid": widget.user.id.toString(),
          "image": base64Image.toString(),
        }).then((response) {
      var jsondata = jsonDecode(response.body);
      print(jsondata);
      if (response.statusCode == 200 && jsondata['status'] == 'success') {
        Fluttertoast.showToast(
            msg: "Success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 16.0);
        val = random.nextInt(1000);
        setState(() {});
        // DefaultCacheManager manager = DefaultCacheManager();
        // manager.emptyCache(); //clears all data in cache.
      } else {
        Fluttertoast.showToast(
            msg: "Failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 16.0);
      }
    });
  }
  
  _updateProfileDialog(int i) {
    switch (i) {
      case 1:
        _updateNameDialog();
        break;
      case 2:
        _updatePhoneDialog();
        break;
      case 3:
        _updatePasswordDialog();
        break;
    }
  }
  
  void _updateNameDialog() {
    TextEditingController nameEditingController = TextEditingController();
    nameEditingController.text = widget.user.name.toString();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          title: Row(
            children: const[
              Icon(Icons.person),
              SizedBox(width: 8),
              Text(
                "Name",
                style: TextStyle(),
              ),
            ],
          ),
          content: TextField(
              controller: nameEditingController,
              keyboardType: TextInputType.text),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Update",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                http.post(Uri.parse("${MyConfig().SERVER}barterit_application/php/update_profile.php"),
                    body: {
                      "name": nameEditingController.text,
                      "userid": widget.user.id
                    }).then((response) {
                  var data = jsonDecode(response.body);
                  print(response.body);
                  if (response.statusCode == 200 &&
                      data['status'] == 'success') {
                        ScaffoldMessenger.of(context)
                          .showSnackBar(const SnackBar(content: Text("Name Updated Successfully")));
                      
                    /*Fluttertoast.showToast(
                        msg: "Success",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        textColor: Colors.green,
                        fontSize: 14.0);*/
                    setState(() {
                      widget.user.name = nameEditingController.text;
                    });
                    return;
                  } else {
                    ScaffoldMessenger.of(context)
                          .showSnackBar(const SnackBar(content: Text("Name Updated Unsuccessfully")));
                      return;
                    /*Fluttertoast.showToast(
                        msg: "Failed",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        textColor: Colors.red,
                        fontSize: 14.0);*/
                  }
                });
              },
            ),
            TextButton(
              child: const Text(
                "Cancel",
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
  
  void _updatePhoneDialog() {
    TextEditingController phoneEditingController = TextEditingController();
     phoneEditingController.text = widget.user.phone.toString();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: Row(
            children: const[
              Icon(Icons.phone),
              SizedBox(width: 8),
              Text(
                "Phone Number",
                style: TextStyle(),
              ),
            ],
          ),

          content: TextField(
              controller: phoneEditingController,
              keyboardType: TextInputType.phone),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Update",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                http.post(Uri.parse("${MyConfig().SERVER}barterit_application/php/update_profile.php"),
                    body: {
                      "phone": phoneEditingController.text,
                      "userid": widget.user.id
                    }).then((response) {
                  var data = jsonDecode(response.body);
                  // print(data);
                  if (response.statusCode == 200 &&
                      data['status'] == 'success') {
                    ScaffoldMessenger.of(context)
                          .showSnackBar(const SnackBar(content: Text("Phone Number Updated Successfully")));
                    setState(() {
                      widget.user.phone = phoneEditingController.text;
                    });
                    return;
                  } else {
                    ScaffoldMessenger.of(context)
                          .showSnackBar(const SnackBar(content: Text("Phone Number Updated Unsuccessfully")));
                      return;
                  }
                });
              },
            ),
            TextButton(
              child: const Text(
                "Cancel",
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
  
  /*void _updatePasswordDialog() {
    TextEditingController pass1EditingController = TextEditingController();
    TextEditingController pass2EditingController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          title: const Text(
            "Update Password",
            style: TextStyle(),
          ),
          contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
          content: SingleChildScrollView(
            //height: screenHeight / 4,
            child: Column(
              children: [
                TextField(
                    controller: pass1EditingController,
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    decoration: const InputDecoration(
                        labelText: 'New password',
                        labelStyle: TextStyle(),
                        icon: Icon(
                          Icons.lock,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2.0),
                        ))),
                        const SizedBox(height: 16),
                TextField(
                    controller: pass2EditingController,
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    decoration: const InputDecoration(
                        labelText: 'Confirm password',
                        labelStyle: TextStyle(),
                        icon: Icon(
                          Icons.lock,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2.0),
                        ))),
                const SizedBox(height: 16),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Confirm",
                style: TextStyle(),
              ),
              onPressed: () {
                if (pass1EditingController.text !=
                    pass2EditingController.text) {
                  Fluttertoast.showToast(
                      msg: "Passwords are not the same",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      textColor: Colors.red,
                      fontSize: 14.0);
                  return;
                }
                if (pass1EditingController.text.isEmpty ||
                    pass2EditingController.text.isEmpty) {
                  Fluttertoast.showToast(
                      msg: "Fill in passwords",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      textColor: Colors.red,
                      fontSize: 14.0);
                  return;
                }
                Navigator.of(context).pop();
                http.post(Uri.parse("${MyConfig().SERVER}barterit_application/php/update_profile.php"),
                    body: {
                      "password": pass1EditingController.text,
                      "userid": widget.user.id
                    }).then((response) {
                  var data = jsonDecode(response.body);
                  //  print(data);
                  if (response.statusCode == 200 &&
                      data['status'] == 'success') {
                    Fluttertoast.showToast(
                        msg: "Success",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        textColor: Colors.green,
                        fontSize: 14.0);
                  } else {
                    Fluttertoast.showToast(
                        msg: "Failed",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        textColor: Colors.red,
                        fontSize: 14.0);
                  }
                });
              },
            ),
            TextButton(
              child: const Text(
                "Cancel",
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
  }*/

    void _updatePasswordDialog() {
      TextEditingController passEditingController = TextEditingController();
  TextEditingController pass1EditingController = TextEditingController();
  TextEditingController pass2EditingController = TextEditingController();
  bool _isObscured = true;
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return SingleChildScrollView(
      child: AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        title: Row(
            children: const[
              Icon(Icons.lock),
              SizedBox(width: 8),
              Text(
                "Password",
                style: TextStyle(),
              ),
            ],
          ),
        contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
        content: Container(
          height: screenHeight * 0.4, // Adjust the height as needed
          child: Column(
            children: [
              TextField(
                controller: passEditingController,
                keyboardType: TextInputType.text,
                obscureText: true,
                //obscureText: _isObscured,
                style: const TextStyle(),
                decoration: const InputDecoration(
                  labelText: 'Old password',
                  labelStyle: TextStyle(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2.0),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: pass1EditingController,
                keyboardType: TextInputType.text,
                //textInputAction: TextInputAction.next,
                obscureText: true,
                //obscureText: !_isObscured,
                style: const TextStyle(),
                decoration: const InputDecoration(
                  labelText: 'New password',
                  labelStyle: TextStyle(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2.0),
                  ),

                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: pass2EditingController,
                keyboardType: TextInputType.text,
                //textInputAction: TextInputAction.next,
                obscureText: true,
                //obscureText: !_isObscured,
                style: const TextStyle(),
                decoration: const InputDecoration(
                  labelText: 'Confirm password',
                  labelStyle: TextStyle(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2.0),
                  ),
                
                ),
              ),
            ],
          ),
        ),
              actions: <Widget>[
            TextButton(
              child: const Text(
                "Update",
                style: TextStyle(),
              ),
              onPressed: () {
                if (pass1EditingController.text !=
                    pass2EditingController.text) {
                  Fluttertoast.showToast(
                      msg: "Passwords are not the same",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      textColor: Colors.red,
                      fontSize: 14.0);
                  return;
                }
                if (pass1EditingController.text.isEmpty ||
                    pass2EditingController.text.isEmpty) {
                  Fluttertoast.showToast(
                      msg: "Fill in passwords",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      textColor: Colors.red,
                      fontSize: 14.0);
                  return;
                }
                Navigator.of(context).pop();
                http.post(Uri.parse("${MyConfig().SERVER}barterit_application/php/update_profile.php"),
                    body: {
                      "oldpass": passEditingController.text,
                      "password": pass1EditingController.text,
                      "userid": widget.user.id
                    }).then((response) {
                  var data = jsonDecode(response.body);
                  //  print(data);
                  if (response.statusCode == 200 &&
                      data['status'] == 'success') {
                    ScaffoldMessenger.of(context)
                          .showSnackBar(const SnackBar(content: Text("Password Updated Successfully")));
                          return;
                  } else {
                    ScaffoldMessenger.of(context)
                          .showSnackBar(const SnackBar(content: Text("Password Updated Unsuccessfully")));
                          return;
                  }
                });
              },
            ),
            TextButton(
              child: const Text(
                "Cancel",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
            ),
          );
        },
      );
    
  
}



  void onLogout() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          title: const Text(
            "Logout?",
            style: TextStyle(
               
            ),
          ),
          content: const Text("Are you sure you want to logout?",
              style: TextStyle()),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Yes",
                style: TextStyle(
                   
                ),
              ),
              onPressed: () {
                SharedPreferences.getInstance().then((prefs) {
                  prefs.remove('accessToken');
                  prefs.remove('refreshToken');
                });
                ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Logout Success")));
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
              },
            ),
            TextButton(
              child: const Text(
                "No",
                style: TextStyle(
                   
                ),
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
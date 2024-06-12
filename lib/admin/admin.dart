import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import 'package:path/path.dart';

import '../constants/themes.dart';
import 'ALLADMIN.dart';
import 'computeradmin.dart';

class admin extends StatefulWidget {
  const admin({super.key});

  @override
  State<admin> createState() => _adminState();
}

class _adminState extends State<admin> {
  @override
  File? file;
  String? url;
  final _Name_Product = TextEditingController();
  final _Price = TextEditingController();
  final _shortDescription = TextEditingController();
  final _longDescription = TextEditingController();

  CollectionReference Computer =
      FirebaseFirestore.instance.collection('Computer');

  Future<void> addComputer() {
    // Call the user's CollectionReference to add a new user
    return Computer
        .add({
          'url': url ?? "noun",
          'Name_Product': _Name_Product.text,
          'Price': _Price.text,
          'shortDescription': _shortDescription.text,
          'longDescription': _longDescription.text,
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  getImage() async {
    final ImagePicker picker = ImagePicker();
// Pick an image.
    final XFile? imagegallery =
        await picker.pickImage(source: ImageSource.gallery);
// Capture a photo.
//     final XFile? photogallery = await picker.pickImage(source: ImageSource.camera);
    if (imagegallery != null) {
      file = File(imagegallery!.path);
      var photoname = basename(imagegallery!.path);
      var refStorge = FirebaseStorage.instance.ref("image").child(photoname);
      await refStorge.putFile(file!);
      url = await refStorge.getDownloadURL();
    }
    setState(() {});
  }

  bool isLoading = true;
  List<QueryDocumentSnapshot> data = [];

  getData() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("Computer").get();
    data.addAll(querySnapshot.docs);
    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => alladmin()));
            },
            icon: Icon(CupertinoIcons.back)),
        backgroundColor: kSecondaryColor,
        title: Text("Computer Admin",style: TextStyle(color: Colors.white),),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: isLoading == true
          ? Center(
              child: CircularProgressIndicator(
                color: kSecondaryColor,
              ),
            )
          : ListView(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 10, left: 20),
                  child: Row(
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => computeradmin()));
                          },
                          child: Text("Delete Computer")),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Container(
                      height: 15,
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          await getImage();
                        },
                        child: Text("Upload Photo")),
                    Container(
                      height: 15,
                    ),
                    if (url != null)
                      Image.network(
                        url!,
                        width: 300,
                        height: 300,
                        fit: BoxFit.fill,
                      ),
                    Container(
                      height: 30,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10, right: 10, top: 20),
                      child: TextFormField(
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                            labelText: "Name Product",
                            labelStyle:
                                TextStyle(color: Colors.black, fontSize: 15),
                            prefixIcon: Icon(
                              Icons.production_quantity_limits,
                              color: Colors.black,
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(color: Colors.black)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(color: Colors.black))),
                        controller: _Name_Product,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10, right: 10, top: 20),
                      child: TextFormField(
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                            labelText: "price",
                            labelStyle:
                                TextStyle(color: Colors.black, fontSize: 15),
                            prefixIcon: Icon(
                              Icons.monetization_on_outlined,
                              color: Colors.black,
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(color: Colors.black)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(color: Colors.black))),
                        controller: _Price,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10, right: 10, top: 20),
                      child: TextFormField(
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                            labelText: "Short Description",
                            labelStyle:
                                TextStyle(color: Colors.black, fontSize: 15),
                            prefixIcon: Icon(
                              Icons.edit,
                              color: Colors.black,
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(color: Colors.black)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(color: Colors.black))),
                        controller: _shortDescription,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10, right: 10, top: 20),
                      child: TextFormField(
                        maxLines: 6,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                            labelText: "Long Description",
                            labelStyle:
                                TextStyle(color: Colors.black, fontSize: 15),
                            prefixIcon: Icon(
                              Icons.edit,
                              color: Colors.black,
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(color: Colors.black)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(color: Colors.black))),
                        controller: _longDescription,
                      ),
                    ),
                    Container(
                      height: 15,
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          await addComputer();
                          await AwesomeDialog(
                            context: context,
                            dialogType: DialogType.success,
                            dialogBackgroundColor: Colors.white,
                            animType: AnimType.rightSlide,
                            title: "Success",
                            desc:
                                "Successful operation, your account has been added",
                            btnOkOnPress: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => admin()));
                            },
                            btnCancelOnPress: () {},
                          ).show();
                        },
                        child: Text("ok")),
                  ],
                ),
              ],
            ),
    );
  }
}

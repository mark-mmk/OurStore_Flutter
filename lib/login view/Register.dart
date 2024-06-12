import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/themes.dart';
import 'Login.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}
class _RegisterState extends State<Register> {
  @override
  final _user = TextEditingController();
  final _password = TextEditingController();
  final _phone = TextEditingController();
  final _address = TextEditingController();
  final _payment = TextEditingController();
  bool passwordvisible1 = true;


  CollectionReference users = FirebaseFirestore.instance.collection('users');
  Future<void> addUser() {
    // Call the user's CollectionReference to add a new user
    return users
        .add({
      'Email': _user.text,"id":FirebaseAuth.instance.currentUser!.uid, // John Doe
      'Password': _password.text, // Stokes and Sons
      'Phone': _phone.text,
      'Address': _address.text,
      'Payment Number': _payment.text,// 42
    })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSecondaryColor,
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(top: 30, right: 15, left: 15, bottom: 160),
            child: SvgPicture.asset(
              "assets/general/store_brand_white.svg",
              color: Colors.white,
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                TextFormField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      labelText: "User Name",
                      labelStyle: TextStyle(color: Colors.white, fontSize: 15),
                      prefixIcon: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.white))),
                  controller: _user,
                ),
                Container(
                  height: 10,
                ),
                TextFormField(
                  style: TextStyle(color: Colors.white),
                  obscureText: passwordvisible1,
                  decoration: InputDecoration(
                      labelText: "Password",
                      labelStyle: TextStyle(color: Colors.white, fontSize: 15),
                      prefixIcon: Icon(
                        Icons.password,
                        color: Colors.white,
                      ),
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              passwordvisible1 = !passwordvisible1;
                            });
                          },
                          icon: Icon(
                            Icons.remove_red_eye_outlined,
                            color: Colors.white,
                          )),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.white)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.white))),
                  controller: _password,
                ),
                Container(
                  height: 10,
                ),
                TextFormField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      labelText: "Address",
                      labelStyle: TextStyle(color: Colors.white, fontSize: 15),
                      prefixIcon: Icon(
                        Icons.location_on,
                        color: Colors.white,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.white))),
                  controller: _address,
                ),
                Container(
                  height: 10,
                ),
                TextFormField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      labelText: "Payment Number",
                      labelStyle: TextStyle(color: Colors.white, fontSize: 15),
                      prefixIcon: Icon(
                        Icons.monetization_on_outlined,
                        color: Colors.white,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.white))),
                  controller: _payment,
                ),
                Container(
                  height: 10,
                ),
                TextFormField(
                  maxLength: 11,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      labelText: "Phone",
                      labelStyle: TextStyle(color: Colors.white, fontSize: 15),
                      prefixIcon: Icon(Icons.phone,color: Colors.white,),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.white)
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.white))),
                  controller: _phone,
                ),


              ],
            ),
          ),
          Container(
            height: 50,
            margin: EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: MaterialButton(
              onPressed: () async {
                try {
                  final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                    email: _user.text.trim(),
                    password: _password.text.trim(),
                  );
                  addUser();
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.success,
                    dialogBackgroundColor:Colors.white ,
                    animType: AnimType.rightSlide,
                    title: "Success",
                    desc: "Successful operation, your account has been added",
                    btnOkOnPress: () { Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>Login()));},
                    btnCancelOnPress: () {},
                  ).show();
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'weak-password') {
                    return AwesomeDialog(
                      context: context,
                      dialogType: DialogType.error,
                      dialogBackgroundColor:Colors.white ,
                      animType: AnimType.rightSlide,
                      title: "Error",
                      desc: "The password provided is too weak.",
                      btnOkOnPress: () {},
                      btnCancelOnPress: () {},
                    ).show();
                  } else if (e.code == 'email-already-in-use') {
                    return AwesomeDialog(
                      context: context,
                      dialogType: DialogType.error,
                      dialogBackgroundColor:Colors.white ,
                      animType: AnimType.rightSlide,
                      title: "Error",
                      desc: "The account already exists for that email.",
                      btnOkOnPress: () {},
                      btnCancelOnPress: () {},
                    ).show();
                  }
                } catch (e) {
                  print(e);
                }
              },
              child: Text(
                "Sign in",
                style: TextStyle(
                    color:kSecondaryColor,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
            height: 50,
            margin: EdgeInsets.only(left: 10, right: 10, top: 10),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: MaterialButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => Login()));

              },
              child: Text(
                "Cancel",
                style: TextStyle(
                    color: kSecondaryColor,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

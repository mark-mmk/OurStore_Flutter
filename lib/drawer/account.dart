import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants/themes.dart';

class account extends StatefulWidget {
  const account({super.key});

  @override
  State<account> createState() => _accountState();
}

class _accountState extends State<account> {
  @override
  List data = [];
  bool isLoading = true;

  getData() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("users")
        .where("id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
    await Future.delayed(Duration(seconds: 1));
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: kSecondaryColor,
        title: const Text(
          'My Account',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: isLoading == true
          ? Center(
              child: CircularProgressIndicator(color: kSecondaryColor),
            )
          : ListView(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 10, top: 20, bottom: 20),
                  child: Row(
                    children: [
                      Icon(
                        Icons.person,
                        color: Colors.black,
                        size: 30,
                      ),
                      Text(
                        " User Name : ${data[0]['Email']} ",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 10, top: 20, bottom: 20),
                  child: Row(
                    children: [
                      Icon(
                        Icons.monetization_on_outlined,
                        color: Colors.black,
                        size: 30,
                      ),
                      Text(
                        " Payment Account : ${data[0]['Payment Number']} ",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 10, top: 20, bottom: 20),
                  child: Row(
                    children: [
                      Icon(
                        Icons.email_outlined,
                        color: Colors.black,
                        size: 30,
                      ),
                      Text(
                        " Email : ${data[0]['Email']} ",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 10, top: 20, bottom: 20),
                  child: Row(
                    children: [
                      Icon(
                        Icons.phone,
                        color: Colors.black,
                        size: 30,
                      ),
                      Text(
                        " Mobile Number : ${data[0]['Phone']} ",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 10, top: 20, bottom: 20),
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        color: Colors.black,
                        size: 30,
                      ),
                      Text(
                        " Address : ${data[0]['Address']} ",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}

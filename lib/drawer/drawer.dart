import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ourstore/drawer/setting.dart';
import '../constants/themes.dart';
import '../login view/Login.dart';
import '../views/cart_page.dart';
import 'account.dart';

class drawer extends StatefulWidget {
  const drawer({super.key});

  @override
  State<drawer> createState() => _drawerState();
}

class _drawerState extends State<drawer> {
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
      backgroundColor: kSecondaryColor,
      body: isLoading == true
          ? Center(
              child: CircularProgressIndicator(color: Colors.white,),
            )
          : ListView(
              children: [
                Container(
                  padding: EdgeInsets.only(right: 15, left: 15, bottom: 5),
                  child: SvgPicture.asset(
                    "assets/general/store_brand_white.svg",
                    color: Colors.white,
                  ),
                ),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage: ExactAssetImage(
                    "assets/general/personal.jpeg",
                  ),
                  maxRadius: 140,
                ),
                Container(
                  padding: EdgeInsets.only(top: 10, bottom: 20),
                  child: Center(
                      child: Text(
                    "${data[0]['Email']}",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  )),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => account()));
                  },
                  child: Container(
                    padding: EdgeInsets.only(left: 15, top: 10, bottom: 10),
                    child: Row(
                      children: [
                        Icon(
                          Icons.key_rounded,
                          color: Colors.white,
                          size: 30,
                        ),
                        Text(
                          "  Account",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        Spacer(),
                        Icon(
                          Icons.navigate_next_sharp,
                          color: Colors.white,
                        ),
                        Container(
                          width: 25,
                        )
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => CardPage()));
                  },
                  child: Container(
                    padding: EdgeInsets.only(left: 15, top: 10, bottom: 10),
                    child: Row(
                      children: [
                        Icon(
                          Icons.shopping_bag,
                          color: Colors.white,
                          size: 30,
                        ),
                        Text(
                          "  My Orders",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        Spacer(),
                        Icon(
                          Icons.navigate_next_sharp,
                          color: Colors.white,
                        ),
                        Container(
                          width: 25,
                        )
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => settings()));
                  },
                  child: Container(
                    padding: EdgeInsets.only(left: 15, top: 10, bottom: 10),
                    child: Row(
                      children: [
                        Icon(
                          Icons.settings,
                          color: Colors.white,
                          size: 30,
                        ),
                        Text(
                          "  Settings",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        Spacer(),
                        Icon(
                          Icons.navigate_next_sharp,
                          color: Colors.white,
                        ),
                        Container(
                          width: 25,
                        )
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => Login()));
                  },
                  child: Container(
                    padding: EdgeInsets.only(left: 15, top: 10, bottom: 10),
                    child: Row(
                      children: [
                        Icon(
                          Icons.logout,
                          color: Colors.white,
                          size: 30,
                        ),
                        Text(
                          "  Logout",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        Spacer(),
                        Icon(
                          Icons.navigate_next_sharp,
                          color: Colors.white,
                        ),
                        Container(
                          width: 25,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

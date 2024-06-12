import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '+.dart';
import '../category/botton2.dart';
import '../category/local_mail.dart';
import '../constants/themes.dart';

class Details extends StatefulWidget {
  const Details({super.key});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  bool isLoading = true;
  List<QueryDocumentSnapshot> data = [];

  getData() async {
    QuerySnapshot querySnapshot =
    await FirebaseFirestore.instance.collection("Phone").get();
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

  Widget build(BuildContext context,) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kSecondaryColor,
        title: const Text(
          'Details Page',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 20, top: 10),
              child: local_mail1(getIndex: 0,),)
        ],
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: isLoading == true
          ? Center(
        child: CircularProgressIndicator(
          color: kSecondaryColor,
        ),
      )
          : SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 300,
              width: double.infinity,
              color: kLightBackground,
          child: Image.network(
            "${data[0]['url']}",),
            ),
            Container(
              padding: const EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${data[0]['Name_Product']}",
                    style: AppTheme.kBigTitle.copyWith(color: kPrimaryColor),
                  ),
                  const Gap(12),
                  const Gap(8),
                  Text( "${data[0]['longDescription']}",),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "\$${data[0]['Price']}",
                        style: AppTheme.kHeadingOne,
                      ),
                      Container(
                        child: pluse(getIndex: 0,),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: kSecondaryColor,
                        minimumSize: const Size(double.infinity, 50)),
                    onPressed: () {
                    },
                    child: botton2(getIndex: 0,),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}



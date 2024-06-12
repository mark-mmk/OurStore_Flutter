import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../category/local_mail.dart';
import '../constants/themes.dart';
import 'botton.dart';
import 'Details.dart';

class Headsets extends StatefulWidget {
  const Headsets({super.key});

  @override
  State<Headsets> createState() => _HeadsetsState();
}

class _HeadsetsState extends State<Headsets> {
  @override
  bool isLoading = true;
  List<QueryDocumentSnapshot> data = [];

  getData() async {
    QuerySnapshot querySnapshot =
    await FirebaseFirestore.instance.collection("Headsets").get();
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
      appBar: AppBar(
        backgroundColor: kSecondaryColor,
        title: const Text(
          'Headsets',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
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
          : ListView(
        children: [
          Column(
            children: [
              GridView.builder(
                  itemCount: data.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, mainAxisExtent: 360),
                  itemBuilder: (context, i) {
                    return Container(
                      decoration: BoxDecoration(
                        color: kWhiteColor,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                              offset: const Offset(0, 6),
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                              spreadRadius: 2),
                        ],
                      ),
                      margin: const EdgeInsets.all(12),
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Column(
                        children: [
                          InkWell(
                            child: Container(
                              width: double.infinity,
                              margin: const EdgeInsets.all(12),
                              color: kLightBackground,
                              child: Image.network(
                                "${data[i]['url']}",
                              ),
                            ),
                            onTap: (){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Details()));
                            },
                          ),
                          const Gap(4),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14),
                            child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${data[i]['Name_Product']}",
                                    style: AppTheme.kCardTitle,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    "${data[i]['shortDescription']}",
                                    style: AppTheme.kBodyText,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "\$${data[i]['Price']}",
                                        style: AppTheme.kCardTitle,
                                      ),
                                      Container(
                                        child: botton(productIndex: i),
                                      )
                                    ],
                                  )
                                ]),
                          ),
                        ],
                      ),
                    );
                  })
            ],
          )
        ],
      ),
    );
  }
}

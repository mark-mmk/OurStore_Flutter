import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../constants/themes.dart';

class HeadsetsDelete extends StatefulWidget {
  const HeadsetsDelete({super.key});

  @override
  State<HeadsetsDelete> createState() => _HeadsetsDeleteState();
}

class _HeadsetsDeleteState extends State<HeadsetsDelete> {
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
          'Headsets Admin',
          style: TextStyle(color: Colors.white),
        ),
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
                                      IconButton(onPressed: ()async{
                                        await AwesomeDialog(
                                          context: context,
                                          dialogType: DialogType.warning,
                                          animType: AnimType.rightSlide,
                                          title: "Warning",
                                          desc: "Delete Items",
                                          btnOkOnPress: () {FirebaseFirestore.instance.collection("Headsets").doc(data[i].id).delete();
                                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>HeadsetsDelete()));},
                                          btnCancelOnPress: () {},
                                        ).show();
                                      } , icon: Icon(Icons.delete,color: Colors.red,)),
                                    ],
                                  ),
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

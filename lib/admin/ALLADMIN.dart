import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:ourstore/admin/HeadsetsAdmin.dart';

import 'package:path/path.dart';

import '../constants/themes.dart';
import '../login view/Login.dart';
import 'PhoneAdmin.dart';
import 'admin.dart';

class alladmin extends StatefulWidget {
  const alladmin({super.key});

  @override
  State<alladmin> createState() => _alladminState();
}

class _alladminState extends State<alladmin> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => Login()));
            },
            icon: Icon(CupertinoIcons.back)),
        backgroundColor: kSecondaryColor,
        title: Text("Admin",style: TextStyle(color: Colors.white),),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(top: 10, left: 20),
            child: Row(
              children: [
                Container(width: 10,),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => admin()));
                    },
                    child: Text("Computer")),
                Container(width: 15,),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => PhoneAdmin()));
                    },
                    child: Text("Phone")),
                Container(width: 15,),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => HeadsetsAdmin()));
                    },
                    child: Text("Headsets"))
              ],
            ),
          ),
        ],
      ),
    );
  }
}

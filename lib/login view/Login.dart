
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../admin/ALLADMIN.dart';
import '../constants/themes.dart';
import '../views/home_page.dart';
import 'Register.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  final _user = TextEditingController();
  final _password = TextEditingController();
  bool passwordvisible = true;

  Future signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential);
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSecondaryColor,
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(top: 30, right: 15, left: 15, bottom: 160),
            child: SvgPicture.asset("assets/general/store_brand_white.svg",color: Colors.white,),
          ),
          Container(
            padding: EdgeInsets.only(left: 10,right: 10,top: 20),
            child: Column(
              children: [
                TextFormField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      labelText: "Email",
                      labelStyle: TextStyle(color: Colors.white, fontSize: 15),
                      prefixIcon: Icon(Icons.person,color: Colors.white,),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.white)
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.white))),
                  controller: _user,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your Email";
                    }
                  },
                ),
                Container(
                  height: 10,
                ),
                TextFormField(
                  style: TextStyle(color: Colors.white),
                  obscureText: passwordvisible,
                  decoration: InputDecoration(
                      labelText: "Password",
                      labelStyle: TextStyle(color: Colors.white, fontSize: 15),
                      prefixIcon: Icon(Icons.password,color: Colors.white,),
                      suffixIcon: IconButton(onPressed: (){
                         setState(() {
                           passwordvisible = !passwordvisible;
                         });
                      }, icon: Icon(Icons.remove_red_eye_outlined,color: Colors.white,)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.white)
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.white))),
                  controller: _password,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your Password";
                    }
                  },
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 15, bottom: 10,top: 10),
            child: Row(
              children: [
                Spacer(),
                InkWell(
                  child: Text("Forget Password",style: TextStyle(color: Colors.white),),
                  onTap: () {
                    FirebaseAuth.instance
                        .sendPasswordResetEmail(email: _user.text);
                  },
                ),
              ],
            ),
          ),
          Container(
            height: 50,
            margin: EdgeInsets.only(left: 10, right: 10,bottom: 10),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: MaterialButton(
              onPressed: () async {
                 if(_user.text.trim() =="admin" && _password.text.trim() =="12345678"){
                 await Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => alladmin()));
                }
                try {
                  final credential =
                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: _user.text.trim(),
                    password: _password.text.trim(),
                  );
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => HomePage()));
                } on FirebaseAuthException catch (e) {
                  return AwesomeDialog(
                    context: context,
                    dialogType: DialogType.error,
                    dialogBackgroundColor:Colors.white ,
                    animType: AnimType.rightSlide,
                    title: "Error",
                    desc: "Please enter your correct email and password.",
                    btnOkOnPress: () {},
                    btnCancelOnPress: () {},
                  ).show();
                }
              },
              child: Text(
                "Login",
                style: TextStyle(
                    color: kSecondaryColor,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
            height: 50,
            margin: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 20),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: MaterialButton(
              onPressed: () {
                signInWithGoogle();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Login With Google",
                    style: TextStyle(
                        color: kSecondaryColor,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have Account ?",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                InkWell(
                  child: Text(
                    " Register",
                    style: TextStyle(color: Colors.red, fontSize: 20),
                  ),
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => Register()));
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

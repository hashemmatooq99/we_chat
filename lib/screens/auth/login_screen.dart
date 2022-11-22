// ignore_for_file: unused_element

import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:we_chat/main.dart';
import 'package:we_chat/screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool _isAnimat = false;
  @override
  void initState() {
    _isAnimat = false;
    super.initState();
    Future.delayed(const Duration(milliseconds: 150), ()
    {
      setState((){
        _isAnimat = true;
      });
    });
}

_handleGoogleBtnClick(){
     _signInWithGoogle().then((user) {
      if(user != null){
       log('\nUser : ${user.user}');
       log('\nUserAdditionalInfo :${user.additionalUserInfo}');
        Navigator.pushReplacement(context,
         MaterialPageRoute(builder: (_) => HomeScreen())
      );
      }
     });
    }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          elevation: 80,
          shape: BeveledRectangleBorder(),
          title: const Text('No Internet Connection  !!!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('To Login Please Connect To Internet ...'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

Future<UserCredential?> _signInWithGoogle() async {
 // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );
  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}

 _signOut() async
 {
await FirebaseAuth.instance.signOut();
await GoogleSignIn().signOut();
 }

  _Connected()
  async {
    bool result = await InternetConnectionChecker().hasConnection;
    if(result == true) {
      print('متصل بالانترنت');
      _handleGoogleBtnClick();
    } else {
      _showMyDialog();
      print('غير متصل بالانترنت');
    }
  }

  @override
  Widget build(BuildContext context) {
        mq = MediaQuery.of(context).size;
    return Scaffold(
     appBar: AppBar(
      automaticallyImplyLeading: false,
      title: const Text('Welcome To We Chat 🔥',
      style: TextStyle(
        fontWeight: FontWeight.bold
      ),),
     ),
     body: Stack(children: [
      AnimatedPositioned 
      (
        top: mq.height * .12,
        right: _isAnimat ? mq .width * .06 : - mq.width * .5,
        width: mq.width * .9,
        duration: const Duration(
          milliseconds : 300,
         ),
        child: 
      Image.asset(
        'assets/images/log-in.png',
        )
        ),
        Positioned
      (
        bottom: mq.height * .15,
        width: mq.width * .6,
        left: mq.width * .22,
        height: mq.height * .08,
        child:
      ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          shape: const StadiumBorder()
        ),
        onPressed: ()  {
          _Connected();
        },
       icon:  Image.asset('assets/images/google.png'),
        label: const Text('Sign in With Google',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15
        ),),
        )
        ),
     ]),
    );
  }
}

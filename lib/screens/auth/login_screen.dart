
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:we_chat/%D9%90APIs/APIs.dart';
import 'package:we_chat/main.dart';
import 'package:we_chat/screens/home_screen.dart';

import '../../helper/Show_Progressbar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool _isAnimat = false;

  @override
  // to make animation in login screen image
  void initState()
  {
    _isAnimat = false;
    super.initState();
    Future.delayed(const Duration(milliseconds: 150), ()
    {
      setState((){
        _isAnimat = true;
      });
    });
}

  //to call _signInWithGoogle FUNCTION & print user info
  _handleGoogleBtnClick()
  {
    Dialogs.showProgressBar(context); //loading circle bar
     _signInWithGoogle().then((user) {
       Navigator.pop(context);
      if(user != null){
       log('\nUser : ${user.user}');
       log('\nUserAdditionalInfo :${user.additionalUserInfo}');
        Navigator.pushReplacement(context,
         MaterialPageRoute(builder: (_) => HomeScreen())
      );
      }
     });
    }

// to show message box alert telling user to fix internet connection

// function to check & signing in with google email
  Future<UserCredential?> _signInWithGoogle() async
  {
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
  return await API.auth.signInWithCredential(credential);
}

// function to to check internet connection & sign in

  @override
  Widget build(BuildContext context) {
//var to control object position in screen
    mq = MediaQuery.of(context).size;
    return Scaffold(
     appBar: AppBar
       (
       centerTitle: true,
      backgroundColor: Colors.black,
      automaticallyImplyLeading: false,
      title: const Text('Welcome To We Chat 🔥',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white
      ),),
     ),
     body: Container(
       color: Colors.black,
       child: Stack(
           children: [
//animation properties
        AnimatedPositioned
        (
          top: mq.height * .12,
          right: _isAnimat ? mq .width * .06 : - mq.width * .5,
          width: mq.width * .9,
          duration: const Duration
            (
            milliseconds : 300,
           ),
          child:
        Image.asset
          (
          'assets/images/log-in.png',
          )
          ),
//Animation Positioned
             //google login button
             Positioned(
                 bottom: mq.height * .15,
                 left: mq.width * .05,
                 width: mq.width * .9,
                 height: mq.height * .08,
                 child: ElevatedButton.icon(
                   style: ElevatedButton.styleFrom(
                       backgroundColor: Colors.black,
                       shape: const StadiumBorder(),
                       elevation: 1),
                   onPressed: () {
                     _handleGoogleBtnClick();
                   },
         icon:  Image.asset('assets/images/google.png'),
          label: const Text
            ('Sign In With Google',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13
          ),),
          )
          ),
       ]),
     ),
    );
  }
}
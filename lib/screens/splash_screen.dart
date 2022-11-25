import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:we_chat/main.dart';
import 'package:we_chat/screens/auth/login_screen.dart';
import 'package:we_chat/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    //Timeout for screen 2 second
    Future.delayed(const Duration(seconds: 2), ()
    {
      //to check user is login or not
      if (FirebaseAuth.instance.currentUser != null)
        {
          log('\nUser : ${FirebaseAuth.instance.currentUser}');
          log('\nUserAdditionalInfo :${FirebaseAuth.instance.currentUser}');
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ));
        }
      else
      {
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ));
      }
    });

  }
  @override
  Widget build(BuildContext context) {
    //to use perfect position
        mq = MediaQuery.of(context).size;
    return Scaffold(
     body: Container(
       color: Colors.black,
       child: Stack(children: [
         // photo position
        Positioned
        (
          top: mq.height * .20,
          right:  mq .width * .06,
          width: mq.width * .9,
          child:
              //photo link
        Image.asset(
          'assets/images/chat.png',
          )
          ),
          // text position & properties
          Positioned
        (
          bottom: mq.height * .20,
          // width: mq.width * .30,
          left: mq.width * .15,
          child:Text('MADE BY HASHEM ❤️',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: .8,
            color: Colors.white
          ),) ,
          )
       ]),
     ),
    );
  }
}
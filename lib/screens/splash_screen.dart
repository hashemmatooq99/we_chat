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
    Future.delayed(const Duration(milliseconds: 5000), ()
    {
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ));
    });

  }
  @override
  Widget build(BuildContext context) {
        mq = MediaQuery.of(context).size;
    return Scaffold(
     body: Stack(children: [
      Positioned 
      (
        top: mq.height * .20,
        right:  mq .width * .06,
        width: mq.width * .9,
        child: 
      Image.asset(
        'assets/images/chat.png',
        )
        ),
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
        ),) ,
        )
     ]),
    );
  }
}
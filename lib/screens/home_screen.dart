import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:we_chat/helper/Show_Progresbar.dart';
import 'package:we_chat/screens/auth/login_screen.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // to create signOut function
   _signOut() async
   {
     await FirebaseAuth.instance.signOut();
     await GoogleSignIn().signOut();
     Navigator.pushReplacement(context,
         MaterialPageRoute(builder: (_) => LoginScreen()));
   }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Scaffold(
       appBar: AppBar(
        leading: const Icon (CupertinoIcons.home),
        title: Text('We Chat🔥'),
        actions: [
          IconButton( //this button for search
            onPressed: () {
              Dialogs.showProgressBar(context);
              _signOut();
            },
            icon: const Icon(Icons.search),
          ),
          IconButton( //this button for profile screen
            onPressed: () {},
            icon: const Icon(Icons.person),
          ),
        ],
       ),
       floatingActionButton: Padding ////this button for add person to chat
       (
         padding: const EdgeInsets.only(bottom: 10),
         child: FloatingActionButton(
          onPressed: () {},
         child: const Icon(Icons.add_comment_sharp),
         ),
       ),
      ),
    );
  }
}
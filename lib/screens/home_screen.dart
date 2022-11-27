import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:we_chat/%D9%90APIs/APIs.dart';
import 'package:we_chat/helper/Show_Progressbar.dart';
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
     await API.auth.signOut();
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
        body: StreamBuilder(
          stream: API.fireStore.collection('users').snapshots(),
          builder: (context, snapshot)
              {
                final list = [];
                if (snapshot.hasData)
                  {
                    final data = snapshot.data?.docs;
                    for (var i in data!)
                      {
                        log ('Data ${i.data()}');
                        list.add(i.data()['name']);
                      }
                  }
                return ListView.builder
                  (
                    itemCount: list.length,
                    padding: EdgeInsets.only(top: 5),
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index)
                    {
                      //return ChatUserCard();
                      return Text('Name : ${list[index]} ');
                    });
              }
        ),
      ),
    );
  }
}
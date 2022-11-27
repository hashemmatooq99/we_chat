import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:we_chat/%D9%90APIs/APIs.dart';
import 'package:we_chat/helper/Show_Progressbar.dart';
import 'package:we_chat/screens/auth/login_screen.dart';
import '../models/chat_user.dart';
import '../widgets/chat_user_card.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
   List<ChatUser> list = [];

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
            icon: const Icon(Icons.output),
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
                switch(snapshot.connectionState)
                {
                  case ConnectionState.waiting:
                  case ConnectionState.none:
                    return const Center(child: CircularProgressIndicator(),);
                    //...............................................................
                  case ConnectionState.active:
                  case ConnectionState.done:
                    final data = snapshot.data?.docs;
                    list = data?.map((e) => ChatUser.fromJson(e.data())).toList() ?? [];
                 if (list.isNotEmpty)
                   {
                     return ListView.builder
                       (
                         itemCount: list.length,
                         padding: EdgeInsets.only(top: 5),
                         physics: BouncingScrollPhysics(),
                         itemBuilder: (context, index)
                         {
                           return ChatUserCard(user: list[index]);
                           // return Text('Name : ${list[index]} ');
                         });
                   }
                 else
                   {
                     return Center(child: Text('No connection Found !!! \n     Connect Please ❤️',
                     style: TextStyle(
                       fontWeight: FontWeight.bold,
                       fontSize: 20
                     ),));
                   }
                }
              }
        ),
      ),
    );
  }
}
import 'package:flutter/cupertino.dart';import 'package:flutter/material.dart';class ChatUserCard extends StatefulWidget {  const ChatUserCard({Key? key}) : super(key: key);  @override  State<ChatUserCard> createState() => _ChatUserCardState();}class _ChatUserCardState extends State<ChatUserCard> {  @override  Widget build(BuildContext context) {    return Card(      margin: EdgeInsets.symmetric(horizontal: 15,      vertical: 5,),      //color: Colors.blue.shade100,      elevation: 0.5,      shape: RoundedRectangleBorder(        borderRadius: BorderRadius.circular(15)      ),      child: InkWell(        onTap: (){},        child: ListTile(          leading: CircleAvatar(            child: Icon(CupertinoIcons.person),          ),          title: Text('Demo Message'),          subtitle: Text('Last User Message',          maxLines: 1,),          trailing: Text('12:00 PM',style:            TextStyle(              color: Colors.black54            ),),        ),      ),    );  }}
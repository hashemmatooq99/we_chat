import 'package:flutter/material.dart';class Dialogs {  // to make loading bar (circle)  static void showProgressBar (BuildContext context)  {    showDialog(context: context, builder: (_) =>    const Center(child:  CircularProgressIndicator()));  }}
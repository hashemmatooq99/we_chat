import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:we_chat/screens/splash_screen.dart';
import 'firebase_options.dart';


//global object for accessing device screen size
late Size mq; 

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  _initializeFirebase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'We Chat 💬',
      theme: ThemeData(
        appBarTheme: const AppBarTheme( 
        elevation: 1,
        iconTheme: IconThemeData(
          color: Colors.black
        ),
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 19,
          color: Colors.black
        ),
        backgroundColor: Colors.white
      ),
      ),
      home:const SplashScreen(),
    );
  }
}

_initializeFirebase() async {
await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
}
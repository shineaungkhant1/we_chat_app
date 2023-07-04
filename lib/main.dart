import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:we_chat_app/pages/moment_page.dart';
import 'package:we_chat_app/pages/start_up_page.dart';
import 'package:we_chat_app/viewitems/bottom_nav_bar_view.dart';

import 'data/models/authentication_model_impl.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();


  runApp(MyApp());
}

class MyApp extends StatefulWidget {


   const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _authenticationModel = AuthenticationModelImpl();

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WeChat App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor:const Color.fromRGBO(249, 249, 249, 1) ,
        appBarTheme:const AppBarTheme(backgroundColor: Colors.white)
      ),
      home: (_authenticationModel.isLoggedIn())?const BottomNavBarView():const StartUpPage(),
    );
  }
}



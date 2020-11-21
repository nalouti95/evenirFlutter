import 'dart:ui';

import 'package:evenirproject/intro.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

    theme: ThemeData(
      scaffoldBackgroundColor: const Color(0xFF372B4B),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      primaryColor: const Color(0xFF95DEDE),
      accentColor: const Color(0xFFE3F6F5),
      brightness: Brightness.dark,
      textTheme: TextTheme(
        headline1: TextStyle(fontSize: 72.0,fontWeight: FontWeight.bold),
        headline5: TextStyle(fontSize: 40.0,fontWeight: FontWeight.bold),
        headline6: TextStyle(fontSize: 31.0, fontStyle: FontStyle.italic),
        bodyText1: TextStyle(

          fontSize: 20.0,
        ),
        bodyText2: TextStyle(
          fontSize: 18.0,
        ),
      ),
    ),

      home: IntroPage() ,
      debugShowCheckedModeBanner: false ,

    );
  }
}







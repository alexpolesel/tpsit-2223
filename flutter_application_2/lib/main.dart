import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'layouts/homePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
      scaffoldBackgroundColor: Color.fromARGB(255, 34, 34, 34),
      textTheme: TextTheme(
      bodyText1: TextStyle(color: Color.fromARGB(255, 29, 28, 28)))),
      home: homePage(),
    );
  }
}

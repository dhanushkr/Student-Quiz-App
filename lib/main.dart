import 'package:flutter/material.dart';
import './splash.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Quizstar",
      theme: ThemeData(
        primaryColor: Colors.redAccent,
      ),
      home: splashscreen(),
    );
  }
}
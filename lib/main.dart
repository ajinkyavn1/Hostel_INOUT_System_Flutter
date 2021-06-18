import 'package:flutter/material.dart';
import 'package:flutter_firebase_demo/HomePage.dart';
import 'package:flutter_firebase_demo/Login.dart';
import 'package:flutter_firebase_demo/Store.dart';
import 'package:flutter_firebase_demo/brain.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  // This widget is the root of your application.
  static Future init() async {
    Brain.localStorage = await SharedPreferences.getInstance();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home:Brain.localStorage!=null?HomePage():LoginPage(),
    );
  }
}
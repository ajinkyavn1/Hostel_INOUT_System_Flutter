import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class HomePage extends StatefulWidget {


  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var email;
  var password;

  FirebaseUser get user => null;

@override
  void initState()async {
    // TODO: implement initState
 final user=await FirebaseAuth.instance.currentUser();
  }
  @override
  Widget build(BuildContext context) {
  FirebaseUser User=user;
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(title: Text("Home Page${User.uid}"),centerTitle: true,),
      body: SingleChildScrollView(
        child: Center(

          child:Column(

            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("jasgsj")

                   ],
      ),
    ),
      ),
    );
  }
}

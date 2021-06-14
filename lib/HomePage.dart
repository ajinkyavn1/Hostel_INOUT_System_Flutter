import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class HomePage extends StatefulWidget {


  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var status;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(title: Text("Home Page"),centerTitle: true,),
      body: SingleChildScrollView(
        child: Center(

          child:Column(

            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              TextFormField(
                onChanged: (value){
                  status=value;
                },
                decoration: InputDecoration(
                  labelText: "Status",
                  border:OutlineInputBorder(),
                ),
              )

                   ],
      ),
    ),
      ),
    );
  }

}

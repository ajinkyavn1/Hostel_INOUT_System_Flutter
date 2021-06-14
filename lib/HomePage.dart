import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _from=GlobalKey<FormState>();
  final _auth=FirebaseAuth.instance;
  var email;
  var password;
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
              Image.network("https://t3.ftcdn.net/jpg/01/22/71/96/240_F_122719641_V0yw2cAOrfxsON3HeWi2Sf4iVxhv27QO.jpg",),

                   ],
      ),
    ),
      ),
    );
  }
}

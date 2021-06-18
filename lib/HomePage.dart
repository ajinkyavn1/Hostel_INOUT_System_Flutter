import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
import 'package:flutter_firebase_demo/Login.dart';
import 'package:flutter_firebase_demo/brain.dart';

import 'main.dart';

class HomePage extends StatefulWidget {


  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String uuid;
  String result = "Hey Welcome To GPJ";
    //  FirebaseUser user;

  Future _scanQR() async {
    try {
      String qrResult = await BarcodeScanner.scan();
      load(qrResult);
      setState(() {
      });
    } on PlatformException catch (ex) {
      if (ex.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          result = "Camera permission was denied";
        });
      } else {
        setState(() {
          result = "Unknown Error $ex";
        });
      }
    } on FormatException {
      setState(() {
        result = "You pressed the back button before scanning anything";
      });
    } catch (ex) {
      setState(() {
        result = "Unknown Error $ex";
      });
    }
  }
  void initState() {
    initialize();
    super.initState();
  }

  void initialize()async{
    //user= await FirebaseAuth.instance.currentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GPJ HOSTEL GATE Verification"),
        actions: [
          IconButton(
            onPressed:() {
              FirebaseAuth.instance.signOut();
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (builder)=>LoginPage()));
            },
            icon: Icon(Icons.logout),)
        ],
      ),
      body: Row(
        children: [
          Text(
            result,
            style: new TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.camera_alt),
        label: Text("Scan"),
        onPressed: _scanQR,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void load(String qrResult) async{
    if(Brain.localStorage.get("status")==qrResult) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("You Are Already${qrResult}")));
    }else {
      if(qrResult=="IN")
      {
        final user = await FirebaseAuth.instance
            .currentUser();

        await FirebaseDatabase.instance
            .reference()
            .child("Hostel")
            .child("Users")
            .child(user.uid)
            .update({'status': 'IN'});
        await MyApp.init();
        Brain.localStorage.setString('status', "IN");
      }
      if(qrResult=="OUT")
      {
        final user = await FirebaseAuth.instance
            .currentUser();
        print("1");
        await FirebaseDatabase.instance
            .reference()
            .child("Hostel")
            .child("Users")
            .child(user.uid)
            .update({'status': 'OUT'});
        await MyApp.init();
        Brain.localStorage.setString('status', "OUT");
      }
    }
  }
}
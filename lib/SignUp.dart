import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:flutter_firebase_demo/HomePage.dart';
import 'package:flutter_firebase_demo/main.dart';

import 'brain.dart';
class SignUPPage extends StatefulWidget {
  @override
  _SignUPPageState createState() => _SignUPPageState();
}

class _SignUPPageState extends State<SignUPPage> {
  final _from = GlobalKey<FormState>();
  final app = FirebaseApp.instance;
  final _realtime = FirebaseDatabase.instance.reference();
  var email;
  var password;
  var mobail;
  var RoomNo;

  var name;

  var Branch;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(title: Text("Signup Page"), centerTitle: true,),
      body: SingleChildScrollView(
        reverse: true,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Form(
                key: _from,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("SignUp", style: TextStyle(fontSize: 40,
                            color: Colors.green,
                            fontWeight: FontWeight.bold),),
                        SizedBox(height: 20,),
                        TextFormField(
                          onChanged: (value) {
                            name = value;
                          },
                          style: TextStyle(fontWeight: FontWeight.bold),
                          validator: (value) {
                            if (value == null && value.isEmpty) {
                              return 'Please Enter Full Name ';
                            }
                            else
                              return null;
                          },
                          decoration: InputDecoration(
                            labelText: "Full Name",
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 20,),
                        TextFormField(
                          onChanged: (value) {
                            email = value;
                          },
                          style: TextStyle(fontWeight: FontWeight.bold),
                          validator: (value) {
                            if (value == null && value.isEmpty) {
                              return 'Please Enter Email';
                            }
                            else
                              return null;
                          },
                          decoration: InputDecoration(
                            labelText: "Email",
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(height: 15,),
                        TextFormField(
                          onChanged: (value) {
                            password = value;
                          },
                          obscureText: true,
                          style: TextStyle(fontWeight: FontWeight.bold),
                          decoration: InputDecoration(

                            labelText: "Password",
                            border: OutlineInputBorder(),
                          ),
                          validator:
                              (value) {

                          },
                        ),

                        SizedBox(height: 15,),
                        TextFormField(
                          onChanged: (value) {
                            mobail = value;
                          },
                          style: TextStyle(fontWeight: FontWeight.bold),
                          decoration: InputDecoration(

                            labelText: "Enter mobile Number",
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null && value.isEmpty) {
                              return 'Please Enter Mobile';
                            }
                            else
                              return null;
                          },
                          keyboardType: TextInputType.number,
                          maxLength: 10,
                        ),
                        SizedBox(height: 15,),
                        TextFormField(
                          onChanged: (value) {
                            RoomNo = value;
                          },
                          style: TextStyle(fontWeight: FontWeight.bold),
                          decoration: InputDecoration(

                            labelText: "Enter Room Number",
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null && value.isEmpty) {
                              return 'Please Enter Mobile';
                            }
                            else
                              return null;
                          },
                          keyboardType: TextInputType.number,
                          maxLength: 3,
                        ),
                        SizedBox(height: 15,),
                        TextFormField(
                          onChanged: (value) {
                            Branch = value;
                          },
                          style: TextStyle(fontWeight: FontWeight.bold),
                          decoration: InputDecoration(

                            labelText: "Enter Branch",
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null && value.isEmpty) {
                              return 'Please Branch';
                            }
                            else
                              return null;
                          },

                        ),
                        SizedBox(height: 15,),
                        ElevatedButton(
                            onPressed: () async {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Registering....")));
                              final signedInUser = await FirebaseAuth.instance
                                  .createUserWithEmailAndPassword(
                                  email: email, password: password);


                              if (signedInUser != null) {
                                final user = await FirebaseAuth.instance
                                    .currentUser();
                                _realtime.child("Hostel").child("Users").child(
                                    user.uid).set({
                                  'email': email,
                                  'Name': name,
                                  'Branch':Branch,
                                  'RoomNo': RoomNo,
                                  'Mobail': mobail,
                                  'status': 'IN'
                                });
                                save(email,user.uid,"Logedin");
                                Navigator.pop(context);
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => HomePage()));

                              }
                            },
                            child: Text("Register")
                        ),
                        SizedBox(height: 10,),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("Already Have Account !")
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

        ),
      ),

    );
  }

  void save(String uuid,String email,String e) async {
    await MyApp.init();
    Brain.localStorage.setString('email', email);
    Brain.localStorage.setString('uuid', uuid);
    Brain.localStorage.setString('islogedin', e);
  }
}
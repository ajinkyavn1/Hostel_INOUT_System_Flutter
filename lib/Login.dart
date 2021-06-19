import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_demo/Admin_Login.dart';
import 'package:flutter_firebase_demo/HomePage.dart';
import 'package:flutter_firebase_demo/SignUp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_demo/StudentRecord.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';

import 'brain.dart';
import 'main.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _auth=FirebaseAuth.instance;
final _from=GlobalKey<FormState>();
var email;
var password;

  Map userData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){

                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder:(context)=>AdminLoginPage()));
        },
        label: Text("ADMIN LOGIN"),
        icon: Icon(Icons.login),
      ),
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(title: Text("Student LoginPage"),centerTitle: true,),
      body: SingleChildScrollView(
        reverse: true,
        child: Center(
         child:Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 55,),
              Image.asset("assets/logo/logo.png"),
              SizedBox(height: 25,),
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
                        Text("Login",style: TextStyle(fontSize:40,color: Colors.green,fontWeight: FontWeight.bold),),
                        SizedBox(height: 25,),
                        TextFormField(
                          onChanged: (value){
                            email=value;
                          },
                          style: TextStyle(fontWeight: FontWeight.bold),
                          validator: (value){
                            if(value==null && value.isEmpty)
                            {
                              return 'Please Enter Username';
                            }
                            else return null;
                          },
                          decoration: InputDecoration(
                            labelText: "UserName",
                            border:OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 15,),
                        TextFormField(
                          onChanged: (value){
                            password=value;
                          },
                          obscureText: true,
                          style: TextStyle(fontWeight: FontWeight.bold),
                          decoration: InputDecoration(

                            labelText: "Password",
                            border:OutlineInputBorder(),
                          ),
                          validator: (value){
                            if(value==null && value.isEmpty)
                            {
                              return 'Please Enter Password';
                            }
                            else return null;
                          },
                        ),
                        SizedBox(height: 15,),
                        ElevatedButton(
                            onPressed: (){
                              if((_from.currentState.validate())){
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(content: Text('Signing In')));
                                 _auth.signInWithEmailAndPassword(email: email, password: password).then((SignInUser) async {
                                   final user=await _auth.currentUser();
                                   FirebaseDatabase.instance.reference().child("Hostel").child("Users").child(user.uid).once().then((DataSnapshot data){
                                     userData=data.value;
                                   });
                                   await save(userData);
                                   Navigator.pop(context);
                                   Navigator.push(context, MaterialPageRoute(builder:(context)=>HomePage()));
                                 });

                              }
                            },
                            child:Text("SignIn")
                        ),
                        SizedBox(height: 10,),
                        ElevatedButton(
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder:(context)=>SignUPPage()));
                            },
                            child:Text("SignUp")
                        ),
                      ],
                    ),
                ),
              ),
             ),
              // SizedBox(height:10,),
            ],
          ),

        ),
      ),

    );
  }

  void save(Map user) async {
    await MyApp.init();
    print(user['status']);
    Brain.localStorage.setString('email',user['email']);
    Brain.localStorage.setString('name',user['Name']);
    Brain.localStorage.setString('Branch',user['Branch']);
    Brain.localStorage.setString('RoomNo',user['RoomNo']);
    Brain.localStorage.setString('status',user['status']);
  }
}

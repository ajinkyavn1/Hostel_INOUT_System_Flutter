import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:flutter_firebase_demo/HomePage.dart';
class SignUPPage extends StatefulWidget {
  @override
  _SignUPPageState createState() => _SignUPPageState();
}

class _SignUPPageState extends State<SignUPPage> {
  final _from=GlobalKey<FormState>();
  final _realtime=Firestore.instance;
  var email;
  var password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(title: Text("Signup Page"),centerTitle: true,),
      body: SingleChildScrollView(
        reverse: true,
        child: Center(
          child:Column(
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
                        Text("SignUp",style: TextStyle(fontSize:40,color: Colors.green,fontWeight: FontWeight.bold),),
                        SizedBox(height: 20,),
                        TextFormField(
                          onChanged: (value){
                            email=value;
                          },
                          style: TextStyle(fontWeight: FontWeight.bold),
                          validator: (value){
                            if(value==null && value.isEmpty)
                            {
                              return 'Please Enter Email';
                            }
                            else return null;
                          },
                          decoration: InputDecoration(
                            labelText: "Email",
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

                          },
                        ),

                        SizedBox(height: 15,),
                        TextFormField(
                          obscureText: true,
                          style: TextStyle(fontWeight: FontWeight.bold),
                          decoration: InputDecoration(

                            labelText: "Enter mobile Number",
                            border:OutlineInputBorder(),
                          ),
                          validator: (value){
                            if(value==null && value.isEmpty)
                            {
                              return 'Please Enter Mobile';
                            }
                            else return null;
                          },
                        ),
                        SizedBox(height: 15,),
                        TextFormField(
                          obscureText: true,
                          style: TextStyle(fontWeight: FontWeight.bold),
                          decoration: InputDecoration(

                            labelText: "Enter Room Number",
                            border:OutlineInputBorder(),
                          ),
                          validator: (value){
                            if(value==null && value.isEmpty)
                            {
                              return 'Please Enter Mobile';
                            }
                            else return null;
                          },
                        ),
                        SizedBox(height: 15,),
                        ElevatedButton(
                            onPressed: (){

                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("Registering....")));
                                    FirebaseAuth.instance.createUserWithEmailAndPassword(
                                    email: email, password: password)
                                        .then((signedInUser){
                                    _Firestore.collection('Users')
                                        .add({'email' : email, 'pass' : password,})
                                        .then((value){
                                    if (signedInUser!= null){
                                              Navigator.push(context, MaterialPageRoute(builder: (v)=>HomePage()));
                                            }
                                    })
                                        .catchError((e){
                                      print(e);
                                    })
                                    ;}
                                    )
                                        .catchError((e){
                                      print(e);
                                    });

                            },
                            child:Text("Register")
                        ),
                        SizedBox(height: 10,),
                        ElevatedButton(
                            onPressed: (){
                              Navigator.pop(context);
                            },
                            child:Text("Already Have Account !")
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
}

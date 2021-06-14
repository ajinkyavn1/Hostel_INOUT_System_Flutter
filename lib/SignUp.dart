import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase_demo/HomePage.dart';
class SignUPPage extends StatefulWidget {
  @override
  _SignUPPageState createState() => _SignUPPageState();
}

class _SignUPPageState extends State<SignUPPage> {
  final _from=GlobalKey<FormState>();
  final _Firestore=Firestore.instance;
  var email;
  var password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(title: Text("Signup Page"),centerTitle: true,),
      body: SingleChildScrollView(
        child: Center(

          child:Column(

            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network("https://t3.ftcdn.net/jpg/01/22/71/96/240_F_122719641_V0yw2cAOrfxsON3HeWi2Sf4iVxhv27QO.jpg",),
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

                          },
                        ),
                        // SizedBox(height: 15,),
                        // TextFormField(
                        //   obscureText: true,
                        //   style: TextStyle(fontWeight: FontWeight.bold),
                        //   decoration: InputDecoration(
                        //
                        //     labelText: "Enter mobile Number",
                        //     border:OutlineInputBorder(),
                        //   ),
                        //   validator: (value){
                        //     if(value==null && value.isEmpty)
                        //     {
                        //       return 'Please Enter Mobile';
                        //     }
                        //     else return null;
                        //   },
                        // ),
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

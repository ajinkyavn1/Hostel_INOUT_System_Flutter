import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

import 'Login.dart';

class StudentRecord extends StatefulWidget {
  const StudentRecord({Key key}) : super(key: key);

  @override
  _StudentRecordState createState() => _StudentRecordState();
}

class _StudentRecordState extends State<StudentRecord> {
  Query _ref;
  DatabaseReference reference =
  FirebaseDatabase.instance.reference().child("Hostel").child("Users");
  @override
  void initState() {
    super.initState();
    _ref = FirebaseDatabase.instance
        .reference()
        .child('Hostel')
        .child("Users");
  }

  Widget _buildContactItem({Map User}) {
    Color typeColor = Colors.red;
    return Card(
      elevation: 15,
        shadowColor: Colors.red,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)
        ),
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          padding: EdgeInsets.all(10),
          height: 150,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Row(
              children: [
                Icon(
                  Icons.person,
                  color: Colors.deepPurple,
                  size: 20,
                ),
                SizedBox(
                  width: 6,
                ),
                Text(
                  User['Name'],
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Icon(
                  Icons.phone_iphone,
                  color: Colors.black,
                  size: 20,
                ),
                SizedBox(
                  width: 6,
                ),
                Text(
                  User['Mobail'],
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(width: 15),
                Icon(
                  Icons.home,
                  color: Colors.green,
                  size: 20,
                ),
                SizedBox(
                  width: 6,
                ),
                Text(
                  User['RoomNo'],
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.bookmark,
                        color: Theme.of(context).primaryColor,
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Text(
                          User['status']=="IN"?"PRESENT IN HOSTEL":"ABSENT IN HOSTEL",
                          style: TextStyle(
                              fontSize: 16,
                              color: User['status']=="IN"?Colors.green:Colors.red,
                              fontWeight: FontWeight.w600)),

                    ],
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.home_repair_service_outlined,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Text(
                      User['Branch'],
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w600)),
                  ],
                ),

                SizedBox(
                  width: 20,
                ),
              ],
            ),
              SizedBox(
                width: 20,
              ),
              Row(
                children: [
                  Icon(
                    Icons.home_repair_service_outlined,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  Text(
                      User['email'],
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w600)),
                ],
              ),
              SizedBox(
                width: 20,
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Record'),
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
      body: Container(
        height: double.infinity,
        child: FirebaseAnimatedList(
          query: _ref,
          itemBuilder: (BuildContext context, DataSnapshot snapshot,
              Animation<double> animation, int index) {
            Map contact = snapshot.value;
            contact['key'] = snapshot.key;
            return _buildContactItem(User: contact);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {

          });
        },
        child: Icon(Icons.refresh, color: Colors.white),
      ),
    );
  }

}

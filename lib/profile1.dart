import 'dart:async';
import 'dart:ffi';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

import 'main_drawer.dart';
class Profile1 extends StatefulWidget {
  @override
  _Profile1State createState() => _Profile1State();
}

class _Profile1State extends State<Profile1> {
  final referenceDatabase = FirebaseDatabase.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  final username = TextEditingController();
  final usercollege = TextEditingController();
  final userlocation = TextEditingController();
  final userinterest = TextEditingController();
  //final userbmi = TextEditingController();
  final formkey = new GlobalKey<FormState>();
  String gender;

  void saveToDatabase(){
    final ref = referenceDatabase.reference();
    var data=
    {
      "username" : username.text.toString(),
      "usercollege" : usercollege.text.toString(),
      "userlocation" : userlocation.text.toString(),
      "usergender" : gender,
      "userinterest" : userinterest.text.toString(),
    };
    ref.child("User Data").child("Profile").set(data).whenComplete(() async{
      await Fluttertoast.showToast(msg: "Uploaded successfully",toastLength: Toast.LENGTH_SHORT,gravity: ToastGravity.BOTTOM ,backgroundColor: Colors.grey,textColor: Colors.white);

    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Profile"),
        centerTitle: true,
      ),
      drawer: MainDrawer(),
      body:SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 10.0,
        ),

        child: Form(
          key: formkey,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Tell us About Yourself ',style:TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold,color: Colors.black) ,),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: username,
                  validator: (String value){
                    if(value.isEmpty){
                      return 'This field cannot be empty';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Name',
                    hintText: 'Enter your Name',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: new Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new Text(
                        'Select your Gender',
                        style: Theme.of(context).textTheme.title,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children:<Widget> [

                      Radio(
                        value: 'Male',
                        groupValue: gender,
                        onChanged: (val){
                          gender = val;
                          setState(() {

                          });
                        },
                      ),
                      Text('Male'
                          ,style: TextStyle(fontSize: 18)),
                    ],
                  ),
                  Spacer(),
                  Row(
                    children:<Widget> [

                      Radio(
                        value: 'Female',
                        groupValue: gender,
                        onChanged: (val){
                          gender = val;
                          setState(() {

                          });
                        },
                      ),
                      Text('Female'
                          ,style: TextStyle(fontSize: 18)),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: usercollege,
                  validator: (String value){
                    if(value.isEmpty){
                      return 'This field cannot be empty';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'College',
                    hintText: 'Enter college name',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: userlocation,
                  validator: (String value){
                    if(value.isEmpty){
                      return 'This field cannot be empty';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Location',
                    hintText: 'Enter your location',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)
                    ),
                  ),
                ),
              ),


              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: RaisedButton(
                    child: Center(
                      child: ListTile(
                        leading: FaIcon(FontAwesomeIcons.upload),
                        title: Text('Save'),
                      ),
                    ),
                  color: Colors.deepOrange,
                  textColor: Colors.white,
                  splashColor: Colors.deepOrange,
                  padding: EdgeInsets.all(8.0),
                  onPressed: (){
                    if(formkey.currentState.validate()){
                      saveToDatabase();
                    }
                    //formkey.currentState.validate();
                    //getCurrentLocation();
                  },
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: TextFormField(
              //     controller: productcategory,
              //     validator: (String value){
              //       if(value.isEmpty){
              //         return 'This field cannot be empty';
              //       }
              //       return null;
              //     },
              //     decoration: InputDecoration(
              //       labelText: 'Product Category',
              //       hintText: 'Enter Product Category',
              //       border: OutlineInputBorder(
              //           borderRadius: BorderRadius.circular(20.0)
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),


    );
  }


}

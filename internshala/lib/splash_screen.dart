import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internshala/mainscreen.dart';

class splash_screen extends StatefulWidget{
  _splash_screenState createState()=>_splash_screenState();
}

class _splash_screenState extends State<splash_screen>{

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 2), () {
      // Navigate to the main screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => mainscreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: Colors.blueAccent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          Text("IS",style: TextStyle(color: Colors.white,fontSize: 40),)
        ]),
      ),
    );
  }

}
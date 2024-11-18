import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_covid_app/main.dart';
import 'package:flutter_covid_app/screen/registration.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  static const String KEYLOGIN = "Login";
  @override
  void initState() {
    super.initState();

    wherTOGo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          // color: Colors.white,
          gradient: LinearGradient(
            colors: [Colors.white, Color(0xFF418f9b)],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/img7.png',
              height: 500,
            ),
            // Icon(
            //   Icons.local_hospital_rounded,
            //   size: 400,
            //   color: Colors.red,
            // ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  void wherTOGo() async {
    var sharedpref = await SharedPreferences.getInstance();

    var isLoggedIn = sharedpref.getBool(KEYLOGIN);
    Timer(Duration(seconds: 2), () {
      if (isLoggedIn != null) {
        if (isLoggedIn) {
          Navigator.pushReplacement(
              context,
              // MaterialPageRoute(builder: (context) => Registration()),
              MaterialPageRoute(builder: (context) => MyHomePage(title: '')));
          // MaterialPageRoute(builder: (context) => Registration()));
        } else {
          Navigator.pushReplacement(
              context,
              // MaterialPageRoute(builder: (context) => Registration()),
              MaterialPageRoute(builder: (context) => Registration()));
        }
      } else {
        Navigator.pushReplacement(
          context,
          // MaterialPageRoute(builder: (context) => Registration()),
          MaterialPageRoute(builder: (context) => Registration()),
        );
      }
    });
  }
}


// Navigator.pushReplacement(
      //   context,
      //   // MaterialPageRoute(builder: (context) => Registration()),
      //   MaterialPageRoute(builder: (context) => Registration()),
      // );
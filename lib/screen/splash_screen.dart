import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_covid_app/screen/registration.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        // MaterialPageRoute(builder: (context) => Registration()),
        MaterialPageRoute(builder: (context) => Registration()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          // gradient: LinearGradient(
          //   colors: [Colors.white, Colors.red],
          //   begin: Alignment.topRight,
          //   end: Alignment.bottomLeft,
          // ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/icon.jpg',
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
}

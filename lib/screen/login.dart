import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_covid_app/screen/registration.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OnboardingScreen(),
    );
  }
}

class OnboardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                'assets/images/img1.png',
                height: height * 0.35,
              ),
              Column(
                children: [
                  Text(
                    "Let's get started",
                    style: TextStyle(
                      fontSize: width * 0.06,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: height * 0.02),
                  Text(
                    'Never a better time than now to start managing all your finances with ease.',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: width * 0.04,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              Column(
                children: [
                  // ElevatedButton(
                  //   onPressed: () {
                  //     Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (context) => registration()));
                  //   },
                  //   style: ElevatedButton.styleFrom(
                  //     backgroundColor: Color(0xFF418f9b),
                  //     padding: EdgeInsets.symmetric(
                  //       horizontal: width * 0.25,
                  //       vertical: height * 0.02,
                  //     ),
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(30.0),
                  //     ),
                  //   ),
                  //   child: Text(
                  //     'Create Account',
                  //     style: TextStyle(
                  //       fontSize: width * 0.045,
                  //       color: Colors.white,
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(height: height * 0.02),
                  // TextButton(
                  //   onPressed: () {},
                  //   child: Text(
                  //     'Login to Account',
                  //     style: TextStyle(
                  //       color: Color(0xFF418f9b),
                  //       fontSize: width * 0.04,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

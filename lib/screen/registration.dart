import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_covid_app/screen/otpscreen.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  TextEditingController phoneController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OnboardingScreen(phoneController: phoneController),
    );
  }
}

class OnboardingScreen extends StatefulWidget {
  final TextEditingController phoneController;

  OnboardingScreen({super.key, required this.phoneController});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'assets/images/img2.png',
                  height: height * 0.35,
                ),
                Column(
                  children: [
                    SizedBox(height: height * 0.02),
                    Text(
                      'Enter your phone number to Send OTP',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: width * 0.04,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                SizedBox(height: 100),
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Row(
                        children: [
                          Text(
                            '+91',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextField(
                              controller: widget.phoneController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Enter Phone Number',
                                  hintStyle: TextStyle(color: Colors.black38)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 50),
                    Column(
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            if (_isValidPhoneNumber(
                                widget.phoneController.text)) {
                              setState(() {
                                isLoading = true;
                              });
                              await _verifyPhoneNumber(context);
                              setState(() {
                                isLoading = false;
                              });
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text('Enter a valid number')));
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF418f9b),
                            padding: EdgeInsets.symmetric(
                              horizontal: width * 0.30,
                              vertical: height * 0.02,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                          child: Text(
                            'Continue',
                            style: TextStyle(
                              fontSize: width * 0.045,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool _isValidPhoneNumber(String phoneNumber) {
    final RegExp phoneRegex = RegExp(r'^[6-9]\d{9}$');
    return phoneRegex.hasMatch(phoneNumber.trim());
  }

  Future<void> _verifyPhoneNumber(BuildContext context) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    String phoneNumber = "+91 ${widget.phoneController.text.trim()}";

    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Verification failed: ${e.message}')));
      },
      codeSent: (String verificationId, int? resendToken) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Otpscreen(verificationId: verificationId),
          ),
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_covid_app/screen/otpscreen.dart';
import 'package:flutter_covid_app/screen/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  TextEditingController phoneController = TextEditingController();

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
  bool isLoading = false; // Track if the button is in loading state

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
                const SizedBox(height: 20),
                Center(
                  child: Image.asset(
                    'assets/images/img6.png',
                    height: 300,
                    fit: BoxFit.cover,
                  ),
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
                const SizedBox(height: 100),
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
                          const Text(
                            '+91',
                            style: TextStyle(fontSize: 16),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              controller: widget.phoneController,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(10),
                              ],
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Enter Phone Number',
                                hintStyle: TextStyle(color: Colors.black38),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 50),
                    Column(
                      children: [
                        SizedBox(
                          width: double.infinity, // Make button fill the width
                          child: ElevatedButton(
                            onPressed: isLoading
                                ? null // Disable the button while loading
                                : () async {
                                    if (_isValidPhoneNumber(
                                        widget.phoneController.text)) {
                                      // Set loading state to true
                                      setState(() {
                                        isLoading = true;
                                      });
                                      await Future.delayed(
                                          const Duration(seconds: 10));

                                      try {
                                        // if Sucessfully Loggin(cred are correct)

                                        var sharepref = await SharedPreferences
                                            .getInstance();
                                        sharepref.setBool(
                                            SplashScreenState.KEYLOGIN, true);
                                        // Perform phone number verification
                                        await _verifyPhoneNumber(context);
                                      } catch (e) {
                                        // Show error if verification fails
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content:
                                                Text('Error: ${e.toString()}'),
                                          ),
                                        );
                                      } finally {
                                        // Reset loading state once finished
                                        // setState(() {
                                        //   isLoading = false;
                                        // });
                                      }
                                    } else {
                                      // Show error if phone number is invalid
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                              'Enter a valid 10-digit number'),
                                        ),
                                      );
                                      // // if Sucessfully Loggin(cred are correct)

                                      // var sharepref =
                                      //     await SharedPreferences.getInstance();
                                      // sharepref.setBool(
                                      //     SplashScreenState.KEYLOGIN, true);
                                    }
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF418f9b),
                              padding: EdgeInsets.symmetric(
                                horizontal: width * 0.30,
                                vertical: height * 0.02,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                            child: isLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white, // White spinner
                                  )
                                : const Text(
                                    'Continue',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        ),
                        const SizedBox(height: 16),
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
          SnackBar(content: Text('Verification failed: ${e.message}')),
        );
      },
      codeSent: (String verificationId, int? resendToken) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Otpscreen(
              verificationId: verificationId,
              mobileNumber: phoneNumber,
            ),
          ),
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }
}

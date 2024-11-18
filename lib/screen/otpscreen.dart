import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_covid_app/Views/BottomBar_Screen.dart';
import 'package:flutter_covid_app/screen/signin.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Otpscreen extends StatefulWidget {
  final String verificationId;
  final String mobileNumber;

  Otpscreen(
      {super.key, required this.verificationId, required this.mobileNumber});

  @override
  State<Otpscreen> createState() => _otpscreenState();
}

class _otpscreenState extends State<Otpscreen> {
  final TextEditingController otpController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF418f9b),
        automaticallyImplyLeading: true,
        leading: IconButton(
          onPressed: () {
            otpController.clear();
            Navigator.pop(context, false);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/img2.png',
                  height: 300,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 50),
                Text(
                  'Enter the 6 digit code sent to your \n ${widget.mobileNumber} number',
                  style: TextStyle(
                    color: const Color(0xFF418f9b),
                    fontSize: width * 0.04,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 50),
                Pinput(
                  length: 6,
                  controller: otpController,
                  keyboardType: TextInputType.number,
                  onCompleted: (pin) => print('OTP Entered: $pin'),
                  onChanged: (value) => print('OTP Changed: $value'),
                  defaultPinTheme: PinTheme(
                    width: 40,
                    height: 55,
                    textStyle: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w100,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFF418f9b)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  focusedPinTheme: PinTheme(
                    width: 40,
                    height: 55,
                    textStyle: TextStyle(
                      fontSize: 20,
                      // color: Colors.black,
                      // fontWeight: FontWeight.bold,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFF418f9b)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 70),
                ElevatedButton(
                  onPressed: isLoading
                      ? null
                      : () async {
                          if (otpController.text.length == 6) {
                            setState(() {
                              isLoading = true;
                            });
                            await _verifyOTP(context);
                            setState(() {
                              isLoading = false;
                            });
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Enter the OTP')),
                            );
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF418f9b),
                    padding: EdgeInsets.symmetric(
                      horizontal: width * 0.35,
                      vertical: height * 0.02,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: isLoading
                      ? const CircularProgressIndicator(
                          color: Color(0xFF418f9b),
                        )
                      : Text(
                          'Verify',
                          style: TextStyle(
                            fontSize: width * 0.045,
                            color: Colors.white,
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _verifyOTP(BuildContext context) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      String otp = otpController.text.trim();

      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
        smsCode: otp,
      );

      final UserCredential userCredential =
          await auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        if (userCredential.additionalUserInfo?.isNewUser ?? false) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => SignUpScreen()),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MyHomePage(title: "")),
          );
        }

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('Phone', widget.mobileNumber);
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'Invalid OTP. Please try again.';

      if (e.code == 'invalid-verification-code') {
        errorMessage = 'The entered OTP is incorrect .';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: ${e.toString()}')),
      );
    }
  }
}

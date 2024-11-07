import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_covid_app/Views/BottomBar_Screen.dart';
import 'package:flutter_covid_app/screen/signin.dart';
import 'package:pinput/pinput.dart';

class Otpscreen extends StatefulWidget {
  final String verificationId;

  Otpscreen({super.key, required this.verificationId});

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
        backgroundColor: Color(0xFF418f9b),
        automaticallyImplyLeading: true,
        leading: IconButton(
            onPressed: () => Navigator.pop(context, false),
            icon: Icon(
              Icons.arrow_back_ios,
            )),
      ),
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
                    Text(
                      'Enter the 6 digit code sent to your mobile number',
                      style: TextStyle(
                        color: Color(0xFF418f9b),
                        fontSize: width * 0.04,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Pinput(
                  length: 6,
                  controller: otpController,
                  onChanged: (value) {},
                  onCompleted: (pin) {
                    print("OTP entered: $pin");
                  },
                ),
                SizedBox(height: 50),
                ElevatedButton(
                  onPressed: () async {
                    if (otpController.text.isNotEmpty) {
                      setState(() {
                        isLoading = true;
                      });
                      await _verifyOTP(context);
                      setState(() {
                        isLoading = false;
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Enter the OTP')));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF418f9b),
                    padding: EdgeInsets.symmetric(
                      horizontal: width * 0.35,
                      vertical: height * 0.02,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: Text(
                    'Verify',
                    style: TextStyle(
                      fontSize: width * 0.045,
                      color: Colors.white,
                    ),
                  ),
                ),
                if (isLoading) CircularProgressIndicator(),
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
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
        smsCode: otpController.text.trim(),
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
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Invalid OTP: ${e.toString()}')));
    }
  }
}

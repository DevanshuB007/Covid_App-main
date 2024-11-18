import 'dart:io';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_covid_app/Views/BottomBar_Screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  File? pickedImage;
  late String Phone;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _initializeFirebase();
  }

  Future<void> _initializeFirebase() async {
    await Firebase.initializeApp();
  }

  Future<void> signUp(String email, String password) async {
    setState(() {
      isLoading = true;
    });
    if (email.isEmpty || pickedImage == null) {
      setState(() {
        isLoading = false;
      });
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Enter Required Fields"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("ok"))
              ],
            );
          });
    } else {
      UserCredential? usercredential;
      try {
        usercredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        print('emsil uplosd');
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('email', email);
        Phone = (await prefs.getString('Phone')) ?? '';
        print('Email saved in SharedPreferences');

        uploadData();
        print('phone upload');
      } on FirebaseAuthException catch (ex) {
        log(ex.code.toString());

        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Error"),
                content: Text(ex.message ?? "An unknown error occurred."),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("ok"))
                ],
              );
            });
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  uploadData() async {
    print('User information uploaded to Firestore');
    if (pickedImage != null) {
      print('................$Phone');
      UploadTask uploadTask = FirebaseStorage.instance
          .ref("profile_pics/$_emailController")
          .child(_emailController.toString())
          .putFile(pickedImage!);

      TaskSnapshot taskSnapshot = await uploadTask;
      String url = await taskSnapshot.ref.getDownloadURL();

      await FirebaseFirestore.instance
          .collection('users')
          .doc(Phone.toString())
          .set({
        'email': _emailController.text.toString(),
        'name': _nameController.text,
        'dob': _dobController.text,
        'Phone': Phone,
        'profilePicUrl': url
      }).then((Value) {
        log("User Uploaded");
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => MyHomePage(title: '')));
      });
    } else {
      log("No image selected.");
    }
  }

  showAlertBox() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Pick Image From'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  onTap: () {
                    PickImage(ImageSource.camera);
                    Navigator.pop(context);
                  },
                  leading: Icon(Icons.camera_alt),
                  title: Text("Camera"),
                ),
                ListTile(
                  onTap: () {
                    PickImage(ImageSource.gallery);
                    Navigator.pop(context);
                  },
                  leading: Icon(Icons.image),
                  title: Text("Gallery"),
                )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAF8FC),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 40),
                Center(
                  child: Image.asset(
                    'assets/images/img4.png',
                    height: 250,
                  ),
                ),
                SizedBox(height: 30),
                Text(
                  'Enter your details',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Colors.black54,
                  ),
                ),
                SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    showAlertBox();
                  },
                  child: pickedImage != null
                      ? CircleAvatar(
                          radius: 50,
                          backgroundColor: Color(0xFF418f9b),
                          backgroundImage: FileImage(pickedImage!),
                        )
                      : CircleAvatar(
                          radius: 40,
                          backgroundColor: Color(0xFF418f9b),
                          child: Icon(
                            Icons.person,
                            size: 40,
                            color: Colors.white,
                          ),
                        ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    prefixIcon: Icon(Icons.email_outlined, color: Colors.teal),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintText: 'Name',
                    prefixIcon: Icon(Icons.person_outline, color: Colors.teal),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _dobController,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: 'Select Date of Birth',
                    prefixIcon:
                        Icon(Icons.calendar_today_outlined, color: Colors.teal),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2100),
                    );
                    if (pickedDate != null) {
                      String formattedDate =
                          DateFormat('dd-MM-yyyy').format(pickedDate);
                      setState(() {
                        _dobController.text = formattedDate;
                      });
                    }
                  },
                ),
                SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    signUp(
                        _emailController.text.toString(), 'your_password_here');

                    // Navigator.pushReplacement(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => MyHomePage(title: '')));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF418f9b),
                    padding: EdgeInsets.symmetric(
                      horizontal: 100,
                      vertical: 18,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: isLoading
                      ? Center(
                          child: CircularProgressIndicator(
                          color: Colors.white,
                        ))
                      : Text(
                          'Sign Up',
                          style: TextStyle(
                            fontSize: 16,
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

  PickImage(ImageSource imageSource) async {
    try {
      final photo = await ImagePicker().pickImage(source: imageSource);
      if (photo == null) return;
      final tempImage = File(photo.path);
      setState(() {
        pickedImage = tempImage;
      });
    } catch (ex) {
      log(ex.toString());
    }
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SignUpScreen(),
  ));
}

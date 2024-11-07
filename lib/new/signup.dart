// import 'dart:io';
// import 'dart:math';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class SignUpPage extends StatefulWidget {
//   const SignUpPage({super.key});

//   @override
//   State<SignUpPage> createState() => _SignUpPageState();
// }

// class _SignUpPageState extends State<SignUpPage> {
//   final emailcontroler = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController dobController = TextEditingController();
//   File? pickedImage;

//   bool isLoading = false;

//   @override
//   void initState() {
//     super.initState();
//     _initializeFirebase();
//   }

//   Future<void> _initializeFirebase() async {
//     await Firebase.initializeApp();
//   }

//   Future<void> signUp(
//     String email,
//     String Password,
//   ) async {
//     setState(() {
//       isLoading = true;
//     });
//     if (email.isEmpty || pickedImage == null) {
//       setState(() {
//         isLoading = false;
//       });
//       return showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return AlertDialog(
//               title: Text("Enter Required Fields"),
//               actions: [
//                 TextButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     child: Text("ok"))
//               ],
//             );
//           });
//     } else {
//       UserCredential? usercredential;
//       try {
//         usercredential = await FirebaseAuth.instance
//             .createUserWithEmailAndPassword(email: email, password: '');
//         print('................1');
//         SharedPreferences prefs = await SharedPreferences.getInstance();
//         await prefs.setString('email', email);
//         print('Email saved in SharedPreferences');

//         uploadData();
//         print('................8');
//       } on FirebaseAuthException catch (ex) {
//         // log(ex.code.toString() as num);

//         showDialog(
//             context: context,
//             builder: (BuildContext context) {
//               return AlertDialog(
//                 title: Text("Error"),
//                 content: Text(ex.message ?? "An unknown error occurred."),
//                 actions: [
//                   TextButton(
//                       onPressed: () {
//                         Navigator.pop(context);
//                       },
//                       child: Text("ok"))
//                 ],
//               );
//             });
//       }
//     }
//     setState(() {
//       isLoading = false;
//     });
//   }

//   uploadData() async {
//     print('User information uploaded to Firestore');
//     if (pickedImage != null) {
//       print('................5');
//       UploadTask uploadTask = FirebaseStorage.instance
//           .ref("profile_pics")
//           .child(emailController.toString())
//           .putFile(pickedImage!);

//       TaskSnapshot taskSnapshot = await uploadTask;
//       String url = await taskSnapshot.ref.getDownloadURL();

//       // Save user information to Firestore
//       await FirebaseFirestore.instance
//           .collection('users')
//           .doc(emailController.text.toString())
//           .set({
//         'email': emailController.text.toString(),
//         'name': nameController.text,
//         'dob': dobController.text,
//         'profilePicUrl': url
//       }).then((Value) {
//         log("User Uploaded" as num);
//       });
//     } else {
//       log("No image selected." as num);
//     }
//   }

//   showAlertBox() {
//     return showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text('Pick Image From'),
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 ListTile(
//                   onTap: () {
//                     PickImage(ImageSource.camera);
//                     Navigator.pop(context);
//                   },
//                   leading: Icon(Icons.camera_alt),
//                   title: Text("Camera"),
//                 ),
//                 ListTile(
//                   onTap: () {
//                     PickImage(ImageSource.gallery);
//                     Navigator.pop(context);
//                   },
//                   leading: Icon(Icons.image),
//                   title: Text("Gallery"),
//                 )
//               ],
//             ),
//           );
//         });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFFFAF8FC),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0),
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 SizedBox(height: 40),
//                 Center(
//                   child: Image.asset(
//                     'assets/images/img4.png', // Replace with your asset image
//                     height: 200,
//                   ),
//                 ),
//                 SizedBox(height: 30),
//                 Text(
//                   'Enter your details',
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.black54,
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 InkWell(
//                   onTap: () {
//                     showAlertBox();
//                   },
//                   child: pickedImage != null
//                       ? CircleAvatar(
//                           radius: 50,
//                           backgroundColor: Color(0xFF418f9b),
//                           backgroundImage: FileImage(pickedImage!),
//                         )
//                       : CircleAvatar(
//                           radius: 50,
//                           backgroundColor: Color(0xFF418f9b),
//                           child: Icon(
//                             Icons.person,
//                             size: 50,
//                             color: Colors.white,
//                           ),
//                         ),
//                 ),
//                 SizedBox(height: 16),
//                 // Email TextField
//                 TextField(
//                   controller: emailController,
//                   decoration: InputDecoration(
//                     hintText: 'Email',
//                     prefixIcon: Icon(Icons.email_outlined, color: Colors.teal),
//                     filled: true,
//                     fillColor: Colors.white,
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(30),
//                       borderSide: BorderSide.none,
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 // Name TextField
//                 TextField(
//                   controller: nameController,
//                   decoration: InputDecoration(
//                     hintText: 'Name',
//                     prefixIcon: Icon(Icons.person_outline, color: Colors.teal),
//                     filled: true,
//                     fillColor: Colors.white,
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(30),
//                       borderSide: BorderSide.none,
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 // Date of Birth TextField
//                 TextField(
//                   controller: dobController,
//                   readOnly: true,
//                   decoration: InputDecoration(
//                     hintText: 'Select Date of Birth',
//                     prefixIcon:
//                         Icon(Icons.calendar_today_outlined, color: Colors.teal),
//                     filled: true,
//                     fillColor: Colors.white,
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(30),
//                       borderSide: BorderSide.none,
//                     ),
//                   ),
//                   onTap: () async {
//                     DateTime? pickedDate = await showDatePicker(
//                       context: context,
//                       initialDate: DateTime.now(),
//                       firstDate: DateTime(1900),
//                       lastDate: DateTime(2100),
//                     );
//                     if (pickedDate != null) {
//                       String formattedDate =
//                           DateFormat('dd-MM-yyyy').format(pickedDate);
//                       setState(() {
//                         dobController.text = formattedDate;
//                       });
//                     }
//                   },
//                 ),
//                 SizedBox(height: 40),
//                 // Sign Up Button
//                 ElevatedButton(
//                   onPressed: () {
//                     signUp(emailController.toString(), 'your_password_here');
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Color(0xFF418f9b),
//                     padding: EdgeInsets.symmetric(
//                       horizontal: 100,
//                       vertical: 18,
//                     ),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                   ),
//                   child: isLoading
//                       ? Center(
//                           child: CircularProgressIndicator(
//                             color: Colors.white,
//                           ),
//                         )
//                       : Text(
//                           'Sign Up',
//                           style: TextStyle(
//                             fontSize: 16,
//                             color: Colors.white,
//                           ),
//                         ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   PickImage(ImageSource imageSource) async {
//     try {
//       final photo = await ImagePicker().pickImage(source: imageSource);
//       if (photo == null) return;
//       final tempImage = File(photo.path);
//       setState(() {
//         pickedImage = tempImage;
//       });
//     } catch (ex) {
//       log(ex.toString() as num);
//     }
//   }
// }

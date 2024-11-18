// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class ProfilePage extends StatefulWidget {
//   @override
//   _ProfilePageState createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//   Future<DocumentSnapshot<Object?>?>? userData;

//   Future<String?> _getUserIdFromPrefs() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString('userId');
//   }

//   Future<DocumentSnapshot<Object?>?> _fetchUserData() async {
//     String? userId = await _getUserIdFromPrefs();
//     if (userId != null) {
//       return FirebaseFirestore.instance.collection('users').doc(userId).get();
//     }
//     return null;
//   }

//   @override
//   void initState() {
//     super.initState();
//     userData = _fetchUserData();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FutureBuilder<DocumentSnapshot<Object?>?>(
//         future: userData,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }
//           if (!snapshot.hasData || snapshot.data == null) {
//             return Center(child: Text('No user data found'));
//           }
//           final data =
//               snapshot.data!.data() as Map<String, dynamic>?; // Cast to Map
//           if (data == null) {
//             return Center(child: Text('User data is unavailable'));
//           }

//           return Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 CircleAvatar(
//                   radius: 50,
//                   backgroundImage: NetworkImage(data['imageUrl'] ?? ''),
//                 ),
//                 SizedBox(height: 20),
//                 Text(
//                   data['name'] ?? '',
//                   style: TextStyle(fontSize: 24),
//                 ),
//                 SizedBox(height: 10),
//                 Text(
//                   'Email: ${data['email'] ?? ''}',
//                   style: TextStyle(fontSize: 16),
//                 ),
//                 SizedBox(height: 10),
//                 Text(
//                   'Date of Birth: ${data['dob'] ?? ''}',
//                   style: TextStyle(fontSize: 16),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

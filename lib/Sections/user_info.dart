import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_covid_app/Sections/calendar_.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({super.key});

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  String userName = '';
  String profilePicUrl = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    print('............');
    // Use WidgetsBinding to call async methods after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchUserData();
    });
  }

  Future<void> fetchUserData() async {
    // Get the email from SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');

    if (email != null) {
      print('$email............');

      // Fetch user data from Firestore by querying for the email field
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: email) // Query for email field
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Assuming there is only one document with the email
        var userDoc = querySnapshot.docs[0]; // Get the first document

        setState(() {
          userName = userDoc['name'];
          print('$userName............');
          profilePicUrl = userDoc['profilePicUrl'];
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        print("No user found with that email");
      }
    } else {
      setState(() {
        isLoading = false;
      });
      print("No email found in SharedPreferences");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Container(
                height: 400,
                width: double.infinity,
                color: const Color(0xFF418f9b),
                child: Padding(
                  padding: const EdgeInsets.only(top: 60, left: 10, right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '👋 Hello,',
                                style: const TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              Text(
                                userName.isNotEmpty ? userName : 'Loading...',
                                // 'Gregory House',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                            ],
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 160, bottom: 26),
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2,
                                ),
                              ),
                              child: profilePicUrl.isNotEmpty
                                  ? CircleAvatar(
                                      radius: 20,
                                      backgroundImage:
                                          NetworkImage(profilePicUrl),
                                    )
                                  : CircleAvatar(
                                      backgroundImage:
                                          AssetImage('assets/images/boy.png'),
                                    ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 70,
                        width: 400,
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search',
                            hintStyle: TextStyle(
                                fontSize: 15,
                                color: Colors.black.withOpacity(0.20)),
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: const Icon(
                              Icons.search,
                              size: 20,
                              color: Color(0xFF418f9b),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40),
                              borderSide: const BorderSide(
                                color: Colors.white,
                                width: 2,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide: const BorderSide(
                                color: Colors.white,
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 100,
                        width: double.infinity,
                        child: Calendar(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}

class MyUserInfo extends StatefulWidget {
  final String name;
  const MyUserInfo({super.key, required this.name});

  @override
  State<MyUserInfo> createState() => _MyUserInfoState();
}

class _MyUserInfoState extends State<MyUserInfo> {
  String userName = '';

  @override
  void initState() {
    super.initState();
    print('..........................');
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final email = user.email;

      DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection('users').doc(email).get();

      if (userDoc.exists) {
        setState(() {
          userName = userDoc['name'];
        });
      } else {
        print("User document does not exist");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      width: double.infinity,
      color: const Color(0xFF418f9b),
      child: Padding(
        padding: const EdgeInsets.only(top: 60, left: 10, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName.isNotEmpty
                          ? userName
                          : 'Loading...', // '👋 Hello,',
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      widget.name,
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 160, bottom: 26),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                    child: const CircleAvatar(
                      backgroundImage: AssetImage('assets/images/boy.png'),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 70,
              width: 400,
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: TextStyle(
                      fontSize: 15, color: Colors.black.withOpacity(0.20)),
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: const Icon(
                    Icons.search,
                    size: 20,
                    color: Color(0xFF418f9b),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                    borderSide: const BorderSide(
                      color: Colors.white,
                      width: 2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: const BorderSide(
                      color: Colors.white,
                      width: 2,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 100,
              width: double.infinity,
              child: Calendar(),
            ),
          ],
        ),
      ),
    );
  }
}

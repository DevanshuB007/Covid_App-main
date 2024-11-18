import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_covid_app/Sections/calendar_.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
    // Use WidgetsBinding to call async methods after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchUserData();
    });
  }

  Future<void> fetchUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('Phone');

    if (email != null) {
      // Fetch user data from Firestore by querying for the email field
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('Phone', isEqualTo: email)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        var userDoc = querySnapshot.docs[0];
        String fetchedName = userDoc['name'];
        String fetchedProfilePicUrl = userDoc['profilePicUrl'];

        // Save user data to SharedPreferences
        prefs.setString('userName', fetchedName);
        prefs.setString('profilePicUrl', fetchedProfilePicUrl);

        setState(() {
          userName = fetchedName;
          profilePicUrl = fetchedProfilePicUrl;
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
      body: Container(
        height: 350,
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
                      const Text(
                        '👋 Hello,',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        userName.isNotEmpty ? userName : 'Loading...',
                        style:
                            const TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 140, bottom: 26),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: profilePicUrl.isNotEmpty
                          ? CircleAvatar(
                              radius: 25,
                              backgroundImage:
                                  CachedNetworkImageProvider(profilePicUrl),
                            )
                          : const CircleAvatar(
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
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_covid_app/Sections/calendar_.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({super.key});

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 400,
        width: double.infinity,
        color: Color(0xFF418f9b),
        child: Padding(
          padding: const EdgeInsets.only(top: 60, left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '👋 Hello,',
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        'Gregory House',
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
                      child: CircleAvatar(
                        backgroundImage:
                            const AssetImage('assets/images/boy.png'),
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

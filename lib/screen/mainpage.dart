import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_covid_app/Sections/reports_.dart';
import 'package:flutter_covid_app/Sections/services_.dart';
import 'package:flutter_covid_app/Sections/user_info.dart';
import 'package:flutter_covid_app/Views/BottomBar_Screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Color(0xFF418f9b),
    ),
  );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // body: Column(
        //   children: [
        //     const SizedBox(
        //       height: 350,
        //       width: double.infinity,
        //       child: UserInfo(),
        //     ),
        //     const SizedBox(
        //       height: 20,
        //     ),
        //     const Services(),
        //     const SizedBox(
        //       height: 2,
        //     ),
        //     const SizedBox(
        //       height: 8,
        //     ),
        //     const Reports(),
        //     // BottomAppBar(),
        //   ],
        // ),
        // bottomNavigationBar: const bottombar_screen(),
        );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_covid_app/Sections/reports_.dart';
import 'package:flutter_covid_app/Sections/services_.dart';
import 'package:flutter_covid_app/Sections/user_info.dart';
import 'package:flutter_covid_app/Views/BottomBar_Screen.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Color(0xFF418f9b),
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF418f9b),
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 350,
              width: double.infinity,
              child: const UserInfo(),
            ),
            const SizedBox(
              height: 20,
            ),
            const Services(),
            SizedBox(
              height: 2,
            ),
            const SizedBox(
              height: 8,
            ),
            const Reports(),
            // BottomAppBar(),
          ],
        ),
      ),
      bottomNavigationBar: const BottombarScreen(),
    );
  }
}

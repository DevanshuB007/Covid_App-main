import 'package:flutter/material.dart';
import 'package:flutter_covid_app/Sections/reports_.dart';
import 'package:flutter_covid_app/Sections/services_.dart';
import 'package:flutter_covid_app/Sections/user_info.dart';
import 'package:flutter_covid_app/Views/Payment_screen.dart';
// import 'package:flutter_covid_app/Views/calendar_screen.dart';

void main() {
  runApp(const bottombar_screen());
}

class bottombar_screen extends StatelessWidget {
  const bottombar_screen({super.key});

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
  int currentIndexvalue = 0;

  List<Widget> screenList = [
    SingleChildScrollView(
      child: Column(
        children: const [
          SizedBox(
            height: 350,
            width: double.infinity,
            child: UserInfo(),
          ),
          SizedBox(height: 20),
          Services(),
          SizedBox(height: 2),
          SizedBox(height: 8),
          Reports(),
        ],
      ),
    ),
    const Center(child: Text('File Screen')),
    paymentScreen(),
    // const Center(child: Text('Calendar Screen')),
    const Center(child: Text('Settings Screen')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screenList[currentIndexvalue],
      bottomNavigationBar: Stack(
        children: [
          BottomNavigationBar(
            currentIndex: currentIndexvalue,
            onTap: (index) {
              setState(() {
                currentIndexvalue = index;
              });
            },
            selectedItemColor: Color(0xFF418f9b),
            unselectedItemColor: const Color(0xFFa0a0a0),
            showSelectedLabels: true,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_filled),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.description),
                label: 'File',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.payment),
                label: 'Payment',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
          ),
          Positioned(
            bottom: 55,
            left: MediaQuery.of(context).size.width / 4 * currentIndexvalue +
                MediaQuery.of(context).size.width / 15,
            child: Container(
              width: 40,
              height: 10,
              color: Color(0xFF418f9b),
            ),
          ),
        ],
      ),
    );
  }
}

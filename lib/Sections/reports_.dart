import 'package:flutter/material.dart';

class Reports extends StatefulWidget {
  const Reports({super.key});

  @override
  State<Reports> createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
      width: double.infinity,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "DAILY REPORTS",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: Text(
                    ':',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 100,
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Symptoms of Coivid to watch out for",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        Text("Sep 01,10.00 AM"),
                      ],
                    ),
                  ),
                  const SizedBox(width: 5),
                  Image.asset(
                    'assets/images/img_1.png',
                    width: 100,
                    height: 100,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 100,
              width: double.infinity,
              // color: Colors.white,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Symptoms of Coivid to watch out for",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        Text("Sep 01,10.00 AM"),
                      ],
                    ),
                  ),
                  const SizedBox(width: 5),
                  Image.asset(
                    'assets/images/img_1.png',
                    width: 100,
                    height: 100,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

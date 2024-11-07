import 'package:flutter/material.dart';

class Services extends StatefulWidget {
  const Services({super.key});

  @override
  State<Services> createState() => _ServicesState();
}

class _ServicesState extends State<Services> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: double.infinity,
      color: Colors.white.withOpacity(0.6),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'SERVICES',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF418f9b),
                  ),
                ),
                Text(
                  'See all',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFFeeda6d),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                serviceicon(Icons.coronavirus, 'Covid-19'),
                serviceicon(Icons.person_4_sharp, 'Doctors'),
                serviceicon(Icons.add_outlined, 'Hospitals'),
                serviceicon(Icons.medical_services, 'Medicines'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget serviceicon(IconData icon, String label) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: const Color(0xFFcbe0e3),
          child: CircleAvatar(
            radius: 30,
            backgroundColor: const Color(0xFF81b6be),
            child: Icon(
              icon,
              color: Colors.black,
              size: 30,
            ),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          label,
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ],
    );
  }
}

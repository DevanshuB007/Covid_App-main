import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Calendar extends StatelessWidget {
  const Calendar({super.key});

  @override
  Widget build(BuildContext context) {
    List<DateTime> sevenDays = [];
    DateTime currentTime = DateTime.now();
    for (int i = 0; i < 7; i++) {
      DateTime nextDay = currentTime.add(Duration(days: i));
      sevenDays.add(nextDay);
    }
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 7,
      itemBuilder: (context, index) {
        DateTime date = sevenDays[index];
        bool isToday = DateFormat('yyyy-MM-dd').format(date) ==
            DateFormat('yyyy-MM-dd').format(currentTime);
        return Padding(
          padding: const EdgeInsets.all(6),
          child: Column(
            children: [
              Text(
                DateFormat('EEE').format(date),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor:
                      isToday ? Colors.white : const Color(0xFF81b6be),
                  child: Text(
                    sevenDays[index].day.toString(),
                    style: TextStyle(
                      fontSize: 15,
                      color: isToday ? const Color(0xFF418f9b) : Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5),
            ],
          ),
        );
      },
    );
  }
}

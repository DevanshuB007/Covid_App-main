import 'package:flutter/material.dart';

class CalendarScreen extends StatelessWidget {
  CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF418f9b),
          // toolbarHeight: 100,
          title: Text(
            'APPOINTMENTS',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
          leading: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 15,
              ),
              doctorprofile(),
              SizedBox(height: 20),
              totalCostSection(),
              SizedBox(height: 20),
              paymentOptions(),
            ],
          ),
        ));
  }
}

Widget doctorprofile() {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 8,
          spreadRadius: 2,
        )
      ],
    ),
    child: Row(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundImage: AssetImage('assets/images/boy.png'),
        ),
        SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Gregory House',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text('Nephrologist', style: TextStyle(color: Colors.grey)),
            SizedBox(height: 8),
            Row(
              children: [
                CircleAvatar(
                  radius: 15,
                  backgroundColor: Color(0xFFd0e9fa),
                  child: Icon(
                    Icons.medical_services,
                    color: Colors.blue,
                    size: 20,
                  ),
                ),
                SizedBox(width: 4),
                Text('4 years'),
                SizedBox(width: 16),
                CircleAvatar(
                  radius: 15,
                  backgroundColor: Color(0xFFffd6da),
                  child: Icon(
                    Icons.favorite,
                    color: Colors.red,
                    size: 20,
                  ),
                ),
                SizedBox(width: 4),
                Text('95%'),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}

Widget totalCostSection() {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 8,
          spreadRadius: 2,
        )
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCostRow('Total Cost', '\$80'),
        SizedBox(height: 8),
        Text('Session fee for 30 minutes',
            style: TextStyle(color: Colors.grey)),
        SizedBox(height: 20),
        _buildCostRow('To Pay', '\$80'),
        SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black,
            backgroundColor: Color(0xFFd0e9fa),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: EdgeInsets.all(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.discount, color: Colors.green),
              Text(
                'Use Promo Code',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w900),
              ),
              Icon(Icons.arrow_forward_ios, color: Colors.black)
            ],
          ),
        ),
      ],
    ),
  );
}

Widget paymentOptions() {
  return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            spreadRadius: 2,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('PAYMENT OPTIONS',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          RadioListTile(
            value: 'PayPal',
            groupValue: 'PayPal',
            onChanged: (value) {},
            title: Text('PayPal'),
          ),
          RadioListTile(
            value: 'Credit Card',
            groupValue: 'PayPal',
            onChanged: (value) {},
            title: Text('Credit Card'),
          ),
          SizedBox(height: 150),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.orange,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              ),
              padding: EdgeInsets.all(16),
            ),
            child: Center(child: Text('Pay & Confirm')),
          ),
        ],
      ));
}

Widget _buildCostRow(String label, String amount) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(label, style: TextStyle(fontSize: 16)),
      Text(amount, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
    ],
  );
}

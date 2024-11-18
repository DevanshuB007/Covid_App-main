import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_covid_app/main.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class paymentScreen extends StatelessWidget {
  paymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF418f9b),
        automaticallyImplyLeading: true,
        toolbarHeight: 80,
        title: Text(
          'APPOINTMENTS',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => MyHomePage(title: '')));
            ;
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.info_outline,
                color: Colors.white,
                size: 25,
              ))
        ],
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
            PaymentOptions(),
          ],
        ),
      ),
    );
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

class PaymentOptions extends StatefulWidget {
  @override
  _PaymentOptionsState createState() => _PaymentOptionsState();
}

class _PaymentOptionsState extends State<PaymentOptions> {
  String? selectedPaymentMethod = 'PayPal';

  Razorpay razorpay = Razorpay();

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    // Show success message
    Fluttertoast.showToast(msg: "Payment Success");

    // Save success data to Firestore
    try {
      await FirebaseFirestore.instance.collection('payments').add({
        'status': 'Payment Success',
        'paymentId': response.paymentId,
        'orderId': response.orderId,
        'signature': response.signature,
        'paymentMethod': selectedPaymentMethod,
        'timestamp': Timestamp.now(),
      });
      print('Payment success data saved to Firestore');
    } catch (e) {
      print('Error saving payment success data: $e');
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) async {
    // Show failure message
    Fluttertoast.showToast(msg: "Payment Failed");

    // Save failure data to Firestore
    try {
      await FirebaseFirestore.instance.collection('payments').add({
        'status': 'failure',
        'code': response.code,
        'message': response.message,
        'paymentMethod': selectedPaymentMethod,
        'timestamp': Timestamp.now(),
      });
      print('Payment failure data saved to Firestore');
    } catch (e) {
      print('Error saving payment failure data: $e');
    }
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Handle external wallet selection if needed
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    razorpay.clear();
  }

  @override
  Widget build(BuildContext context) {
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 2,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'PAYMENT OPTIONS',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              children: [
                Radio<String>(
                  value: 'PayPal',
                  groupValue: selectedPaymentMethod,
                  onChanged: (String? value) {
                    setState(() {
                      selectedPaymentMethod = value;
                    });
                  },
                ),
                const Text('PayPal'),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              children: [
                Radio<String>(
                  value: 'Credit Card',
                  groupValue: selectedPaymentMethod,
                  onChanged: (String? value) {
                    setState(() {
                      selectedPaymentMethod = value;
                    });
                  },
                ),
                const Text('Credit Card'),
              ],
            ),
          ),
          const SizedBox(height: 150),
          ElevatedButton(
            onPressed: () {
              var options = {
                'key': 'rzp_test_TWAO5KerX8OA4W',
                'amount': 100,
                'name': 'Acme Corp.',
                'description': 'Fine T-Shirt',
                'prefill': {
                  'contact': '8888888888',
                  'email': 'test@razorpay.com'
                }
              };

              razorpay.open(options);
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.orange,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              ),
              padding: const EdgeInsets.all(16),
            ),
            child: const Center(child: Text('Pay & Confirm')),
          ),
        ],
      ),
    );
  }
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

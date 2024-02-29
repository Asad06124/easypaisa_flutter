import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  TextEditingController paymentAmountController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  Color primaryColor = Color(0xff290D4A);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Screen'),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 16.0),
          TextFormField(
            controller: accountNumberController,
            decoration: InputDecoration(
              labelText: 'Account Number',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 16.0), TextFormField(
            controller: paymentAmountController,
            decoration: InputDecoration(
              labelText: 'Amount',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 16.0),
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
            ),
          ),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white, backgroundColor: primaryColor,
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            onPressed: () {
              if (accountNumberController.text.isEmpty) {
                Fluttertoast.showToast(
                  msg: "Please enter account number",
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: primaryColor,
                  textColor: Colors.white,
                );
              } else if (emailController.text.isEmpty) {
                Fluttertoast.showToast(
                  msg: "Please enter email",
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: primaryColor,
                  textColor: Colors.white,
                );
              } else if (paymentAmountController.text.isEmpty) {
                Fluttertoast.showToast(
                  msg: "Please enter amount",
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: primaryColor,
                  textColor: Colors.white,
                );
              } else {
                print("On Tapped");
                makePayment();
              }
            },
            child: Text(
              'Continue',
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
          ),
        ],
      ),
    );
  }


  void makePayment() async {
    Response response = await EasypaisaFlutter.requestPayment(
        '1.0',
        '03376980901',
        'asadbalqani@gmail.com',
       );
    print(response.body);

  }

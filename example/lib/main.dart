import 'package:easypaisa_flutter/easypaisa_flutter.dart';
import 'package:example/payment_screen.dart';
import 'package:flutter/material.dart';

void main() {
  EasypaisaFlutter.initialize(
      'rideoptions',
      'd7d530ae300bf32090a2a0bc932ac708',
      '25056',
      true /*is testing account or not*/,
      AccountType.MA /*Merchant account type either Mobile account or OTC */);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: PaymentScreen(),
    );
  }
}

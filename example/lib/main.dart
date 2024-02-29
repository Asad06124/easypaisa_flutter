import 'package:example/payment_screen.dart';
import 'package:flutter/material.dart';

void main() {
  EasypaisaFlutter.initialize( 'username', 'password' ,'storeId', true/*is testing account or not*/, AccountType.MA/*Merchant account type either Mobile account or OTC */);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: PaymentScreen(),
    );
  }
}

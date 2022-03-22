import 'package:flutter/material.dart';

import 'screens/stock_info.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FinnData',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: const StockInfoScreen(title: 'Stock Info'),
    );
  }
}
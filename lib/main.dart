import 'package:flutter/material.dart';
import 'screens/menu.dart';

void main() {
  runApp(const BolabaleStoreApp());
}

class BolabaleStoreApp extends StatelessWidget {
  const BolabaleStoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bolabale Store',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage(),
    );
  }
}

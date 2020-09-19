import 'package:flutter/material.dart';
import 'package:guncel_kur_bilgisi/screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      home: HomeScreen(),
    );
  }
}

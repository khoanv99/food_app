import 'package:flutter/material.dart';
import 'package:food_app/pages/onboarding.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Tắt chữ Debug ở góc phải
      title: 'Flutter Demo',
      home: const Onboarding(),
    );

  }
}

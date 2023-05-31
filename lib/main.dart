import 'package:flutter/material.dart';
import 'package:smartbin_alert/views/signup_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SmartBin Alert',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFF5EAD4)),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const SignupScreen(),
    );
  }
}
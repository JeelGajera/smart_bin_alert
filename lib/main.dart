import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:smartbin_alert/views/home_screen.dart';
import 'package:smartbin_alert/views/signup_screen.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Check if the user is authenticated
  final FirebaseAuth auth = FirebaseAuth.instance;
  final User? currentUser = auth.currentUser;
  Widget initialRoute = const SignupScreen();

  if (currentUser != null) {
    initialRoute = const HomeScreen();
  }

  runApp(MyApp(initialRoute: initialRoute));
}

class MyApp extends StatelessWidget {
  final Widget initialRoute;
  const MyApp({super.key, required this.initialRoute});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SmartBin Alert',
      themeMode: ThemeMode.system,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFF5EAD4)),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: initialRoute,
    );
  }
}

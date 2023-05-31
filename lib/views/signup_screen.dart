import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:smartbin_alert/utils/colors.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  SignupScreenState createState() => SignupScreenState();
}

class SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
          child: Column(
            children: <Widget>[
              const Text(
                'Welcome to SmartBin Alert!',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: tertiaryColor,
                ),
              ),
              Image.asset(
                'assets/home.jpg',
                height: 300,
                width: 300,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: DefaultTextStyle(
                  style: const TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: greenColor,
                  ),
                  child: AnimatedTextKit(
                    isRepeatingAnimation: false,
                    totalRepeatCount: 1,
                    animatedTexts: [
                      TypewriterAnimatedText(
                          'Your all-in-one solution for efficient waste management and disposal.',
                          speed: const Duration(milliseconds: 100)),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: tertiaryColor,
                  elevation: 12,
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 32,
                  ),
                  textStyle: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: secondaryColor),
                ),
                child: InkWell(
                  onTap: () {
                    MaterialPageRoute(
                      builder: (context) => const SignupScreen(),
                    );
                  },
                  child: const Text(
                    'Let\'s get started!🚀',
                    style: TextStyle(color: yellowColor),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

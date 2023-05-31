import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:smartbin_alert/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smartbin_alert/views/home_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  SignupScreenState createState() => SignupScreenState();
}

class SignupScreenState extends State<SignupScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleSignInAccount =
        await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    return await _auth.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    // Check if the user is already signed in
    if (_auth.currentUser != null) {
      return const HomeScreen();
    }

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
                onPressed: () async {
                  final UserCredential userCredential =
                      await signInWithGoogle();
                  print(userCredential.user!.displayName);
                  // ignore: use_build_context_synchronously
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeScreen(),
                    ),
                  );
                },
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
                child: const Text(
                  'Let\'s get started!🚀',
                  style: TextStyle(color: yellowColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // static Future<String?> googleSignIn() async {
  //   try {
  //     await Firebase.initializeApp(
  //       options: DefaultFirebaseOptions.currentPlatform,
  //     );
  //     await FirebaseAuth.instance.signInWithRedirect(
  //       GoogleAuthProvider(),
  //     );
  //     return null;
  //   } on FirebaseAuthException catch (ex) {
  //     return "${ex.code}: ${ex.message}";
  //   } on UnimplementedError catch (ex) {
  //     return ex.message;
  //   }
  // }

  static Future<String?> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      return null;
    } on FirebaseAuthException catch (ex) {
      return "${ex.code}: ${ex.message}";
    }
  }
}

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo_app/screens/homescreen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_demo_app/screens/authscreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    auth.authStateChanges().listen(
      (User user) {
        (user == null) ? isLoggedIn = false : isLoggedIn = true;
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: AnimatedSplashScreen(
          animationDuration: Duration(
            milliseconds: 1800,
          ),
          splash: Image.asset("assets/flutter.png"),
          nextScreen: isLoggedIn ? HomeScreen() : AuthScreen(),
          splashTransition: SplashTransition.scaleTransition,
          pageTransitionType: PageTransitionType.scale,
        ),
      ),
    );
  }
}

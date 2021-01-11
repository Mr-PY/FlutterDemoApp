import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo_app/screens/homescreen.dart';
import 'package:flutter_demo_app/utilities.dart/google_auth.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleAuthentication googleAuthentication = GoogleAuthentication();

  @override
  void initState() {
    super.initState();
    auth.authStateChanges().listen(
          (User user) => {
            if (user != null)
              {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  ),
                ),
              }
          },
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset("assets/flutter.png"),
                  Text(
                    "Demo App",
                    style: TextStyle(fontSize: 24.0),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            RaisedButton.icon(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
              color: Theme.of(context).primaryColorDark,
              onPressed: () => googleAuthentication.signInWithGoogle(),
              label: Text(
                "Sign In With Google",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 16.0,
                ),
              ),
              icon: Image.asset(
                'assets/google.png',
                height: 20.0,
                width: 20.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_demo_app/screens/splashscreen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.teal),
      home: SplashScreen(),
    );
  }
}

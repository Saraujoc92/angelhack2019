import 'package:financial_advisor/screens/SplashScreen.dart';
import 'package:financial_advisor/screens/home/home.dart';
import 'package:financial_advisor/screens/login/LoginScreen.dart';
import 'package:financial_advisor/services/auth.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CrediTÚ',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: LandingPage(),
    );
  }
}

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Auth.isSignedIn,
      builder: (context, snapshot) {
        debugPrint('got snapshot ${snapshot.data}');
        if (!snapshot.hasData) {
          return SplashScreen();
        }
        if (snapshot.data) {
          return Home();
        }
        return LoginSignUpPage();
      },
    );
  }
}

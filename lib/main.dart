import 'package:flutter/material.dart';
import 'package:gwaliorkart/screens/home.dart';
import 'package:gwaliorkart/screens/login.dart';
import 'package:gwaliorkart/screens/signup.dart';
import 'package:gwaliorkart/screens/splash.dart';
import 'package:gwaliorkart/utils/constants.dart';

void main() {
  runApp(GwaliorKart());
}

class GwaliorKart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Constants.appName,
      theme: ThemeData(
        primaryIconTheme: IconThemeData(color: Constants.myWhite),
        primaryTextTheme: TextTheme(headline6: TextStyle(color: Colors.white)),
        primarySwatch: Constants.primary_green,
        primaryColor: Constants.primary_green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => Splash(),
        '/home': (context) => Home(),
        '/login': (context) => Login(),
        '/sign-up': (context) => SignUp(),
      },
    );
  }
}

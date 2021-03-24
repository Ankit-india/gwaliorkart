import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gwaliorkart/screens/home.dart';
import 'package:gwaliorkart/screens/login.dart';
import 'package:gwaliorkart/utils/auth_utils.dart';
import 'package:gwaliorkart/utils/constants.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    Timer(Duration(seconds: 2), () {
      _navigateFromSplash();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Constants.primary_green,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset("assets/icons/logo2.png", width: width * .7),
          ],
        ),
      ),
    );
  }

  Future<void> _navigateFromSplash() async {
    final String _authToken = await AuthUtils.getToken();
    print("\nSplash Token:=> $_authToken\n");
    if (_authToken != null && _authToken != '') {
      await AuthUtils.getUserInfo();
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => Home()));
    } else {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => Login()));
    }
  }
}

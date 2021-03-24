import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gwaliorkart/utils/constants.dart';

class ErrorScreen extends StatefulWidget {
  final Exception exception;
  final int state;

  ErrorScreen(this.exception, this.state);

  @override
  _ErrorScreenState createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  Exception exception;
  Size _deviceSize;

  @override
  void initState() {
    super.initState();
    exception = widget.exception;
    Timer(Duration(seconds: 0), () {
      if (exception.runtimeType.toString() == 'UnAuthorizeException') {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _deviceSize = MediaQuery.of(context).size;
    if (exception.runtimeType.toString() == 'UnAuthorizeException') {
      return _unAuthorizedWidget();
    } else if (exception.runtimeType.toString() == 'SocketException') {
      return _offlineMessageWidget();
    } else if (exception.runtimeType.toString() == 'BadGatewayException') {
      return _badeGatewayWidget();
    } else if (exception.runtimeType.toString() == 'FormatException') {
      return _formatExceptionWidget();
    } else {
      return _reportMeMessage();
    }
  }

  Widget _unAuthorizedWidget() {
    return Container(
      color: Constants.myWhite,
      alignment: Alignment.center,
      width: _deviceSize.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "You are logged out",
            style: TextStyle(fontSize: 20, letterSpacing: 0.5),
          ),
          Constants.height(10.0),
          Text(
            "Please login",
            style: TextStyle(fontSize: 17, letterSpacing: 0.5),
          ),
        ],
      ),
    );
  }

  Widget _offlineMessageWidget() {
    return Container(
      color: Constants.myWhite,
      alignment: Alignment.center,
      width: _deviceSize.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            "assets/icons/offline.png",
            width: 60,
          ),
          Constants.width(10.0),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "You're offline",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                  fontStyle: FontStyle.italic,
                ),
              ),
              Constants.height(5.0),
              Text(
                "Check your connection\nand try again",
                style: TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _badeGatewayWidget() {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "There is an error",
              style: TextStyle(fontSize: 20, letterSpacing: 0.5),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                "Please try again",
                style: TextStyle(fontSize: 17, letterSpacing: 0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _formatExceptionWidget() {
    return Container(
      color: Constants.myWhite,
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "There is an error",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, letterSpacing: 0.5),
          ),
          Constants.height(10.0),
          Text(
            "Please try again.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, letterSpacing: 0.5),
          ),
        ],
      ),
    );
  }

  Widget _reportMeMessage() {
    return Container(
      color: Constants.myWhite,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "There is an error",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 18.0,
                letterSpacing: 0.5,
                fontWeight: FontWeight.w500,
                color: Constants.grey600),
          ),
          Constants.height(15.0),
          InkWell(
            child: Text(
              "Report a problem",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.pink[300]),
            ),
            onTap: () => Constants.showShortToastBuilder('Report submitted.'),
          ),
        ],
      ),
    );
  }
}

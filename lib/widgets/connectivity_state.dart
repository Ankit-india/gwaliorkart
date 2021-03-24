//import 'dart:async';
//
//import 'package:back_button_interceptor/back_button_interceptor.dart';
//import 'package:connectivity/connectivity.dart';
//import 'package:flushbar/flushbar.dart';
//import 'package:flutter/material.dart';
//import 'package:gwaliorkart/utils/constants.dart';
//
//class ConnectivityManager {
//  StreamSubscription<ConnectivityResult> subscription;
//  Connectivity connectivity = new Connectivity();
//  ConnectivityState _connectivityState;
//  bool isPageAdded = false;
//  Flushbar flushBar;
//
//  void initConnectivity(BuildContext context) {
//    subscription =
//        connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
//      if (result == ConnectivityResult.wifi ||
//          result == ConnectivityResult.mobile) {
//        if (_connectivityState != null &&
//            _connectivityState != ConnectivityState.online)
//          _connectivityState = ConnectivityState.online;
//        if (isPageAdded) Navigator.of(context).pop();
//        isPageAdded = false;
//      } else {
//        _connectivityState = ConnectivityState.offline;
//        pushInternetOffScreen(context);
//      }
//    });
//  }
//
//  void pushInternetOffScreen(BuildContext context) {
//    Navigator.of(context).push(new MaterialPageRoute<Null>(
//        builder: (BuildContext context) {
//          return new ConnectivityPage();
//        },
//        fullscreenDialog: true));
//    isPageAdded = true;
//  }
//
//  void dispose() {
//    subscription.cancel();
//  }
//}
//
//class ConnectivityPage extends StatefulWidget {
//  @override
//  _ConnectivityPageState createState() => _ConnectivityPageState();
//}
//
//class _ConnectivityPageState extends State<ConnectivityPage> {
//  @override
//  void initState() {
//    // TODO: implement initState
//    super.initState();
//    BackButtonInterceptor.add(myInterceptor);
//  }
//
//  @override
//  void dispose() {
//    BackButtonInterceptor.removeAll();
//    super.dispose();
//  }
//
//  bool myInterceptor(bool stopDefaultButtonEvent) {
//    return true;
//  }
//
//  Widget _backButton() {
//    return InkWell(
//      onTap: () {
//        Navigator.pop(context);
//      },
//      child: Container(
//        padding: EdgeInsets.symmetric(horizontal: 10),
//        child: Row(
//          children: <Widget>[
//            Container(
//              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
//              child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
//            ),
//            Text('Back',
//                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
//          ],
//        ),
//      ),
//    );
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      body: Container(
//        width: double.infinity,
//        height: double.infinity,
//        color: Colors.green,
//        child: Stack(
//          children: <Widget>[
//            Container(
//              width: double.infinity,
//              child: Padding(
//                padding: const EdgeInsets.only(top: 70.0),
//                child: RichText(
//                  textAlign: TextAlign.center,
//                  text: TextSpan(
//                      text: 'Gwa',
//                      style: TextStyle(
//                        fontFamily: 'HolyFat',
//                        fontSize: 40,
//                        fontWeight: FontWeight.w700,
//                        color: Constants.myWhite,
//                      ),
//                      children: [
//                        TextSpan(
//                          text: 'lior',
//                          style: TextStyle(
//                              fontFamily: 'HolyFat',
//                              color: Colors.black,
//                              fontSize: 40),
//                        ),
//                        TextSpan(
//                          text: 'Kart',
//                          style: TextStyle(
//                              fontFamily: 'HolyFat',
//                              color: Constants.myWhite,
//                              fontSize: 40),
//                        ),
//                      ]),
//                ),
//              ),
//            ),
//            Center(
//              child: Column(
//                crossAxisAlignment: CrossAxisAlignment.center,
//                mainAxisAlignment: MainAxisAlignment.center,
//                children: <Widget>[
//                  Icon(
//                    Icons.signal_wifi_off,
//                    color: Colors.white,
//                    size: 80.0,
//                  ),
//                  Padding(
//                    padding: const EdgeInsets.all(16.0),
//                    child: Text(
//                      'You are not connected to the internet.',
//                      style: TextStyle(color: Colors.white, fontSize: 22.0),
//                      textAlign: TextAlign.center,
//                    ),
//                  ),
//                ],
//              ),
//            ),
//            Positioned(top: 30, left: 0, child: _backButton()),
//          ],
//        ),
//      ),
//    );
//  }
//}
//
//enum ConnectivityState { offline, online }

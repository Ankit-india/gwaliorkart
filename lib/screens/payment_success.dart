import 'package:flutter/material.dart';
import 'package:gwaliorkart/utils/constants.dart';

class PaymentSuccess extends StatefulWidget {
  final int state;

  PaymentSuccess(this.state);

  @override
  _PaymentSuccessState createState() => _PaymentSuccessState();
}

class _PaymentSuccessState extends State<PaymentSuccess> {
  final MainAxisAlignment _mStart = MainAxisAlignment.start;
  final MainAxisAlignment _mCenter = MainAxisAlignment.center;
  final CrossAxisAlignment _cStart = CrossAxisAlignment.start;
  final CrossAxisAlignment _cCenter = CrossAxisAlignment.center;
  int _state;
  final double _iconSize = 80.0, _fontSize = 25.0;

  @override
  void initState() {
    _state = widget.state;
    super.initState();
  }

  Widget _success() {
    return Column(
      crossAxisAlignment: _cCenter,
      mainAxisAlignment: _mCenter,
      children: [
        Icon(
          Icons.check_circle,
          size: _iconSize,
          color: Constants.myGreen,
        ),
        Constants.height(20.0),
        Text("PAYMENT\nSUCCESSFUL",
            style: TextStyle(
                fontSize: _fontSize,
                letterSpacing: 1.0,
                color: Constants.myGreen,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center),
      ],
    );
  }

  Widget _failure() {
    return Column(
      crossAxisAlignment: _cCenter,
      mainAxisAlignment: _mCenter,
      children: [
        Icon(
          Icons.error_outline,
          size: _iconSize,
          color: Colors.red,
        ),
        Constants.height(20.0),
        Text("PAYMENT\nFAILED",
            style: TextStyle(
                fontSize: _fontSize,
                letterSpacing: 1.0,
                color: Colors.red,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center),
      ],
    );
  }

  Widget _externalWallet() {
    return Column(
      crossAxisAlignment: _cCenter,
      mainAxisAlignment: _mCenter,
      children: [
        Icon(
          Icons.account_balance_wallet,
          size: _iconSize,
          color: Constants.myGreen,
        ),
        Constants.height(20.0),
        Text("WALLET\nFAILED",
            style: TextStyle(
                fontSize: _fontSize,
                letterSpacing: 1.0,
                color: Constants.myGreen,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(elevation: 0.0,backgroundColor: Colors.transparent,),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          child: _state == 1
              ? _success()
              : _state == 2
                  ? _failure()
                  : _state == 3 ? _externalWallet() : Container(),
        ),
      ),
    );
  }
}

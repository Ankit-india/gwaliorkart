import 'package:flutter/material.dart';
import 'package:gwaliorkart/utils/constants.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class ConfirmOrder extends StatefulWidget {
  @override
  _ConfirmOrderState createState() => _ConfirmOrderState();
}

class _ConfirmOrderState extends State<ConfirmOrder> {


  Razorpay _razorPay;
  TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _razorPay = Razorpay();

    _razorPay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    _razorPay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    _razorPay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _razorPay.clear();
  }

  void _openCheckout(){
    final Map<String, dynamic> _options = {
      "key" : "rzp_test_9IxQ1XiYyGA7in",
      "amount" : num.parse(_textEditingController.text)*100,
      "name" : "Gwalior Cart",
      "description" : "Choose a payment method",
      "prefill" : {
        "contact" : "7739674343",
        "email" : "akhil@gmail.com"
      },
      "external" : {
        "wallets" : "paytm"
      }
    };

    print("\n\n_options:=> $_options\n\n");

    try{
      final _response = _razorPay.open(_options);
    }catch(_exp){
      print("\n\ncatch exp;=> ${_exp.toString()}\n\n");
    }

  }

  void handlerPaymentSuccess(){
    print("\n\nPayment success\n\n");
    Constants.showShortToastBuilder("\n\nPayment success\n\n");
//    Toast.show("Payment success", context);
  }

  void handlerErrorFailure(){
    print("\n\nPayment error\n\n");
    Constants.showShortToastBuilder("\n\nPayment error\n\n");
//    Toast.show("Payment error", context);
  }

  void handlerExternalWallet(){
    print("\n\nExternal Wallet\n\n");
    Constants.showShortToastBuilder("External Wallet");
//    Toast.show("External Wallet", context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Razor Pay Tutorial"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            TextField(
              controller: _textEditingController,
              decoration: InputDecoration(
                  hintText: "amount to pay"
              ),
            ),
            SizedBox(height: 12,),
            RaisedButton(
              color: Colors.blue,
              child: Text("Donate Now", style: TextStyle(
                  color: Colors.white
              ),),
              onPressed: () => _openCheckout(),
            )
          ],
        ),
      ),
    );
  }
}

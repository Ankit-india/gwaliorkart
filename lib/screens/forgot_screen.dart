//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutter/material.dart';
//import 'package:gwaliorkart/utils/constants.dart';
//
//class ForgotScreen extends StatefulWidget {
//  @override
//  _ForgotScreenState createState() => _ForgotScreenState();
//}
//
//class _ForgotScreenState extends State<ForgotScreen> {
//  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
//  TextEditingController email;
//
//  @override
//  void initState() {
//    super.initState();
//    email = TextEditingController();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        centerTitle: true,
//        title: Text("Forgot Password"),
//      ),
//      body: Center(
//        child: Padding(
//          padding: EdgeInsets.only(top: 50, left: 20, right: 20),
//          child: Form(
//            autovalidate: false,
//            key: _formKey,
//            child: Column(
//              children: <Widget>[
//                Text(
//                  "We will mail you a link...Please click on that link to reset your password",textAlign: TextAlign.center,
//                  style: TextStyle(fontSize: 20.0),
//                ),
//                SizedBox(
//                  height: 20,
//                ),
//                TextFormField(
//                  controller: email,
//                  keyboardType: TextInputType.emailAddress,
//                  autofocus: false,
//                  cursorColor: Constants.primary_green,
//                  decoration: InputDecoration(
//                    focusedBorder: OutlineInputBorder(
//                      borderRadius: BorderRadius.circular(10.0),
//                      borderSide: const BorderSide(
//                          color: Constants.primary_green, width: 1.5),
//                    ),
//                    hintText: 'Email',
//                    prefixIcon: Icon(Icons.email),
//                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
//                    border: OutlineInputBorder(
//                        borderRadius: BorderRadius.circular(10.0),
//                        borderSide: const BorderSide(
//                            color: Constants.primary_green, width: 1.5)),
//                  ),
//                  validator: (emailId) {
//                    if (emailId.isEmpty) {
//                      return 'Please enter email';
//                    }
//                    return null;
//                  },
//                ),
//                SizedBox(
//                  height: 20,
//                ),
//                InkWell(
//                  onTap: () {
//                    if (_formKey.currentState.validate()) {
//                      FirebaseAuth.instance
//                          .sendPasswordResetEmail(email: email.text)
//                          .then((dynamic result) {
//                        Constants.showShortToastBuilder(
//                            'Password link sent to your mail');
//                      });
//                    }
//                  },
//                  child: Container(
//                    width: MediaQuery.of(context).size.width,
//                    padding: EdgeInsets.symmetric(vertical: 10),
//                    alignment: Alignment.center,
//                    decoration: BoxDecoration(
//                      color: Constants.primary_green,
//                      borderRadius: BorderRadius.all(Radius.circular(10)),
//                      boxShadow: <BoxShadow>[
//                        BoxShadow(
//                            color: Colors.grey.shade200,
//                            offset: Offset(2, 4),
//                            blurRadius: 5,
//                            spreadRadius: 2)
//                      ],
//                    ),
//                    child: Text(
//                      'Send Email',
//                      style: TextStyle(fontSize: 20, color: Colors.white),
//                    ),
//                  ),
//                ),
//              ],
//            ),
//          ),
//        ),
//      ),
//    );
//  }
//}

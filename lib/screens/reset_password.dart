import 'package:flutter/material.dart';
import 'package:gwaliorkart/utils/auth_utils.dart';
import 'package:gwaliorkart/utils/constants.dart';
import 'package:gwaliorkart/widgets/connectivity_state.dart';
import 'package:gwaliorkart/widgets/locator.dart';

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  TextEditingController code, password, confirm;
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    code = TextEditingController();
    password = TextEditingController();
    confirm = TextEditingController();
//    locator<ConnectivityManager>().initConnectivity(context);
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Future reset() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      Constants.showLoadingIndicator(context);

      var resetParam = ResetData(
        code.text,
        password.text,
        confirm.text,
      );

      await AuthUtils.resetPassword(resetParam).then((dynamic result) {
        if (result.containsKey("success")) {
          Constants.showShortToastBuilder(result["success"]);
          Navigator.of(context).pushNamedAndRemoveUntil(
              '/login', (Route<dynamic> route) => false);
        } else if (result.containsKey("error")) {
          Constants.showLongToastBuilder(result["error"]);
          Navigator.of(context).pop();
        } else {
          Constants.showShortToastBuilder("Password reset failed.");
          Navigator.of(context).pop();
        }
      }).catchError((err) {
        print('Login error:=> $err');
        if (err == "SocketException") {
          Constants.showShortToastBuilder(
              "You're offline, Check your internet connection.");
          Navigator.of(context).pop();
        } else if (err.runtimeType.toString() == "FormatException") {
          Constants.showShortToastBuilder("Oops something is wrong.");
          Navigator.of(context).pop();
        }
      });
    } else {
      return null;
    }
  }

  InkWell _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.0),
        child: Row(
          children: <Widget>[
            Icon(
              Icons.navigate_before,
              color: Constants.primary_green,
            ),
            Text('Back',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Constants.primary_green,
                ))
          ],
        ),
      ),
      splashColor: Constants.myWhite,
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'Gwa',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Constants.primary_green,
          ),
          children: [
            TextSpan(
              text: 'lior',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
            TextSpan(
              text: 'Kart',
              style: TextStyle(color: Constants.primary_green, fontSize: 30),
            ),
          ]),
    );
  }

  Widget _reset() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('RESET',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.5,
              color: Constants.primary_green,
            ))
      ],
    );
  }

  Widget _codeField() {
    return TextFormField(
      controller: code,
      keyboardType: TextInputType.number,
      autofocus: false,
      cursorColor: Constants.primary_green,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide:
              const BorderSide(color: Constants.primary_green, width: 1.5),
        ),
        hintText: 'Code',
        prefixIcon: Icon(Icons.confirmation_number),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide:
                const BorderSide(color: Constants.primary_green, width: 1.5)),
      ),
      validator: (emailId) {
        if (emailId.isEmpty) {
          return 'Please enter confirmation code';
        }
        return null;
      },
    );
  }

  Widget _passwordField() {
    return TextFormField(
      controller: password,
      autofocus: false,
      obscureText: _obscureText,
      cursorColor: Constants.primary_green,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide:
              const BorderSide(color: Constants.primary_green, width: 1.5),
        ),
        hintText: 'Password',
        prefixIcon: Icon(Icons.lock),
        suffixIcon: IconButton(
            icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
            onPressed: _toggle),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
      ),
      validator: (pwd) {
        if (pwd.isEmpty) {
          return 'Please enter password.';
        }
        return null;
      },
    );
  }

  Widget _confirmPasswordField() {
    return TextFormField(
      controller: confirm,
      autofocus: false,
      obscureText: _obscureText,
      cursorColor: Constants.primary_green,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide:
              const BorderSide(color: Constants.primary_green, width: 1.5),
        ),
        hintText: 'Confirm Password',
        prefixIcon: Icon(Icons.lock),
        suffixIcon: IconButton(
            icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
            onPressed: _toggle),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
      ),
      validator: (cnfPwd) {
        if (cnfPwd.isEmpty) {
          return 'Please enter confirm password.';
        } else if (cnfPwd.length < 6) {
          return 'Password too short.';
        } else if (password.text != cnfPwd) {
          return 'Confirm password do not match.';
        }
        return null;
      },
    );
  }

  Widget _resetButton() {
    return InkWell(
      onTap: () async {
        reset();
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Constants.primary_green,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.shade200,
                offset: Offset(2, 4),
                blurRadius: 5,
                spreadRadius: 2)
          ],
        ),
        child: Text(
          'Reset',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: _body(),
    );
  }

  Widget _body() {
    final height = MediaQuery.of(context).size.height;
    return Container(
      height: height,
      child: Stack(
        children: <Widget>[
          Form(
            key: _formKey,
            autovalidate: false,
            child: Center(
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                children: <Widget>[
                  Constants.logo(),
                  Constants.height(height * 0.08),
                  _reset(),
                  Constants.height(30),
                  _codeField(),
                  Constants.height(30),
                  _passwordField(),
                  Constants.height(30),
                  _confirmPasswordField(),
                  Constants.height(30),
                  _resetButton(),
                ],
              ),
            ),
          ),
          Positioned(top: 40, left: 0, child: _backButton()),
        ],
      ),
    );
  }
}

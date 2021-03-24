import 'package:flutter/material.dart';
import 'package:gwaliorkart/utils/auth_utils.dart';
import 'package:gwaliorkart/utils/constants.dart';
import 'package:gwaliorkart/widgets/widget_page.dart';

class PasswordChange extends StatefulWidget {
  @override
  _PasswordChangeState createState() => _PasswordChangeState();
}

class _PasswordChangeState extends State<PasswordChange> {
  final GlobalKey<FormState> _passwordKey = GlobalKey<FormState>();
  TextEditingController _password, _confirm;
  bool _validate = false, _obscureText = true;
  String _customerId, _email;

  @override
  void initState() {
    _customerId = AuthUtils.userId;
    _email = AuthUtils.userEmailId;
    _password = TextEditingController();
    _confirm = TextEditingController();
    super.initState();
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Future<void> _changePassword() async {
    if (_passwordKey.currentState.validate()) {
      _passwordKey.currentState.save();
      Constants.showLoadingIndicator(context);
      PasswordData _passwordParam =
          PasswordData(_customerId, _email, _password.text, _confirm.text);

      await AuthUtils.changePassword(_passwordParam)
          .then((dynamic _result) async {
        if (_result != null &&
            _result.containsKey("success") &&
            _result['success'] != null) {
          print("Success: Your password has been successfully updated.");
          Navigator.of(context).pop();
          Navigator.of(context).pop();
          _passwordKey.currentState.reset();
          Constants.showShortToastBuilder(_result['success']);
        } else if (_result.containsKey("error_warning") &&
            _result['error_warning'] != null) {
          Navigator.of(context).pop();
          Constants.showLongToastBuilder(_result['error_warning']);
        } else {
          Navigator.of(context).pop();
          Constants.showShortToastBuilder("Password change failed.");
        }
      }).catchError((err) {
        if (err == "SocketException") {
          Navigator.of(context).pop();
          Constants.showShortToastBuilder(
              "You're offline, Check your internet connection.");
        } else if (err.runtimeType.toString() == "FormatException") {
          Navigator.of(context).pop();
          Constants.showShortToastBuilder("Oops something is wrong.");
        }
      });
    } else {
      setState(() {
        _validate = true;
      });
    }
  }

  @override
  void dispose() {
    _password.dispose();
    _confirm.dispose();
    super.dispose();
  }

  InputDecoration _inputDecoration(final String _label) {
    return InputDecoration(
      labelText: _label,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.0),
        borderSide:
            const BorderSide(color: Constants.primary_green, width: 1.5),
      ),
      prefixIcon: Icon(Icons.lock),
      suffixIcon: IconButton(
          icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
          onPressed: _toggle),
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
    );
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      color: Constants.primary_green,
      borderRadius: BorderRadius.all(Radius.circular(5)),
      boxShadow: <BoxShadow>[
        BoxShadow(
            color: Colors.grey.shade200,
            offset: Offset(2, 4),
            blurRadius: 5,
            spreadRadius: 2)
      ],
    );
  }

  TextFormField _passwordField() {
    return TextFormField(
      controller: _password,
      obscureText: _obscureText,
      cursorColor: Constants.primary_green,
      decoration: _inputDecoration('Password'),
      validator: (pwd) {
        if (pwd.isEmpty) {
          return 'Please enter password.';
        } else if (pwd.length < 6) {
          return 'Password too short.';
        }
        return null;
      },
    );
  }

  TextFormField _confirmPasswordField() {
    return TextFormField(
      controller: _confirm,
      obscureText: _obscureText,
      cursorColor: Constants.primary_green,
      decoration: _inputDecoration('Confirm Password'),
      validator: (cnfPwd) {
        if (cnfPwd.isEmpty) {
          return 'Please enter confirm password.';
        } else if (cnfPwd.length < 6) {
          return 'Password too short.';
        } else if (_password.text != cnfPwd) {
          return 'Confirm password do not match.';
        }
        return null;
      },
      onFieldSubmitted: (term) async {
        if (_password.text != '' && _confirm.text != '') {
          await _changePassword();
        }
      },
    );
  }

  Widget _updateButton() {
    return InkWell(
      onTap: () async => _changePassword(),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 10),
        alignment: Alignment.center,
        decoration: _boxDecoration(),
        child: Text(
          'CONTINUE',
          style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              letterSpacing: 0.5,
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetPage.passwordAppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Form(
          autovalidate: _validate,
          key: _passwordKey,
          child: Column(
            children: [
              Constants.height(40.0),
              _passwordField(),
              Constants.height(40.0),
              _confirmPasswordField(),
              Constants.height(40.0),
              _updateButton(),
              Constants.height(40.0),
            ],
          ),
        ),
      ),
    );
  }
}

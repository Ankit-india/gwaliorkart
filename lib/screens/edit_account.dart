import 'package:flutter/material.dart';
import 'package:gwaliorkart/utils/auth_utils.dart';
import 'package:gwaliorkart/utils/constants.dart';
import 'package:gwaliorkart/widgets/widget_page.dart';

class EditAccount extends StatefulWidget {
  final EditAccountData editData;

  EditAccount(this.editData);

  @override
  _EditAccountState createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  TextEditingController _firstName, _lastName, _email, _preEmail, _telephone;
  EditAccountData _editData;
  bool _validate = false;
  String _customerId, _name, _image, _password, _token, _totalReward, _country;

  @override
  void initState() {
    widget.editData != null ? _editData = widget.editData : _editData = null;
    _customerId = AuthUtils.userId;
    _name = AuthUtils.userFullName;
    _image = AuthUtils.userImage;
    _password = AuthUtils.userPassword;
    _token = AuthUtils.authToken;
    _totalReward = AuthUtils.totalReward;
    _country = AuthUtils.country;
    _firstName = TextEditingController(text: _editData.firstName);
    _lastName = TextEditingController(text: _editData.lastName);
    _email = TextEditingController(text: _editData.email);
    _preEmail = TextEditingController(text: _editData.email);
    _telephone = TextEditingController(text: _editData.telephone);
    super.initState();
  }

  Future<void> _update() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      Constants.showLoadingIndicator(context);
      EditAccountData _updateParam = EditAccountData(
          _customerId,
          _firstName.text,
          _lastName.text,
          _email.text,
          _preEmail.text,
          _telephone.text);

      await AuthUtils.updateProfile(_updateParam).then((dynamic _result) async {
        if (_result != null &&
            _result.containsKey("success") &&
            _result['success'] != null) {
          print("Success: Your account has been successfully updated.");
          await Constants.setAndGetUserInfo(
                  _result['firstname'],
                  _result['lastname'],
                  '${_result['firstname']} ${_result['lastname']}',
                  _result['email'],
                  _result['telephone'],
                  _image,
                  _password,
                  _customerId,
                  _token,
                  _totalReward.toString(),
                  _country)
              .then((dynamic _setRes) {
            print("setAndGetUserInfo:= $_setRes");
            Navigator.of(context).pop();
            Navigator.of(context).pop();
            _formKey.currentState.reset();
            Constants.showShortToastBuilder(_result['success']);
          }).catchError((_err) {
            print("setAndGetUserInfo catchError:= $_err");
            Constants.showLongToastBuilder("setAndGetUserInfo failed.");
          });
        } else if (_result.containsKey("error_warning") &&
            _result['error_warning'] != null) {
          Constants.showLongToastBuilder(_result['error_warning']);
          Navigator.of(context).pop();
        } else {
          Constants.showShortToastBuilder("Profile update failed.");
          Navigator.of(context).pop();
        }
      }).catchError((err) {
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
      setState(() {
        _validate = true;
      });
    }
  }

  InputDecoration _inputDecoration(final String _label) {
    return InputDecoration(
      labelText: _label,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.0),
        borderSide:
            const BorderSide(color: Constants.primary_green, width: 1.5),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
    );
  }

  Widget _firstNameField() {
    return TextFormField(
      controller: _firstName,
      keyboardType: TextInputType.text,
      cursorColor: Constants.primary_green,
      decoration: _inputDecoration('First Name'),
      validator: (fName) {
        if (fName.isEmpty) {
          return 'Please enter first name.';
        }
        return null;
      },
    );
  }

  Widget _lastNameField() {
    return TextFormField(
      controller: _lastName,
      keyboardType: TextInputType.text,
      cursorColor: Constants.primary_green,
      decoration: _inputDecoration('Last Name'),
      validator: (lName) {
        if (lName.isEmpty) {
          return 'Please enter last name.';
        }
        return null;
      },
    );
  }

  Widget _emailField() {
    return TextFormField(
      controller: _email,
      keyboardType: TextInputType.emailAddress,
      cursorColor: Constants.primary_green,
      decoration: _inputDecoration('Email'),
      validator: (emailId) {
        if (emailId.isEmpty) {
          return 'Please enter email.';
        }
        return null;
      },
    );
  }

  Widget _preEmailField() {
    return TextFormField(
      controller: _preEmail,
      keyboardType: TextInputType.emailAddress,
      cursorColor: Constants.primary_green,
      decoration: _inputDecoration('Pre Email'),
      validator: (emailId) {
        if (emailId.isEmpty) {
          return 'Please enter pre email.';
        }
        return null;
      },
    );
  }

  Widget _phoneField() {
    return TextFormField(
      controller: _telephone,
      keyboardType: TextInputType.phone,
      cursorColor: Constants.primary_green,
      decoration: _inputDecoration('Phone'),
      validator: (phone) {
        if (phone.isEmpty) {
          return 'Please enter phone number.';
        } else if (phone.length < 10 || phone.length > 10) {
          return 'Invalid phone number.';
        }
        return null;
      },
    );
  }

  Widget _updateButton() {
    return InkWell(
      onTap: () async => _update(),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Constants.primary_green,
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.shade200,
                offset: Offset(2, 4),
                blurRadius: 5,
                spreadRadius: 2)
          ],
        ),
        child: Text(
          'UPDATE',
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
      appBar: WidgetPage.updateProfileAppBar(),
      body: Form(
        key: _formKey,
        autovalidate: _validate,
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: <Widget>[
                Constants.height(35.0),
                _firstNameField(),
                Constants.height(35.0),
                _lastNameField(),
                Constants.height(35.0),
                _emailField(),
                Constants.height(35.0),
                _preEmailField(),
                Constants.height(35.0),
                _phoneField(),
                Constants.height(35.0),
                _updateButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _firstName.dispose();
    _lastName.dispose();
    _email.dispose();
    _preEmail.dispose();
    _telephone.dispose();
    super.dispose();
  }
}

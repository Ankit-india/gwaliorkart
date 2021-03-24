import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:gwaliorkart/screens/login.dart';
import 'package:gwaliorkart/utils/auth_utils.dart';
import 'package:gwaliorkart/utils/constants.dart';
import 'package:gwaliorkart/widgets/connectivity_state.dart';
import 'package:gwaliorkart/widgets/locator.dart';

class SignUp extends StatefulWidget {
  SignUp({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  TextEditingController firstName,
      lastName,
      email,
      telephone,
      password,
      confirm;
  bool _obscureText = true,
      agree = false,
      newsletter = false,
      loading = false,
      hidePass = true,
      isLoggedIn = false;
  FirebaseAuth auth;
  GoogleSignIn _googleSignUp;
  FacebookLogin _fbSignUp;
  DateTime currentBackPressTime;

  @override
  void initState() {
    super.initState();
    firstName = TextEditingController();
    lastName = TextEditingController();
    email = TextEditingController();
    telephone = TextEditingController();
    password = TextEditingController();
    confirm = TextEditingController();
    agree = false;
    newsletter = true;
    auth = FirebaseAuth.instance;
    _googleSignUp = GoogleSignIn();
    _fbSignUp = FacebookLogin();
//    locator<ConnectivityManager>().initConnectivity(context);
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Future<void> register() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      Constants.showLoadingIndicator(context);
      SignUpData signUpParam = SignUpData(
          firstName.text,
          lastName.text,
          email.text,
          telephone.text,
          password.text,
          confirm.text,
          agree,
          newsletter);

      await AuthUtils.signUpUser(signUpParam).then((dynamic result) {
        if (result != null && result.containsKey("success")) {
          Constants.showShortToastBuilder(result['success']);
          Navigator.of(context).pushNamedAndRemoveUntil(
              '/login', (Route<dynamic> route) => false);
        } else if (result.containsKey("error")) {
          Constants.showLongToastBuilder(result['error']);
          Navigator.of(context).pop();
        } else {
          Constants.showShortToastBuilder("Sign up failed.");
          Navigator.of(context).pop();
        }
      }).catchError((err) {
        if (err == "SocketException") {
          Constants.showLongToastBuilder(
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

  Future<void> _signUpWithFacebook() async {
    Constants.showLoadingIndicator(context);
    await _fbSignUp.logIn(['email']).then((dynamic _res1) async {
      if (_res1.status != FacebookLoginStatus.cancelledByUser) {
        if (_res1.status == FacebookLoginStatus.loggedIn) {
          final String _token = _res1.accessToken.token;
          if (_token != null && _token != '') {
            final AuthCredential _credential =
                FacebookAuthProvider.getCredential(accessToken: _token);
            await auth
                .signInWithCredential(_credential)
                .then((dynamic _res3) async {
              print("signInWithFacebook Response:=> $_res3");
              final AuthResult _authResult = _res3;
              final Map<String, dynamic> _profile =
                  _authResult.additionalUserInfo.profile;
              SignUpData _facebookParam = SignUpData(
                  _profile['first_name'] != null ? _profile['first_name'] : '',
                  _profile['last_name'] != null ? _profile['last_name'] : '',
                  _profile['email'] != null ? _profile['email'] : '',
                  null,
                  null,
                  null,
                  null,
                  null);
              await AuthUtils.signUpWithSocial(
                      _facebookParam,
                      _profile['picture']['data']['url'],
                      _profile['password'],
                      context)
                  .then((_res5) {
                if (_res5 != null && _res5['customer_id'] != null && _res5['token'] != null) {
                  Constants.showShortToastBuilder("Logged in");
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/home', (Route<dynamic> route) => false);
                }else{
                  Navigator.of(context).pop();
                  Constants.showShortToastBuilder("Login failed.");
                }
              }).catchError((_err1) {
                Navigator.of(context).pop();
                Constants.showShortToastBuilder("signUpWithFacebook failed.");
              });
            }).catchError((_err3) {
              Navigator.of(context).pop();
              Constants.showShortToastBuilder("signInWithCredential failed.");
            });
          }
        }
      } else {
        Navigator.of(context).pop();
        Constants.showShortToastBuilder("Login canceled");
      }
    }).catchError((_err1) {
      Navigator.of(context).pop();
      Constants.showShortToastBuilder("Login failed");
    });
  }

  Future<void> _signUpWithGoogle() async {
    Constants.showLoadingIndicator(context);
    await _googleSignUp.signIn().then((dynamic _res1) async {
      await _res1.authentication.then((dynamic _res2) async {
        final GoogleSignInAuthentication _googleAuth = _res2;
        if (_googleAuth.accessToken != null && _googleAuth.accessToken != '') {
          final AuthCredential _credential = GoogleAuthProvider.getCredential(
            accessToken: _googleAuth.accessToken,
            idToken: _googleAuth.idToken,
          );
          await auth
              .signInWithCredential(_credential)
              .then((dynamic _res4) async {
            print("signInWithGoogle Response:=> $_res4");
            final AuthResult _authResult = _res4;
            final Map<String, dynamic> _profile =
                _authResult.additionalUserInfo.profile;
            SignUpData _googleParam = SignUpData(
                _profile['given_name'] != null ? _profile['given_name'] : '',
                _profile['family_name'] != null ? _profile['family_name'] : '',
                _profile['email'] != null ? _profile['email'] : '',
                null,
                null,
                null,
                null,
                null);
            await AuthUtils.signUpWithSocial(_googleParam, _profile['picture'],
                    _profile['password'], context)
                .then((_res6) {
              if (_res6 != null && _res6['customer_id'] != null && _res6['token'] != null) {
                Constants.showShortToastBuilder("Logged in");
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/home', (Route<dynamic> route) => false);
              }else{
                Navigator.of(context).pop();
                Constants.showShortToastBuilder("Login failed.");
              }
            }).catchError((_err6) {
              Navigator.of(context).pop();
              Constants.showShortToastBuilder("signUpWithGoogle failed.");
            });
            final FirebaseUser _user = _authResult.user;
            assert(_user.email != null);
            assert(_user.displayName != null);
            assert(!_user.isAnonymous);
            assert(await _user.getIdToken() != null);
            await auth.currentUser().then((dynamic _res7) async {
              final FirebaseUser _currentUser = _res7;
              assert(_user.uid == _currentUser.uid);
            }).catchError((_err7) {
              Navigator.of(context).pop();
              Constants.showShortToastBuilder("currentUser failed.");
            });
          }).catchError((_err4) {
            Navigator.of(context).pop();
            Constants.showShortToastBuilder("signInWithCredential failed.");
          });
        }
      }).catchError((_err2) {
        Navigator.of(context).pop();
        Constants.showShortToastBuilder("authentication failed");
      });
    }).catchError((_err1) {
      Navigator.of(context).pop();
      Constants.showShortToastBuilder("_googleSignIn failed");
    });
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Constants.showShortToastBuilder("Tap back again to leave");
      return Future.value(false);
    }
    return Future.value(true);
  }

  InkWell _skipButton() {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () => Navigator.of(context)
          .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.0),
        child: RichText(
          text: TextSpan(
              text: 'Skip ',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Constants.primary_green,
              ),
              children: [
                TextSpan(
                  text: '>',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Constants.primary_green,
                  ),
                ),
              ]),
        ),
      ),
    );
  }

  /*InkWell _skipButton() {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.0),
        child: Row(
          children: <Widget>[
            Text('Skip',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Constants.primary_green,
                )),
            Icon(
              Icons.navigate_next,
              color: Constants.primary_green,
            ),
          ],
        ),
      ),
    );
  }*/

  Widget _signUpLabel() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('SIGNUP',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.5,
              color: Constants.primary_green,
            ))
      ],
    );
  }

  Widget firstNameField() {
    return TextFormField(
      controller: firstName,
      keyboardType: TextInputType.text,
      autofocus: false,
      cursorColor: Constants.primary_green,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide:
              const BorderSide(color: Constants.primary_green, width: 1.5),
        ),
        hintText: 'First Name',
        prefixIcon: Icon(Icons.supervised_user_circle),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
      ),
      validator: (fName) {
        if (fName.isEmpty) {
          return 'Please enter first name.';
        }
        return null;
      },
    );
  }

  Widget lastNameField() {
    return TextFormField(
      controller: lastName,
      keyboardType: TextInputType.text,
      autofocus: false,
      cursorColor: Constants.primary_green,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide:
              const BorderSide(color: Constants.primary_green, width: 1.5),
        ),
        hintText: 'Last Name',
        prefixIcon: Icon(Icons.supervised_user_circle),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
      ),
      validator: (lName) {
        if (lName.isEmpty) {
          return 'Please enter last name.';
        }
        return null;
      },
    );
  }

  Widget emailField() {
    return TextFormField(
      controller: email,
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      cursorColor: Constants.primary_green,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide:
              const BorderSide(color: Constants.primary_green, width: 1.5),
        ),
        hintText: 'Email',
        prefixIcon: Icon(Icons.email),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      validator: (emailId) {
        if (emailId.isEmpty) {
          return 'Please enter email.';
        }
        return null;
      },
    );
  }

  Widget phoneField() {
    return TextFormField(
      controller: telephone,
      keyboardType: TextInputType.phone,
      autofocus: false,
      cursorColor: Constants.primary_green,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide:
              const BorderSide(color: Constants.primary_green, width: 1.5),
        ),
        hintText: 'Phone',
        prefixIcon: Icon(Icons.smartphone),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
      ),
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

  Widget passwordField() {
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
        } else if (pwd.length < 6) {
          return 'Password too short.';
        }
        return null;
      },
    );
  }

  Widget confirmPasswordField() {
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

  _tAndCDetail() {}

  Text _tAndCTitle() {
    TextStyle _style =
        TextStyle(color: Constants.primary_green, fontStyle: FontStyle.italic);
    return Text(
      "Agree to Terms & Conditions",
      style: _style,
    );
  }

  Widget _agree() {
    return CheckboxListTile(
      title: InkWell(
        onTap: _tAndCDetail,
        child: _tAndCTitle(),
      ),
      value: agree,
      onChanged: (val) {
        if (agree == false) {
          setState(() {
            agree = val;
          });
        } else if (agree == true) {
          setState(() {
            agree = val;
          });
        }
      },
      dense: true,
      controlAffinity: ListTileControlAffinity.leading, //  <-- leading Checkbox
    );
  }

  Widget _signUpButton() {
    return InkWell(
      onTap: () async {
        register();
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
          'Register',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget _divider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          Constants.width(20.0),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          Text('or'),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          Constants.width(20.0),
        ],
      ),
    );
  }

  Widget _facebookButton() {
    return InkWell(
      onTap: () async {
        _signUpWithFacebook();
      },
      child: Container(
        height: 50,
        margin: EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xff1959a9),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(5),
                      topLeft: Radius.circular(5)),
                ),
                alignment: Alignment.center,
                child: Text('f',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w400)),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xff2872ba),
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(5),
                      topRight: Radius.circular(5)),
                ),
                alignment: Alignment.center,
                child: Text('Log in with Facebook',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w400)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _googleButton() {
    return InkWell(
      onTap: () async {
        _signUpWithGoogle();
      },
      child: Container(
        height: 50,
        margin: EdgeInsets.symmetric(vertical: 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(5),
                      topLeft: Radius.circular(5)),
                ),
                alignment: Alignment.center,
                child: Text('G',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w400)),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(5),
                      topRight: Radius.circular(5)),
                ),
                alignment: Alignment.center,
                child: Text('Log in with Google',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w400)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _loginAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Login()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Already have an account ?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            Constants.width(10.0),
            Text(
              'Login',
              style: TextStyle(
                  color: Constants.primary_green,
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(child: _body(), onWillPop: onWillPop),
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
                  Constants.height(height * 0.1),
                  Constants.logo(),
                  Constants.height(height * 0.08),
                  _signUpLabel(),
                  Constants.height(30.0),
                  firstNameField(),
                  Constants.height(20.0),
                  lastNameField(),
                  Constants.height(20.0),
                  emailField(),
                  Constants.height(20.0),
                  phoneField(),
                  Constants.height(20.0),
                  passwordField(),
                  Constants.height(20.0),
                  confirmPasswordField(),
                  _agree(),
                  Constants.height(20.0),
                  _signUpButton(),
                  Constants.height(10.0),
                  _divider(),
                  _facebookButton(),
                  _googleButton(),
                  _loginAccountLabel(),
                ],
              ),
            ),
          ),
          Positioned(top: 35, right: 5, child: _skipButton()),
        ],
      ),
    );
  }
}

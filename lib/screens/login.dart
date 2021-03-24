import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:gwaliorkart/screens/reset_password.dart';
import 'package:gwaliorkart/screens/signup.dart';
import 'package:gwaliorkart/utils/auth_utils.dart';
import 'package:gwaliorkart/utils/constants.dart';
import 'package:gwaliorkart/widgets/connectivity_state.dart';
import 'package:gwaliorkart/widgets/locator.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final GlobalKey<FormState> _resetKey = new GlobalKey<FormState>();
  TextEditingController email, resetEmail, password;
  bool _obscureText = true,
      loading = false,
      hidePass = true,
      isLoggedIn = false;
  FirebaseAuth auth;
  GoogleSignIn _googleSignIn;
  FacebookLogin _fbLogIn;
  DateTime currentBackPressTime;

  @override
  void initState() {
    super.initState();
    email = TextEditingController();
    resetEmail = TextEditingController();
    password = TextEditingController();
    auth = FirebaseAuth.instance;
    _googleSignIn = GoogleSignIn();
    _fbLogIn = FacebookLogin();
//    locator<ConnectivityManager>().initConnectivity(context);
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _showForgotFormDialog() {
    var alert = AlertDialog(
      content: ListTile(
        title: Text(
          "Password Reset Link Will Be Sent To Your EmailID",
          textAlign: TextAlign.center,
        ),
        subtitle: Form(
          key: _resetKey,
          autovalidate: false,
          child: TextFormField(
            autovalidate: false,
            controller: resetEmail,
            autocorrect: true,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.alternate_email, color: Colors.blueGrey),
              hintText: "Enter Your Email",
              labelText: "Email",
            ),
            // ignore: missing_return
            validator: (val) {
              if (val.isEmpty) {
                return "Please Enter Your Email.";
              }
            },
            onSaved: (val) {
              resetEmail.text = val;
            },
          ),
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text("Cancel"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text("Send"),
          onPressed: () async {
            _forgotPassword();
          },
        ),
      ],
    );
    showDialog(context: context, builder: (_) => alert);
  }

  Future<void> signIn() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      Constants.showLoadingIndicator(context);
      LoginData loginParam = LoginData(
        email.text,
        password.text,
      );

      await AuthUtils.loginUser(loginParam).then((dynamic _loginRes) {
        if (_loginRes != null &&
            _loginRes.containsKey("success") &&
            _loginRes['customer_id'] != null &&
            _loginRes['token'] != null) {
          Constants.showShortToastBuilder('Logged in');
          Navigator.of(context).pushNamedAndRemoveUntil(
              '/home', (Route<dynamic> route) => false);
        } else if (_loginRes.containsKey("error")) {
          Navigator.of(context).pop();
          Constants.showLongToastBuilder(_loginRes["error"]);
        } else {
          Navigator.of(context).pop();
          Constants.showShortToastBuilder("Login failed.");
        }
      }).catchError((err) {
        if (err == "SocketException") {
          Constants.showShortToastBuilder(
              "You're offline, Check your internet connection.");
          Navigator.of(context).pop();
        } else if (err.runtimeType.toString() == "FormatException") {
          Navigator.of(context).pop();
          Constants.showShortToastBuilder("Oops something is wrong.");
        } else {}
      });
    } else {
      return null;
    }
  }

  Future<void> _signInWithFacebook() async {
    Constants.showLoadingIndicator(context);
    await _fbLogIn.logIn(['email']).then((dynamic _res1) async {
      if (_res1.status != FacebookLoginStatus.cancelledByUser) {
        if (_res1.status == FacebookLoginStatus.loggedIn) {
          final String _token = _res1.accessToken.token;
          if (_token != null && _token != '') {
            final AuthCredential _credential =
                FacebookAuthProvider.getCredential(accessToken: _token);
            await auth
                .signInWithCredential(_credential)
                .then((dynamic _res2) async {
              print("signInWithFacebook Response:=> $_res2");
              final AuthResult _authResult = _res2;
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
                  .then((_res3) {
                if (_res3 != null &&
                    _res3['customer_id'] != null &&
                    _res3['token'] != null) {
                  Constants.showShortToastBuilder("Logged in");
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/home', (Route<dynamic> route) => false);
                } else {
                  Navigator.of(context).pop();
                  Constants.showShortToastBuilder("Login failed.");
                }
              }).catchError((_err3) {
                Navigator.of(context).pop();
                print("signUpWithFacebook catchError $_err3");
                Constants.showShortToastBuilder("signUpWithFacebook failed.");
              });
            }).catchError((_err2) {
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

  Future<void> _signInWithGoogle() async {
    Constants.showLoadingIndicator(context);
    await _googleSignIn.signIn().then((dynamic _res1) async {
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
              if (_res6 != null &&
                  _res6['customer_id'] != null &&
                  _res6['token'] != null) {
                Constants.showShortToastBuilder("Logged in");
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/home', (Route<dynamic> route) => false);
              } else {
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

  /*Future<void> _signInWithFacebook() async {
    Constants.showLoadingIndicator(context);
    await _fbLogIn.logIn(['email']).then((dynamic _res1) async {
      if (_res1.status != FacebookLoginStatus.cancelledByUser) {
        if (_res1.status == FacebookLoginStatus.loggedIn) {
          final String _token = _res1.accessToken.token;
          await Constants.setTokenAndGetUserInfo(_token)
              .then((dynamic _res2) async {
            if (AuthUtils.authToken != null && AuthUtils.authToken != '') {
              final AuthCredential _credential =
                  FacebookAuthProvider.getCredential(
                      accessToken: AuthUtils.authToken);
              await auth
                  .signInWithCredential(_credential)
                  .then((dynamic _res3) async {
                print("signInWithFacebook Response:=> $_res3");
                final AuthResult _authResult = _res3;
                final Map<String, dynamic> _profile =
                    _authResult.additionalUserInfo.profile;
                await Constants.setAndGetUserInfo(
                        _profile['first_name'],
                        _profile['last_name'],
                        _profile['name'],
                        _profile['email'],
                        _profile['phone'],
                        _profile['picture']['data']['url'],
                        _profile['password'],
                        _profile['customer_id'],
                        _profile['token'])
                    .then((dynamic _res4) async {
                  if (_authResult.additionalUserInfo.isNewUser) {
                    SignUpData _facebookParam = SignUpData(
                        AuthUtils.userFirstName,
                        AuthUtils.userLastName,
                        AuthUtils.userEmailId,
                        null,
                        null,
                        null,
                        null,
                        null);
                    await AuthUtils.signUpWithSocial(_facebookParam)
                        .then((_res5) {
                      Constants.showShortToastBuilder("Logged in");
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/home', (Route<dynamic> route) => false);
                    }).catchError((_err1) {
                      Navigator.of(context).pop();
                      Constants.showShortToastBuilder(
                          "signUpWithFacebook failed.");
                    });
                  } else {
                    Constants.showShortToastBuilder("Logged in");
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/home', (Route<dynamic> route) => false);
                  }
                }).catchError((_err4) {
                  Navigator.of(context).pop();
                  Constants.showShortToastBuilder("setAndGetUserInfo failed.");
                });
              }).catchError((_err3) {
                Navigator.of(context).pop();
                Constants.showShortToastBuilder("signInWithCredential failed.");
              });
            }
          }).catchError((_err2) {
            Navigator.of(context).pop();
            Constants.showShortToastBuilder("setTokenAndGetUserInfo failed.");
          });
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

  Future<void> _signInWithGoogle() async {
    Constants.showLoadingIndicator(context);
    await _googleSignIn.signIn().then((dynamic _res1) async {
      final GoogleSignInAccount _googleUser = _res1;
      await _res1.authentication.then((dynamic _res2) async {
        final GoogleSignInAuthentication _googleAuth = _res2;
        await Constants.setTokenAndGetUserInfo(_googleAuth.accessToken)
            .then((dynamic _res3) async {
          if (AuthUtils.authToken != null && AuthUtils.authToken != '') {
            final AuthCredential _credential = GoogleAuthProvider.getCredential(
              accessToken: AuthUtils.authToken,
              idToken: _googleAuth.idToken,
            );
            await auth
                .signInWithCredential(_credential)
                .then((dynamic _res4) async {
              print("signInWithGoogle Response:=> $_res4");
              final AuthResult _authResult = _res4;
              final Map<String, dynamic> _profile =
                  _authResult.additionalUserInfo.profile;
              await Constants.setAndGetUserInfo(
                      _profile['given_name'],
                      _profile['family_name'],
                      _profile['name'],
                      _profile['email'],
                      _profile['phone'],
                      _profile['picture'],
                      _profile['password'],
                      _profile['customer_id'],
                      _profile['token'])
                  .then((dynamic _res5) async {
                if (_authResult.additionalUserInfo.isNewUser) {
                  SignUpData _googleParam = SignUpData(
                      AuthUtils.userFirstName,
                      AuthUtils.userLastName,
                      AuthUtils.userEmailId,
                      null,
                      null,
                      null,
                      null,
                      null);
                  await AuthUtils.signUpWithSocial(_googleParam).then((_res6) {
                    Constants.showShortToastBuilder("Logged in");
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/home', (Route<dynamic> route) => false);
                  }).catchError((_err6) {
                    Navigator.of(context).pop();
                    Constants.showShortToastBuilder("signUpWithGoogle failed.");
                  });
                } else {
                  Constants.showShortToastBuilder("Logged in");
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/home', (Route<dynamic> route) => false);
                }
              }).catchError((_err5) {
                Navigator.of(context).pop();
                Constants.showShortToastBuilder("setAndGetUserInfo failed.");
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
        }).catchError((_err3) {
          Navigator.of(context).pop();
          Constants.showShortToastBuilder("setTokenAndGetUserInfo failed.");
        });
      }).catchError((_err2) {
        Navigator.of(context).pop();
        Constants.showShortToastBuilder("authentication failed");
      });
    }).catchError((_err1) {
      Navigator.of(context).pop();
      Constants.showShortToastBuilder("_googleSignIn failed");
    });
  }*/

  Future<void> _forgotPassword() async {
    if (_resetKey.currentState.validate()) {
      _resetKey.currentState.save();
      Constants.showLoadingIndicator(context);

      var forgotParam = ForgotData(resetEmail.text);

      await AuthUtils.forgotPassword(forgotParam).then((dynamic result) {
        if (result.containsKey("success")) {
          Constants.showShortToastBuilder(result["success"]);
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return ResetPassword();
          })).then((result) {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          });
        } else if (result.containsKey("error")) {
          Constants.showShortToastBuilder(result["error"]);
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        } else {
          Constants.showShortToastBuilder("Login failed.");
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        }
      }).catchError((err) {
        if (err == "SocketException") {
          Constants.showShortToastBuilder(
              "You're offline, Check your internet connection.");
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        } else if (err.runtimeType.toString() == "FormatException") {
          Constants.showShortToastBuilder("Oops something is wrong.");
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        }
      });
    } else {
      return null;
    }
  }

  /*Positioned(top: 35, right: 5, child: _skipButton()),

  InkWell _skipButton() {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.0),
        child: Row(
          children: <Widget>[
            Text(
              'Skip',
              style: TextStyle(
                fontSize: 12,
                backgroundColor: Constants.myWhite,
                fontWeight: FontWeight.w500,
                color: Constants.primary_green,
              ),
            ),
            Icon(
              Icons.navigate_next,
              color: Constants.primary_green,
            ),
          ],
        ),
      ),
      splashColor: Constants.myWhite,
    );
  }*/

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

  Widget _loginLabel() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'LOGIN',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.5,
            color: Constants.primary_green,
          ),
        ),
      ],
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
            borderSide:
                const BorderSide(color: Constants.primary_green, width: 1.5)),
      ),
      validator: (emailId) {
        if (emailId.isEmpty) {
          return 'Please enter email';
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
        }
        return null;
      },
      onFieldSubmitted: (term) async {
        if (email.text != '' && password.text != '') {
          await signIn();
        }
      },
    );
  }

  Widget _loginButton() {
    return InkWell(
      onTap: () async {
        signIn();
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
          'Login',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget _forgotPasswordLabel() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      alignment: Alignment.centerRight,
      child: InkWell(
        onTap: () async {
          _showForgotFormDialog();
        },
        child: Text('Forgot Password ?',
            style: TextStyle(
                fontSize: 14,
                color: Constants.primary_green,
                fontWeight: FontWeight.w500)),
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
        _signInWithFacebook();
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
        _signInWithGoogle();
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

  Widget _createAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignUp()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Don\'t have an account ?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            Constants.width(10.0),
            Text(
              'Register',
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
                  Constants.height(height * .1),
                  Constants.logo(),
                  Constants.height(height * 0.08),
                  _loginLabel(),
                  Constants.height(30.0),
                  emailField(),
                  Constants.height(30.0),
                  passwordField(),
                  Constants.height(30.0),
                  _loginButton(),
                  _forgotPasswordLabel(),
                  _divider(),
                  _facebookButton(),
                  _googleButton(),
                  _createAccountLabel(),
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

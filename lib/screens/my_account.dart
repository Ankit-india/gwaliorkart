import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gwaliorkart/screens/change_location.dart';
import 'package:gwaliorkart/screens/edit_account.dart';
import 'package:gwaliorkart/screens/wish_list.dart';
import 'package:gwaliorkart/utils/auth_utils.dart';
import 'package:gwaliorkart/utils/constants.dart';

class MyAccount extends StatefulWidget {
  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  final double _walletBalance = 0.00;
  final String _avatar = "https://img.techpowerup.org/200626/avatar.png";
  static final Color _grey700 = Constants.grey700;
  FirebaseAuth auth = FirebaseAuth.instance;
  String firstName,
      lastName,
      fullName,
      emailId,
      phoneNo,
      _image,
      _password,
      _userId,
      _token;

  @override
  void initState() {
    firstName = AuthUtils.userFirstName;
    lastName = AuthUtils.userLastName;
    fullName = AuthUtils.userFullName;
    emailId = AuthUtils.userEmailId;
    phoneNo = AuthUtils.userPhoneNo;
    _image = AuthUtils.userImage;
    _password = AuthUtils.userPassword;
    _userId = AuthUtils.userId;
    _token = AuthUtils.authToken;
    _getEditProfile();
    super.initState();
    print(
        "User_Info: firstName:=> $firstName, lastName:=> $lastName, fullName:=> $fullName, emailId:=> $emailId, phoneNo:=> $phoneNo, image:=> $_image, password:=> $_password, userId:=> $_userId, token:=> $_token");
  }

  Future<dynamic> _getEditProfile() async {
    if (_userId != null && _userId != '') {
      await AuthUtils.getEditProfile(_userId).then((dynamic _profileRes) {
        if (_profileRes != null) {
          setState(() {
            firstName = _profileRes['firstname'];
            lastName = _profileRes['lastname'];
            emailId = _profileRes['email'];
            phoneNo = _profileRes['telephone'];
          });
        }
      }).catchError((_err) {
        print("\ngetEditProfile catchError:=> $_err");
      });
    }
  }

  String currentUser() {
    return AuthUtils.authToken;
  }

  String userName() {
    if (currentUser != null) {
      if (fullName == null && emailId != null) {
        return emailId.replaceAll('@gmail.com', '');
      }
      return fullName;
    } else {
      return "";
    }
  }

  String photoUrl() {
    if (currentUser != null && emailId != null) {
      return emailId[0].toUpperCase();
    } else {
      return "";
    }
  }

  Widget _imageOrText() {
    Widget _userCircle;
    if (currentUser != null && _image != null) {
      _userCircle = CircleAvatar(
        radius: 35.0,
        backgroundImage: NetworkImage(_image),
        backgroundColor: Colors.transparent,
      );
    } else {
      _userCircle = CircleAvatar(
        radius: 35.0,
        backgroundColor: Colors.white,
        child: Text(
          '${photoUrl()}',
          style: TextStyle(fontFamily: 'Gotham', fontSize: 35.0),
        ),
      );
    }
    return _userCircle;
  }

  AppBar _appbar = AppBar(
    centerTitle: true,
    title: Text(
      "MY ACCOUNT",
      style: TextStyle(fontSize: 16),
    ),
  );

  EdgeInsetsGeometry _padding = EdgeInsets.symmetric(horizontal: 15.0);

  Divider _divider = Divider(
    indent: 30.0,
  );

  Widget _fullNameWithEdit() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          userName(),
          style: TextStyle(
              color: Constants.myWhite,
              fontSize: 16.0,
              fontWeight: FontWeight.w500),
        ),
        InkWell(
          child: Icon(
            Icons.edit,
            color: Constants.myWhite,
            size: 22.0,
          ),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return EditAccount(EditAccountData(
                  _userId, firstName, lastName, emailId, emailId, phoneNo));
            })).then((value) {
              setState(() {
                firstName = AuthUtils.userFirstName;
                lastName = AuthUtils.userLastName;
                fullName = AuthUtils.userFullName;
                emailId = AuthUtils.userEmailId;
                phoneNo = AuthUtils.userPhoneNo;
                _image = AuthUtils.userImage;
                _password = AuthUtils.userPassword;
                _userId = AuthUtils.userId;
                _token = AuthUtils.authToken;
              });
            });
          },
        ),
      ],
    );
  }

  final TextStyle _textStyle = TextStyle(
      color: Constants.myWhite, fontSize: 14.0, fontWeight: FontWeight.w400);

  Widget _email() {
    Widget _emailId;
    if (currentUser != null && emailId != null) {
      _emailId = Column(
        children: <Widget>[
          Constants.height(5.0),
          Text(
            emailId,
            overflow: TextOverflow.ellipsis,
            style: _textStyle,
          ),
        ],
      );
    } else {
      _emailId = Column(
        children: <Widget>[
          Constants.height(5.0),
          Text(
            "user@gwaliorcart.com",
            overflow: TextOverflow.ellipsis,
            style: _textStyle,
          ),
        ],
      );
    }
    return _emailId;
  }

  Widget _phone() {
    Widget _phoneNum;
    if (currentUser != null && phoneNo != null) {
      _phoneNum = Column(
        children: <Widget>[
          Constants.height(5.0),
          Text(
            phoneNo,
            overflow: TextOverflow.ellipsis,
            style: _textStyle,
          ),
        ],
      );
    } else {
      _phoneNum = Column(
        children: <Widget>[
          Constants.height(5.0),
          Text(
            "91XXXXXXXX",
            overflow: TextOverflow.ellipsis,
            style: _textStyle,
          ),
        ],
      );
    }
    return _phoneNum;
  }

  Text _locationText = Text(
    "Gurgaon Sector 66 Gurgaon- 122001",
    style: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 14.0,
      color: _grey700,
    ),
  );

  Container _changeButton() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        border: Border.all(width: 1, color: Colors.red),
      ),
      child: InkWell(
        onTap: () =>
            Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ChangeLocation();
        })),
        child: Text(
          "Change",
          style: TextStyle(
              color: Colors.red, fontSize: 13.0, fontWeight: FontWeight.w300),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.myWhite,
      appBar: _appbar,
      body: ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: <Widget>[
          Container(
            decoration: Constants.gradientBgColor(),
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _imageOrText(),
                    Constants.width(10.0),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          _fullNameWithEdit(),
                          _email(),
                          _phone(),
                        ],
                      ),
                    ),
                  ],
                ),
                Constants.height(12.0),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    color: Constants.myWhite,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  padding:
                      EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.location_on,
                        color: Colors.red,
                      ),
                      Constants.width(10.0),
                      Expanded(
                        child: _locationText,
                      ),
                      _changeButton(),
                      Constants.width(5.0),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            title: Row(
              children: <Widget>[
                Image.asset(
                  "assets/icons/order.png",
                  width: 25.0,
                ),
                Constants.width(10.0),
                Text("My Orders"),
              ],
            ),
            contentPadding: _padding,
            onTap: () => Navigator.of(context).pop(),
          ),
          _divider,
          ListTile(
            title: Row(
              children: <Widget>[
                Image.asset(
                  "assets/icons/wallet.png",
                  width: 25.0,
                ),
                Constants.width(10.0),
                Text("My Wallet"),
              ],
            ),
            trailing: Text(
              "Rs " + _walletBalance.toString(),
              style: TextStyle(color: Colors.green, fontSize: 15.0),
            ),
            contentPadding: _padding,
            onTap: () => Navigator.of(context).pop(),
          ),
          _divider,
          ListTile(
            title: Row(
              children: <Widget>[
                Icon(Icons.payment),
                Constants.width(10.0),
                Text("My Payments"),
              ],
            ),
            contentPadding: _padding,
            onTap: () => Navigator.of(context).pop(),
          ),
          _divider,
          ListTile(
            title: Row(
              children: <Widget>[
                Image.asset(
                  "assets/icons/wish_list.png",
                  width: 25.0,
                ),
                Constants.width(10.0),
                Text("My Wish List"),
              ],
            ),
            contentPadding: _padding,
            onTap: () async => Constants.goToWishListPage(_userId, context),
          ),
          _divider,
          ListTile(
            title: Row(
              children: <Widget>[
                Icon(Icons.rate_review),
                Constants.width(10.0),
                Text("My Ratings & Reviews"),
              ],
            ),
            contentPadding: _padding,
            onTap: () => Navigator.of(context).pop(),
          ),
          _divider,
          ListTile(
            title: Row(
              children: <Widget>[
                Icon(Icons.notifications),
                Constants.width(10.0),
                Text("Notifications"),
              ],
            ),
            contentPadding: _padding,
            onTap: () => Navigator.of(context).pop(),
          ),
          _divider,
          ListTile(
            title: Row(
              children: <Widget>[
                Icon(Icons.card_giftcard),
                Constants.width(10.0),
                Text("My Gift Cards"),
              ],
            ),
            contentPadding: _padding,
            onTap: () => Navigator.of(context).pop(),
          ),
          _divider,
          ListTile(
            title: Row(
              children: <Widget>[
                Icon(Icons.location_on),
                Constants.width(10.0),
                Text("My Delivery Address"),
              ],
            ),
            contentPadding: _padding,
            onTap: () => Navigator.of(context).pop(),
          ),
          _divider,
          ListTile(
            title: Row(
              children: <Widget>[
                Image.asset(
                  "assets/icons/sign-out.png",
                  width: 20.0,
                ),
                Constants.width(10.0),
                Text("Logout"),
              ],
            ),
            onTap: () async => Constants.showLogoutDialog(context),
            contentPadding: _padding,
          ),
        ],
      ),
    );
  }
}

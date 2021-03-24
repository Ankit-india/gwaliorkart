import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gwaliorkart/screens/auth_login.dart';
import 'package:gwaliorkart/screens/edit_account.dart';
import 'package:gwaliorkart/screens/login.dart';
import 'package:gwaliorkart/screens/my_account.dart';
import 'package:gwaliorkart/screens/order_history.dart';
import 'package:gwaliorkart/screens/password_change.dart';
import 'package:gwaliorkart/screens/wish_list.dart';
import 'package:gwaliorkart/utils/auth_utils.dart';
import 'package:gwaliorkart/utils/constants.dart';

class DrawerPage extends StatefulWidget {
  @override
  _DrawerPageState createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
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
  int _pageNum = 1;

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

  String userName() {
    String _userName;
    if (fullName == null && emailId != null) {
      _userName = emailId.replaceAll('@gmail.com', '');
    } else if (emailId == null) {
      _userName = '';
    } else {
      _userName = fullName;
    }
    return _userName;
  }

  String email() {
    if (emailId != null) {
      return emailId;
    } else {
      return "user@gwaliorkart.com";
    }
  }

  String phone() {
    if (phoneNo != null) {
      return phoneNo;
    } else {
      return "91XXXXXXXX";
    }
  }

  String photoUrl() {
    if (emailId != null) {
      return emailId[0].toUpperCase();
    } else {
      return "";
    }
  }

  Widget _imageOrText() {
    Widget _userCircle;
    if (_image != null) {
      _userCircle = CircleAvatar(
        radius: 40.0,
        backgroundImage: NetworkImage(_image),
        backgroundColor: Colors.transparent,
      );
    } else {
      _userCircle = CircleAvatar(
        backgroundColor: Colors.white,
        child: Text(
          '${photoUrl()}',
          style: TextStyle(fontFamily: 'Gotham', fontSize: 35.0),
        ),
      );
    }
    return _userCircle;
  }

  Widget userAccountsDrawerHeader() {
    if (_token != null && _token != '') {
      return UserAccountsDrawerHeader(
        accountName: Text(
          '${userName()}',
          style: TextStyle(fontFamily: 'Gotham'),
        ),
        accountEmail: Text(
          '${email()}',
          style: TextStyle(fontFamily: 'Gotham'),
        ),
        currentAccountPicture: _imageOrText(),
      );
    } else {
      return Container(
        color: Colors.black54,
        padding: EdgeInsets.symmetric(vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            OutlineButton(
              onPressed: () {
                MaterialPageRoute authRoute =
                    MaterialPageRoute(builder: (context) => AuthLogin());
                Navigator.push(context, authRoute);
                /*Navigator.of(context).pushNamedAndRemoveUntil(
                    '/login', (Route<dynamic> route) => false);*/
              },
              textColor: Constants.myWhite,
              borderSide: BorderSide(
                color: Constants.myWhite,
                width: 1.0,
              ),
              child: Text(
                "Login",
              ),
              padding: EdgeInsets.symmetric(horizontal: 40.0),
            ),
            OutlineButton(
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/sign-up', (Route<dynamic> route) => false);
              },
              textColor: Constants.myWhite,
              borderSide: BorderSide(
                color: Constants.myWhite,
                width: 1.0,
              ),
              child: Text(
                "Sign Up",
              ),
              padding: EdgeInsets.symmetric(horizontal: 30.0),
            ),
          ],
        ),
      );
    }
  }

  Widget _listTileWidget() {
    Widget _listTile;
    if (_token != null) {
      _listTile = ListTile(
        title: _titleText("Logout"),
        subtitle: Constants.height(10.0),
        onTap: () async => Constants.showLogoutDialog(context),
      );
    } else {
      _listTile = Container();
    }
    return _listTile;
  }

  Text _titleText(final String _text) {
    return Text(
      _text,
      style: TextStyle(fontFamily: 'Gotham', fontSize: 15.0),
    );
  }

  final TextStyle _style = TextStyle(
      fontWeight: FontWeight.w400, color: Colors.grey[600], fontSize: 15.0);

  EdgeInsetsGeometry _padding = EdgeInsets.only(left: 40.0);

  ListTile _listTile(final String _title) {
    return ListTile(
      title: Text(
        _title,
        style: _style,
      ),
      contentPadding: _padding,
    );
  }

  InkWell _profile(){return InkWell(
    child: _listTile("Profile"),
    onTap: () async {
      Navigator.of(context).pop();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return MyAccount();
        }),
      );
    },
  );}

  InkWell _editAccount(){
    return
      InkWell(
        child: _listTile("Edit Account"),
        onTap: () {
          Navigator.of(context).pop();
          MaterialPageRoute _accountRoute = MaterialPageRoute(
              builder: (context) => EditAccount(EditAccountData(
                  _userId,
                  firstName,
                  lastName,
                  emailId,
                  emailId,
                  phoneNo)));
          Navigator.push(context, _accountRoute).then((value) {
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
      );
  }

  InkWell _passwordWidget(){return InkWell(
    child: _listTile("Password"),
    onTap: () {
      Navigator.of(context).pop();
      MaterialPageRoute _accountRoute = MaterialPageRoute(
          builder: (context) => PasswordChange());
      Navigator.push(context, _accountRoute).then((value) {
        setState(() {
          _password = AuthUtils.userPassword;
        });
      });
    },
  );}

  InkWell _addressBook(){return InkWell(
    child: _listTile("Address Book"),
    onTap: () async => Constants.goToAddressBookPage(_userId, context),
    // onTap: () => Navigator.of(context).pop(),
  );}

  InkWell _wishList(){return InkWell(
    child: _listTile("Wish List"),
    onTap: () async => Constants.goToWishListPage(_userId, context),
  );}

  InkWell _orderHistory(){
    return InkWell(
      // onTap: () async => Constants.goToOrderHistoryPage(_userId, _pageNum, context),
      // onTap: () async => Constants.goToOrderHistoryPage('1', _pageNum, context),
      onTap : () => Navigator.push(context, MaterialPageRoute(builder: (context) {
        return OrderHistory();
      })),
      child: _listTile("Order History"),
    );
  }

  InkWell _referAndEarn(){
    return InkWell(
      onTap: () => Navigator.of(context).pop(),
      child: _listTile("Refer & Earn"),
    );
  }

  InkWell _rewardPoints(){
    return InkWell(
      onTap: () => Navigator.of(context).pop(),
      child: _listTile("Reward Points"),
    );
  }

  InkWell _returns(){
    return InkWell(
      onTap: () => Navigator.of(context).pop(),
      child: _listTile("Returns"),
    );
  }

  InkWell _newsletter(){
    return InkWell(
      onTap: () => Navigator.of(context).pop(),
      child: _listTile("News Letter"),
    );
  }

  InkWell _myWallet(){return InkWell(
    onTap: () => Navigator.of(context).pop(),
    child: _listTile("My Wallet"),
  );}

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          userAccountsDrawerHeader(),
          Constants.height(10.0),
          ListTile(
            title: _titleText("Home"),
            onTap: () => Navigator.of(context).pop(),
          ),
          _token != null && _token != ''
              ? ExpansionTile(
                  title: _titleText("My Account"),
                  children: <Widget>[_editAccount(),_passwordWidget(),_addressBook(),_wishList(),_orderHistory(),_referAndEarn(),_rewardPoints(),_returns(),_newsletter(),_myWallet(),
                  ],
                )
              : Container(),
          ListTile(
            title: _titleText("Notification"),
            onTap: () => Navigator.of(context).pop(),
          ),
          ListTile(
            title: _titleText("Rate our App"),
            onTap: () => Navigator.of(context).pop(),
          ),
          ListTile(
            title: _titleText("Need Help?"),
            onTap: () => Navigator.of(context).pop(),
          ),
          _listTileWidget(),
        ],
      ),
    );
  }
}

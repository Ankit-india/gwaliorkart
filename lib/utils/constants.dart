import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gwaliorkart/models/address_data.dart';
import 'package:gwaliorkart/models/billing_address_data.dart';
import 'package:gwaliorkart/models/cart_data.dart';
import 'package:gwaliorkart/models/category_model.dart';
import 'package:gwaliorkart/models/landing_model.dart';
import 'package:gwaliorkart/models/location_data.dart';
import 'package:gwaliorkart/models/order_data.dart';
import 'package:gwaliorkart/models/product_detail_model.dart';
import 'package:gwaliorkart/models/shipping_address_data.dart';
import 'package:gwaliorkart/models/wish_list_data.dart';
import 'package:gwaliorkart/screens/add_new_address.dart';
import 'package:gwaliorkart/screens/address_book.dart';
import 'package:gwaliorkart/screens/cart.dart';
import 'package:gwaliorkart/screens/change_location.dart';
import 'package:gwaliorkart/screens/checkout_page.dart';
import 'package:gwaliorkart/screens/dummy_product_details.dart';
import 'package:gwaliorkart/screens/order_detail.dart';
import 'package:gwaliorkart/screens/order_history.dart';
import 'package:gwaliorkart/screens/proceed_to_pay.dart';
import 'package:gwaliorkart/screens/product_details.dart';
import 'package:gwaliorkart/screens/product_listing_page.dart';
import 'package:gwaliorkart/screens/shipping_address.dart';
import 'package:gwaliorkart/screens/subcategory_page.dart';
import 'package:gwaliorkart/screens/view_more.dart';
import 'package:gwaliorkart/screens/wish_list.dart';
import 'package:gwaliorkart/utils/auth_utils.dart';
import 'package:gwaliorkart/utils/storage_utils.dart';

class Constants {
  static Size _deviceSize;
  static final String appName = 'Gwalior Cart';

  static const Color myWhite = Color(0xFFFFFFFF);
  static const Color myBlack = Color(0xFF000000);
  static const Color myGreen = const Color(0xff85C20D);
  static final Color grey100 = Colors.grey[100];
  static final Color grey200 = Colors.grey[200];
  static final Color grey300 = Colors.grey[300];
  static final Color grey400 = Colors.grey[400];
  static final Color grey500 = Colors.grey[500];
  static final Color grey600 = Colors.grey[600];
  static final Color grey700 = Colors.grey[700];
  static final Color grey800 = Colors.grey[800];
  static final Color grey900 = Colors.grey[900];
  static final Color red200 = Colors.red[200];
  static final Color red300 = Colors.red[300];
  static final Color red400 = Colors.red[400];
  static final Color red500 = Colors.red[500];
  static const MaterialColor primary_green = MaterialColor(
    0xff85C20D,
    <int, Color>{
      50: Color(0xFFFFF3E0),
      100: Color(0xFFFFE0B2),
      200: Color(0xFFFFCC80),
      300: Color(0xFFFFB74D),
      400: Color(0xFFFFA726),
      500: Color(0xff85C20D),
      600: Color(0xFFFB8C00),
      700: Color(0xFFF57C00),
      800: Color(0xFFEF6C00),
      900: Color(0xFFE65100),
    },
  );
  static final String currentDate =
      '${DateTime.now().toLocal().year.toString()}-${DateTime.now().toLocal().month.toString()}-${DateTime.now().toLocal().day.toString()}';
  static final String currentDateTime =
      '${DateTime.now().toLocal().year.toString()}-${DateTime.now().month.toString()}-${DateTime.now().day.toString()} ${DateTime.now().hour.toString()}:${DateTime.now().minute.toString()}';
  static final String currentTime =
      '${DateTime.now().toLocal().hour.toString()}:${DateTime.now().toLocal().minute.toString()}';

  static gradientBgColor() {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: <Color>[red300, red400],
      ),
    );
  }

  static String isLoggedIn = "IS_LOGGED_IN";
  static final String patternEmail =
      "^([0-9a-zA-Z]([-.+\\w]*[0-9a-zA-Z])*@([0-9a-zA-Z][-\\w]*[0-9a-zA-Z]\\.)+[a-zA-Z]{2,9})\$";
  static const TextStyle gotham13normal = TextStyle(
      fontFamily: 'Gotham', fontSize: 13, fontWeight: FontWeight.normal);
  static const TextStyle gotham13bold = TextStyle(
      fontFamily: 'Gotham', fontSize: 13, fontWeight: FontWeight.bold);

  static void showLoadingIndicator(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(),
              Constants.width(20.0),
              Text("Loading...")
            ],
          ),
        );
      },
    );
  }

  static void showMessageLoader(BuildContext context, final String _msg) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(),
              Constants.width(20.0),
              Expanded(
                child: Text(_msg),
              ),
            ],
          ),
        );
      },
    );
  }

  static Container smallLoader() {
    return Container(
      child: SizedBox(
        child: CircularProgressIndicator(
          backgroundColor: Colors.white,
          strokeWidth: 2,
        ),
        height: 18.0,
        width: 18.0,
      ),
      alignment: Alignment.center,
    );
  }

  static Container sizeLoader(
      final double _height, final double _width, final double _strokeWidth) {
    return Container(
      alignment: Alignment.center,
      child: SizedBox(
        height: _height,
        width: _width,
        child: CircularProgressIndicator(
          backgroundColor: Colors.white,
          strokeWidth: _strokeWidth,
        ),
      ),
    );
  }

  static SizedBox height(final double size) {
    return SizedBox(
      height: size,
    );
  }

  static SizedBox width(final double size) {
    return SizedBox(
      width: size,
    );
  }

  static SizedBox heightWidth(final double height, final double width) {
    return SizedBox(
      height: height,
      width: width,
    );
  }

  static Container logo() {
    return Container(
      height: 70.0,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        image: DecorationImage(
          image: AssetImage("assets/icons/logo2.png"),
        ),
      ),
    );
  }

  static double getHeight(BuildContext context, final double _height) {
    return MediaQuery.of(context).size.height * _height;
  }

  static double getWidth(BuildContext context, final double _width) {
    return MediaQuery.of(context).size.width * _width;
  }

  static double getTextScale(BuildContext context, final double _fontSize) {
    return MediaQuery.of(context).textScaleFactor * _fontSize;
  }

  static SizedBox sizedBoxHeight(BuildContext context, final double _height) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * _height,
    );
  }

  static SizedBox sizedBoxWidth(BuildContext context, final double _width) {
    return SizedBox(
      height: MediaQuery.of(context).size.width * _width,
    );
  }

  //  ########################   ALL FUTURE METHODS CALL   #####################

  static Future<void> loadCurrentUser() async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseUser _parentUser = await _auth.currentUser();
    if (_parentUser != null) {
      await _parentUser.reload();
    }
    FirebaseUser _childUser = await _auth.currentUser();
    if (_childUser == null) {
      await logoutUserSession()
          .then((dynamic _res1) {})
          .catchError((onError) {});
    }
  }

  static Future<bool> showLongToastBuilder(final String msg) {
    return Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
    );
  }

  static Future<bool> showShortToastBuilder(final String msg) {
    return Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
    );
  }

  static Future<dynamic> setTokenAndGetUserInfo(final String _token) async {
    return [
      await StorageProvider.setToken(_token),
      await AuthUtils.getUserInfo()
    ];
  }

  static Future<dynamic> setAndGetUserInfo(
      final String _firstName,
      final String _lastName,
      final String _name,
      final String _email,
      final String _phone,
      final String _image,
      final String _password,
      final String _userId,
      final String _token,
      final String _reward,
      final String _country) async {
    return [
      await StorageProvider.setToken(_token),
      await StorageProvider.setUserInfo(
          _firstName != null ? _firstName : '',
          _lastName != null ? _lastName : '',
          _name,
          _email != null ? _email : '',
          _phone,
          _image,
          _password,
          _userId,
          _token,
          _reward != null && _reward != '' ? _reward : '0',
          _country != null ? _country : ''),
      await AuthUtils.getUserInfo()
    ];
  }

  static Future<dynamic> logoutUserSession() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    return [
      await StorageProvider.clearUserInfo(),
      await auth.signOut(),
      await AuthUtils.getUserInfo()
    ];
  }

  static Future<void> showLogoutDialog(BuildContext context) async {
    AlertDialog alert = AlertDialog(
      content: Container(
        height: 135.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Log out",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
            ),
            Constants.height(15.0),
            Divider(),
            Constants.height(15.0),
            Text(
              "Are you sure you want to log out?",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Constants.grey700,
                  letterSpacing: 1.0,
                  fontSize: 16.0),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text(
            "No",
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text(
            "Yes",
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          onPressed: () async => logout(context),
        ),
      ],
    );
    showDialog(context: context, builder: (_) => alert);
  }

  static Future<void> infoDialog(BuildContext context) async {
    _deviceSize = MediaQuery.of(context).size;
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.white,
      elevation: 0.0,
      content: Container(
        width: _deviceSize.width,
        height: 110.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Shop for Rs.383.00 more on Standard to get this shipment for FREE!",
              style: TextStyle(fontSize: 12.0),
            ),
            Constants.height(15.0),
            InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () => Navigator.of(context).pop(),
              child: Text(
                "View FAQ",
                textAlign: TextAlign.left,
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: Constants.grey600,
                  fontSize: 12.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
    showDialog(context: context, builder: (_) => alert);
  }

  static Future<void> viewItemDialog(BuildContext context) async {
    _deviceSize = MediaQuery.of(context).size;
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.white,
      elevation: 0.0,
      content: Container(
        width: _deviceSize.width,
        height: 110.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Shop for Rs.383.00 more on Standard to get this shipment for FREE!",
              style: TextStyle(fontSize: 12.0),
            ),
            Constants.height(15.0),
            InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () => Navigator.of(context).pop(),
              child: Text(
                "View FAQ",
                textAlign: TextAlign.left,
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: Constants.grey600,
                  fontSize: 12.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
    showDialog(context: context, builder: (_) => alert);
  }

  static Future<void> logout(BuildContext context) async {
    Constants.showLoadingIndicator(context);
    await _logoutUser().then((dynamic _result) {
      if (_result == null) {
        Constants.showShortToastBuilder("Logged out.");
        Navigator.of(context).pop();
        Navigator.of(context).pushReplacementNamed('/login');
      }
    }).catchError((error) {
      Navigator.of(context).pop();
      Constants.showShortToastBuilder("logoutUser failed.");
    });
  }

  static Future<dynamic> _logoutUser() async {
    await Constants.logoutUserSession().then((dynamic _result) {
      final dynamic res = _result;
      print("logoutUser Response:=>  $res");
      return res;
    }).catchError((err) {
      Constants.showShortToastBuilder("logoutUserSession failed.");
      print('logoutUserSession catchError:= $err');
    });
  }

  static Future<dynamic> getCartListData(
      final String _customerId,
      final String _vouchers,
      final String _coupon,
      final String _reward) async {
    return await CartUtils.getCartList(
        _customerId != null && _customerId != "" ? _customerId : "-",
        _vouchers != null && _vouchers != "" ? _vouchers : "-",
        _coupon != null && _coupon != "" ? _coupon : "-",
        _reward != null && _reward != "" ? _reward : "-");
  }

  static Future<void> goToCartListPage(
      final Map<String, dynamic> _snapshotData, BuildContext context) async {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => Cart(_snapshotData)));
  }

  static Future<void> goToProductDetailsPage(final String _productId,
      final String _customerId, BuildContext context) async {
    if (_productId != null) {
      Constants.showLoadingIndicator(context);
      await ProductDetailUtils.getProductDetails(_productId, _customerId)
          .then((dynamic _result) {
        if (_result != null) {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return ProductDetails(_result);
          })).then((value) => Navigator.of(context).pop());
        } else {
          Constants.showShortToastBuilder("failed.");
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
    }
  }

  static Future<void> goToWishListPage(
      final String _customerId, BuildContext context) async {
    if (_customerId != null && _customerId != "") {
      Constants.showLoadingIndicator(context);
      await WishListUtils.getWishList(_customerId).then((dynamic _wishRes) {
        if (_wishRes != null) {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return WishList(_wishRes);
          })).then((value) {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          });
        } else {
          Constants.showShortToastBuilder("failed.");
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
    }
  }

  static Future<void> goToAddressBookPage(
      final String _customerId, BuildContext context) async {
    if (_customerId != null && _customerId != "") {
      Constants.showLoadingIndicator(context);
      await AddressUtils.getCustomerAddressList(_customerId)
          .then((dynamic _addressRes) {
        if (_addressRes != null && _addressRes.containsKey('addresses')) {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return AddressBook(_addressRes['addresses']);
          })).then((value) {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          });
        } else {
          Constants.showShortToastBuilder("failed.");
          Navigator.of(context).pop();
        }
      }).catchError((_err) {
        if (_err == "SocketException") {
          Constants.showShortToastBuilder(
              "You're offline, Check your internet connection.");
          Navigator.of(context).pop();
        } else if (_err.runtimeType.toString() == "FormatException") {
          Constants.showShortToastBuilder("Oops something is wrong.");
          Navigator.of(context).pop();
        } else {
          Navigator.of(context).pop();
          Constants.showShortToastBuilder("Oops something is wrong.");
          print("\n\ngetCustomerAddressList catchError:=> $_err\n\n");
        }
      });
    }
  }

  static Future<void> goToSubCategoryPage(final String _categoryId,
      final String _categoryName, BuildContext context) async {
    if (_categoryId != null && _categoryId != "") {
      Constants.showLoadingIndicator(context);
      await CategoryUtils.getCategoryList(_categoryId)
          .then((dynamic _categoryRes) {
        if (_categoryRes != null) {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return SubCategoryPage(_categoryRes, _categoryName);
          })).then((value) => Navigator.of(context).pop());
        } else {
          Constants.showShortToastBuilder("failed.");
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
    }
  }

  static Future<void> goToProductListPage(final String _categoryId,
      final String _categoryName, BuildContext context) async {
    if (_categoryId != null && _categoryId != "") {
      Constants.showLoadingIndicator(context);
      await CategoryUtils.getCategoryList(_categoryId)
          .then((dynamic _categoryRes) {
        if (_categoryRes != null) {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return ProductLisPage(_categoryRes, _categoryName);
          })).then((value) => Navigator.of(context).pop());
        } else {
          Constants.showShortToastBuilder("failed.");
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
    }
  }

  static Future<void> goToViewMorePage(
      final String _categoryKey, BuildContext context) async {
    if (_categoryKey != null && _categoryKey != "") {
      Constants.showLoadingIndicator(context);
      await LandingPageUtils.getLandingPageList().then((dynamic _categoryRes) {
        if (_categoryRes != null) {
          if (_categoryRes.containsKey(_categoryKey)) {
            if (_categoryRes[_categoryKey] != null &&
                _categoryRes[_categoryKey].length > 0) {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ViewMore(_categoryRes[_categoryKey], _categoryKey);
              })).then((value) => Navigator.of(context).pop());
            } else {
              Constants.showShortToastBuilder("failed.");
              Navigator.of(context).pop();
            }
          } else {
            Constants.showShortToastBuilder("failed.");
            Navigator.of(context).pop();
          }
        } else {
          Constants.showShortToastBuilder("failed.");
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
    }
  }

  static Future<dynamic> _getCountryAndStateData(
      final String _customerId, final String _countryId) async {
    return [
      await LocationUtils.getCountries(_customerId),
      await LocationUtils.getStates(_countryId)
    ];
  }

  static Future<void> goToCheckoutPage(final String _customerId,
      final String _countryId, BuildContext context) async {
    if (_customerId != null &&
        _customerId != "" &&
        _countryId != null &&
        _countryId != '') {
      Constants.showLoadingIndicator(context);
      await _getCountryAndStateData(_customerId, _countryId)
          .then((dynamic _locationRes) {
        if (_locationRes != null && _locationRes.length > 0) {
          CountryData _countryData = CountryData.fromJson(_locationRes[0]);
          ZoneData _zoneData = ZoneData.fromJson(_locationRes[1]);
          Navigator.of(context).pop();
          /*Navigator.push(context, MaterialPageRoute(builder: (context) {
            return CheckoutPage(null, _countryData, _zoneData);
          })).then((value) => Navigator.of(context).pop());*/
        } else {
          Constants.showShortToastBuilder("failed.");
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
    }
  }

  static Future<dynamic> checkAddress(
      final String _customerId, BuildContext context) async {
    if (_customerId != null && _customerId != '') {
      Constants.showLoadingIndicator(context);
      await BillingAddressUtils.getBillingAddress(_customerId)
          .then((final dynamic _res) {
        if (_res != null && _res.containsKey('addresses')) {
          if (_res['addresses'] != null && _res['addresses'].length > 0) {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ProceedToPay();
            })).then((value) => Navigator.of(context).pop());
          } else {
            /*Navigator.push(context, MaterialPageRoute(builder: (context) {
              return CheckoutPage();
            })).then((value) => Navigator.of(context).pop());*/
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ChangeLocation();
            })).then((value) => Navigator.of(context).pop());
          }
        } else {
          Navigator.of(context).pop();
          print("get Billing Address Failed");
          Constants.showLongToastBuilder("get Billing Address Failed");
        }
      }).catchError((_err) {
        Navigator.of(context).pop();
        print("getBillingAddress catchError:=> $_err");
        Constants.showLongToastBuilder(-_err);
      });
    }
  }

  static Future<dynamic> _getAddressCountryAndStateData(
      final String _customerId, final String _countryId) async {
    return [
      await BillingAddressUtils.getBillingAddress(_customerId),
      await LocationUtils.getStates(_countryId)
    ];
  }

  static Future<dynamic> getBillingAddressCountryAndStateData(
      final String _customerId,
      final String _countryId,
      BuildContext context) async {
    if (_customerId != null && _customerId != '') {
      Constants.showLoadingIndicator(context);
      await _getAddressCountryAndStateData(_customerId, _countryId)
          .then((final dynamic _res) {
        if (_res != null && _res.length > 0) {
          dynamic _addresses;
          CountryData _countryData;
          ZoneData _zoneData;

          if (_res[0] != null &&
              _res[0].containsKey('addresses') &&
              _res[0]['addresses'] != null &&
              _res[0]['addresses'].length > 0) {
            _addresses = _res[0]['addresses'];
          }
          if (_res[0] != null &&
              _res[0].containsKey('countries') &&
              _res[0]['countries'] != null &&
              _res[0]['countries'].length > 0) {
            _res[0]['countries'].insert(0, {
              'country_id': '0',
              'name': ' --- Please Select --- ',
              'iso_code_2': 'PS',
              'postcode_required': '0',
              'status': '0'
            });
            _countryData = CountryData.fromJson(_res[0]);
          }
          if (_res[1] != null &&
              _res[1].containsKey('zone') &&
              _res[1]['zone'] != null &&
              _res[1]['zone'].length > 0) {
            _zoneData = ZoneData.fromJson(_res[1]);
          }

          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return CheckoutPage(_addresses, _countryData, _zoneData);
          })).then((value) => Navigator.of(context).pop());
        } else {
          Navigator.of(context).pop();
          print("Oops something went wrong!");
          Constants.showLongToastBuilder("Oops something went wrong!");
        }
      }).catchError((_err) {
        Navigator.of(context).pop();
        print("getBillingAddressCountryAndStateData catchError:=> $_err");
        Constants.showLongToastBuilder(_err.toString());
      });
    }
  }

  static Future<dynamic> getCustomerAddAddressFormData(final String _customerId,
      final String _addressId, final BuildContext context) async {
    if (_customerId != null && _customerId != '') {
      Constants.showLoadingIndicator(context);
      await AddressUtils.getCustomerAddAddressForm(_customerId, _addressId)
          .then((dynamic _formRes) async {
        if (_formRes != null) {
          final AddressData _address = AddressData.fromJson(_formRes);
          if (_address.countryId != null && _address.countryId != '') {
            CountryData _countryData;
            if (_address.countries != null && _address.countries.length > 0) {
              _address.countries.insert(0, {
                'country_id': '0',
                'name': ' --- Please Select --- ',
                'iso_code_2': 'PS',
                'postcode_required': '0',
                'status': '0'
              });
            }
            _countryData = CountryData.fromJson(_formRes);

            await LocationUtils.getStates(_address.countryId)
                .then((dynamic _stateRes) {
              final ZoneData _zoneData = ZoneData.fromJson(_stateRes);
              if (_zoneData != null &&
                  _zoneData.countryId == _address.countryId &&
                  _zoneData.zone != null &&
                  _zoneData.zone.length > 0) {
                MaterialPageRoute _addressRoute = MaterialPageRoute(
                    builder: (context) => AddNewAddress(
                        AddressData(
                            _customerId,
                            _address.firstName,
                            _address.lastName,
                            _address.company,
                            _address.telephone,
                            _address.emailData,
                            _address.address1,
                            _address.address2,
                            _address.city,
                            _address.postcode,
                            _address.zoneId,
                            _address.countryId,
                            _address.defaults),
                        _countryData,
                        _zoneData));
                Navigator.push(context, _addressRoute).then((value) {
                  Navigator.of(context).pop();
                });
              } else {
                Navigator.of(context).pop();
                print("\n\ngetStates:=> $_stateRes\n\n");
                Constants.showLongToastBuilder('getStates failed.');
              }
            }).catchError((dynamic _stateErr) {
              Navigator.of(context).pop();
              print("\n\ngetStates catchError:=> $_stateErr\n\n");
              Constants.showLongToastBuilder(
                  'Oops something went wrong during getStates!');
            });
          } else {
            Navigator.of(context).pop();
            print("\n\nCountry id not available.\n\n");
            Constants.showLongToastBuilder('Country id not available.');
          }
        } else {
          Navigator.of(context).pop();
          print("\n\ngetCustomerAddAddressFormData:=> $_formRes\n\n");
          Constants.showLongToastBuilder('Get address form data failed.');
        }
      }).catchError((dynamic _err) {
        Navigator.of(context).pop();
        print("\n\ngetCustomerAddAddressFormData catchError:=> $_err\n\n");
        Constants.showLongToastBuilder('Oops something went wrong!');
      });
    }
  }

  /*static Future<void> goToOrderHistoryPage(final String _customerId,
      final int _pageNum, BuildContext context) async {
    if (_customerId != null && _customerId != "") {
      Constants.showLoadingIndicator(context);
      await AddressUtils.getOrder(_customerId, _pageNum)
          .then((dynamic _orderRes) {
        if (_orderRes != null) {
          final OrderData _orderData = OrderData.fromJson(_orderRes);
          Constants.showShortToastBuilder('get order Success.');
          // Navigator.push(context, MaterialPageRoute(builder: (context) {
          //   return OrderHistory(_orderData);
          // })).then((value) {
          //   Navigator.of(context).pop();
          //   // Navigator.of(context).pop();
          // });
        } else {
          Constants.showShortToastBuilder("Get order history failed.");
          Navigator.of(context).pop();
        }
      }).catchError((_err) {
        if (_err == "SocketException") {
          Constants.showShortToastBuilder(
              "You're offline, Check your internet connection.");
          Navigator.of(context).pop();
        } else if (_err.runtimeType.toString() == "FormatException") {
          Constants.showShortToastBuilder("Oops something is wrong.");
          Navigator.of(context).pop();
        } else {
          Navigator.of(context).pop();
          Constants.showShortToastBuilder("Oops something is wrong.");
          print("\n\ngetOrder catchError:=> $_err\n\n");
        }
      });
    }
  }*/

  static Future<void> goToOrderDetailPage(final String _customerId,
      final String _orderId, BuildContext context) async {
    if (_customerId != null &&
        _customerId != "" &&
        _orderId != null &&
        _orderId != '') {
      Constants.showLoadingIndicator(context);
      await OrderUtils.getOrderInfo(_customerId, _orderId)
          .then((dynamic _orderRes) {
        if (_orderRes != null) {
          final OrderData _orderData = OrderData.fromJson(_orderRes);
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return OrderDetail(_orderData);
          })).then((value) {
            Navigator.of(context).pop();
          });
        } else {
          Constants.showShortToastBuilder("Get order detail failed.");
          Navigator.of(context).pop();
        }
      }).catchError((_err) {
        if (_err == "SocketException") {
          Constants.showShortToastBuilder(
              "You're offline, Check your internet connection.");
          Navigator.of(context).pop();
        } else if (_err.runtimeType.toString() == "FormatException") {
          Constants.showShortToastBuilder("Oops something is wrong.");
          Navigator.of(context).pop();
        } else {
          Navigator.of(context).pop();
          Constants.showShortToastBuilder("Oops something is wrong.");
          print("\n\ngetOrderInfo catchError:=> $_err\n\n");
        }
      });
    }
  }
}

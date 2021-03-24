//import 'package:flutter/material.dart';
//import 'package:gwaliorkart/models/location_data.dart';
//import 'package:gwaliorkart/models/shipping_address_data.dart';
//import 'package:gwaliorkart/screens/auth_login.dart';
//import 'package:gwaliorkart/screens/home.dart';
//import 'package:gwaliorkart/utils/auth_utils.dart';
//import 'package:gwaliorkart/utils/constants.dart';
//import 'package:gwaliorkart/widgets/error_screen.dart';
//import 'package:gwaliorkart/widgets/loader.dart';
//import 'package:gwaliorkart/widgets/widget_page.dart';
//
//class ShippingAddress extends StatefulWidget {
//  final ShippingAddressData shipObj;
//
//  ShippingAddress(this.shipObj);
//
//  @override
//  _ShippingAddressState createState() => _ShippingAddressState();
//}
//
//class _ShippingAddressState extends State<ShippingAddress> {
//  MainAxisAlignment _mStart = MainAxisAlignment.start;
//  MainAxisAlignment _mCenter = MainAxisAlignment.center;
//  CrossAxisAlignment _cStart = CrossAxisAlignment.start;
//  CrossAxisAlignment _cCenter = CrossAxisAlignment.center;
//  ShippingAddressData _shipObj;
//  String _token, _customerId, _countryId, _zoneId, _addressId, _paymentAddress;
//
//  TextEditingController _firstName,
//      _lastName,
//      _company,
//      _email,
//      _address_1,
//      _address_2,
//      _city,
//      _postcode;
//  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//  Future<dynamic> _countryAndStateDataHolder;
//  Size _deviceSize;
//  bool _autoValidate = false;
//  CountryData _countryData;
//  ZoneData _zoneData;
//  List<dynamic> _countriesList, _statesList;
//
//  @override
//  void initState() {
//    _shipObj = widget.shipObj;
//    _token = AuthUtils.authToken;
//    _customerId = AuthUtils.userId;
//    _firstName = TextEditingController(text: _shipObj.firstName);
//    _lastName = TextEditingController(text: _shipObj.lastName);
//    _company = TextEditingController(text: _shipObj.company);
//    _email = TextEditingController(text: _shipObj.email);
//    _address_1 = TextEditingController(text: _shipObj.address_1);
//    _address_2 = TextEditingController(text: _shipObj.address_2);
//    _city = TextEditingController(text: _shipObj.city);
//    _postcode = TextEditingController(text: _shipObj.postcode);
//    _countryId = _shipObj.countryId;
//    _zoneId = _shipObj.zoneId;
//    _countryAndStateDataHolder =
//        _getCountryAndStateData(_customerId, _countryId);
//    super.initState();
//  }
//
//  Future<dynamic> _getCountryAndStateData(
//      final String _customerId, final String _countryId) async {
//    return [
//      await LocationUtils.getCountries(_customerId),
//      await LocationUtils.getStates(_countryId)
//    ];
//  }
//
//  FutureBuilder _futureBuilder() {
//    return FutureBuilder<dynamic>(
//      future: _countryAndStateDataHolder,
//      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
//        switch (snapshot.connectionState) {
//          case ConnectionState.none:
//          case ConnectionState.active:
//          case ConnectionState.waiting:
//            return Loader();
//          case ConnectionState.done:
//          default:
//            if (snapshot.hasError) {
//              return ErrorScreen(snapshot.error, 1);
//            } else {
//              return _addressBuilder(snapshot.data);
//            }
//        }
//      },
//    );
//  }
//
//  Future<dynamic> _updateState(final String _newCountryCode) async {
//    if (_newCountryCode != null && _newCountryCode != '') {
////      Constants.showLoadingIndicator(context);
//      await LocationUtils.getStates(_newCountryCode)
//          .then((final dynamic _newStateRes) {
//        if (_newStateRes != null && _newStateRes.containsKey('zone')) {
//          if (_newStateRes['zone'] != null && _newStateRes['zone'].length > 0) {
//            setState(() {
//              print("_statesList:=> $_newStateRes");
//              _zoneData = ZoneData.fromJson(_newStateRes);
//            });
//          }
//        } else {
////          Navigator.of(context).pop();
//          print("getStates Failed");
//          Constants.showLongToastBuilder("State not found!");
//        }
//      }).catchError((_err) {
////        Navigator.of(context).pop();
//        print("\ngetStates catchError:=> $_err\n");
//        Constants.showLongToastBuilder(_err.toString());
//      });
//    }
//  }
//
//  Future<void> _saveShippingData(BuildContext context) async {
//    if (_formKey.currentState.validate()) {
//      _formKey.currentState.save();
//      if (_token != null &&
//          _token != '' &&
//          _customerId != null &&
//          _customerId != '') {
//        Constants.showLoadingIndicator(context);
//        if (_shipObj.addressId == null) {
//          ShippingAddressData _addParams = ShippingAddressData(
//              _customerId,
//              _addressId,
//              _paymentAddress,
//              _firstName.text,
//              _lastName.text,
//              _company.text,
//              _email.text,
//              _address_1.text,
//              _address_2.text,
//              _city.text,
//              _postcode.text,
//              _countryId,
//              _zoneId);
//
//          await ShippingAddressUtils.saveNewShippingAddress(_addParams)
//              .then((dynamic _shipRes) {
//            if (_shipRes != null && _shipRes.containsKey("success")) {
//              Navigator.of(context).pop();
//              Constants.showShortToastBuilder(
//                  'Shipping address saved successfully.');
//              Navigator.pushReplacement(context,
//                  MaterialPageRoute(builder: (BuildContext context) => Home()));
//            } else {
//              Navigator.of(context).pop();
//              Constants.showShortToastBuilder('Oops something went wrong!');
//              print('\nsaveNewShippingAddress:= $_shipRes\n');
//            }
//          }).catchError((_shipErr) {
//            Navigator.of(context).pop();
//            Constants.showShortToastBuilder('Oops something went wrong!');
//            print('\nsaveNewShippingAddress catchError:= $_shipErr\n');
//          });
//        } else {
//          ShippingAddressData _updateParams = ShippingAddressData(
//              _customerId,
//              _addressId,
//              _paymentAddress,
//              _firstName.text,
//              _lastName.text,
//              _company.text,
//              _email.text,
//              _address_1.text,
//              _address_2.text,
//              _city.text,
//              _postcode.text,
//              _countryId,
//              _zoneId);
//
//          await ShippingAddressUtils.updateShippingAddress(_updateParams)
//              .then((dynamic _shipRes) {
//            if (_shipRes != null && _shipRes.containsKey("success")) {
//              Navigator.of(context).pop();
//              Constants.showShortToastBuilder(
//                  'Shipping address updated successfully.');
//              Navigator.pushReplacement(context,
//                  MaterialPageRoute(builder: (BuildContext context) => Home()));
//            } else {
//              Navigator.of(context).pop();
//              Constants.showShortToastBuilder('Oops something went wrong!');
//              print('\nupdateShippingAddress:= $_shipRes\n');
//            }
//          }).catchError((_shipErr) {
//            Navigator.of(context).pop();
//            Constants.showShortToastBuilder('Oops something went wrong!');
//            print('\nupdateShippingAddress catchError:= $_shipErr\n');
//          });
//        }
//      } else {
//        MaterialPageRoute authRoute =
//            MaterialPageRoute(builder: (context) => AuthLogin());
//        Navigator.push(context, authRoute);
//      }
//    } else {
//      setState(() {
//        _autoValidate = true; //enable realtime validation
//      });
//    }
//  }
//
//  TextStyle _richTextStyle = TextStyle(
//      fontWeight: FontWeight.w500, fontSize: 16.5, color: Colors.black);
//  TextStyle _textSpanStyle = TextStyle(
//    color: Colors.red,
//    fontWeight: FontWeight.bold,
//    fontSize: 16.5,
//  );
//
//  Widget _countryField(final List<dynamic> _countries) {
//    return Column(
//      mainAxisAlignment: _mStart,
//      crossAxisAlignment: _cStart,
//      children: <Widget>[
//        RichText(
//          text: TextSpan(text: '* ', style: _textSpanStyle, children: [
//            TextSpan(
//              text: 'Country',
//              style: _richTextStyle,
//            ),
//          ]),
//        ),
//        Container(
//          width: _deviceSize.width,
//          child: DropdownButtonFormField(
//            value: _countryId,
//            elevation: 0,
//            isDense: true,
//            isExpanded: true,
//            iconEnabledColor: Colors.green,
//            items: WidgetPage.countryMenuItems(_countries),
//            onChanged: (_newCountryVal) async {
//              print("NewCountry Id:=> $_newCountryVal");
//              if (_newCountryVal != null && _newCountryVal != '') {
//                await _updateState(_newCountryVal);
//              }
//            },
//            validator: (_value) =>
//                _value == null ? 'Please select a company!' : null,
//          ),
//        ),
//      ],
//    );
//  }
//
//  Widget _stateField(final List<dynamic> _states) {
//    return Column(
//      mainAxisAlignment: _mStart,
//      crossAxisAlignment: _cStart,
//      children: <Widget>[
//        RichText(
//          text: TextSpan(text: '* ', style: _textSpanStyle, children: [
//            TextSpan(
//              text: 'Region / State',
//              style: _richTextStyle,
//            ),
//          ]),
//        ),
//        Container(
//          width: _deviceSize.width,
//          child: DropdownButtonFormField(
//            value: _zoneId,
//            elevation: 0,
//            isDense: true,
//            isExpanded: true,
//            iconEnabledColor: Colors.green,
//            items: WidgetPage.stateMenuItems(_states),
//            /*items: ['MR.', 'MS.'].map<DropdownMenuItem<String>>((String value) {
//              return DropdownMenuItem<String>(
//                value: value,
//                child: Text(value),
//              );
//            }).toList(),*/
//            onChanged: (_newStateVal) {
//              print("state new id:=> $_newStateVal");
//            },
//            validator: (_value) =>
//                _value == null ? 'Please select a region / state!' : null,
//          ),
//        ),
//      ],
//    );
//  }
//
//  Widget _addressBuilder(final List<dynamic> _listData) {
//    _countryData = CountryData.fromJson(_listData[0]);
//    _zoneData = ZoneData.fromJson(_listData[1]);
//    _countriesList = _countryData.countries;
//    _statesList = _zoneData.zone;
//    print("\nCountries:=> $_countriesList\n");
//    print("\nStates:=> $_statesList\n");
//    print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
//    return Form(
//      key: _formKey,
//      autovalidate: _autoValidate,
//      child: SingleChildScrollView(
//        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
//        scrollDirection: Axis.vertical,
//        child: Column(
//          mainAxisAlignment: _mStart,
//          children: <Widget>[
//            WidgetPage.textFormField(
//                _firstName,
//                TextInputType.text,
//                'First Name',
//                'First Name must be between 1 and 32 characters!'),
//            Constants.height(30.0),
//            WidgetPage.textFormField(_lastName, TextInputType.text, 'Last Name',
//                'Last Name must be between 1 and 32 characters!'),
//            Constants.height(30.0),
//            WidgetPage.textFormFieldWithoutValidation(
//                _company, TextInputType.text, 'Company'),
//            Constants.height(30.0),
//            WidgetPage.textFormField(_email, TextInputType.emailAddress,
//                'Email', 'Please enter email.'),
//            Constants.height(30.0),
//            WidgetPage.textFormField(_address_1, TextInputType.text,
//                'Address 1', 'Address must be between 3 and 128 characters!'),
//            Constants.height(30.0),
//            WidgetPage.textFormFieldWithoutValidation(
//                _address_2, TextInputType.text, 'Address 2'),
//            Constants.height(30.0),
//            WidgetPage.textFormField(_city, TextInputType.text, 'City',
//                'City must be between 2 and 128 characters!'),
//            Constants.height(30.0),
//            WidgetPage.textFormField(_postcode, TextInputType.number,
//                'Post Code', 'City must be 6 characters!'),
//            Constants.height(30.0),
//            _countryField(_countriesList),
//            Constants.height(30.0),
//            _stateField(_statesList),
//          ],
//        ),
//      ),
//    );
//  }
//
//  BottomAppBar _bottomAppBarSaveButton() {
//    return BottomAppBar(
//      elevation: 0.0,
//      color: Constants.primary_green,
//      child: InkWell(
//        onTap: () async => _saveShippingData(context),
//        child: Container(
//          width: MediaQuery.of(context).size.width,
//          padding: EdgeInsets.symmetric(vertical: 12),
//          child: Text(
//            'SAVE ADDRESS',
//            textAlign: TextAlign.center,
//            style: TextStyle(color: Colors.white),
//          ),
//        ),
//      ),
//    );
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    _deviceSize = MediaQuery.of(context).size;
//    return Scaffold(
//      appBar: WidgetPage.shippingAddressAppBar(),
//      body: _futureBuilder(),
//      bottomNavigationBar: _bottomAppBarSaveButton(),
//    );
//  }
//}

/*TextStyle _labelStyle = TextStyle(fontSize: 12.0);
  EdgeInsets _padding = EdgeInsets.all(0);
  Widget _firstNameField() {
    return TextFormField(
      controller: _firstName,
      keyboardType: TextInputType.text,
      autofocus: false,
      cursorColor: Constants.primary_green,
      decoration: InputDecoration(
        labelText: 'First Name',
        labelStyle: _labelStyle,
        contentPadding: _padding,
      ),
      validator: (_fName) {
        if (_fName.isEmpty) {
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
      autofocus: false,
      cursorColor: Constants.primary_green,
      decoration: InputDecoration(
        labelText: 'Last Name',
        labelStyle: _labelStyle,
        contentPadding: _padding,
      ),
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
      autofocus: false,
      cursorColor: Constants.primary_green,
      decoration: InputDecoration(
        labelText: 'Email',
        labelStyle: _labelStyle,
        contentPadding: _padding,
      ),
      validator: (emailId) {
        if (emailId.isEmpty) {
          return 'Please enter email';
        }
        return null;
      },
    );
  }

  Widget _address1Field() {
    return TextFormField(
      controller: _address_1,
      keyboardType: TextInputType.text,
      autofocus: false,
      cursorColor: Constants.primary_green,
      decoration: InputDecoration(
        labelText: 'Address 1',
        labelStyle: _labelStyle,
        contentPadding: _padding,
      ),
      validator: (_newAddress1) {
        if (_newAddress1.isEmpty) {
          return 'Please enter address 1.';
        }
        return null;
      },
    );
  }

  Widget _address2Field() {
    return TextFormField(
      controller: _address_2,
      keyboardType: TextInputType.text,
      autofocus: false,
      cursorColor: Constants.primary_green,
      decoration: InputDecoration(
        labelText: 'Address 2',
        labelStyle: _labelStyle,
        contentPadding: _padding,
      ),
      validator: (_newAddress2) {
        if (_newAddress2.isEmpty) {
          return 'Please enter address 2.';
        }
        return null;
      },
    );
  }

  Widget _countryIdField() {
    return TextFormField(
      controller: _countryId,
      keyboardType: TextInputType.text,
      autofocus: false,
      cursorColor: Constants.primary_green,
      decoration: InputDecoration(
        labelText: 'Country id',
        labelStyle: _labelStyle,
        contentPadding: _padding,
      ),
      validator: (_newId) {
        if (_newId.isEmpty) {
          return 'Please enter country id.';
        }
        return null;
      },
    );
  }

  Widget _zoneIdField() {
    return TextFormField(
      controller: _zoneId,
      keyboardType: TextInputType.text,
      autofocus: false,
      cursorColor: Constants.primary_green,
      decoration: InputDecoration(
        labelText: 'Zone Id',
        labelStyle: _labelStyle,
        contentPadding: _padding,
      ),
      validator: (_newZone) {
        if (_newZone.isEmpty) {
          return 'Please enter zone id.';
        }
        return null;
      },
    );
  }

  Widget _cityField() {
    return TextFormField(
      controller: _city,
      keyboardType: TextInputType.text,
      autofocus: false,
      cursorColor: Constants.primary_green,
      decoration: InputDecoration(
        labelText: 'City',
        labelStyle: _labelStyle,
        contentPadding: _padding,
      ),
      validator: (_newCity) {
        if (_newCity.isEmpty) {
          return 'Please enter city.';
        }
        return null;
      },
    );
  }

  Widget _postCodeField() {
    return TextFormField(
      controller: _postcode,
      keyboardType: TextInputType.number,
      autofocus: false,
      cursorColor: Constants.primary_green,
      decoration: InputDecoration(
        labelText: 'Pin Code',
        contentPadding: _padding,
      ),
      validator: (_newCode) {
        if (_newCode.isEmpty) {
          return 'Please enter pin code.';
        }
        return null;
      },
    );
  }

  Widget _saveButton() {
    return InkWell(
      onTap: () async => _saveShippingData(context),
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
          'SAVE ADDRESS',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }*/




//import 'package:flutter/material.dart';
//import 'package:gwaliorkart/models/location_data.dart';
//import 'package:gwaliorkart/models/shipping_address_data.dart';
//import 'package:gwaliorkart/screens/auth_login.dart';
//import 'package:gwaliorkart/screens/home.dart';
//import 'package:gwaliorkart/utils/auth_utils.dart';
//import 'package:gwaliorkart/utils/constants.dart';
//import 'package:gwaliorkart/widgets/error_screen.dart';
//import 'package:gwaliorkart/widgets/loader.dart';
//import 'package:gwaliorkart/widgets/widget_page.dart';
//
//class ShippingAddress extends StatefulWidget {
//  final ShippingAddressData shipObj;
//  final CountryData countryData;
//  final ZoneData zoneData;
//
//  ShippingAddress(this.shipObj, this.countryData, this.zoneData);
//
//  @override
//  _ShippingAddressState createState() => _ShippingAddressState();
//}
//
//class _ShippingAddressState extends State<ShippingAddress> {
//  MainAxisAlignment _mStart = MainAxisAlignment.start;
//  MainAxisAlignment _mCenter = MainAxisAlignment.center;
//  CrossAxisAlignment _cStart = CrossAxisAlignment.start;
//  CrossAxisAlignment _cCenter = CrossAxisAlignment.center;
//  ShippingAddressData _shipObj;
//  String _token, _customerId, _countryId, _zoneId, _addressId, _paymentAddress;
//
//  TextEditingController _firstName,
//      _lastName,
//      _company,
//      _email,
//      _address_1,
//      _address_2,
//      _city,
//      _postcode;
//  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//
////  Future<dynamic> _countryAndStateDataHolder;
//  Size _deviceSize;
//  bool _autoValidate = false;
//  CountryData _countryData;
//  ZoneData _zoneData;
//  List<dynamic> _countriesList, _statesList;
//
//  @override
//  void initState() {
//    _shipObj = widget.shipObj;
//    _token = AuthUtils.authToken;
//    _customerId = AuthUtils.userId;
//    widget.countryData != null
//        ? _countryData = widget.countryData
//        : _countryData = null;
//    widget.zoneData != null ? _zoneData = widget.zoneData : _zoneData = null;
//    _paymentAddress = _shipObj.paymentAddress;
//    _firstName = TextEditingController(text: _shipObj.firstName);
//    _lastName = TextEditingController(text: _shipObj.lastName);
//    _company = TextEditingController(text: _shipObj.company);
//    _address_1 = TextEditingController(text: _shipObj.address_1);
//    _address_2 = TextEditingController(text: _shipObj.address_2);
//    _city = TextEditingController(text: _shipObj.city);
//    _postcode = TextEditingController(text: _shipObj.postcode);
//    _countryId = _shipObj.countryId;
//    _zoneId = _shipObj.zoneId;
////    _countryAndStateDataHolder = _getCountryAndStateData(_customerId, _countryId);
//    super.initState();
//  }
//
//  /*Future<dynamic> _getCountryAndStateData(
//      final String _customerId, final String _countryId) async {
//    return [
//      await LocationUtils.getCountries(_customerId),
//      await LocationUtils.getStates(_countryId)
//    ];
//  }
//
//  FutureBuilder _futureBuilder() {
//    return FutureBuilder<dynamic>(
//      future: _countryAndStateDataHolder,
//      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
//        switch (snapshot.connectionState) {
//          case ConnectionState.none:
//          case ConnectionState.active:
//          case ConnectionState.waiting:
//            return Loader();
//          case ConnectionState.done:
//          default:
//            if (snapshot.hasError) {
//              return ErrorScreen(snapshot.error, 1);
//            } else {
//              return _addressBuilder(snapshot.data);
//            }
//        }
//      },
//    );
//  }
//
//  Future<dynamic> _updateState(final String _newCountryCode) async {
//    if (_newCountryCode != null && _newCountryCode != '') {
////      Constants.showLoadingIndicator(context);
//      await LocationUtils.getStates(_newCountryCode)
//          .then((final dynamic _newStateRes) {
//        if (_newStateRes != null && _newStateRes.containsKey('zone')) {
//          if (_newStateRes['zone'] != null && _newStateRes['zone'].length > 0) {
//            setState(() {
//              print("_statesList:=> $_newStateRes");
//              _zoneData = ZoneData.fromJson(_newStateRes);
//            });
//          }
//        } else {
////          Navigator.of(context).pop();
//          print("getStates Failed");
//          Constants.showLongToastBuilder("State not found!");
//        }
//      }).catchError((_err) {
////        Navigator.of(context).pop();
//        print("\ngetStates catchError:=> $_err\n");
//        Constants.showLongToastBuilder(_err.toString());
//      });
//    }
//  }*/
//
//  Future<dynamic> _updateState(final String _newCountryCode) async {
//    if (_newCountryCode != null && _newCountryCode != '') {
//      await LocationUtils.getStates(_newCountryCode)
//          .then((final dynamic _newStateRes) {
//        if (_newStateRes != null && _newStateRes.containsKey('zone')) {
//          if (_newStateRes['zone'] != null && _newStateRes['zone'].length > 0) {
//            setState(() {
//              this._zoneData = ZoneData.fromJson(_newStateRes);
//              this._zoneId = _zoneData.zone[0]['zone_id'];
//            });
//          }
//        } else {
//          print("getStates Failed");
//          Constants.showLongToastBuilder("State not found!");
//        }
//      }).catchError((_err) {
//        print("\ngetStates catchError:=> $_err\n");
//        Constants.showLongToastBuilder(_err.toString());
//      });
//    }
//  }
//
//  Future<void> _saveShippingData(BuildContext context) async {
//    if (_formKey.currentState.validate()) {
//      _formKey.currentState.save();
//      if (_token != null &&
//          _token != '' &&
//          _customerId != null &&
//          _customerId != '') {
//        Constants.showLoadingIndicator(context);
//        if (_shipObj.addressId == null) {
//          ShippingAddressData _addParams = ShippingAddressData(
//              _customerId,
//              _paymentAddress,
//              _firstName.text,
//              _lastName.text,
//              _company.text,
//              _address_1.text,
//              _address_2.text,
//              _city.text,
//              _postcode.text,
//              _countryId,
//              _zoneId,null,null,null);
//
//          await ShippingAddressUtils.saveNewShippingAddress(_addParams)
//              .then((dynamic _shipRes) {
//            if (_shipRes != null && _shipRes.containsKey("success")) {
//              Navigator.of(context).pop();
//              Constants.showShortToastBuilder(
//                  'Shipping address saved successfully.');
//              Navigator.pushReplacement(context,
//                  MaterialPageRoute(builder: (BuildContext context) => Home()));
//            } else {
//              Navigator.of(context).pop();
//              Constants.showShortToastBuilder('Oops something went wrong!');
//              print('\nsaveNewShippingAddress:= $_shipRes\n');
//            }
//          }).catchError((_shipErr) {
//            Navigator.of(context).pop();
//            Constants.showShortToastBuilder('Oops something went wrong!');
//            print('\nsaveNewShippingAddress catchError:= $_shipErr\n');
//          });
//        } else {
//          ShippingAddressData _updateParams = ShippingAddressData(
//              _customerId,
//              _paymentAddress,
//              _firstName.text,
//              _lastName.text,
//              _company.text,
//              _address_1.text,
//              _address_2.text,
//              _city.text,
//              _postcode.text,
//              _countryId,
//              _zoneId,null,null,null);
//
//          await ShippingAddressUtils.updateShippingAddress(_updateParams)
//              .then((dynamic _shipRes) {
//            if (_shipRes != null && _shipRes.containsKey("success")) {
//              Navigator.of(context).pop();
//              Constants.showShortToastBuilder(
//                  'Shipping address updated successfully.');
//              Navigator.pushReplacement(context,
//                  MaterialPageRoute(builder: (BuildContext context) => Home()));
//            } else {
//              Navigator.of(context).pop();
//              Constants.showShortToastBuilder('Oops something went wrong!');
//              print('\nupdateShippingAddress:= $_shipRes\n');
//            }
//          }).catchError((_shipErr) {
//            Navigator.of(context).pop();
//            Constants.showShortToastBuilder('Oops something went wrong!');
//            print('\nupdateShippingAddress catchError:= $_shipErr\n');
//          });
//        }
//      } else {
//        MaterialPageRoute authRoute =
//            MaterialPageRoute(builder: (context) => AuthLogin());
//        Navigator.push(context, authRoute);
//      }
//    } else {
//      setState(() {
//        _autoValidate = true; //enable realtime validation
//      });
//    }
//  }
//
//  TextStyle _richTextStyle = TextStyle(
//      fontWeight: FontWeight.w400, fontSize: 12.0, color: Constants.grey600);
//  TextStyle _textSpanStyle = TextStyle(
//    color: Colors.red,
//    fontWeight: FontWeight.bold,
//    fontSize: 16.5,
//  );
//
//  Widget _countryField(final List<dynamic> _countries) {
//    return Column(
//      mainAxisAlignment: _mStart,
//      crossAxisAlignment: _cStart,
//      children: <Widget>[
//        RichText(
//          text: TextSpan(text: '* ', style: _textSpanStyle, children: [
//            TextSpan(
//              text: 'Country',
//              style: _richTextStyle,
//            ),
//          ]),
//        ),
//        Container(
//          width: _deviceSize.width,
//          child: DropdownButtonFormField(
//            value: _countryId,
//            elevation: 0,
//            isDense: true,
//            isExpanded: true,
//            iconEnabledColor: Colors.green,
//            items: WidgetPage.countryMenuItems(_countries),
//            onChanged: (final String _newCountryVal) async {
//              print("NewCountry Id:=> $_newCountryVal");
//              if (_newCountryVal != null && _newCountryVal != '') {
//                setState(() {
//                  this._countryId = _newCountryVal.toString();
//                });
//                await _updateState(_countryId);
//              }
//            },
//            validator: (_value) => _value == null
//                ? 'Please select a company!'
//                : _value == '0' ? 'Please select a company!' : null,
//          ),
//        ),
//      ],
//    );
//  }
//
//  Widget _stateField(final List<dynamic> _states) {
//    print("stateField zoneId:= $_zoneId");
//    if (_zoneId == null || _zoneId == '') {
//      setState(() {
//        _zoneId = _states[0]['zone_id'];
//      });
//    }
//    return Column(
//      mainAxisAlignment: _mStart,
//      crossAxisAlignment: _cStart,
//      children: <Widget>[
//        RichText(
//          text: TextSpan(text: '* ', style: _textSpanStyle, children: [
//            TextSpan(
//              text: 'Region / State',
//              style: _richTextStyle,
//            ),
//          ]),
//        ),
//        Container(
//          width: _deviceSize.width,
//          child: DropdownButtonFormField(
//            value: _zoneId.toString(),
//            elevation: 0,
//            isDense: true,
//            isExpanded: true,
//            iconEnabledColor: Colors.green,
//            items: WidgetPage.stateMenuItems(_states),
//            onChanged: (final String _newStateVal) {
//              setState(() {
//                this._zoneId = _newStateVal;
//                print("state new id:=> $_zoneId");
//              });
//            },
//            validator: (_value) => _value == null
//                ? 'Please select a region / state!'
//                : _value == '0' ? 'Please select a region / state!' : null,
//          ),
//        ),
//      ],
//    );
//  }
//
//  Widget _addressBuilder(
//      final CountryData _countryData, final ZoneData _zoneData) {
//    List<dynamic> _countriesList = _countryData.countries,
//        _statesList = _zoneData.zone;
//    return Form(
//      key: _formKey,
//      autovalidate: _autoValidate,
//      child: SingleChildScrollView(
//        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
//        scrollDirection: Axis.vertical,
//        child: Column(
//          mainAxisAlignment: _mStart,
//          children: <Widget>[
//            WidgetPage.textFormField(
//                _firstName,
//                TextInputType.text,
//                'First Name',
//                'First Name must be between 1 and 32 characters!'),
//            Constants.height(30.0),
//            WidgetPage.textFormField(_lastName, TextInputType.text, 'Last Name',
//                'Last Name must be between 1 and 32 characters!'),
//            Constants.height(30.0),
//            WidgetPage.textFormFieldWithoutValidation(
//                _company, TextInputType.text, 'Company'),
//            /*Constants.height(30.0),
//            WidgetPage.textFormField(_email, TextInputType.emailAddress,
//                'Email', 'Please enter email.'),*/
//            Constants.height(30.0),
//            WidgetPage.textFormField(_address_1, TextInputType.text,
//                'Address 1', 'Address must be between 3 and 128 characters!'),
//            Constants.height(30.0),
//            WidgetPage.textFormFieldWithoutValidation(
//                _address_2, TextInputType.text, 'Address 2'),
//            Constants.height(30.0),
//            WidgetPage.textFormField(_city, TextInputType.text, 'City',
//                'City must be between 2 and 128 characters!'),
//            Constants.height(30.0),
//            WidgetPage.textFormField(_postcode, TextInputType.number,
//                'Post Code', 'City must be 6 characters!'),
//            Constants.height(30.0),
//            _countryField(_countriesList),
//            Constants.height(30.0),
//            _stateField(_statesList),
//          ],
//        ),
//      ),
//    );
//  }
//
//  BottomAppBar _bottomAppBarSaveButton() {
//    return BottomAppBar(
//      elevation: 0.0,
//      color: Constants.primary_green,
//      child: InkWell(
//        onTap: () async => _saveShippingData(context),
//        child: Container(
//          width: MediaQuery.of(context).size.width,
//          padding: EdgeInsets.symmetric(vertical: 14),
//          child: Text(
//            'SAVE ADDRESS',
//            textAlign: TextAlign.center,
//            style: TextStyle(color: Colors.white),
//          ),
//        ),
//      ),
//    );
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    _deviceSize = MediaQuery.of(context).size;
//    return Scaffold(
//      appBar: WidgetPage.addNewAddressAppBar(),
//      body: _addressBuilder(_countryData, _zoneData),
//      bottomNavigationBar: _bottomAppBarSaveButton(),
//    );
//  }
//}

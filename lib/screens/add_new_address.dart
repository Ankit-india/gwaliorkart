// import 'package:flutter/material.dart';
// import 'package:gwaliorkart/models/address_data.dart';
// import 'package:gwaliorkart/models/shipping_address_data.dart';
// import 'package:gwaliorkart/screens/home.dart';
// import 'package:gwaliorkart/utils/auth_utils.dart';
// import 'package:gwaliorkart/utils/constants.dart';
// import 'package:gwaliorkart/widgets/widget_page.dart';
// import 'package:gwaliorkart/models/location_data.dart';
// import 'package:gwaliorkart/screens/auth_login.dart';
//
// class AddNewAddress extends StatefulWidget {
//
//  @override
//  _AddNewAddressState createState() => _AddNewAddressState();
// }
//
// class _AddNewAddressState extends State<AddNewAddress> {
//  MainAxisAlignment _mStart = MainAxisAlignment.start;
//  MainAxisAlignment _mCenter = MainAxisAlignment.center;
//  CrossAxisAlignment _cStart = CrossAxisAlignment.start;
//  CrossAxisAlignment _cCenter = CrossAxisAlignment.center;
//  AddressData _address;
//  String _token, _customerId, _countryId, _zoneId, _addressId, _paymentAddress,_defaults;
//  TextEditingController _firstName,
//      _lastName,
//      _company,_telephone,
//      _email,
//      _address_1,
//      _address_2,
//      _city,
//      _postcode;
//  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//  Size _deviceSize;
//  bool _autoValidate = false;
//  CountryData _countryData;
//  ZoneData _zoneData;
//  List<dynamic> _countriesList, _statesList;
//
//  @override
//  void initState() {
//    // widget.address != null ? _address = widget.address : _address = _address;
//    _token = AuthUtils.authToken;
//    _customerId = AuthUtils.userId;
//    _firstName = TextEditingController();
//    _lastName = TextEditingController();
//    _company = TextEditingController();
//    _telephone = TextEditingController();
//    _email = TextEditingController();
//    _address_1 = TextEditingController();
//    _address_2 = TextEditingController();
//    _city = TextEditingController();
//    _postcode = TextEditingController();
//    _countryId = _address.countryId;
//    _zoneId = '1480';
// //    _countryAndStateDataHolder = _getCountryAndStateData(_customerId, _countryId);
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
// //      Constants.showLoadingIndicator(context);
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
// //          Navigator.of(context).pop();
//          print("getStates Failed");
//          Constants.showLongToastBuilder("State not found!");
//        }
//      }).catchError((_err) {
// //        Navigator.of(context).pop();
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
//  Future<void> _saveAddress(BuildContext context) async {
//    if (_formKey.currentState.validate()) {
//      _formKey.currentState.save();
//      if (_token != null &&
//          _token != '' &&
//          _customerId != null &&
//          _customerId != '') {
//        Constants.showLoadingIndicator(context);
//        AddressData _addressParam = AddressData(
//            _customerId,
//            _firstName.text,
//            _lastName.text,
//            _company.text,_telephone.text,_email.text,
//            _address_1.text,
//            _address_2.text,
//            _zoneId,
//            _city.text,
//            _postcode.text,
//            _defaults);
//
//        await AddressUtils.saveCustomerAddressForm(_addressParam)
//            .then((dynamic _shipRes) {
//          if (_shipRes != null && _shipRes.containsKey("success")) {
//            Navigator.of(context).pop();
//            Constants.showShortToastBuilder('Address saved successfully.');
//            /*Navigator.pushReplacement(context,
//                MaterialPageRoute(builder: (BuildContext context) => Home()));*/
//          } else {
//            Navigator.of(context).pop();
//            Constants.showShortToastBuilder('Create new address failed');
//            print('\nsaveCustomerAddressForm:= $_shipRes\n');
//          }
//        }).catchError((_shipErr) {
//          Navigator.of(context).pop();
//          Constants.showShortToastBuilder('Oops something went wrong!');
//          print('\nsaveCustomerAddressForm catchError:= $_shipErr\n');
//        });
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
//        onTap: () async => _saveAddress(context),
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
// }

import 'package:flutter/material.dart';
import 'package:gwaliorkart/models/address_data.dart';
import 'package:gwaliorkart/utils/auth_utils.dart';
import 'package:gwaliorkart/utils/constants.dart';
import 'package:gwaliorkart/widgets/widget_page.dart';
import 'package:gwaliorkart/models/location_data.dart';
import 'package:gwaliorkart/screens/auth_login.dart';

class AddNewAddress extends StatefulWidget {
  final AddressData addressData;
  final CountryData countryData;
  final ZoneData zoneData;

  AddNewAddress(this.addressData, this.countryData, this.zoneData);

  @override
  _AddNewAddressState createState() => _AddNewAddressState();
}

class _AddNewAddressState extends State<AddNewAddress> {
  MainAxisAlignment _mStart = MainAxisAlignment.start;
  CrossAxisAlignment _cStart = CrossAxisAlignment.start;
  AddressData _addressData;
  CountryData _countryData;
  ZoneData _zoneData;
  String _token,
      _customerId,
      _countryId,
      _zoneId,
      _defaults;
  TextEditingController _firstName,
      _lastName,
      _company,
      _telephone,
      _email,
      _address_1,
      _address_2,
      _city,
      _postcode;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Size _deviceSize;
  bool _autoValidate = false;

  @override
  void initState() {
    _token = AuthUtils.authToken;
    _customerId = AuthUtils.userId;
    widget.addressData != null
        ? _addressData = widget.addressData
        : _addressData = _addressData;
    widget.countryData != null
        ? _countryData = widget.countryData
        : _countryData = _countryData;
    widget.zoneData != null
        ? _zoneData = widget.zoneData
        : _zoneData = _zoneData;
    _firstName = TextEditingController(text: _addressData.firstName);
    _lastName = TextEditingController(text: _addressData.lastName);
    _company = TextEditingController(text: _addressData.company);
    _telephone = TextEditingController(text: _addressData.telephone);
    _email = TextEditingController(text: _addressData.emailData);
    _address_1 = TextEditingController(text: _addressData.address1);
    _address_2 = TextEditingController(text: _addressData.address2);
    _city = TextEditingController(text: _addressData.city);
    _postcode = TextEditingController(text: _addressData.postcode);
    _countryId = _addressData.countryId;
    _addressData.defaults != null && _addressData.defaults == 'false' ? _defaults = '0' : _defaults = '1';
    super.initState();
  }

  Future<void> _saveAddress(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      if (_token != null &&
          _token != '' &&
          _customerId != null &&
          _customerId != '') {
        Constants.showLoadingIndicator(context);
        AddressData _addressParam = AddressData(
            _customerId,
            _firstName.text,
            _lastName.text,
            _company.text,
            _telephone.text,
            _email.text,
            _address_1.text,
            _address_2.text,
            _city.text,
            _postcode.text,
            _zoneId,
            _countryId,
            _defaults);

        await AddressUtils.saveCustomerAddressForm(_addressParam)
            .then((dynamic _shipRes) {
          // if (_shipRes != null && _shipRes.containsKey("success")) {
          if (_shipRes != null) {
            Navigator.of(context).pop();
            Constants.showShortToastBuilder('Address saved successfully.');
            _formKey.currentState.reset();
            /*Navigator.pushReplacement(context,
               MaterialPageRoute(builder: (BuildContext context) => Home()));*/
          } else {
            Navigator.of(context).pop();
            Constants.showShortToastBuilder('Create new address failed');
            print('\nsaveCustomerAddressForm:= $_shipRes\n');
          }
        }).catchError((_shipErr) {
          Navigator.of(context).pop();
          Constants.showShortToastBuilder('Oops something went wrong!');
          print('\nsaveCustomerAddressForm catchError:= $_shipErr\n');
        });
      } else {
        MaterialPageRoute authRoute =
            MaterialPageRoute(builder: (context) => AuthLogin());
        Navigator.push(context, authRoute);
      }
    } else {
      setState(() {
        _autoValidate = true; //enable realtime validation
      });
    }
  }

  final TextStyle _richTextStyle = TextStyle(
      fontWeight: FontWeight.w400, fontSize: 12.0, color: Constants.grey600);
  final TextStyle _textSpanStyle = TextStyle(
    color: Colors.red,
    fontWeight: FontWeight.bold,
    fontSize: 16.5,
  );

  Widget _stateField(final List<dynamic> _states) {
    if (_zoneId == null || _zoneId == '') {
      setState(() {
        this._zoneId = _states[0]['zone_id'];
      });
    }
    return Column(
      mainAxisAlignment: _mStart,
      crossAxisAlignment: _cStart,
      children: <Widget>[
        RichText(
          text: TextSpan(text: '* ', style: _textSpanStyle, children: [
            TextSpan(
              text: 'Region / State',
              style: _richTextStyle,
            ),
          ]),
        ),
        Container(
          width: _deviceSize.width,
          child: DropdownButtonFormField(
            value: _zoneId.toString(),
            elevation: 0,
            isDense: true,
            isExpanded: true,
            iconEnabledColor: Colors.green,
            items: WidgetPage.stateMenuItems(_states),
            onChanged: (final String _newStateVal) {
              setState(() {
                this._zoneId = _newStateVal;
                print("state new id:=> $_zoneId");
              });
            },
            validator: (_value) => _value == null
                ? 'Please select a region / state!'
                : _value == '0' ? 'Please select a region / state!' : null,
          ),
        ),
      ],
    );
  }

  Future<dynamic> _updateState(final String _newCountryId) async {
    if (_newCountryId != null && _newCountryId != '') {
      await LocationUtils.getStates(_newCountryId)
          .then((final dynamic _newStateRes) {
        if (_newStateRes != null && _newStateRes.containsKey('zone')) {
          if (_newStateRes['zone'] != null && _newStateRes['zone'].length > 0) {
            setState(() {
              this._zoneId = null;
              this._zoneData = ZoneData.fromJson(_newStateRes);
              this._zoneId = this._zoneData.zone[0]['zone_id'];
            });
          }
        } else {
          print("getStates Failed");
          Constants.showLongToastBuilder("State not found!");
        }
      }).catchError((_err) {
        print("\ngetStates catchError:=> $_err\n");
        Constants.showLongToastBuilder(_err.toString());
      });
    }
  }

  Widget _countryField(final List<dynamic> _countries){
    return Column(
      mainAxisAlignment: _mStart,
      crossAxisAlignment: _cStart,
      children: <Widget>[
        RichText(
          text: TextSpan(text: '* ', style: _textSpanStyle, children: [
            TextSpan(
              text: 'Country',
              style: _richTextStyle,
            ),
          ]),
        ),
        Container(
          width: _deviceSize.width,
          child: DropdownButtonFormField(
            value: this._countryId,
            elevation: 0,
            isDense: true,
            isExpanded: true,
            iconEnabledColor: Colors.green,
            items: WidgetPage.countryMenuItems(
                this._countryData.countries),
            onChanged: (dynamic _newCountryVal) async {
              if (_newCountryVal != null && _newCountryVal != '') {
                setState(() {
                  this._countryId = _newCountryVal.toString();
                  print("onChanged countryId:=> $_newCountryVal");
                });
                await _updateState(this._countryId);
              }
            },
            validator: (dynamic _value) => _value == null
                ? 'Please select a country!'
                : _value == '0' ? 'Please select a country!' : null,
          ),
        ),
      ],
    );
  }

  Widget _addressBuilder() {
    return Form(
      key: _formKey,
      autovalidate: _autoValidate,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: _mStart,
          children: <Widget>[
            WidgetPage.textFormField(
                _firstName,
                TextInputType.text,
                'First Name',
                'First Name must be between 1 and 32 characters!'),
            Constants.height(30.0),
            WidgetPage.textFormField(_lastName, TextInputType.text, 'Last Name',
                'Last Name must be between 1 and 32 characters!'),
            Constants.height(30.0),
            WidgetPage.textFormFieldWithoutValidation(
                _company, TextInputType.text, 'Company'),
            Constants.height(30.0),
            WidgetPage.textFormField(_telephone, TextInputType.phone, 'Mobile',
                'Mobile number must be 10 digits.'),
            Constants.height(30.0),
            WidgetPage.textFormField(_email, TextInputType.emailAddress,
                'Email', 'Please enter email.'),
            Constants.height(30.0),
            WidgetPage.textFormField(_address_1, TextInputType.text,
                'Address 1', 'Address must be between 3 and 128 characters!'),
            Constants.height(30.0),
            WidgetPage.textFormFieldWithoutValidation(
                _address_2, TextInputType.text, 'Address 2'),
            Constants.height(30.0),
            WidgetPage.textFormField(_city, TextInputType.text, 'City',
                'City must be between 2 and 128 characters!'),
            Constants.height(30.0),
            WidgetPage.textFormField(_postcode, TextInputType.number,
                'Post Code', 'Post code must be 6 characters!'),
            Constants.height(30.0),
            _countryField(_countryData.countries),
            Constants.height(30.0),
            _stateField(_zoneData.zone),
          ],
        ),
      ),
    );
  }

  BottomAppBar _bottomAppBarSaveButton() {
    return BottomAppBar(
      elevation: 0.0,
      color: Constants.primary_green,
      child: InkWell(
        onTap: () async => _saveAddress(context),
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(vertical: 14),
          child: Text(
            'SAVE ADDRESS',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: WidgetPage.addNewAddressAppBar(),
      body: _addressBuilder(),
      bottomNavigationBar: _bottomAppBarSaveButton(),
    );
  }
}

/*Future<dynamic> _getCountryAndStateData(
     final String _customerId, final String _countryId) async {
   return [
     await LocationUtils.getCountries(_customerId),
     await LocationUtils.getStates(_countryId)
   ];
 }

 FutureBuilder _futureBuilder() {
   return FutureBuilder<dynamic>(
     future: _countryAndStateDataHolder,
     builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
       switch (snapshot.connectionState) {
         case ConnectionState.none:
         case ConnectionState.active:
         case ConnectionState.waiting:
           return Loader();
         case ConnectionState.done:
         default:
           if (snapshot.hasError) {
             return ErrorScreen(snapshot.error, 1);
           } else {
             return _addressBuilder(snapshot.data);
           }
       }
     },
   );
 }

 Future<dynamic> _updateState(final String _newCountryCode) async {
   if (_newCountryCode != null && _newCountryCode != '') {
//      Constants.showLoadingIndicator(context);
     await LocationUtils.getStates(_newCountryCode)
         .then((final dynamic _newStateRes) {
       if (_newStateRes != null && _newStateRes.containsKey('zone')) {
         if (_newStateRes['zone'] != null && _newStateRes['zone'].length > 0) {
           setState(() {
             print("_statesList:=> $_newStateRes");
             _zoneData = ZoneData.fromJson(_newStateRes);
           });
         }
       } else {
//          Navigator.of(context).pop();
         print("getStates Failed");
         Constants.showLongToastBuilder("State not found!");
       }
     }).catchError((_err) {
//        Navigator.of(context).pop();
       print("\ngetStates catchError:=> $_err\n");
       Constants.showLongToastBuilder(_err.toString());
     });
   }
 }

  Future<dynamic> _updateState(final String _newCountryCode) async {
    if (_newCountryCode != null && _newCountryCode != '') {
      await LocationUtils.getStates(_newCountryCode)
          .then((final dynamic _newStateRes) {
        if (_newStateRes != null && _newStateRes.containsKey('zone')) {
          if (_newStateRes['zone'] != null && _newStateRes['zone'].length > 0) {
            setState(() {
              this._zoneData = ZoneData.fromJson(_newStateRes);
              this._zoneId = _zoneData.zone[0]['zone_id'];
            });
          }
        } else {
          print("getStates Failed");
          Constants.showLongToastBuilder("State not found!");
        }
      }).catchError((_err) {
        print("\ngetStates catchError:=> $_err\n");
        Constants.showLongToastBuilder(_err.toString());
      });
    }
  }*/

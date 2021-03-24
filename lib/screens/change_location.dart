import 'package:flutter/material.dart';
import 'package:gwaliorkart/models/location_data.dart';
import 'package:gwaliorkart/models/shipping_address_data.dart';
import 'package:gwaliorkart/screens/add_new_address.dart';
import 'package:gwaliorkart/screens/shipping_address.dart';
import 'package:gwaliorkart/utils/auth_utils.dart';
import 'package:gwaliorkart/utils/constants.dart';

class ChangeLocation extends StatefulWidget {
  @override
  _ChangeLocationState createState() => _ChangeLocationState();
}

class _ChangeLocationState extends State<ChangeLocation> {
  String _token, _customerId, _currentCity, _currentPinCode;

  @override
  void initState() {
    _token = AuthUtils.authToken;
    _customerId = AuthUtils.userId;
    _currentCity = AuthUtils.currentCity;
    _currentPinCode = AuthUtils.currentPinCode;
    super.initState();
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: Constants.myWhite,
      elevation: 0,
      bottom: PreferredSize(
        preferredSize: Size(0, 0),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Constants.myWhite,
            borderRadius: BorderRadius.circular(5),
          ),
          margin: EdgeInsets.all(10.0),
          child: Row(
            children: <Widget>[
              InkWell(
                child: Icon(
                  Icons.navigate_before,
                  color: Constants.grey600,
                  size: 30.0,
                ),
                onTap: () => Navigator.of(context).pop(),
              ),
              Constants.width(10.0),
              Expanded(
                child: InkWell(
                  onTap: () =>
                      Constants.showShortToastBuilder("Search area Clicked"),
                  child: Text(
                    "Search for area, landmark or apart",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Constants.grey500, fontSize: 14.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _body() {
    return ListView(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      children: <Widget>[
        Container(
          color: Colors.green,
          height: 1.0,
        ),
        InkWell(
          onTap: () =>
              Constants.showShortToastBuilder("Current location clicked"),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Constants.myWhite,
              borderRadius: BorderRadius.circular(3),
              border: Border.all(width: 1, color: Constants.grey500),
            ),
            height: 45,
            margin: EdgeInsets.all(10.0),
            child: Row(
              children: <Widget>[
                Constants.width(30.0),
                Icon(
                  Icons.my_location,
                  color: Constants.grey500,
                  size: 18.0,
                ),
                Constants.width(20.0),
                Text(
                  "Choose current location",
                  style: TextStyle(color: Constants.grey500, fontSize: 14.5),
                ),
              ],
            ),
          ),
        ),
        _token != null && _token != ''
            ? Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  InkWell(
                    onTap: () async => Constants.goToCheckoutPage(
                        _customerId, '99', context),
                    child: Container(
                      color: Colors.grey[200],
                      padding: EdgeInsets.symmetric(vertical: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "+ADD NEW ADDRESS",
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          "assets/icons/delivery.png",
                          width: 150.0,
                          color: Constants.myGreen,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      "Let us know where to deliver your order!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16.0,
                          color: Constants.grey800),
                    ),
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                    child: Text(
                      "Add address and experience faster checkout!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 13.0,
                          color: Constants.grey500),
                    ),
                  ),
                ],
              )
            : Container(
                padding: EdgeInsets.only(top: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "powered by",
                      style: TextStyle(
                          fontSize: 11.0,
                          color: Constants.grey700,
                          letterSpacing: 0.3),
                    ),
                    Constants.width(5.0),
                    Image.asset(
                      'assets/icons/google.png',
                      height: 17.0,
                    )
                  ],
                ),
              ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.myWhite,
      appBar: _appBar(),
      body: _body(),
    );
  }
}

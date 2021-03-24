import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:gwaliorkart/screens/change_location.dart';
import 'package:gwaliorkart/utils/auth_utils.dart';
import 'package:gwaliorkart/utils/constants.dart';

class ProceedToPay extends StatefulWidget {
  @override
  _ProceedToPayState createState() => _ProceedToPayState();
}

class _ProceedToPayState extends State<ProceedToPay> {
  CrossAxisAlignment _cStart = CrossAxisAlignment.start;
  MainAxisAlignment _mStart = MainAxisAlignment.start;
  CrossAxisAlignment _cCenter = CrossAxisAlignment.center;
  MainAxisAlignment _mCenter = MainAxisAlignment.center;
  final bool _isLoading = false;

  AppBar _appBar() {
    return AppBar(
      elevation: 0.0,
      centerTitle: true,
      title: Text("Delivery Options"),
    );
  }

  Future<void> _proceedToPayButton(BuildContext context) async {
    Constants.showShortToastBuilder('success');
  }

  Widget _defaultAddressSection() {
    return Container(
      color: Constants.myWhite,
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
      child: Column(
        mainAxisAlignment: _mStart,
        crossAxisAlignment: _cStart,
        children: <Widget>[
          Row(
            mainAxisAlignment: _mStart,
            crossAxisAlignment: _cStart,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: 5.0),
                  child: Row(
                    mainAxisAlignment: _mStart,
                    crossAxisAlignment: _cCenter,
                    children: <Widget>[
                      Icon(
                        Icons.location_on,
                        color: Colors.grey,
                        size: 22.0,
                      ),
                      Constants.width(5.0),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            text: 'Delivery to: Home ',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Constants.grey800,
                                fontSize: 18.0),
                            children: [
                              TextSpan(
                                text: '(Default)',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15.0),
                              ),
                            ]),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) {
                  return ChangeLocation();
                })),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(width: 1, color: Constants.grey500),
                  ),
                  child: Text(
                    "Change",
                    style: TextStyle(fontSize: 11.0, color: Constants.grey700),
                  ),
                ),
              ),
            ],
          ),
          Constants.height(8.0),
          Text(
            "${AuthUtils.currentLocality} ${AuthUtils.currentCity} ${AuthUtils.currentState} ${AuthUtils.currentCountry}, Pin - ${AuthUtils.currentPinCode}, Near by Mohan Baba temple",
            style: TextStyle(fontSize: 12.0, color: Constants.grey800),
          ),
        ],
      ),
    );
  }

  Widget _defaultDeliveryOption() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
      child: Column(
          mainAxisAlignment: _mStart,
          crossAxisAlignment: _cStart,
          children: <Widget>[
            Row(
                mainAxisAlignment: _mStart,
                crossAxisAlignment: _cStart,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      "Default Delivery\nOption",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Constants.grey800,
                          fontSize: 14.0),
                    ),
                  ),
                  Text(
                    "1 Shipment\nDelivery Charge: Rs 30",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Constants.grey700,
                        fontSize: 12.0),
                  ),
                ]),
            Divider(
              height: 30.0,
            ),
            Row(
              mainAxisAlignment: _mStart,
              children: <Widget>[
                Expanded(
                  child: Text(
                    "Shipment 1: Standard Delivery",
                    style: TextStyle(fontSize: 12.0),
                  ),
                ),
                InkWell(
                  /*onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) {
                    return ChangeLocation();
                  })),*/
                  onTap: () => null,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(width: 1, color: Constants.grey500),
                    ),
                    child: Text(
                      "View 2 items",
                      style:
                          TextStyle(fontSize: 11.0, color: Constants.grey700),
                    ),
                  ),
                ),
              ],
            ),
            Constants.height(15.0),
            Row(
              mainAxisAlignment: _mStart,
              children: <Widget>[
                Text(
                  "Delivery Charge: Rs 30",
                  style: TextStyle(
                      fontSize: 12.0,
                      color: Constants.grey900,
                      fontWeight: FontWeight.w300),
                ),
                Constants.width(5.0),
                InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async => Constants.infoDialog(context),
                  child: Icon(
                    Icons.info_outline,
                    size: 20.0,
                    color: Constants.grey500,
                  ),
                )
              ],
            ),
          ]),
    );
  }

  /*BottomAppBar _bottomAppBarProceedToPayButton() {
    return BottomAppBar(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 55.0,
          padding: EdgeInsets.symmetric(vertical: 6.0),
          child: _isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.green,
                  ),
                )
              : FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2)),
                  color: Colors.deepOrange,
                  child: Text(
                    'PROCEED TO PAY',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.w400),
                  ),
                  onPressed: () async => _proceedToPayButton(context),
                ),
        ),
      ),
    );
  }*/

  Widget _bottomAppBarProceedToPayButton() {
    return BottomAppBar(
      elevation: 0.0,
      color: Colors.deepOrange,
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () async => _proceedToPayButton(context),
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(vertical: 15),
          child: Text(
            'PROCEED TO PAY',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 15, color: Colors.white, fontWeight: FontWeight.w400),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.grey200,
      appBar: _appBar(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: _mStart,
          children: <Widget>[
            _defaultAddressSection(),
            Constants.height(15.0),
            _defaultDeliveryOption(),
          ],
        ),
      ),
      bottomNavigationBar: _bottomAppBarProceedToPayButton(),
    );
  }
}

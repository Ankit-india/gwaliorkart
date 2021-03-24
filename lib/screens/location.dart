import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gwaliorkart/utils/constants.dart';
import 'package:gwaliorkart/utils/storage_utils.dart';

class Location extends StatefulWidget {
  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location> {
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  Position _currentPosition;
  String _currentAddress = '';

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Current Location",
          style: TextStyle(fontSize: 18.0),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _currentPosition != null
                ? Container(
                    child: Text(
                      _currentAddress != null
                          ? _currentAddress
                          : Constants.smallLoader().toString(),
                    ),
                  )
                : FlatButton(
                    child: Text("Get location"),
                    onPressed: () {
                      _getCurrentLocation();
                    },
                  ),
          ],
        ),
      ),
    );
  }

  _getCurrentLocation() {
    Geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });

      _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark _place = p[0];

      setState(() async {
        _currentAddress =
            "${_place.locality}, ${_place.postalCode}, ${_place.country}";
      });
    } catch (e) {
      print(e);
    }
  }
}

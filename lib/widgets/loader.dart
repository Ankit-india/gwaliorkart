import 'package:flutter/material.dart';
import 'package:gwaliorkart/utils/constants.dart';

class Loader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<String>(
          builder: (context, snapshot) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(),
                Text(""),
                Text(
                  "Please Wait",
                  style: TextStyle(
                      color: Constants.primary_green,
                      fontWeight: FontWeight.w600,
                      fontSize: 15),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

//import 'dart:convert';
//
//import 'package:flutter/material.dart';
//import 'package:gwaliorkart/models/dummy_data_model.dart';
//import 'package:gwaliorkart/utils/constants.dart';
//import 'package:gwaliorkart/widgets/error_screen.dart';
//import 'package:gwaliorkart/widgets/loader.dart';
//
//class DummyUserList extends StatefulWidget {
//  @override
//  _DummyUserListState createState() => _DummyUserListState();
//}
//
//class _DummyUserListState extends State<DummyUserList> {
//  SizedBox _height(final double size) {
//    return SizedBox(
//      height: size,
//    );
//  }
//
//  Future<dynamic> dummyUserDataHolder;
//
//  @override
//  void initState() {
//    super.initState();
//    dummyUserDataHolder = _getDummyUserData();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        centerTitle: true,
//        title: Text("Dummy User List"),
//      ),
//      body: Container(
//        child: Center(
//          child: _futureBuilder(),
//        ),
//      ),
//    );
//  }
//
//  Future<dynamic> _getDummyUserData() async {
//    return await DefaultAssetBundle.of(context)
//        .loadString('load_json/person.json');
//  }
//
//  FutureBuilder _futureBuilder() {
//    return FutureBuilder<dynamic>(
//      future: dummyUserDataHolder,
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
//              return _userListViewBuilder(
//                  json.decode(snapshot.data.toString()));
//            }
//        }
//      },
//    );
//  }
//
//  Widget _userListViewBuilder(final List<dynamic> snapshot) {
//    final List<dynamic> userList = snapshot[0]['userJson'].map((item) {
//      return DummyUserData.fromJson(item);
//    }).toList();
//    return ListView.builder(
//        shrinkWrap: true,
//        scrollDirection: Axis.vertical,
//        itemCount: userList == null ? 0 : userList.length,
//        itemBuilder: (BuildContext context, int index) {
//          DummyUserData userData = userList[index];
//          return InkWell(
//            onTap: () {
//              Constants.showToastBuilder(userData.id.toString());
//            },
//            child: Card(
//              margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
//              child: Padding(
//                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
//                child: Row(
//                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                  children: <Widget>[
//                    SizedBox(
//                      height: 100,
//                      width: 100,
//                      child: userData.getImage(),
//                    ),
//                    CircleAvatar(
//                      radius: 45.0,
//                      backgroundImage: NetworkImage(
//                          "https://img.techpowerup.org/200623/picme1.jpg"),
//                      backgroundColor: Colors.transparent,
//                    ),
//                    SizedBox(
//                      width: 10,
//                    ),
//                    Expanded(
//                      child: Column(
//                        crossAxisAlignment: CrossAxisAlignment.stretch,
//                        children: <Widget>[
//                          Text("Name: " + userData.name),
//                          _height(5),
//                          Text("Age: " + userData.age),
//                          _height(5),
//                          Text("Height: " + userData.height),
//                          _height(5),
//                          Text("Gender: " + userData.gender),
//                          _height(5),
//                          Text("Hair Color: " + userData.hairColor),
//                        ],
//                      ),
//                    ),
//                  ],
//                ),
//              ),
//            ),
//          );
//        });
//  }
//}

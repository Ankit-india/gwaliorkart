//import 'dart:convert';
//
//import 'package:flutter/material.dart';
//import 'package:gwaliorkart/models/dummy_data_model.dart';
//import 'package:gwaliorkart/utils/constants.dart';
//import 'package:gwaliorkart/widgets/error_screen.dart';
//import 'package:gwaliorkart/widgets/loader.dart';
//
//class Search extends StatefulWidget {
//  final ScrollController _scrollBottomBarController;
//
//  Search(this._scrollBottomBarController);
//
//  @override
//  _SearchState createState() => _SearchState();
//}
//
//class _SearchState extends State<Search> {
//  Future<dynamic> searchKeywordHolder;
//
//  @override
//  void initState() {
//    super.initState();
//    searchKeywordHolder = _getKeywordData();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      color: Constants.myWhite,
//      child: Column(
//        crossAxisAlignment: CrossAxisAlignment.start,
//        children: <Widget>[
//          Container(
//            padding: EdgeInsets.symmetric(horizontal: 17.0, vertical: 20.0),
//            child: Text(
//              "Popular Searched",
//              style: TextStyle(color: Colors.grey),
//            ),
//          ),
//          Expanded(
//            child: _futureBuilder(),
//          ),
//        ],
//      ),
//    );
//  }
//
//  Future<dynamic> _getKeywordData() async {
//    return await DefaultAssetBundle.of(context)
//        .loadString('load_json/search_keyword.json');
//  }
//
//  FutureBuilder _futureBuilder() {
//    return FutureBuilder<dynamic>(
//      future: searchKeywordHolder,
//      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
//        switch (snapshot.connectionState) {
//          case ConnectionState.none:
//          case ConnectionState.active:
//          case ConnectionState.waiting:
//            return Loader();
//          case ConnectionState.done:
//          default:
//            if (snapshot.hasError) {
//              print(snapshot.error);
//              return ErrorScreen(snapshot.error, 1);
//            } else {
//              return _categoriesListViewBuilder(
//                  json.decode(snapshot.data.toString()));
//            }
//        }
//      },
//    );
//  }
//
//  Widget _categoriesListViewBuilder(final List<dynamic> snapshot) {
//    final List<dynamic> keywordList = snapshot.map((items) {
//      return DummySearchData.fromJson(items);
//    }).toList();
//    return ListView.builder(
//        shrinkWrap: true,
//        scrollDirection: Axis.vertical,
//        itemCount: keywordList == null ? 0 : keywordList.length,
//        itemBuilder: (BuildContext context, int index) {
//          DummySearchData keyword = keywordList[index];
//          return ListTile(
//            onTap: () {
//              Constants.showToastBuilder(keyword.id.toString());
//            },
//            title: Text(keyword.keyword),
//            trailing: Icon(
//              Icons.call_made,
//              textDirection: TextDirection.rtl,
//            ),
//          );
//        });
//  }
//}


import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gwaliorkart/screens/search_screen.dart';
import 'package:gwaliorkart/utils/constants.dart';

class Search extends StatefulWidget {
  final ScrollController _scrollBottomBarController;

  Search(this._scrollBottomBarController);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {

  @override
  void initState() {
    super.initState();
//    _loadCurrentUser();
    Timer(Duration(seconds: 0), () {
      navigateFromSearch();
    });
  }

  Future<void> _loadCurrentUser() async {
    await Constants.loadCurrentUser()
        .then((dynamic _val) {})
        .catchError((_err) {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(color: Constants.myWhite,);
  }

  Future navigateFromSearch() async {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => SearchScreen()));
  }
}
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gwaliorkart/models/landing_model.dart';
import 'package:gwaliorkart/screens/subcategory_page.dart';
import 'package:gwaliorkart/utils/constants.dart';
import 'package:gwaliorkart/widgets/error_screen.dart';
import 'package:gwaliorkart/widgets/loader.dart';

class Categories extends StatefulWidget {
  final ScrollController _scrollBottomBarController;

  Categories(this._scrollBottomBarController);

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  Future<dynamic> _categoriesListDataHolder;
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser _currentUser;

  @override
  void initState() {
    super.initState();
//    _loadCurrentUser();
    _categoriesListDataHolder = _getCategoriesListData();
  }

  Future<void> _loadCurrentUser() async {
    await Constants.loadCurrentUser()
        .then((dynamic _val) {})
        .catchError((_err) {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Constants.myWhite,
      child: _futureBuilder(),
    );
  }

  Future<dynamic> _getCategoriesListData() async {
    return await LandingPageUtils.getLandingPageList();
  }

  FutureBuilder _futureBuilder() {
    return FutureBuilder<dynamic>(
      future: _categoriesListDataHolder,
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
              return _categoriesListViewBuilder(snapshot.data);
            }
        }
      },
    );
  }

  Widget _categoriesListViewBuilder(Map<String, dynamic> snapshot) {
    final List<dynamic> categoryList = snapshot['categories'].map((item) {
      return CategoriesListingData.fromJson(item);
    }).toList();
    return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        controller: widget._scrollBottomBarController,
        itemCount: categoryList == null ? 0 : categoryList.length,
        itemBuilder: (BuildContext context, int index) {
          CategoriesListingData categoryData = categoryList[index];

          final List<dynamic> subCatList =
              categoryData.subcategory.map((items) {
            return CategoriesChildrenListingData.fromJson(items);
          }).toList();

          return Column(
            children: <Widget>[
              ExpansionTile(
                leading: SizedBox(
                  height: 35,
                  width: 35,
                  child:
                      categoryData.getImage(int.parse(categoryData.categoryId)),
                ),
                title: Text(categoryData.name),
                children: <Widget>[
                  ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: subCatList == null ? 0 : subCatList.length,
                      itemBuilder: (BuildContext context, int index) {
                        CategoriesChildrenListingData listData =
                            subCatList[index];
                        return InkWell(
                          onTap: () async => Constants.goToProductListPage(
                              listData.categoryId, listData.name, context),
//                          onTap: () async => Constants.goToSubCategoryPage(listData.categoryId, listData.name, context),
                          child: Column(
                            children: <Widget>[
                              ListTile(
                                title: Text(listData.name),
                                contentPadding: EdgeInsets.only(left: 35.0),
                              ),
                              Divider(
                                height: 1,
                                indent: 35,
                              )
                            ],
                          ),
                        );
                      })
                ],
              ),
              Divider(
                height: 2.5,
                indent: 18,
              )
            ],
          );
        });
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:math';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:gwaliorkart/models/dummy_data_model.dart';
import 'package:gwaliorkart/screens/subcategory_page.dart';
import 'package:gwaliorkart/utils/constants.dart';
import 'package:gwaliorkart/widgets/error_screen.dart';
import 'package:gwaliorkart/widgets/loader.dart';

class Offers extends StatefulWidget {
  final ScrollController _scrollBottomBarController;

  Offers(this._scrollBottomBarController);

  @override
  _OffersState createState() => _OffersState();
}

class _OffersState extends State<Offers> {
  Future<dynamic> offerPageDataHolder;
  static Random random = Random();
  TextStyle myStyle = TextStyle(fontFamily: 'Gotham', fontSize: 13);
  TextStyle myStyleSmall =
      TextStyle(fontFamily: 'Gotham', fontSize: 12, color: Colors.grey[600]);
  final _minpadding = 5.0;

  @override
  void initState() {
    super.initState();
//    _loadCurrentUser();
    offerPageDataHolder = _getOfferData();
  }

  Future<void> _loadCurrentUser() async {
    await Constants.loadCurrentUser()
        .then((dynamic _val) {})
        .catchError((_err) {});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
      future: offerPageDataHolder,
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
              return _bodyListViewBuilder(
                  json.decode(snapshot.data.toString()));
            }
        }
      },
    );
  }

  Future<dynamic> _getOfferData() async {
    return await DefaultAssetBundle.of(context)
        .loadString('load_json/landing.json');
  }

  Widget _bodyListViewBuilder(final List<dynamic> snapshot) {
    final List<dynamic> dataList = snapshot;
    final List<dynamic> categoryListData = dataList[1]['categoryJson'];
    final List<dynamic> milkJuiceListData = dataList[2]['milkAndJuiceJson'];
    final List<dynamic> popularData = dataList[3]['popularJson'];
    final List<dynamic> fruitsVegetableListData =
        dataList[4]['fruitsAndVegetableJson'];
    final List<dynamic> bannerListData = dataList[5]['offerBannerJson'];
    return Container(
      child: SingleChildScrollView(
        controller: widget._scrollBottomBarController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _imgCarousel(bannerListData),
            _divider(1),
            Constants.height(10.0),
            _label(8.0, 'Shop by Category'),
            _categorySection(categoryListData),
            Constants.height(2.0),
            _label(0.0, 'Milk & Juice'),
            _milkCategory(milkJuiceListData),
            Constants.height(8.0),
            _deliveryTime(),
            _subscription(popularData),
            Constants.height(3.0),
            _label(0.0, 'Fruits & Vegetable'),
            _fruitsAndVegetableSection(fruitsVegetableListData),
            _thatAllFolks(),
          ],
        ),
      ),
    );
  }

  Widget _imgCarousel(final List<dynamic> carouselData) {
    return Container(
      height: 170.0,
      child: Carousel(
        dotIncreasedColor: Constants.primary_green,
        animationCurve: Curves.bounceInOut,
        dotBgColor: Colors.transparent,
        boxFit: BoxFit.cover,
        autoplay: true,
        dotSize: 5.0,
        images: carouselData.map((item) {
          return InkWell(
            onTap: () {},
            child: Image(
              image: NetworkImage(item['image']),
              fit: BoxFit.cover,
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _divider(final double height) {
    return Divider(
      height: height,
      color: Colors.grey,
    );
  }

  Widget _label(final double _horizontal, final String _title) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: _horizontal),
      padding: EdgeInsets.all(10.0),
      color: Colors.lightBlueAccent.withAlpha(60),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Icon(
            Icons.category,
            color: Colors.blue,
            size: 20,
          ),
          Text(
            _title,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),
          ),
          Icon(
            Icons.category,
            color: Colors.blue,
            size: 20,
          ),
        ],
      ),
    );
  }

  Widget _categorySection(final List<dynamic> categoryData) {
    final List<dynamic> categoryList = categoryData.map((item) {
      return DummyCategoryData.fromJson(item);
    }).toList();
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: categoryList == null ? 0 : categoryList.length,
      primary: false,
      padding: EdgeInsets.only(right: 8, left: 8, bottom: 8),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 200 / 200,
      ),
      itemBuilder: (BuildContext context, int item) {
        DummyCategoryData categoryData = categoryList[item];
        return InkWell(
          onTap: () async => Constants.goToSubCategoryPage(categoryData.id, categoryData.categoryName, context),
//          onTap: () {
//            Navigator.push(context, MaterialPageRoute(builder: (context) {
//              return SubCategoryPage(categoryData.id, categoryData.categoryName);
//            }));
//          },
          child: Container(
            padding: EdgeInsets.only(right: 0.5, left: 0.5, bottom: 1),
            child: categoryData.getImage(),
          ),
        );
      },
    );
  }

  Widget _milkCategory(final List<dynamic> milkJuiceData) {
    final List<dynamic> itemList = milkJuiceData.map((item) {
      return DummyMilkAndJuiceData.fromJson(item);
    }).toList();
    return SizedBox(
      height: 340,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: itemList == null ? 0 : itemList.length,
        itemBuilder: (BuildContext context, int item) {
          DummyMilkAndJuiceData itemData = itemList[item];
          return InkWell(
            onTap: () async => Constants.goToSubCategoryPage(itemData.id, itemData.name, context),
//            onTap: () {
//              Navigator.push(context, MaterialPageRoute(builder: (context) {
//                return SubCategoryPage(itemData.id, itemData.name);
//              }));
//            },
            child: Card(
              elevation: 2.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  itemData.getImage(),
                  Text(
                    "AMUL",
                    style: myStyleSmall,
                  ),
                  Text(
                    "Amul Taaza",
                    style: myStyle,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: _minpadding * 3),
                    child: Text("1000 ml", style: myStyleSmall),
                  ),
                  Padding(
                    padding: EdgeInsets.all(1.0),
                    child: RaisedButton(
                      onPressed: () {},
                      color: Colors.pink,
                      child: Text(
                        "SUBSCRIBE @67",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Gotham',
                            fontSize: 10.0),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 3),
                    child: Text(
                      'MRP \u20B967',
                      style: TextStyle(fontFamily: 'Gotham', fontSize: 10.0),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 3),
                    child: Container(
                      height: 20,
                      width: 200,
                      color: Colors.green[400],
                      child: const Center(
                          child: Text(
                        'BUY ONCE',
                        style: TextStyle(
                            fontFamily: 'Gotham',
                            fontSize: 10,
                            color: Colors.white),
                      )),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _deliveryTime() {
    return Container(
      padding: EdgeInsets.all(_minpadding * 4),
      color: Colors.white,
      child: Center(
        child: Text(
          'DAILY DELIVERY between 5:00AM-7:00AM',
          style: TextStyle(fontFamily: 'Gotham', fontSize: 12.0),
        ),
      ),
    );
  }

  Widget _subscription(final List<dynamic> subscriptionData) {
    final List<dynamic> itemList = subscriptionData.map((item) {
      return DummySubscriptionData.fromJson(item);
    }).toList();
    DummySubscriptionData data = itemList[0];
    return Container(
      padding: EdgeInsets.all(_minpadding * 2),
      width: double.infinity,
      child: InkWell(
        onTap: () async => Constants.goToSubCategoryPage(data.id, 'Dummy', context),
//        onTap: () {
//          Navigator.push(context, MaterialPageRoute(builder: (context) {
//            return SubCategoryPage(data.id, 'Dummy');
//          }));
//        },
        child: data.getImage(),
      ),
    );
  }

  Widget _fruitsAndVegetableSection(final List<dynamic> fruitVegetableData) {
    final List<dynamic> itemList = fruitVegetableData.map((item) {
      return DummyFruitsAndVegetableData.fromJson(item);
    }).toList();
    return SizedBox(
      height: 336.3,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: itemList == null ? 0 : itemList.length,
        itemBuilder: (BuildContext context, int item) {
          DummyFruitsAndVegetableData itemData = itemList[item];

          Row _imageWidget = Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 174.0,
                width: 174.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  image: DecorationImage(
                    image: itemData.getImage(),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          );
          return InkWell(
            onTap: () async => Constants.goToSubCategoryPage(itemData.id, itemData.name, context),
//            onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) {return SubCategoryPage(itemData.id, itemData.name);}));},
            child: Card(
              elevation: 2.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  _imageWidget,
                  Text(
                    "FRESHO",
                    style: myStyleSmall,
                  ),
                  Text(
                    "Banana-Robusta",
                    style: myStyle,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: _minpadding * 3),
                    child: Text("500 gm", style: myStyleSmall),
                  ),
                  Padding(
                    padding: EdgeInsets.all(1.0),
                    child: RaisedButton(
                      onPressed: () {},
                      color: Colors.pink,
                      child: Text(
                        "SUBSCRIBE @110",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Gotham',
                            fontSize: 10.0),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 3),
                    child: Text(
                      'MRP \u20B922.5',
                      style: TextStyle(fontFamily: 'Gotham', fontSize: 10.0),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 3),
                    child: Container(
                      height: 20,
                      width: 200,
                      color: Colors.green[400],
                      child: const Center(
                          child: Text(
                            'BUY ONCE',
                            style: TextStyle(
                                fontFamily: 'Gotham',
                                fontSize: 10,
                                color: Colors.white),
                          )),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _thatAllFolks() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("That's All folks!"),
        ],
      ),
    );
  }
}

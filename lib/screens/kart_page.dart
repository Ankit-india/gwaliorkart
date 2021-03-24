import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gwaliorkart/models/dummy_data_model.dart';
import 'package:gwaliorkart/screens/data_search.dart';
import 'package:gwaliorkart/screens/search_screen.dart';
import 'package:gwaliorkart/utils/constants.dart';
import 'package:gwaliorkart/widgets/error_screen.dart';
import 'package:gwaliorkart/widgets/loader.dart';

class KartPage extends StatefulWidget {
  final ScrollController _scrollBottomBarController;

  KartPage(this._scrollBottomBarController);

  @override
  _KartPageState createState() => _KartPageState();
}

class _KartPageState extends State<KartPage> {
  Future<dynamic> basketDataHolder;

  @override
  void initState() {
    super.initState();
    basketDataHolder = _getBasketData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBarBuilder(),
      body: Column(
        children: <Widget>[
          FutureBuilder<dynamic>(
            future: basketDataHolder,
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
                    return _basketListViewBuilder(
                        json.decode(snapshot.data.toString()));
                  }
              }
            },
          ),
        ],
      ),
      bottomSheet: Container(
          height: 60,
          color: Colors.black45,
          width: MediaQuery.of(context).size.width,
          child: Center(
              child: Text(
            'semi transparent bottom sheet :)',
            style: TextStyle(color: Colors.green),
          ))),
    );
  }

  AppBar _appBarBuilder() {
    return AppBar(
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.search,
            size: 25,
          ),
          onPressed: () async => Navigator.push(context, MaterialPageRoute(builder: (context) {return SearchScreen();})),
        ),
        IconButton(
            icon: Icon(
              Icons.more_vert,
              size: 25,
            ),
            onPressed: () {}),
      ],
      title: Text(
        'Review Basket',
        style: TextStyle(fontFamily: 'Gotham'),
      ),
      centerTitle: true,
    );
  }

  Future<dynamic> _getBasketData() async {
    return await DefaultAssetBundle.of(context)
        .loadString('load_json/basket.json');
  }

  Widget _basketListViewBuilder(final List<dynamic> snapshot) {
    final List<dynamic> basketList = snapshot.map((item) {
      return BasketData.fromJson(item);
    }).toList();
    return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        controller: widget._scrollBottomBarController,
        itemCount: basketList == null ? 0 : basketList.length,
        itemBuilder: (BuildContext context, int index) {
          BasketData kartData = basketList[index];

          final List<dynamic> productList = kartData.product.map((items) {
            return BasketProductData.fromJson(items);
          }).toList();

          TextStyle _productCategoryStyle =
              TextStyle(fontWeight: FontWeight.w500, fontSize: 16.0);
          Text _productCategoryName = Text(
            kartData.categoryName,
            style: _productCategoryStyle,
          );
          TextStyle _itemLenStyle = TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14.0,
              color: Colors.black45);
          Text _totalItemText = Text(
              kartData.product.length.toString() + " Item",
              style: _itemLenStyle);
          return Container(
            child: Column(
              children: <Widget>[
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      _productCategoryName,
                      _totalItemText,
                    ],
                  ),
                ),
                ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: productList == null ? 0 : productList.length,
                    itemBuilder: (BuildContext context, int index) {
                      BasketProductData productData = productList[index];

                      Text _itemNameText = Text(
                        productData.name,
                        style: TextStyle(fontWeight: FontWeight.w500),
                      );
                      Text _itemQuantityText = Text(
                        productData.quantity,
                        style: TextStyle(color: Colors.grey),
                      );
                      Text _itemRealPriceText = Text(
                        "Rs " + productData.realPrice,
                        style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey,
                        ),
                      );
                      Text _itemDiscountPriceText = Text(
                        "Rs " + productData.discountPrice,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      );
                      Text _rsText = Text(
                        "Rs " + productData.discount.toString(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.w500),
                      );
                      Text _savedText = Text(
                        "SAVED",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.w500),
                      );

                      Column _savedPriceText = Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          _rsText,
                          Constants.height(2),
                          _savedText,
                        ],
                      );

                      Widget _savedPriceView() {
                        Widget _stack;
                        if (double.parse(productData.discount).toInt() > 0) {
                          _stack = Positioned(
                            left: 0,
                            child: Container(
                              width: 50.0,
                              height: 50.0,
                              decoration: new BoxDecoration(
                                color: Colors.redAccent,
                                shape: BoxShape.circle,
                              ),
                              child: _savedPriceText,
                            ),
                          );
                        } else {
                          _stack = Text("");
                        }
                        return _stack;
                      }

                      Row _addOrSubtractButton = Row(
                        children: <Widget>[
                          InkWell(
                            onTap: () {},
                            child: Container(
                              padding: EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(width: 1, color: Colors.red),
                              ),
                              child: Icon(
                                Icons.remove,
                                color: Colors.red,
                              ),
                            ),
                          ),
                          Constants.width(10.0),
                          Text(
                            productData.numOfItem,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.red,
                            ),
                          ),
                          Constants.width(10.0),
                          InkWell(
                            onTap: () {},
                            child: Container(
                              padding: EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(width: 1, color: Colors.red),
                              ),
                              child: Icon(
                                Icons.add,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ],
                      );

                      _divider() {
                        if (index != productList.length - 1) {
                          return Divider();
                        } else {
                          return Text("");
                        }
                      }

                      return Container(
                        color: Constants.myWhite,
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 5.0),
                              child: InkWell(
                                onTap: () {},
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Stack(
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.only(top: 10.0),
                                          height: 120.0,
                                          width: 100.0,
                                          child: productData.getImage(),
                                        ),
                                        _savedPriceView(),
                                      ],
                                    ),
                                    Constants.width(10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          _itemNameText,
                                          Constants.height(5),
                                          _itemQuantityText,
                                          Constants.height(15),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  _itemRealPriceText,
                                                  Constants.height(2),
                                                  _itemDiscountPriceText,
                                                ],
                                              ),
                                              _addOrSubtractButton,
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            _divider(),
                          ],
                        ),
                      );
                    }),
              ],
            ),
          );
        });
  }
}

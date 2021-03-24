//import 'dart:convert';
//
//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter_slidable/flutter_slidable.dart';
//import 'package:gwaliorkart/models/dummy_data_model.dart';
//import 'package:gwaliorkart/utils/constants.dart';
//import 'package:gwaliorkart/widgets/error_screen.dart';
//import 'package:gwaliorkart/widgets/loader.dart';
//
//class Basket extends StatefulWidget {
//  final ScrollController _scrollBottomBarController;
//
//  Basket(this._scrollBottomBarController);
//
//  @override
//  _BasketState createState() => _BasketState();
//}
//
//class _BasketState extends State<Basket> {
//  Future<dynamic> basketDataHolder;
//  FirebaseAuth _auth = FirebaseAuth.instance;
//  FirebaseUser _currentUser;
//  final bool isLoading = false;
//
//  @override
//  void initState() {
//    super.initState();
////    _loadCurrentUser();
//    basketDataHolder = _getBasketData();
//  }
//
//  Future<void> _loadCurrentUser() async {
//    await Constants.loadCurrentUser()
//        .then((dynamic _val) {})
//        .catchError((_err) {});
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//        body: FutureBuilder<dynamic>(
//          future: basketDataHolder,
//          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
//            switch (snapshot.connectionState) {
//              case ConnectionState.none:
//              case ConnectionState.active:
//              case ConnectionState.waiting:
//                return Loader();
//              case ConnectionState.done:
//              default:
//                if (snapshot.hasError) {
//                  return ErrorScreen(snapshot.error, 1);
//                } else {
//                  return _basketListViewBuilder(
//                      json.decode(snapshot.data.toString()));
//                }
//            }
//          },
//        ),
//        bottomNavigationBar: BottomAppBar(
//            child: Container(
//                height: 100,
//                child: Column(children: [
//                  Padding(
//                    padding: const EdgeInsets.only(top: 10.0),
//                    child: itemTotalContainer(),
//                  ),
//                  proceedToCheckoutButton(),
//                ]))));
//  }
//
//  Widget itemTotalContainer() {
//    return Row(
//      mainAxisAlignment: MainAxisAlignment.center,
//      children: <Widget>[
//        Text(
//          "Cart Sub Total (9 items): ",
//          style: TextStyle(
//              fontSize: 15,
//              color: Colors.grey.shade700,
//              fontWeight: FontWeight.bold),
//        ),
//        Text(
//          "Rs.2,029.00",
//          style: TextStyle(
//              fontSize: 16.5, color: Colors.red, fontWeight: FontWeight.bold),
//        ),
//      ],
//    );
//  }
//
//  Widget proceedToCheckoutButton() {
//    return Padding(
//      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
//      child: Container(
//        width: MediaQuery.of(context).size.width,
//        height: 58.0,
//        padding: EdgeInsets.all(10),
//        child: isLoading
//            ? Center(
//                child: CircularProgressIndicator(
//                  backgroundColor: Colors.green,
//                ),
//              )
//            : FlatButton(
//                shape: RoundedRectangleBorder(
//                    borderRadius: BorderRadius.circular(2)),
//                color: Colors.deepOrange,
//                child: Text(
//                  'PROCEED TO CHECKOUT',
//                  style: TextStyle(
//                      fontSize: 15,
//                      color: Colors.white,
//                      fontWeight: FontWeight.w300),
//                ),
//                onPressed: () async {},
//              ),
//      ),
//    );
//  }
//
//  Future<dynamic> _getBasketData() async {
//    return await DefaultAssetBundle.of(context)
//        .loadString('load_json/basket.json');
//  }
//
//  Widget _basketListViewBuilder(final List<dynamic> snapshot) {
//    final List<dynamic> basketList = snapshot.map((item) {
//      return BasketData.fromJson(item);
//    }).toList();
//    return ListView.builder(
//        shrinkWrap: true,
//        scrollDirection: Axis.vertical,
//        controller: widget._scrollBottomBarController,
//        itemCount: basketList == null ? 0 : basketList.length,
//        itemBuilder: (BuildContext context, int index) {
//          BasketData kartData = basketList[index];
//
//          final List<dynamic> productList = kartData.product.map((items) {
//            return BasketProductData.fromJson(items);
//          }).toList();
//
//          TextStyle _productCategoryStyle =
//              TextStyle(fontWeight: FontWeight.w500, fontSize: 16.0);
//          Text _productCategoryName = Text(
//            kartData.categoryName,
//            style: _productCategoryStyle,
//          );
//          TextStyle _itemLenStyle = TextStyle(
//              fontWeight: FontWeight.w500,
//              fontSize: 14.0,
//              color: Colors.black45);
//          Text _totalItemText = Text(
//              kartData.product.length.toString() + " Item",
//              style: _itemLenStyle);
//          return Column(
//            children: <Widget>[
//              Container(
//                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
//                child: Row(
//                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                  children: <Widget>[
//                    _productCategoryName,
//                    _totalItemText,
//                  ],
//                ),
//              ),
//              ListView.builder(
//                  shrinkWrap: true,
//                  physics: NeverScrollableScrollPhysics(),
//                  itemCount: productList == null ? 0 : productList.length,
//                  itemBuilder: (BuildContext context, int index) {
//                    BasketProductData productData = productList[index];
//
//                    Text _itemNameText = Text(
//                      productData.name,
//                      style: TextStyle(fontWeight: FontWeight.w500),
//                    );
//                    Text _itemQuantityText = Text(
//                      productData.quantity,
//                      style: TextStyle(color: Colors.grey),
//                    );
//                    Text _itemRealPriceText = Text(
//                      "Rs " + productData.realPrice,
//                      style: TextStyle(
//                        decoration: TextDecoration.lineThrough,
//                        color: Colors.grey,
//                      ),
//                    );
//                    Text _itemDiscountPriceText = Text(
//                      "Rs " + productData.discountPrice,
//                      style: TextStyle(
//                        fontWeight: FontWeight.bold,
//                        fontSize: 15,
//                      ),
//                    );
//                    Text _rsText = Text(
//                      "Rs " + productData.discount.toString(),
//                      style: TextStyle(
//                          color: Colors.white,
//                          fontSize: 9,
//                          fontWeight: FontWeight.w500),
//                    );
//                    Text _savedText = Text(
//                      "SAVED",
//                      style: TextStyle(
//                          color: Colors.white,
//                          fontSize: 9,
//                          fontWeight: FontWeight.w500),
//                    );
//                    TextStyle _textStyle = TextStyle(
//                        color: Constants.myWhite, fontWeight: FontWeight.w500);
//
//                    Column _savedPriceText = Column(
//                      mainAxisAlignment: MainAxisAlignment.center,
//                      crossAxisAlignment: CrossAxisAlignment.center,
//                      children: <Widget>[
//                        _rsText,
//                        Constants.height(2),
//                        _savedText,
//                      ],
//                    );
//
//                    Widget _savedPriceView() {
//                      Widget _stack;
//                      if (double.parse(productData.discount).toInt() > 0) {
//                        _stack = Positioned(
//                          left: 0,
//                          child: Container(
//                            width: 50.0,
//                            height: 50.0,
//                            decoration: new BoxDecoration(
//                              color: Colors.redAccent,
//                              shape: BoxShape.circle,
//                            ),
//                            child: _savedPriceText,
//                          ),
//                        );
//                      } else {
//                        _stack = Text("");
//                      }
//                      return _stack;
//                    }
//
//                    Row _addOrSubtractButton = Row(
//                      children: <Widget>[
//                        InkWell(
//                          onTap: () {},
//                          child: Container(
//                            padding: EdgeInsets.all(2),
//                            decoration: BoxDecoration(
//                              borderRadius: BorderRadius.circular(4),
//                              border: Border.all(width: 1, color: Colors.red),
//                            ),
//                            child: Icon(
//                              Icons.remove,
//                              color: Colors.red,
//                            ),
//                          ),
//                        ),
//                        Constants.width(10.0),
//                        Text(
//                          productData.numOfItem,
//                          style: TextStyle(
//                            fontWeight: FontWeight.bold,
//                            fontSize: 16,
//                            color: Colors.red,
//                          ),
//                        ),
//                        Constants.width(10.0),
//                        InkWell(
//                          onTap: () {},
//                          child: Container(
//                            padding: EdgeInsets.all(2),
//                            decoration: BoxDecoration(
//                              borderRadius: BorderRadius.circular(4),
//                              border: Border.all(width: 1, color: Colors.red),
//                            ),
//                            child: Icon(
//                              Icons.add,
//                              color: Colors.red,
//                            ),
//                          ),
//                        ),
//                      ],
//                    );
//
//                    _divider() {
//                      if (index != productList.length - 1) {
//                        return Divider();
//                      } else {
//                        return Text("");
//                      }
//                    }
//
//                    return Container(
//                      color: Constants.myWhite,
//                      child: Column(
//                        crossAxisAlignment: CrossAxisAlignment.start,
//                        children: <Widget>[
//                          Container(
//                            padding: EdgeInsets.symmetric(
//                                horizontal: 10.0, vertical: 5.0),
//                            child: InkWell(
//                              onTap: () {},
//                              child: Slidable(
//                                child: Row(
//                                  mainAxisAlignment: MainAxisAlignment.start,
//                                  children: <Widget>[
//                                    Stack(
//                                      children: <Widget>[
//                                        Container(
//                                          padding: EdgeInsets.only(top: 10.0),
//                                          height: 120.0,
//                                          width: 100.0,
//                                          child: productData.getImage(),
//                                        ),
//                                        _savedPriceView(),
//                                      ],
//                                    ),
//                                    Constants.width(10),
//                                    Expanded(
//                                      child: Column(
//                                        crossAxisAlignment:
//                                            CrossAxisAlignment.start,
//                                        children: <Widget>[
//                                          _itemNameText,
//                                          Constants.height(5),
//                                          _itemQuantityText,
//                                          Constants.height(15),
//                                          Row(
//                                            mainAxisAlignment:
//                                                MainAxisAlignment.spaceBetween,
//                                            children: <Widget>[
//                                              Column(
//                                                crossAxisAlignment:
//                                                    CrossAxisAlignment.start,
//                                                children: <Widget>[
//                                                  _itemRealPriceText,
//                                                  Constants.height(2),
//                                                  _itemDiscountPriceText,
//                                                ],
//                                              ),
//                                              _addOrSubtractButton,
//                                            ],
//                                          ),
//                                        ],
//                                      ),
//                                    )
//                                  ],
//                                ),
//                                actionPane: SlidableScrollActionPane(),
//                                actionExtentRatio: 0.25,
//                                secondaryActions: <Widget>[
//                                  IconSlideAction(
//                                    iconWidget: Column(
//                                      children: <Widget>[
//                                        Icon(
//                                          Icons.delete,
//                                          color: Constants.myWhite,
//                                        ),
//                                        Constants.height(8.0),
//                                        Column(
//                                          children: <Widget>[
//                                            Text(
//                                              "Remove",
//                                              style: _textStyle,
//                                            ),
//                                            Text("Item", style: _textStyle),
//                                          ],
//                                        ),
//                                      ],
//                                      mainAxisAlignment:
//                                          MainAxisAlignment.center,
//                                    ),
//                                    color: Colors.black54,
//                                    onTap: () =>
//                                        Constants.showShortToastBuilder(
//                                            'Delete'),
//                                  ),
//                                  IconSlideAction(
//                                    iconWidget: Column(
//                                      children: <Widget>[
//                                        Icon(
//                                          Icons.save,
//                                          color: Constants.myWhite,
//                                        ),
//                                        Constants.height(8.0),
//                                        Column(
//                                          children: <Widget>[
//                                            Text(
//                                              "Save For",
//                                              style: _textStyle,
//                                            ),
//                                            Text("Later", style: _textStyle),
//                                          ],
//                                        ),
//                                      ],
//                                      mainAxisAlignment:
//                                          MainAxisAlignment.center,
//                                    ),
//                                    color: Colors.blue,
//                                    onTap: () =>
//                                        Constants.showShortToastBuilder(
//                                            'Save For Later'),
//                                  ),
//                                ],
//                              ),
//                            ),
//                          ),
//                          _divider(),
//                        ],
//                      ),
//                    );
//                  }),
//            ],
//          );
//        });
//  }
//}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gwaliorkart/utils/auth_utils.dart';
import 'package:gwaliorkart/utils/constants.dart';
import 'package:gwaliorkart/widgets/error_screen.dart';
import 'package:gwaliorkart/widgets/loader.dart';
import 'package:gwaliorkart/widgets/widget_page.dart';

class Basket extends StatefulWidget {
  final ScrollController _scrollBottomBarController;

  Basket(this._scrollBottomBarController);

  @override
  _BasketState createState() => _BasketState();
}

class _BasketState extends State<Basket> {
  Future<dynamic> _cartDataHolder;
  final bool isLoading = false;
  String _customerId, _vouchers, _coupon, _reward;

  @override
  void initState() {
    super.initState();
    _customerId = AuthUtils.userId;
    _coupon = AuthUtils.coupon;
    _vouchers = AuthUtils.voucher;
    _reward = AuthUtils.reward;
    _cartDataHolder =
        Constants.getCartListData(_customerId, _vouchers, _coupon, _reward);
  }

  FutureBuilder _futureBuilder() {
    return FutureBuilder<dynamic>(
      future: _cartDataHolder,
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
              return WidgetPage.renderCartList(snapshot.data, context);
            }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _futureBuilder(),
    );
  }
}

//import 'dart:async';
//
//import 'package:flutter/material.dart';
//import 'package:gwaliorkart/screens/cart.dart';
//import 'package:gwaliorkart/utils/constants.dart';
//
//class Basket extends StatefulWidget {
//  final ScrollController _scrollBottomBarController;
//
//  Basket(this._scrollBottomBarController);
//
//  @override
//  _BasketState createState() => _BasketState();
//}
//
//class _BasketState extends State<Basket> {
//
//  @override
//  void initState() {
//    super.initState();
////    _loadCurrentUser();
//    Timer(Duration(seconds: 0), () {
//      navigateFromBasket();
//    });
//  }
//
//  Future<void> _loadCurrentUser() async {
//    await Constants.loadCurrentUser()
//        .then((dynamic _val) {})
//        .catchError((_err) {});
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      color: Constants.myWhite,
//    );
//  }
//
//  Future navigateFromBasket() async {
//    Navigator.pushReplacement(context,
//        MaterialPageRoute(builder: (BuildContext context) => BasketPage()));
//  }
//}

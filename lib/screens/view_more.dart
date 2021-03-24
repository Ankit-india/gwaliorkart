//import 'package:flutter/material.dart';
//import 'package:gwaliorkart/models/landing_model.dart';
//import 'package:gwaliorkart/screens/product_details.dart';
//import 'package:gwaliorkart/screens/search_screen.dart';
//import 'package:gwaliorkart/utils/auth_utils.dart';
//import 'package:gwaliorkart/utils/constants.dart';
//import 'package:gwaliorkart/widgets/error_screen.dart';
//import 'package:gwaliorkart/widgets/loader.dart';
//import 'package:gwaliorkart/models/category_model.dart';
//import 'package:gwaliorkart/screens/data_search.dart';
//import 'package:intl/intl.dart';
//
//class ViewMore extends StatefulWidget {
//  final String categoryKey;
//
//  ViewMore(this.categoryKey);
//
//  @override
//  _ViewMoreState createState() => _ViewMoreState();
//}
//
//class _ViewMoreState extends State<ViewMore> {
//  Future<dynamic> _listDataHolder;
//  bool _isAdded = false;
//  int numOfAddedItem = 1;
//  String _title;
//  String _customerId;
//
//  @override
//  void initState() {
//    super.initState();
//    _customerId = AuthUtils.userId;
//    _listDataHolder = _getListData();
//    _isAdded = false;
//    _title = toBeginningOfSentenceCase(
//        widget.categoryKey.split('_').toSet().join(' '));
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      backgroundColor: Constants.grey300,
//      appBar: _appBar(),
//      body: _futureBuilder(),
//    );
//  }
//
//  AppBar _appBar() {
//    return AppBar(
//      elevation: 0.0,
//      centerTitle: true,
//      actions: <Widget>[
//        IconButton(
//          icon: Icon(
//            Icons.search,
//            size: 25.0,
//          ),
//          onPressed: () async => Navigator.push(context, MaterialPageRoute(builder: (context) {return SearchScreen();})),
////          onPressed: () async => Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => SearchScreen())),
//        ),
//      ],
//      title: Text(
//        _title,
//        style: TextStyle(color: Constants.myWhite),
//      ),
//    );
//  }
//
//  Future<dynamic> _getListData() async {
//    return await LandingPageUtils.getLandingPageList();
//  }
//
//  FutureBuilder _futureBuilder() {
//    return FutureBuilder<dynamic>(
//      future: _listDataHolder,
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
//              return _bodyListViewBuilder(snapshot.data);
//            }
//        }
//      },
//    );
//  }
//
//  Widget _bodyListViewBuilder(Map<String, dynamic> snapshot) {
//    return Container(
//      child: SingleChildScrollView(
//        child: Column(
//          crossAxisAlignment: CrossAxisAlignment.start,
//          children: <Widget>[
//            _itemListViewBuilder(snapshot[widget.categoryKey]),
//            _thatAllFolks(snapshot[widget.categoryKey].length),
//          ],
//        ),
//      ),
//    );
//  }
//
//  Widget _itemListViewBuilder(final List<dynamic> snapshot) {
//    Widget _listWidget;
//    if (snapshot.length > 0) {
//      final List<dynamic> productList = snapshot.map((items) {
//        return SubCategoryProductListData.fromJson(items);
//      }).toList();
//
//      _listWidget = ListView.builder(
//          shrinkWrap: true,
//          physics: NeverScrollableScrollPhysics(),
//          primary: false,
//          itemCount: productList == null ? 0 : productList.length,
//          itemBuilder: (BuildContext context, int index) {
//            SubCategoryProductListData productData = productList[index];
//
//            Widget _itemNameText() {
//              Widget _itemName;
//              if (index == 0) {
//                _itemName = Column(
//                  children: <Widget>[
//                    Constants.height(5.0),
//                    Text(
//                      productData.name,
//                      style: TextStyle(fontWeight: FontWeight.w500),
//                    ),
//                  ],
//                );
//              } else {
//                _itemName = Text(
//                  productData.name,
//                  style: TextStyle(fontWeight: FontWeight.w500),
//                );
//              }
//              return _itemName;
//            }
//
//            Widget _ratingWidget() {
//              Widget _rating;
//              if (productData.rating != null && productData.rating >= 0) {
//                _rating = Column(
//                  children: <Widget>[
//                    Text(
//                      "Rating: " + productData.rating.toString(),
//                      style: TextStyle(color: Constants.myGreen),
//                    ),
//                    Constants.height(5),
//                  ],
//                );
//              } else {
//                _rating = Container();
//              }
//              return _rating;
//            }
//
//            Widget _itemRealPriceText() {
//              Widget _price;
//              if (productData.specialPrice() != '' &&
//                  productData.specialPrice() != null) {
//                _price = RichText(
//                  textAlign: TextAlign.center,
//                  text: TextSpan(
//                      text: 'MRP: ',
//                      style: TextStyle(
//                        color: Colors.grey,
//                      ),
//                      children: [
//                        TextSpan(
//                          text: productData.price,
//                          style: TextStyle(
//                            color: Colors.grey,
//                            decoration: TextDecoration.lineThrough,
//                          ),
//                        ),
//                      ]),
//                );
//              } else {
//                _price = Text(
//                  productData.price,
//                  style: TextStyle(
//                    fontWeight: FontWeight.bold,
//                    fontSize: 15,
//                  ),
//                );
//              }
//              return _price;
//            }
//
//            Widget _itemDiscountPriceText() {
//              Widget _price;
//              if (productData.specialPrice() != '') {
//                _price = Text(
//                  productData.specialPrice(),
//                  textAlign: TextAlign.left,
//                  style: TextStyle(
//                    fontWeight: FontWeight.bold,
//                    fontSize: 15.0,
//                  ),
//                );
//              } else {
//                _price = Text("");
//              }
//              return _price;
//            }
//
//            Text _rsText = Text(
//              "Rs " + productData.saved().toString(),
//              style: TextStyle(
//                  color: Colors.white,
//                  fontSize: 9,
//                  fontWeight: FontWeight.w500),
//            );
//
//            Text _savedText = Text(
//              "SAVED",
//              style: TextStyle(
//                  color: Colors.white,
//                  fontSize: 9,
//                  fontWeight: FontWeight.w500),
//            );
//
//            Column _savedPriceText = Column(
//              mainAxisAlignment: MainAxisAlignment.center,
//              crossAxisAlignment: CrossAxisAlignment.center,
//              children: <Widget>[
//                _rsText,
//                Constants.height(2),
//                _savedText,
//              ],
//            );
//
//            EdgeInsets _stackPadding() {
//              EdgeInsets _padding;
//              if (productData.saved() > 0 && productData.saved() != null) {
//                _padding = EdgeInsets.only(top: 10.0);
//              } else {
//                _padding = EdgeInsets.only(top: 0);
//              }
//              return _padding;
//            }
//
//            Widget _savedPriceView() {
//              Widget _stack;
//              if (productData.saved() > 0 && productData.saved() != null) {
//                _stack = Positioned(
//                  left: 0,
//                  top: 0,
//                  child: Container(
//                    width: 50.0,
//                    height: 50.0,
//                    decoration: new BoxDecoration(
//                      color: Colors.redAccent,
//                      shape: BoxShape.circle,
//                    ),
//                    child: _savedPriceText,
//                  ),
//                );
//              } else {
//                _stack = Container();
//              }
//              return _stack;
//            }
//
//            Widget _addButton(final bool isAdded) {
//              Widget buttonSection;
//              if (isAdded == false) {
//                buttonSection = InkWell(
//                  onTap: () {
//                    setState(() {
//                      _isAdded = true;
//                    });
//                    Constants.showShortToastBuilder("Item added into the kart");
//                  },
//                  child: Container(
//                    decoration: BoxDecoration(
//                      color: Colors.red,
//                      borderRadius: BorderRadius.circular(3),
//                    ),
//                    child: Text(
//                      "ADD",
//                      style: TextStyle(
//                          color: Constants.myWhite,
//                          fontWeight: FontWeight.w500),
//                    ),
//                    padding:
//                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 7.0),
//                  ),
//                );
//              } else {
//                buttonSection = Row(
//                  children: <Widget>[
//                    InkWell(
//                      onTap: () {
//                        setState(() {
//                          _isAdded = false;
//                        });
//                        Constants.showShortToastBuilder('Item removed');
//                      },
//                      child: Container(
//                        padding: EdgeInsets.all(2),
//                        decoration: BoxDecoration(
//                          borderRadius: BorderRadius.circular(4),
//                          border: Border.all(width: 1, color: Colors.red),
//                        ),
//                        child: Icon(
//                          Icons.remove,
//                          color: Colors.red,
//                        ),
//                      ),
//                    ),
//                    Constants.width(10.0),
//                    Text(
//                      numOfAddedItem.toString(),
//                      style: TextStyle(
//                        fontWeight: FontWeight.bold,
//                        fontSize: 16,
//                        color: Colors.red,
//                      ),
//                    ),
//                    Constants.width(10.0),
//                    InkWell(
//                      onTap: () {
//                        Constants.showShortToastBuilder('Item added');
//                      },
//                      child: Container(
//                        padding: EdgeInsets.all(2),
//                        decoration: BoxDecoration(
//                          borderRadius: BorderRadius.circular(4),
//                          border: Border.all(width: 1, color: Colors.red),
//                        ),
//                        child: Icon(
//                          Icons.add,
//                          color: Colors.red,
//                        ),
//                      ),
//                    ),
//                  ],
//                );
//              }
//              return buttonSection;
//            }
//
//            _divider() {
//              if (index != productList.length - 1) {
//                return Divider();
//              } else {
//                return Container();
//              }
//            }
//
//            return Container(
//              color: Constants.myWhite,
//              child: Column(
//                crossAxisAlignment: CrossAxisAlignment.start,
//                mainAxisAlignment: MainAxisAlignment.start,
//                children: <Widget>[
//                  Container(
//                    padding:
//                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
//                    child: InkWell(
//                      onTap: ()  async => Constants.goToProductDetailsPage(productData.productId, _customerId != null ? _customerId : "-", context),
//                      child: Row(
//                        mainAxisAlignment: MainAxisAlignment.start,
//                        crossAxisAlignment: CrossAxisAlignment.start,
//                        children: <Widget>[
//                          Stack(
//                            children: <Widget>[
//                              Container(
//                                padding: _stackPadding(),
//                                height: 120.0,
//                                width: 100.0,
//                                child: productData.getImage(),
//                              ),
//                              _savedPriceView(),
//                            ],
//                          ),
//                          Constants.width(10),
//                          Expanded(
//                            child: Column(
//                              crossAxisAlignment: CrossAxisAlignment.start,
//                              mainAxisAlignment: MainAxisAlignment.start,
//                              children: <Widget>[
//                                _itemNameText(),
//                                Constants.height(15),
//                                _ratingWidget(),
//                                Row(
//                                  mainAxisAlignment:
//                                      MainAxisAlignment.spaceBetween,
//                                  children: <Widget>[
//                                    Column(
//                                      crossAxisAlignment:
//                                          CrossAxisAlignment.start,
//                                      children: <Widget>[
//                                        _itemRealPriceText(),
//                                        Constants.height(2),
//                                        _itemDiscountPriceText(),
//                                      ],
//                                    ),
//                                    _addButton(_isAdded),
//                                  ],
//                                ),
//                              ],
//                            ),
//                          )
//                        ],
//                      ),
//                    ),
//                  ),
//                  _divider(),
//                ],
//              ),
//            );
//          });
//    } else {
//      _listWidget = Container(
//        color: Constants.myWhite,
//        child: Center(
//          child: Column(
//            mainAxisAlignment: MainAxisAlignment.center,
//            children: <Widget>[
//              Text(
//                "No item found.",
//                style: TextStyle(
//                    fontSize: 18.0,
//                    color: Constants.grey500,
//                    fontWeight: FontWeight.w500),
//              ),
//            ],
//          ),
//        ),
//      );
//    }
//    return _listWidget;
//  }
//
//  Widget _thatAllFolks(final int len) {
//    Widget _widget;
//    if (len >= 4) {
//      _widget = Container(
//        padding: EdgeInsets.symmetric(vertical: 25.0),
//        child: Row(
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: <Widget>[
//            Text("That's All folks!"),
//          ],
//        ),
//      );
//    } else {
//      _widget = Container();
//    }
//    return _widget;
//  }
//}

import 'package:flutter/material.dart';
import 'package:gwaliorkart/models/cart_data.dart';
import 'package:gwaliorkart/models/landing_model.dart';
import 'package:gwaliorkart/screens/product_details.dart';
import 'package:gwaliorkart/screens/search_screen.dart';
import 'package:gwaliorkart/utils/auth_utils.dart';
import 'package:gwaliorkart/utils/constants.dart';
import 'package:gwaliorkart/widgets/error_screen.dart';
import 'package:gwaliorkart/widgets/loader.dart';
import 'package:gwaliorkart/models/category_model.dart';
import 'package:gwaliorkart/screens/data_search.dart';
import 'package:gwaliorkart/widgets/widget_page.dart';
import 'package:intl/intl.dart';
import 'dart:math';

class ViewMore extends StatefulWidget {
  final List<dynamic> snapshotData;
  final String categoryKey;

  ViewMore(this.snapshotData, this.categoryKey);

  @override
  _ViewMoreState createState() => _ViewMoreState();
}

class _ViewMoreState extends State<ViewMore> {
  CrossAxisAlignment _cStart = CrossAxisAlignment.start;
  CrossAxisAlignment _cCenter = CrossAxisAlignment.center;
  MainAxisAlignment _mStart = MainAxisAlignment.start;
  MainAxisAlignment _mCenter = MainAxisAlignment.center;
  bool _isAdded = false;
  int _quantity, _itemInCart, _productCartId;
  List<dynamic> optionList = [], _snapshot;
  List<int> _cartIdDic = [];
  String _customerId, _vouchers, _coupon, _reward, _cartId, _title;
  SubCategoryData _subCatData;
  CategoriesData _catData;
  ProductsData _productsData;
  CartData _cartData;
  CartProductsData _cartProductsData;

  @override
  void initState() {
    _customerId = AuthUtils.userId;
    if (widget.snapshotData != null && widget.snapshotData.length > 0) {
      _snapshot = widget.snapshotData;
    }
    _title = toBeginningOfSentenceCase(
        widget.categoryKey.split('_').toSet().join(' '));
    super.initState();
  }

  Future<dynamic> _getCartListData() async {
    await CartUtils.getCartList(
            _customerId != null && _customerId != "" ? _customerId : "-",
            _vouchers != null && _vouchers != "" ? _vouchers : "-",
            _coupon != null && _coupon != "" ? _coupon : "-",
            _reward != null && _reward != "" ? _reward : "-")
        .then((dynamic _listRes) async {
      if (_listRes != null) {
        if (_listRes.containsKey('text_count')) {
          setState(() {
            _cartData = CartData.fromJson(_listRes);
            _itemInCart = _cartData.textCount;
          });
        }
      }
    }).catchError((_onError) {
      print("\ngetCartData catchError:=> $_onError\n");
    });
  }

  Future<dynamic> _getCartListDataOnAdd(
      final String _customerId,
      final String _vouchers,
      final String _coupon,
      final String _reward,
      final String _productId) async {
    await CartUtils.getCartList(
            _customerId != null && _customerId != "" ? _customerId : "-",
            _vouchers != null && _vouchers != "" ? _vouchers : "-",
            _coupon != null && _coupon != "" ? _coupon : "-",
            _reward != null && _reward != "" ? _reward : "-")
        .then((dynamic _response) async {
      if (_response != null) {
        setState(() {
          _cartData = CartData.fromJson(_response);
        });
        if (_cartData.textCount != null) {
          if (_cartData.products != null && _cartData.products.length > 0) {
            _cartData.products.forEach((dynamic _products) {
              if (_products['id'] == _productId) {
                setState(() {
                  _cartProductsData = CartProductsData.fromJson(_products);
                  _itemInCart = _response['text_count'];
                  _cartIdDic.add(int.parse(_cartProductsData.cartId));
                });
              }
            });
            setState(() {
              _productCartId = _cartIdDic.reduce(max);
            });
            _cartData.products.forEach((dynamic _products) {
              if (_products['cart_id'] == _productCartId.toString()) {
                setState(() {
                  _cartProductsData = CartProductsData.fromJson(_products);
                  _quantity = _cartProductsData.quantity;
                  _cartId = _cartProductsData.cartId;
                  _itemInCart = _response['text_count'];
                });
              }
            });
          }
        }
      }
    }).catchError((_onError) {
      print("\n_getCartListDataOnAdd catchError:=> $_onError\n");
    });
  }

  Future<dynamic> _getCartListDataOnUpdate() async {
    await CartUtils.getCartList(
            _customerId != null && _customerId != "" ? _customerId : "-",
            _vouchers != null && _vouchers != "" ? _vouchers : "-",
            _coupon != null && _coupon != "" ? _coupon : "-",
            _reward != null && _reward != "" ? _reward : "-")
        .then((dynamic _response) async {
      if (_response != null) {
        if (_response.containsKey('text_count')) {
          if (_response.containsKey('products') &&
              _response['products'] != null &&
              _response['products'].length > 0) {
            _response['products'].forEach((dynamic _products) {
              if (_products['cart_id'] == _productCartId.toString()) {
                setState(() {
                  _cartProductsData = CartProductsData.fromJson(_products);
                  _quantity = _cartProductsData.quantity;
                  _cartId = _cartProductsData.cartId;
                  _itemInCart = _response['text_count'];
                });
              }
            });
          }
        }
      }
    }).catchError((_onError) {
      print("\n_getCartListDataOnAdd catchError:=> $_onError\n");
    });
  }

  Future<dynamic> _removeFromCart(
      final String _cartId, final String _customerId) async {
    Constants.showMessageLoader(context, 'Please wait item is removing...');
    CartData _removeParams =
        CartData(null, _customerId, null, null, null, null, null, _cartId);
    await CartUtils.removeCart(_removeParams).then((dynamic _removeRes) async {
      if (_removeRes != null && _removeRes.containsKey("success")) {
        await _getCartListDataOnUpdate();
        await _getCartListData();
        setState(() {
          _isAdded = false;
        });
        Navigator.of(context).pop();
        Constants.showShortToastBuilder('Item removed successfully');
      }
    }).catchError((_onError) {
      Navigator.of(context).pop();
      print("\nremoveCart catchError:=> $_onError\n");
      Constants.showLongToastBuilder('Oops! Something went wrong');
    });
  }

  Future<dynamic> _updateToAdd(final CartProductsData _addBtn) async {
    Constants.showMessageLoader(context, 'Please wait item is updating...');
    CartData _addParams = CartData(null, null, _addBtn.quantity + 1, null, null,
        null, null, _addBtn.cartId);
    await CartUtils.editCart(_addParams).then((dynamic _addRes) async {
      if (_addRes != null && _addRes.containsKey("success")) {
        await _getCartListDataOnUpdate();
        Navigator.of(context).pop();
        Constants.showShortToastBuilder(_addRes["success"]);
      } else if (_addRes.containsKey("error")) {
        Navigator.of(context).pop();
        Constants.showShortToastBuilder(_addRes["error"]);
      }
    }).catchError((_addErr) {
      Navigator.of(context).pop();
      print('\neditCart catchError:= $_addErr\n');
      Constants.showShortToastBuilder('Oops something is wrong..');
    });
  }

  Future<dynamic> _updateToRemove(final CartProductsData _removeBtn) async {
    Constants.showMessageLoader(context, 'Please wait item is updating...');
    CartData _addParams = CartData(null, null, _removeBtn.quantity - 1, null,
        null, null, null, _removeBtn.cartId);
    await CartUtils.editCart(_addParams).then((dynamic _addRes) async {
      if (_addRes != null && _addRes.containsKey("success")) {
        await _getCartListDataOnUpdate();
        Navigator.of(context).pop();
        Constants.showShortToastBuilder(_addRes["success"]);
      } else if (_addRes.containsKey("error")) {
        Navigator.of(context).pop();
        Constants.showShortToastBuilder(_addRes["error"]);
      }
    }).catchError((_addErr) {
      Navigator.of(context).pop();
      print('\neditCart catchError:= $_addErr\n');
      Constants.showShortToastBuilder('Oops something is wrong..');
    });
  }

  Future<dynamic> _firstTimeAddToCart(
      List<dynamic> _options,
      final String _productId,
      final String _customerId,
      final int _quantity,
      final String _vouchers,
      final String _coupon,
      final String _reward,
      BuildContext context) async {
    if (_options != null && _options.length > 0) {
      Constants.goToProductDetailsPage(
          _productId, _customerId != null ? _customerId : "-", context);
    } else {
      Constants.showMessageLoader(context, 'Please wait item is adding...');
      CartData _cartParams = CartData(
          int.parse(_productId),
          _customerId,
          _quantity,
          _options,
          _vouchers != null ? _vouchers : "",
          _coupon != null ? _coupon : "",
          _reward != null ? _reward : "",
          null);

      await CartUtils.addToCart(_cartParams).then((dynamic _cartRes) async {
        if (_cartRes != null && _cartRes.containsKey("success")) {
          await _getCartListDataOnAdd(
              _customerId, _vouchers, _coupon, _reward, _productId);
          setState(() {
            _isAdded = true;
          });
          Navigator.of(context).pop();
          Constants.showShortToastBuilder(_cartRes["success"]);
        } else if (_cartRes.containsKey("error")) {
          Navigator.of(context).pop();
          Constants.showShortToastBuilder(_cartRes["error"]);
        }
      }).catchError((_err) {
        Navigator.of(context).pop();
        print('addToCart catchError:= $_err');
        Constants.showShortToastBuilder('Oops something is wrong..');
      });
      optionList.clear();
    }
  }

  Widget _bodyListViewBuilder(final List<dynamic> _listData) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: _cStart,
          mainAxisAlignment: _mStart,
          children: <Widget>[
            _itemListViewBuilder(_listData),
            WidgetPage.thatAllFolks(_listData.length, 4)
          ],
        ),
      ),
    );
  }

  Widget _itemListViewBuilder(final List<dynamic> _lists) {
    Widget _listWidget;
    if (_lists != null && _lists.length > 0) {
      final List<dynamic> _productList = _lists.map((items) {
        return ProductsData.fromJson(items);
      }).toList();

      _listWidget = ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          primary: false,
          itemCount: _productList == null ? 0 : _productList.length,
          itemBuilder: (BuildContext context, int index) {
            ProductsData _productsData = _productList[index];

            Widget _addToCartButtonWidget(
                final bool _isCartAdded,
                List<dynamic> _options,
                final String _productId,
                final String _customerId,
                final int _quantity,
                final String _vouchers,
                final String _coupon,
                final String _reward,
                BuildContext context) {
              Widget _cartWidget;
              if (_isCartAdded == false) {
                _cartWidget = InkWell(
                  onTap: () async => _firstTimeAddToCart(
                      _options,
                      _productId,
                      _customerId,
                      _quantity,
                      _vouchers,
                      _coupon,
                      _reward,
                      context),
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 13.0, vertical: 6.5),
                    decoration: BoxDecoration(
                      color: Constants.red300,
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Text(
                      "ADD",
                      style: TextStyle(
                          color: Constants.myWhite,
                          fontSize: 13.0,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                );
              } else if (_isCartAdded == true) {
                _cartWidget = Container(
                  padding: EdgeInsets.symmetric(vertical: 9.0),
                  color: Colors.transparent,
                  child: Row(
                    children: <Widget>[
                      InkWell(
                        onTap: () async => _cartProductsData != null &&
                                _cartProductsData.quantity != null
                            ? _cartProductsData.quantity >= 2
                                ? _updateToRemove(_cartProductsData)
                                : _removeFromCart(
                                    _cartProductsData.cartId,
                                    _customerId != null && _customerId != ""
                                        ? _customerId
                                        : "-")
                            : null,
                        child: Container(
                          padding: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            border:
                                Border.all(width: 1, color: Constants.red300),
                          ),
                          child: Icon(
                            Icons.remove,
                            color: Constants.red300,
                          ),
                        ),
                      ),
                      Constants.width(20.0),
                      Text(
                        _quantity.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: Constants.red300,
                        ),
                      ),
                      Constants.width(20.0),
                      InkWell(
                        onTap: () async => _cartProductsData != null &&
                                _cartProductsData.quantity != null &&
                                _cartProductsData.quantity > 0
                            ? _updateToAdd(_cartProductsData)
                            : null,
                        child: Container(
                          padding: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            border:
                                Border.all(width: 1, color: Constants.red300),
                          ),
                          child: Icon(
                            Icons.add,
                            color: Constants.red300,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
              return _cartWidget;
            }

            return Container(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
              decoration: BoxDecoration(
                color: Constants.myWhite,
                border: Border.all(width: 0.1, color: Colors.grey),
              ),
              child: InkWell(
                onTap: () async => Constants.goToProductDetailsPage(
                    _productsData.productId,
                    _customerId != null ? _customerId : "-",
                    context),
                child: Row(
                  mainAxisAlignment: _mStart,
                  crossAxisAlignment: _cStart,
                  children: <Widget>[
                    _productsData != null
                        ? WidgetPage.productImageStack(
                            _productsData.productId,
                            _productsData.thumb,
                            _customerId,
                            _productsData.savedPrice,
                            context)
                        : Container(),
                    Constants.width(10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: _cStart,
                        mainAxisAlignment: _mStart,
                        children: <Widget>[
                          WidgetPage.itemNameText(_productsData.name),
                          Constants.height(15),
                          _productsData.rating != null &&
                                  _productsData.rating >= 0
                              ? WidgetPage.productRating(_productsData.rating)
                              : Container(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: _cStart,
                                mainAxisAlignment: _mStart,
                                children: <Widget>[
                                  _productsData.specialPrice() != null &&
                                          _productsData.specialPrice() != ''
                                      ? _productsData.price != null &&
                                              _productsData.price != ''
                                          ? WidgetPage
                                              .productRealPriceWithSpecial(
                                                  _productsData.price)
                                          : Container()
                                      : _productsData.price != null &&
                                              _productsData.price != ''
                                          ? WidgetPage
                                              .productRealPriceWithoutSpecial(
                                                  _productsData.price)
                                          : Container(),
                                  Constants.height(2),
                                  _productsData.specialPrice() != null &&
                                          _productsData.specialPrice() != ''
                                      ? WidgetPage.productDiscountPriceText(
                                          _productsData.specialPrice())
                                      : Container(),
                                ],
                              ),
                              _addToCartButtonWidget(
                                  _productsData.isAdded,
                                  _productsData.options,
                                  _productsData.productId,
                                  _customerId,
                                  _quantity,
                                  _vouchers,
                                  _coupon,
                                  _reward,
                                  context),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          });
    } else {
      _listWidget = WidgetPage.noItemFoundWidget();
    }
    return _listWidget;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.grey300,
      appBar: _title != null && _title != ""
          ? WidgetPage.viewMoreAppBar(_title, context)
          : WidgetPage.viewMoreAppBar("Gwalior Cart", context),
      body: _snapshot != null && _snapshot.length > 0
          ? _bodyListViewBuilder(_snapshot)
          : WidgetPage.noItemFoundWidget(),
    );
  }
}

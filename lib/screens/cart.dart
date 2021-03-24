/*
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gwaliorkart/models/dummy_data_model.dart';
import 'package:gwaliorkart/screens/auth_login.dart';
import 'package:gwaliorkart/screens/home.dart';
import 'package:gwaliorkart/screens/proceed_to_pay.dart';
import 'package:gwaliorkart/screens/product_details.dart';
import 'package:gwaliorkart/screens/search_screen.dart';
import 'package:gwaliorkart/utils/auth_utils.dart';
import 'package:gwaliorkart/utils/constants.dart';
import 'package:gwaliorkart/widgets/error_screen.dart';
import 'package:gwaliorkart/widgets/loader.dart';

class BasketPage extends StatefulWidget {
  final List<dynamic> snapshot;

  BasketPage(this.snapshot);

  @override
  _BasketPageState createState() => _BasketPageState();
}

class _BasketPageState extends State<BasketPage> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser _currentUser;
  final bool isLoading = false;
  List<dynamic> _snapshot;
  String _customerId;

  @override
  void initState() {
    super.initState();
    _customerId = AuthUtils.userId;
    _snapshot = widget.snapshot;
//    _loadCurrentUser();
  }

  Future<void> _loadCurrentUser() async {
    await Constants.loadCurrentUser()
        .then((dynamic _val) {})
        .catchError((_err) {});
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          appBar: _appBarBuilder(),
          body: _basketListViewBuilder(_snapshot),
          bottomNavigationBar: _snapshot.length > 0
              ? BottomAppBar(
                  child: Container(
                    height: 100,
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: itemTotalContainer(),
                      ),
                      _proceedToCheckoutButton(),
                    ]),
                  ),
                )
              : Container(),
        ),
        onWillPop: _willPopCallback);
  }

  AppBar _appBarBuilder() {
    return AppBar(
      title: Text(
        'Review Basket',
        style: TextStyle(fontFamily: 'Gotham', fontSize: 18.0),
      ),
      centerTitle: true,
      leading: Builder(builder: (BuildContext context) {
        return IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: _back,
        );
      }),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.search,
            size: 25,
          ),
          onPressed: () async => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => SearchScreen())),
        ),
        IconButton(
            icon: Icon(
              Icons.more_vert,
              size: 25,
            ),
            onPressed: () {}),
      ],
    );
  }

  Widget itemTotalContainer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "Cart Sub Total (9 items): ",
          style: TextStyle(
              fontSize: 15,
              color: Colors.grey.shade700,
              fontWeight: FontWeight.bold),
        ),
        Text(
          "Rs.2,029.00",
          style: TextStyle(
              fontSize: 16.5, color: Colors.red, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _proceedToCheckoutButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 58.0,
        padding: EdgeInsets.all(10),
        child: isLoading
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
                  'PROCEED TO CHECKOUT',
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.w300),
                ),
                onPressed: () {
                  if (AuthUtils.authToken != null &&
                      AuthUtils.authToken != '') {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ProceedToPay();
                    }));
                  } else {
                    MaterialPageRoute authRoute =
                        MaterialPageRoute(builder: (context) => AuthLogin());
                    Navigator.push(context, authRoute);
                  }
                },
              ),
      ),
    );
  }

  Widget _basketListViewBuilder(final List<dynamic> snapshot) {
    final List<dynamic> basketList = snapshot.map((item) {
      return BasketData.fromJson(item);
    }).toList();
    return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
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
          return Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
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
                    TextStyle _textStyle = TextStyle(
                        color: Constants.myWhite, fontWeight: FontWeight.w500);
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
                    Widget _divider() {
                      Widget _widget;
                      if (index != productList.length - 1) {
                        _widget = Divider();
                      } else {
                        _widget = Container();
                      }
                      return _widget;
                    }

                    return Container(
                      color: Constants.myWhite,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 5.0),
                            child: InkWell(
                              onTap: () async =>
                                  Constants.goToProductDetailsPage(
                                      productData.id, _customerId != null ? _customerId : "-", context),
                              child: Slidable(
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
                                actionPane: SlidableScrollActionPane(),
                                actionExtentRatio: 0.25,
                                secondaryActions: <Widget>[
                                  IconSlideAction(
                                    iconWidget: Column(
                                      children: <Widget>[
                                        Icon(
                                          Icons.delete,
                                          color: Constants.myWhite,
                                        ),
                                        Constants.height(8.0),
                                        Column(
                                          children: <Widget>[
                                            Text(
                                              "Remove",
                                              style: _textStyle,
                                            ),
                                            Text("Item", style: _textStyle),
                                          ],
                                        ),
                                      ],
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                    ),
                                    color: Colors.black54,
                                    onTap: () =>
                                        Constants.showShortToastBuilder(
                                            'Delete'),
                                  ),
                                  IconSlideAction(
                                    iconWidget: Column(
                                      children: <Widget>[
                                        Icon(
                                          Icons.save,
                                          color: Constants.myWhite,
                                        ),
                                        Constants.height(8.0),
                                        Column(
                                          children: <Widget>[
                                            Text(
                                              "Save For",
                                              style: _textStyle,
                                            ),
                                            Text("Later", style: _textStyle),
                                          ],
                                        ),
                                      ],
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                    ),
                                    color: Colors.blue,
                                    onTap: () =>
                                        Constants.showShortToastBuilder(
                                            'Save For Later'),
                                  ),
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
          );
        });
  }

  Future<bool> _willPopCallback() async {
    return _back();
  }

  _back() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (BuildContext context) => Home()));
  }
}
*/

/*  %%%%%%%%%%%%%%%  CART LIST PAGE WITH REAL API DATA AND DYNAMIC PAGE  %%%%%%%%%%%%%%%%%%%%  */

/*############################################################################*/
//import 'dart:convert';
//
//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter_slidable/flutter_slidable.dart';
//import 'package:gwaliorkart/models/cart_data.dart';
//import 'package:gwaliorkart/models/dummy_data_model.dart';
//import 'package:gwaliorkart/screens/auth_login.dart';
//import 'package:gwaliorkart/screens/home.dart';
//import 'package:gwaliorkart/screens/proceed_to_pay.dart';
//import 'package:gwaliorkart/screens/product_details.dart';
//import 'package:gwaliorkart/screens/search_screen.dart';
//import 'package:gwaliorkart/utils/auth_utils.dart';
//import 'package:gwaliorkart/utils/constants.dart';
//import 'package:gwaliorkart/widgets/error_screen.dart';
//import 'package:gwaliorkart/widgets/loader.dart';
//import 'package:gwaliorkart/widgets/widget_page.dart';
//
//class Cart extends StatefulWidget {
//  final Map<String, dynamic> snapshot;
//
//  Cart(this.snapshot);
//
//  @override
//  _CartState createState() => _CartState();
//}
//
//class _CartState extends State<Cart> {
//  FirebaseAuth _auth = FirebaseAuth.instance;
//  FirebaseUser _currentUser;
//  final bool isLoading = false;
//  CartData _cartData;
//  CartProductsData _cartItem;
//  CartProductsOptionData _cartProductsOptionData;
//  CartTotalsData _cartTotalsData;
//  String _customerId, _vouchers, _coupon, _reward;
//  final String _title = "Shopping Cart";
//  MainAxisAlignment _mStart = MainAxisAlignment.start;
//  MainAxisAlignment _mCenter = MainAxisAlignment.center;
//  CrossAxisAlignment _cStart = CrossAxisAlignment.start;
//  CrossAxisAlignment _cCenter = CrossAxisAlignment.center;
//
//  @override
//  void initState() {
//    super.initState();
//    _customerId = AuthUtils.userId;
//    if (widget.snapshot != null) {
//      _cartData = CartData.fromJson(widget.snapshot);
//    }
//  }
//
//  Future<dynamic> _getCartListData() async {
//    Constants.showLoadingIndicator(context);
//    await CartUtils.getCartList(
//            _customerId != null && _customerId != "" ? _customerId : "-",
//            _vouchers != null && _vouchers != "" ? _vouchers : "-",
//            _coupon != null && _coupon != "" ? _coupon : "-",
//            _reward != null && _reward != "" ? _reward : "-")
//        .then((dynamic _listRes) {
//      if (_listRes != null) {
//        if (_listRes.containsKey('text_count')) {
//          setState(() {
//            _cartData = CartData.fromJson(_listRes);
//          });
//          Navigator.of(context).pop();
//        }
//      }
//    }).catchError((_onError) {
//      print("\ngetCartListData catchError:=> $_onError\n");
//    });
//  }
//
//  Future<dynamic> _removeFromCart(
//      final String _cartId, final String _customerId) async {
//    Constants.showLoadingIndicator(context);
//    CartData _removeParams =
//        CartData(null, _customerId, null, null, null, null, null, _cartId);
//    await CartUtils.removeCart(_removeParams).then((dynamic _removeRes) {
//      if (_removeRes != null && _removeRes.containsKey("success")) {
//        setState(() {});
//        _getCartListData();
//        Navigator.of(context).pop();
//        Constants.showShortToastBuilder('Item removed successfully');
//      }
//    }).catchError((_onError) {
//      Navigator.of(context).pop();
//      print("\nremoveCart catchError:=> $_onError\n");
//      Constants.showLongToastBuilder('Oops! Something went wrong');
//    });
//  }
//
//  Future<dynamic> _updateToAdd(final CartProductsData _addBtn) async {
//    Constants.showLoadingIndicator(context);
//    print("_quantity:= ${_addBtn.quantity}");
//    CartData _addParams =
//        CartData(null, null, 1, null, null, null, null, _addBtn.cartId);
//
//    await CartUtils.editCart(_addParams).then((dynamic _addRes) {
//      if (_addRes != null && _addRes.containsKey("success")) {
//        setState(() {});
//        _getCartListData();
//        Navigator.of(context).pop();
//        Constants.showShortToastBuilder(_addRes["success"]);
//      } else if (_addRes.containsKey("error")) {
//        Navigator.of(context).pop();
//        Constants.showShortToastBuilder(_addRes["error"]);
//      }
//    }).catchError((_addErr) {
//      Navigator.of(context).pop();
//      print('\neditCart catchError:= $_addErr\n');
//      Constants.showShortToastBuilder('Oops something is wrong..');
//    });
//  }
//
//  Future<dynamic> _updateToRemove(final CartProductsData _addBtn) async {
//    Constants.showLoadingIndicator(context);
//    print("_quantity:= ${_addBtn.quantity}");
//    CartData _addParams =
//        CartData(null, null, 1, null, null, null, null, _addBtn.cartId);
//
//    await CartUtils.editCart(_addParams).then((dynamic _addRes) {
//      if (_addRes != null && _addRes.containsKey("success")) {
//        setState(() {});
//        _getCartListData();
//        Navigator.of(context).pop();
//        Constants.showShortToastBuilder(_addRes["success"]);
//      } else if (_addRes.containsKey("error")) {
//        Navigator.of(context).pop();
//        Constants.showShortToastBuilder(_addRes["error"]);
//      }
//    }).catchError((_addErr) {
//      Navigator.of(context).pop();
//      print('\neditCart catchError:= $_addErr\n');
//      Constants.showShortToastBuilder('Oops something is wrong..');
//    });
//  }
//
//  AppBar _appBarBuilder(final String _title) {
//    return AppBar(
//      elevation: 0.0,
//      title: Text(
//        _title,
//        style: TextStyle(fontFamily: 'Gotham', fontSize: 16.0),
//      ),
//      centerTitle: true,
//      leading: Builder(builder: (BuildContext context) {
//        return IconButton(
//          icon: Icon(Icons.arrow_back_ios),
//          onPressed: _back,
//        );
//      }),
//      actions: <Widget>[
//        IconButton(
//          icon: Icon(
//            Icons.search,
//            size: 25,
//          ),
//          onPressed: () async => Navigator.pushReplacement(
//              context,
//              MaterialPageRoute(
//                  builder: (BuildContext context) => SearchScreen())),
//        ),
//        IconButton(
//            icon: Icon(
//              Icons.more_vert,
//              size: 25,
//            ),
//            onPressed: () {}),
//      ],
//    );
//  }
//
//  Widget _cartListViewBuilder(final CartData _cartMap) {
//    final List<dynamic> _cartList = _cartMap.products.map((_listItem) {
//      print("\n_cartList:=> $_listItem\n");
//      return CartProductsData.fromJson(_listItem);
//    }).toList();
//    return ListView.builder(
//      shrinkWrap: true,
//      physics: NeverScrollableScrollPhysics(),
//      primary: false,
//      itemCount: _cartList == null ? 0 : _cartList.length,
//      itemBuilder: (BuildContext context, int _listIndex) {
//        _cartItem = _cartList[_listIndex];
//
//        TextStyle _textStyle = TextStyle(color: Constants.myWhite);
//
//        List<Widget> _secondaryActionsWidget(
//            final CartProductsData _actionData) {
//          List<Widget> _actionWidgets = List();
//          _actionWidgets.add(IconSlideAction(
//            iconWidget: Column(
//              children: <Widget>[
//                Icon(
//                  Icons.delete,
//                  color: Constants.myWhite,
//                ),
//                Constants.height(8.0),
//                Column(
//                  children: <Widget>[
//                    Text(
//                      "Remove",
//                      style: _textStyle,
//                    ),
//                    Text("Item", style: _textStyle),
//                  ],
//                ),
//              ],
//              mainAxisAlignment: MainAxisAlignment.center,
//            ),
//            color: Colors.black54,
//            onTap: () async => _removeFromCart(_actionData.cartId,
//                _customerId != null && _customerId != "" ? _customerId : "-"),
//          ));
//          return _actionWidgets;
//        }
//
//        Widget _addOrRemoveButton(final CartProductsData _cartBtn) {
//          return Container(
//            padding: EdgeInsets.symmetric(vertical: 9.0),
//            color: Constants.myWhite,
//            child: Row(
//              mainAxisAlignment: _mCenter,
//              children: <Widget>[
//                InkWell(
//                  onTap: () async =>
//                      _cartBtn != null && int.parse(_cartBtn.quantity) != null
//                          ? int.parse(_cartBtn.quantity) >= 2
//                              ? _updateToRemove(_cartBtn)
//                              : _removeFromCart(
//                                  _cartBtn.cartId,
//                                  _customerId != null && _customerId != ""
//                                      ? _customerId
//                                      : "-")
//                          : null,
//                  child: Container(
//                    padding: EdgeInsets.all(3),
//                    decoration: BoxDecoration(
//                      borderRadius: BorderRadius.circular(4),
//                      border: Border.all(width: 1, color: Constants.red300),
//                    ),
//                    child: Icon(
//                      Icons.remove,
//                      color: Constants.red300,
//                    ),
//                  ),
//                ),
//                Constants.width(20.0),
//                Text(
//                  _cartBtn.quantity,
//                  style: TextStyle(
//                    fontWeight: FontWeight.w500,
//                    fontSize: 18,
//                    color: Constants.red300,
//                  ),
//                ),
//                Constants.width(20.0),
//                InkWell(
//                  onTap: () async => _cartBtn != null &&
//                          int.parse(_cartBtn.quantity) != null &&
//                          int.parse(_cartBtn.quantity) > 0
//                      ? _updateToAdd(_cartBtn)
//                      : null,
//                  child: Container(
//                    padding: EdgeInsets.all(3),
//                    decoration: BoxDecoration(
//                      borderRadius: BorderRadius.circular(4),
//                      border: Border.all(width: 1, color: Constants.red300),
//                    ),
//                    child: Icon(
//                      Icons.add,
//                      color: Constants.red300,
//                    ),
//                  ),
//                ),
//              ],
//            ),
//          );
//        }
//
//        return Slidable(
//          child: Container(
//            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
//            decoration: BoxDecoration(
//              color: Constants.myWhite,
//              border: Border.all(width: 0.1, color: Colors.grey),
//            ),
//            child: Row(
//              crossAxisAlignment: _cStart,
//              mainAxisAlignment: _mStart,
//              children: <Widget>[
//                _cartItem != null
//                    ? WidgetPage.productImageStack(
//                        _cartItem, _customerId, context)
//                    : Container(),
//                Constants.width(0),
//                Expanded(
//                  child: Column(
//                    crossAxisAlignment: _cStart,
//                    mainAxisAlignment: _mStart,
//                    children: <Widget>[
//                      _cartItem != null &&
//                              _cartItem.name != null &&
//                              _cartItem.name != ''
//                          ? WidgetPage.itemNameText(_cartItem.name)
//                          : Container(),
//                      _cartItem != null &&
//                              _cartItem.quantity != null &&
//                              _cartItem.quantity != ''
//                          ? WidgetPage.itemQuantityText(
//                              _cartMap, _cartItem.quantity)
//                          : Container(),
//                      _cartItem != null &&
//                              _cartItem.option != null &&
//                              _cartItem.option.length > 0
//                          ? WidgetPage.optionWidget(_cartItem.option)
//                          : Container(),
//                      _cartItem != null &&
//                              _cartItem.price != null &&
//                              _cartItem.price != ''
//                          ? WidgetPage.unitPrice(_cartMap, _cartItem.price)
//                          : Container(),
//                      _cartItem != null &&
//                              _cartItem.total != null &&
//                              _cartItem.total != ''
//                          ? WidgetPage.totalPrice(_cartMap, _cartItem.total)
//                          : Container(),
//                      _cartItem != null &&
//                              _cartItem.quantity != null &&
//                              _cartItem.quantity != ""
//                          ? _addOrRemoveButton(_cartItem)
//                          : Container(),
//                    ],
//                  ),
//                )
//              ],
//            ),
//          ),
//          actionPane: SlidableScrollActionPane(),
//          actionExtentRatio: 0.25,
//          secondaryActions: _cartItem != null
//              ? _secondaryActionsWidget(_cartItem)
//              : Container(),
//        );
//      },
//    );
//  }
//
//  Widget _cartTotalPriceWidget(final List<dynamic> _totals) {
//    return Container(
//      color: Constants.myWhite,
//      padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
//      child: Column(
//        crossAxisAlignment: _cStart,
//        mainAxisAlignment: _mStart,
//        children: _totals != null && _totals.length > 0
//            ? WidgetPage.totalsWidget(_totals)
//            : Container(),
//      ),
//    );
//  }
//
//  Widget _bodyListViewBuilder(final CartData _cartDataItems) {
//    return SingleChildScrollView(
//      scrollDirection: Axis.vertical,
//      child: Column(
//        crossAxisAlignment: _cStart,
//        mainAxisAlignment: _mStart,
//        children: <Widget>[
//          _cartDataItems != null
//              ? _cartDataItems.textCount != null
//                  ? _cartDataItems.textCount > 0
//                      ? _cartListViewBuilder(_cartDataItems)
//                      : Container()
//                  : Container()
//              : Container(),
//          Divider(
//            height: 0.0,
//            thickness: 1.0,
//          ),
//          _cartDataItems != null
//              ? _cartDataItems.textCount != null
//                  ? _cartDataItems.textCount > 0
//                      ? _cartTotalPriceWidget(_cartData.totals)
//                      : Container()
//                  : Container()
//              : Container(),
//        ],
//      ),
//    );
//  }
//
//  BottomAppBar _bottomAppBarProceedToCheckoutButton() {
//    return BottomAppBar(
//      child: Padding(
//        padding: const EdgeInsets.symmetric(horizontal: 10.0),
//        child: Container(
//          width: MediaQuery.of(context).size.width,
//          height: 58.0,
//          padding: EdgeInsets.all(10),
//          child: isLoading
//              ? Center(
//                  child: CircularProgressIndicator(
//                    backgroundColor: Colors.green,
//                  ),
//                )
//              : FlatButton(
//                  shape: RoundedRectangleBorder(
//                      borderRadius: BorderRadius.circular(2)),
//                  color: Colors.deepOrange,
//                  child: Text(
//                    'PROCEED TO CHECKOUT',
//                    style: TextStyle(
//                        fontSize: 15,
//                        color: Colors.white,
//                        fontWeight: FontWeight.w300),
//                  ),
//                  onPressed: () {
//                    if (AuthUtils.authToken != null &&
//                        AuthUtils.authToken != '') {
//                      Navigator.push(context,
//                          MaterialPageRoute(builder: (context) {
//                        return ProceedToPay();
//                      }));
//                    } else {
//                      MaterialPageRoute authRoute =
//                          MaterialPageRoute(builder: (context) => AuthLogin());
//                      Navigator.push(context, authRoute);
//                    }
//                  },
//                ),
//        ),
//      ),
//    );
//  }
//
//  Future<bool> _willPopCallback() async {
//    return _back();
//  }
//
//  _back() {
//    Navigator.pushReplacement(
//        context, MaterialPageRoute(builder: (BuildContext context) => Home()));
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return WillPopScope(
//        child: Scaffold(
//          appBar: _appBarBuilder(_cartData != null
//              ? _cartData.headingTitle != null
//                  ? _cartData.headingTitle != ""
//                      ? _cartData.headingTitle
//                      : _title
//                  : _title
//              : _title),
//          body: _cartData != null
//              ? _cartData.textCount != null
//                  ? _cartData.textCount > 0
//                      ? _bodyListViewBuilder(_cartData)
//                      : WidgetPage.continueToShopping(_cartData, context)
//                  : WidgetPage.continueToShopping(_cartData, context)
//              : WidgetPage.continueToShopping(_cartData, context),
//          bottomNavigationBar: _cartData != null
//              ? _cartData.textCount != null
//                  ? _cartData.textCount > 0
//                      ? _bottomAppBarProceedToCheckoutButton()
//                      : Container()
//                  : Container()
//              : Container(),
//        ),
//        onWillPop: _willPopCallback);
//  }
//}
/*############################################################################*/

//  Widget _listBuilder(final CartData snapshot){
//    final List<dynamic> basketList = snapshot.map((item) {
//      return CartProductsData.fromJson(item);
//    }).toList();
//    return ListView.builder(
//        shrinkWrap: true,
//        scrollDirection: Axis.vertical,
//        itemCount: basketList == null ? 0 : basketList.length,
//        itemBuilder: (BuildContext context, int index) {
//          CartProductsData kartData = basketList[index];
//
//          final List<dynamic> productList = kartData.product.map((items) {
//            return CartProductsData.fromJson(items);
//          }).toList();
//
//          TextStyle _productCategoryStyle =
//          TextStyle(fontWeight: FontWeight.w500, fontSize: 16.0);
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
//                    Column _savedPriceText = Column(
//                      mainAxisAlignment: MainAxisAlignment.center,
//                      crossAxisAlignment: CrossAxisAlignment.center,
//                      children: <Widget>[
//                        _rsText,
//                        Constants.height(2),
//                        _savedText,
//                      ],
//                    );
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
//                    Widget _divider() {
//                      Widget _widget;
//                      if (index != productList.length - 1) {
//                        _widget = Divider();
//                      } else {
//                        _widget = Container();
//                      }
//                      return _widget;
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
//                              onTap: () async =>
//                                  Constants.goToProductDetailsPage(
//                                      productData.id,
//                                      _customerId != null ? _customerId : "-",
//                                      context),
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
//                                        CrossAxisAlignment.start,
//                                        children: <Widget>[
//                                          _itemNameText,
//                                          Constants.height(5),
//                                          _itemQuantityText,
//                                          Constants.height(15),
//                                          Row(
//                                            mainAxisAlignment:
//                                            MainAxisAlignment.spaceBetween,
//                                            children: <Widget>[
//                                              Column(
//                                                crossAxisAlignment:
//                                                CrossAxisAlignment.start,
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
//                                      MainAxisAlignment.center,
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
//                                      MainAxisAlignment.center,
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

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gwaliorkart/models/cart_data.dart';
import 'package:gwaliorkart/screens/auth_login.dart';
import 'package:gwaliorkart/screens/home.dart';
import 'package:gwaliorkart/screens/search_screen.dart';
import 'package:gwaliorkart/utils/auth_utils.dart';
import 'package:gwaliorkart/utils/constants.dart';
import 'package:gwaliorkart/utils/storage_utils.dart';
import 'package:gwaliorkart/widgets/widget_page.dart';

class Cart extends StatefulWidget {
  final Map<String, dynamic> snapshot;

  Cart(this.snapshot);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser _currentUser;
  final bool isLoading = false;
  CartData _cartData;
  CartProductsData _cartItem;
  CartProductsOptionData _cartProductsOptionData;
  CartTotalsData _cartTotalsData;
  String _customerId, _vouchers, _coupon, _reward, _countryId = '99';
  final String _title = "Shopping Cart",
      _empty = 'Your shopping cart is empty!';
  MainAxisAlignment _mStart = MainAxisAlignment.start;
  MainAxisAlignment _mCenter = MainAxisAlignment.center;
  CrossAxisAlignment _cStart = CrossAxisAlignment.start;
  CrossAxisAlignment _cCenter = CrossAxisAlignment.center;
  final GlobalKey<FormState> _couponFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _voucherFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _rewardFormKey = GlobalKey<FormState>();
  TextEditingController _couponController = TextEditingController();
  TextEditingController _voucherController = TextEditingController();
  TextEditingController _rewardController = TextEditingController();
  Size _deviceSize;

  @override
  void initState() {
    super.initState();
    widget.snapshot != null
        ? _cartData = CartData.fromJson(widget.snapshot)
        : _cartData = null;
    _customerId = AuthUtils.userId;
    _coupon = AuthUtils.coupon;
    _vouchers = AuthUtils.voucher;
    _reward = AuthUtils.reward;
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
          });
          if (_cartData.textCount == 0) {
            await StorageProvider.clearVoucherInfo();
            await StorageProvider.clearCouponInfo();
            await StorageProvider.clearRewardInfo();
          }
        }
      }
    }).catchError((_onError) {
      print("\ngetCartListData catchError:=> $_onError\n");
    });
  }

  Future<dynamic> _updateToAdd(final CartProductsData _addBtn) async {
    Constants.showMessageLoader(context, 'Please wait item is updating...');
    CartData _addParams = CartData(null, null, _addBtn.quantity + 1, null, null,
        null, null, _addBtn.cartId);
    await CartUtils.editCart(_addParams).then((dynamic _addRes) async {
      if (_addRes != null && _addRes.containsKey("success")) {
        await _getCartListData();
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
        await _getCartListData();
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

  Future<dynamic> _removeFromCart(
      final String _cartId, final String _customerId) async {
    Constants.showMessageLoader(context, 'Please wait item is removing...');
    CartData _removeParams =
        CartData(null, _customerId, null, null, null, null, null, _cartId);
    await CartUtils.removeCart(_removeParams).then((dynamic _removeRes) async {
      if (_removeRes != null && _removeRes.containsKey("success")) {
        await _getCartListData();
        Navigator.of(context).pop();
        Constants.showShortToastBuilder('Item removed successfully');
      }
    }).catchError((_onError) {
      Navigator.of(context).pop();
      print("\nremoveCart catchError:=> $_onError\n");
      Constants.showLongToastBuilder('Oops! Something went wrong');
    });
  }

  Future<dynamic> _applyToCoupon() async {
    if (_couponFormKey.currentState.validate()) {
      _couponFormKey.currentState.save();
      Constants.showMessageLoader(context, 'Please wait coupon is applying...');
      CouponData _couponParam = CouponData(
        _couponController.text,
        null,
        null,
        _customerId,
      );
      await CouponUtils.applyCoupon(_couponParam)
          .then((dynamic _couponRes) async {
        if (_couponRes != null && _couponRes.containsKey("success")) {
          await StorageProvider.setCouponInfo(_couponController.text);
          await AuthUtils.getCoupon().then((final String _getCoupon) async {
            if (_getCoupon != null && _getCoupon != '') {
              setState(() {
                _coupon = AuthUtils.coupon;
              });
              await _getCartListData();
              Navigator.of(context).pop();
              Constants.showLongToastBuilder(_couponRes["success"]);
            }
          }).catchError((_getErr) {
            Navigator.of(context).pop();
            print("\n\ngetCoupon catchError:=> $_getErr\n\n");
            Constants.showLongToastBuilder(_getErr);
          });
        } else if (_couponRes.containsKey("error")) {
          Navigator.of(context).pop();
          print("\n\napplyCoupon Error:=> ${_couponRes["error"]}\n\n");
          Constants.showLongToastBuilder(_couponRes["error"]);
        } else {
          Navigator.of(context).pop();
          print("\n\nCoupon Applied Failed.\n\n");
          Constants.showShortToastBuilder("Coupon Applied Failed.");
        }
      }).catchError((_couponErr) {
        Navigator.of(context).pop();
        print("\n\napplyCoupon catchError:=> $_couponErr\n\n");
        Constants.showLongToastBuilder(_couponErr);
      });
    }
  }

  Future<dynamic> _applyToVoucher() async {
    if (_voucherFormKey.currentState.validate()) {
      _voucherFormKey.currentState.save();
      Constants.showMessageLoader(
          context, 'Please wait voucher is applying...');
      CouponData _voucherParam = CouponData(
        null,
        _voucherController.text,
        null,
        _customerId,
      );
      await CouponUtils.applyVoucher(_voucherParam)
          .then((dynamic _voucherRes) async {
        if (_voucherRes != null && _voucherRes.containsKey("success")) {
          await StorageProvider.setVoucherInfo(_voucherController.text);
          await AuthUtils.getVoucher().then((final String _getVoucher) async {
            if (_getVoucher != null && _getVoucher != '') {
              setState(() {
                _vouchers = AuthUtils.voucher;
              });
              await _getCartListData();
              Navigator.of(context).pop();
              Constants.showLongToastBuilder(_voucherRes["success"]);
            }
          }).catchError((_getErr) {
            Navigator.of(context).pop();
            print("\n\ngetVoucher catchError:=> $_getErr\n\n");
            Constants.showLongToastBuilder(_getErr);
          });
        } else if (_voucherRes.containsKey("error")) {
          Navigator.of(context).pop();
          print("\n\napplyVoucher Error:=> ${_voucherRes["error"]}\n\n");
          Constants.showLongToastBuilder(_voucherRes["error"]);
        } else {
          Navigator.of(context).pop();
          print("\n\nVoucher Applied Failed.\n\n");
          Constants.showShortToastBuilder("Voucher Applied Failed.");
        }
      }).catchError((_voucherErr) {
        Navigator.of(context).pop();
        print("\n\napplyVoucher catchError:=> $_voucherErr\n\n");
        Constants.showShortToastBuilder(_voucherErr.toString());
      });
    }
  }

  Future<dynamic> _applyToReward() async {
    if (_rewardFormKey.currentState.validate()) {
      _rewardFormKey.currentState.save();
      Constants.showMessageLoader(context, 'Please wait reward is applying...');
      CouponData _rewardParam = CouponData(
        null,
        null,
        _rewardController.text,
        _customerId,
      );
      await CouponUtils.applyReward(_rewardParam)
          .then((dynamic _rewardRes) async {
        if (_rewardRes != null && _rewardRes.containsKey("success")) {
          await StorageProvider.setRewardInfo(_rewardController.text);
          await AuthUtils.getReward().then((final String _getReward) async {
            if (_getReward != null && _getReward != '') {
              setState(() {
                _reward = AuthUtils.reward;
              });
              await _getCartListData();
              Navigator.of(context).pop();
              Constants.showLongToastBuilder(_rewardRes["success"]);
            }
          }).catchError((_getErr) {
            Navigator.of(context).pop();
            print("\n\ngetVoucher catchError:=> $_getErr\n\n");
            Constants.showLongToastBuilder(_getErr);
          });
        } else if (_rewardRes.containsKey("error")) {
          Navigator.of(context).pop();
          print("\n\napplyReward Error:=> ${_rewardRes["error"]}\n\n");
          Constants.showLongToastBuilder(_rewardRes["error"]);
        } else {
          Navigator.of(context).pop();
          print("\n\nReward Applied Failed.\n\n");
          Constants.showShortToastBuilder("Reward Applied Failed.");
        }
      }).catchError((_rewardErr) {
        Navigator.of(context).pop();
        print("\n\napplyReward catchError:=> $_rewardErr\n\n");
        Constants.showShortToastBuilder(_rewardErr);
      });
    }
  }

  Future<bool> _willPopCallback() async {
    return _back();
  }

  Future _back() async {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (BuildContext context) => Home()));
  }

  AppBar _appBarBuilder(final String _title) {
    return AppBar(
      elevation: 0.0,
      title: Text(
        _title,
        style: TextStyle(fontFamily: 'Gotham', fontSize: 16.0),
      ),
      centerTitle: true,
      leading: Builder(builder: (BuildContext context) {
        return IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: _back,
        );
      }),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.search,
            size: 25,
          ),
          onPressed: () async => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => SearchScreen())),
        ),
        IconButton(
            icon: Icon(
              Icons.more_vert,
              size: 25,
            ),
            onPressed: () {}),
      ],
    );
  }

  Widget _cartListViewBuilder(final CartData _cartMap) {
    final List<dynamic> _cartList = _cartMap.products.map((_listItem) {
      return CartProductsData.fromJson(_listItem);
    }).toList();
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      primary: false,
      itemCount: _cartList == null ? 0 : _cartList.length,
      itemBuilder: (BuildContext context, int _listIndex) {
        _cartItem = _cartList[_listIndex];

        TextStyle _textStyle = TextStyle(color: Constants.myWhite);

        List<Widget> _secondaryActionsWidget(
            final CartProductsData _actionData) {
          List<Widget> _actionWidgets = List();
          _actionWidgets.add(IconSlideAction(
            iconWidget: Column(
              children: <Widget>[
                Icon(
                  Icons.delete,
                  color: Constants.myWhite,
                ),
                Constants.height(8.0),
                Column(
                  children: <Widget>[
                    Text(
                      "Remove",
                      style: _textStyle,
                    ),
                    Text("Item", style: _textStyle),
                  ],
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
            color: Colors.black54,
            onTap: () async => _removeFromCart(_actionData.cartId,
                _customerId != null && _customerId != "" ? _customerId : "-"),
          ));
          return _actionWidgets;
        }

        Widget _updateCartListBuilder(final CartProductsData _cartBtn) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 9.0),
            color: Constants.myWhite,
            child: Row(
              mainAxisAlignment: _mStart,
              children: <Widget>[
                InkWell(
                  onTap: () async =>
                      _cartBtn != null && _cartBtn.quantity != null
                          ? _cartBtn.quantity >= 2
                              ? _updateToRemove(_cartBtn)
                              : _removeFromCart(
                                  _cartBtn.cartId,
                                  _customerId != null && _customerId != ""
                                      ? _customerId
                                      : "-")
                          : null,
                  child: Container(
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(width: 1, color: Constants.red300),
                    ),
                    child: Icon(
                      Icons.remove,
                      color: Constants.red300,
                    ),
                  ),
                ),
                Constants.width(20.0),
                Text(
                  _cartBtn.quantity.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: Constants.red300,
                  ),
                ),
                Constants.width(20.0),
                InkWell(
                  onTap: () async => _cartBtn != null &&
                          _cartBtn.quantity != null &&
                          _cartBtn.quantity > 0
                      ? _updateToAdd(_cartBtn)
                      : null,
                  child: Container(
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(width: 1, color: Constants.red300),
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

        return Slidable(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
            decoration: BoxDecoration(
              color: Constants.myWhite,
              border: Border.all(width: 0.1, color: Colors.grey),
            ),
            child: Row(
              crossAxisAlignment: _cStart,
              mainAxisAlignment: _mStart,
              children: <Widget>[
                _cartItem != null
                    ? WidgetPage.productImageStack(
                        _cartItem.id,
                        _cartItem.thumb,
                        _customerId,
                        _cartItem.savedPrice,
                        context)
                    : Container(),
                Constants.width(5),
                Expanded(
                  child: Column(
                    crossAxisAlignment: _cStart,
                    mainAxisAlignment: _mStart,
                    children: <Widget>[
                      _cartItem != null &&
                              _cartItem.name != null &&
                              _cartItem.name != ''
                          ? WidgetPage.itemNameText(_cartItem.name)
                          : Container(),
                      _cartItem != null &&
                              _cartItem.quantity != null &&
                              _cartItem.quantity > 0
                          ? WidgetPage.itemQuantityText(
                              _cartMap, _cartItem.quantity.toString())
                          : Container(),
                      _cartItem != null &&
                              _cartItem.option != null &&
                              _cartItem.option.length > 0
                          ? WidgetPage.optionWidget(_cartItem.option)
                          : Container(),
                      _cartItem != null &&
                              _cartItem.price != null &&
                              _cartItem.price != ''
                          ? WidgetPage.unitPrice(_cartMap, _cartItem.price)
                          : Container(),
                      _cartItem != null &&
                              _cartItem.total != null &&
                              _cartItem.total != ''
                          ? WidgetPage.totalPrice(_cartMap, _cartItem.total)
                          : Container(),
                      _cartItem != null &&
                              _cartItem.quantity != null &&
                              _cartItem.quantity > 0
                          ? _updateCartListBuilder(_cartItem)
                          : Container(),
                    ],
                  ),
                )
              ],
            ),
          ),
          actionPane: SlidableScrollActionPane(),
          actionExtentRatio: 0.25,
          secondaryActions: _cartItem != null
              ? _secondaryActionsWidget(_cartItem)
              : Container(),
        );
      },
    );
  }

  Widget _cartTotalPriceWidget(final List<dynamic> _totals) {
    return Container(
      color: Constants.myWhite,
      padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
      child: Column(
        crossAxisAlignment: _cStart,
        mainAxisAlignment: _mStart,
        children: _totals != null && _totals.length > 0
            ? WidgetPage.totalsWidget(_totals)
            : Container(),
      ),
    );
  }

  Widget _couponWidget() {
    return Container(
      width: _deviceSize.width,
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
      color: Constants.myWhite,
      child: Column(
        crossAxisAlignment: _cStart,
        mainAxisAlignment: _mStart,
        children: <Widget>[
          Constants.height(10.0),
          Text(
            "What would you like to do next?",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              decoration: TextDecoration.underline,
            ),
          ),
          Constants.height(10.0),
          Text(
            "Choose if you have a discount code or reward points you want to use or would like to estimate your delivery cost.",
            style: TextStyle(color: Constants.grey700),
          ),
          Constants.height(25.0),
          Form(
            key: _couponFormKey,
            autovalidate: false,
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: WidgetPage.couponGiftAndRewardTextField(
                      _couponController,
                      TextInputType.text,
                      "Enter your coupon here",
                      "Please enter coupon code"),
                ),
                Constants.width(10.0),
                Expanded(
                  child: RaisedButton(
                    onPressed: () async => _applyToCoupon(),
                    child: Text("APPLY"),
                    padding:
                        EdgeInsets.symmetric(vertical: 16.5, horizontal: 0.0),
                    elevation: 0.0,
                    color: Constants.myGreen,
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    textColor: Constants.myWhite,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _voucherWidget() {
    return Container(
      width: _deviceSize.width,
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
      color: Constants.myWhite,
      child: Column(
        crossAxisAlignment: _cStart,
        mainAxisAlignment: _mStart,
        children: <Widget>[
          /*Constants.height(10.0),
          Text(
            "What would you like to do next?",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              decoration: TextDecoration.underline,
            ),
          ),
          Constants.height(10.0),
          Text(
            "Choose if you have a discount code or reward points you want to use or would like to estimate your delivery cost.",
            style: TextStyle(color: Constants.grey700),
          ),*/
          Constants.height(20.0),
          Form(
            key: _voucherFormKey,
            autovalidate: false,
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: WidgetPage.couponGiftAndRewardTextField(
                      _voucherController,
                      TextInputType.text,
                      "Enter your gift Voucher code here",
                      "Please enter voucher code"),
                ),
                Constants.width(10.0),
                Expanded(
                  child: RaisedButton(
                    onPressed: () async => _applyToVoucher(),
                    child: Text("APPLY"),
                    padding:
                        EdgeInsets.symmetric(vertical: 16.5, horizontal: 0.0),
                    elevation: 0.0,
                    color: Constants.myGreen,
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    textColor: Constants.myWhite,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _rewardWidget() {
    return Container(
      width: _deviceSize.width,
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
      color: Constants.myWhite,
      child: Column(
        crossAxisAlignment: _cStart,
        mainAxisAlignment: _mStart,
        children: <Widget>[
          /*Constants.height(10.0),
          Text(
            "What would you like to do next?",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              decoration: TextDecoration.underline,
            ),
          ),
          Constants.height(10.0),
          Text(
            "Choose if you have a discount code or reward points you want to use or would like to estimate your delivery cost.",
            style: TextStyle(color: Constants.grey700),
          ),*/
          Constants.height(20.0),
          Form(
            key: _rewardFormKey,
            autovalidate: false,
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: WidgetPage.couponGiftAndRewardTextField(
                      _rewardController,
                      TextInputType.number,
                      "Enter your reward here",
                      "Please enter reward code"),
                ),
                Constants.width(10.0),
                Expanded(
                  child: RaisedButton(
                    onPressed: () async => _applyToReward(),
                    child: Text("APPLY"),
                    padding:
                        EdgeInsets.symmetric(vertical: 16.5, horizontal: 0.0),
                    elevation: 0.0,
                    color: Constants.myGreen,
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    textColor: Constants.myWhite,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _bodyListViewBuilder(final CartData _cartDataItems) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: _cStart,
        mainAxisAlignment: _mStart,
        children: <Widget>[
          _cartDataItems != null &&
                  _cartDataItems.textCount != null &&
                  _cartDataItems.textCount > 0 &&
                  _cartDataItems.products != null &&
                  _cartDataItems.products.length > 0
              ? _cartListViewBuilder(_cartDataItems)
              : Container(),
          Divider(
            height: 0.0,
            thickness: 1.0,
          ),
          _cartDataItems != null &&
                  _cartDataItems.textCount != null &&
                  _cartDataItems.textCount > 0 &&
                  _cartDataItems.vouchersList != null &&
                  _cartDataItems.vouchersList.length > 0
              ? _couponWidget()
              : Container(),
          _cartDataItems != null &&
                  _cartDataItems.textCount != null &&
                  _cartDataItems.textCount > 0 &&
                  _cartDataItems.vouchersList != null &&
                  _cartDataItems.vouchersList.length > 0
              ? _voucherWidget()
              : Container(),
          _cartDataItems != null &&
                  _cartDataItems.textCount != null &&
                  _cartDataItems.textCount > 0 &&
                  _cartDataItems.vouchersList != null &&
                  _cartDataItems.vouchersList.length > 0
              ? _rewardWidget()
              : Container(),
          /*_couponWidget(),
          _voucherWidget(),
          _rewardWidget(),*/
          _cartDataItems != null &&
                  _cartDataItems.textCount != null &&
                  _cartDataItems.textCount > 0 &&
                  _cartDataItems.totals != null &&
                  _cartDataItems.totals.length > 0
              ? _cartTotalPriceWidget(_cartData.totals)
              : Container(),
        ],
      ),
    );
  }

  Widget _bottomAppBarProceedToCheckoutButton() {
    return BottomAppBar(
      elevation: 0.0,
      color: Colors.deepOrange,
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () async {
          if (AuthUtils.authToken != null && AuthUtils.authToken != '') {
            await Constants.getBillingAddressCountryAndStateData(
                _customerId, _countryId, context);
//            await Constants.checkAddress(_customerId, context);
          } else {
            MaterialPageRoute authRoute =
                MaterialPageRoute(builder: (context) => AuthLogin());
            Navigator.push(context, authRoute);
          }
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(vertical: 15),
          child: Text(
            'PROCEED TO CHECKOUT',
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
    _deviceSize = MediaQuery.of(context).size;
    return WillPopScope(
        child: Scaffold(
          appBar: _appBarBuilder(_cartData != null &&
                  _cartData.headingTitle != null &&
                  _cartData.headingTitle != ""
              ? _cartData.headingTitle
              : _title),
          body: _cartData != null &&
                  _cartData.textCount != null &&
                  _cartData.textCount > 0
              ? _cartData.textError != null && _cartData.textError != ''
                  ? WidgetPage.continueToShopping(_cartData.textError, context)
                  : _bodyListViewBuilder(_cartData)
              : WidgetPage.continueToShopping(_empty, context),
          bottomNavigationBar: _cartData != null &&
                  _cartData.textCount != null &&
                  _cartData.textCount > 0
              ? _bottomAppBarProceedToCheckoutButton()
              : BottomAppBar(),
        ),
        onWillPop: _willPopCallback);
  }

//  BottomAppBar _bottomAppBarProceedToCheckoutButton() {
//    return BottomAppBar(
//      child: Padding(
//        padding: const EdgeInsets.symmetric(horizontal: 10.0),
//        child: Container(
//          width: MediaQuery.of(context).size.width,
//          height: 55.0,
//          padding: EdgeInsets.symmetric(vertical: 6.0),
//          child: isLoading
//              ? Center(
//                  child: CircularProgressIndicator(
//                    backgroundColor: Colors.green,
//                  ),
//                )
//              : FlatButton(
//                  shape: RoundedRectangleBorder(
//                      borderRadius: BorderRadius.circular(2)),
//                  color: Colors.deepOrange,
//                  child: Text(
//                    'PROCEED TO CHECKOUT',
//                    style: TextStyle(
//                        fontSize: 15,
//                        color: Colors.white,
//                        fontWeight: FontWeight.w400),
//                  ),
//                  onPressed: () {
//                    if (AuthUtils.authToken != null &&
//                        AuthUtils.authToken != '') {
//                      Navigator.push(context,
//                          MaterialPageRoute(builder: (context) {
//                        return ProceedToPay();
//                      }));
//                    } else {
//                      MaterialPageRoute authRoute =
//                          MaterialPageRoute(builder: (context) => AuthLogin());
//                      Navigator.push(context, authRoute);
//                    }
//                  },
//                ),
//        ),
//      ),
//    );
//  }
}

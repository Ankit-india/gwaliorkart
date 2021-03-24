//import 'package:flutter/material.dart';
//import 'package:flutter_slidable/flutter_slidable.dart';
//import 'package:gwaliorkart/models/category_model.dart';
//import 'package:gwaliorkart/models/landing_model.dart';
//import 'package:gwaliorkart/models/wish_list_data.dart';
//import 'package:gwaliorkart/screens/search_screen.dart';
//import 'package:gwaliorkart/utils/constants.dart';
//import 'package:gwaliorkart/widgets/error_screen.dart';
//import 'package:gwaliorkart/widgets/loader.dart';
//import 'package:gwaliorkart/widgets/widget_page.dart';
//
//class WishList extends StatefulWidget {
//  final String customerId;
//
//  WishList(this.customerId);
//
//  @override
//  _WishListState createState() => _WishListState();
//}
//
//class _WishListState extends State<WishList> {
//  Future<dynamic> _listDataHolder;
//  bool _isAdded = false;
//  int numOfAddedItem = 1;
//  String _customerId;
//  CrossAxisAlignment _cStart = CrossAxisAlignment.start;
//  CrossAxisAlignment _cCenter = CrossAxisAlignment.center;
//  MainAxisAlignment _mStart = MainAxisAlignment.start;
//  MainAxisAlignment _mCenter = MainAxisAlignment.center;
//
//  @override
//  void initState() {
//    super.initState();
//    _customerId = widget.customerId;
////    _listDataHolder = _getListData();
//    _isAdded = false;
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
//          onPressed: () async => Navigator.pushReplacement(
//              context,
//              MaterialPageRoute(
//                  builder: (BuildContext context) => SearchScreen())),
//        ),
//      ],
//      title: Text(
//        "Shopping List",
//        style: TextStyle(color: Constants.myWhite),
//      ),
//    );
//  }
//
//  Future<dynamic> _getListData() async {
//    return await WishListUtils.getWishList(_customerId);
//  }
//
//  Widget _wishListBuilder(final Map<String, dynamic> _snapshot) {
//    final List<dynamic> snapshot = _snapshot['products'];
//    Widget _listWidget;
//    if (snapshot.length > 0) {
//      final List<dynamic> productList = snapshot.map((items) {
//        return WishListData.fromJson(items);
//      }).toList();
//
//      _listWidget = ListView.builder(
//          shrinkWrap: true,
//          physics: NeverScrollableScrollPhysics(),
//          primary: false,
//          itemCount: productList == null ? 0 : productList.length,
//          itemBuilder: (BuildContext context, int index) {
//            WishListData productData = productList[index];
//
//            Future<dynamic> _removeWishList() async {
//              Constants.showMessageLoader(
//                  context, 'Please wait item is removing...');
//              await WishListUtils.removeWishList(
//                      int.parse(productData.productId), _customerId)
//                  .then((dynamic _removeRes) {
//                if (_removeRes != null && _removeRes.containsKey("success")) {
////                  setState(() {});
//                  Navigator.of(context).pop();
//                  Constants.showShortToastBuilder('Item removed successfully');
//                }
//              }).catchError((_onError) {
//                Navigator.of(context).pop();
//                print("\nremoveWishList catchError:=> $_onError\n");
//                Constants.showShortToastBuilder('Oops! Something went wrong');
//              });
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
//            Widget _addButton() {
//              return InkWell(
//                onTap: () async => Constants.goToProductDetailsPage(
//                    productData.productId,
//                    _customerId != null ? _customerId : "-",
//                    context),
//                child: WidgetPage.addButtonWidget(),
//              );
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
//            TextStyle _textStyle = TextStyle(
//                color: Constants.myWhite, fontWeight: FontWeight.w500);
//
//            /*Stack _productImageStack() {
//              return Stack(
//                children: <Widget>[
//                  Container(
//                    padding: _stackPadding(),
//                    height: 120.0,
//                    width: 100.0,
//                    child: InkWell(
//                      splashColor: Colors.transparent,
//                      highlightColor: Colors.transparent,
//                      onTap: () async => Constants.goToProductDetailsPage(
//                          productData.productId,
//                          _customerId != null && _customerId != ""
//                              ? _customerId
//                              : "-",
//                          context),
//                      child: FadeInImage(
//                        image: NetworkImage(
//                            productData.thumb != null && productData.thumb != ''
//                                ? productData.thumb
//                                : ''),
//                        placeholder: AssetImage(
//                            'assets/placeholders/no-product-image.png'),
//                      ),
//                    ),
//                  ),
//                  _savedPriceView(),
//                ],
//              );
//            }*/
//
//            return Slidable(
//              child: Container(
//                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
//                decoration: BoxDecoration(
//                  color: Constants.myWhite,
//                  border: Border.all(width: 0.1, color: Colors.grey),
//                ),
//                child: Row(
//                  mainAxisAlignment: _mStart,
//                  crossAxisAlignment: _cStart,
//                  children: <Widget>[
//                    productData != null
//                        ? WidgetPage.productImageStack(productData.productId,
//                            productData.thumb, _customerId, context)
//                        : Container(),
//                    Constants.width(5),
//                    Expanded(
//                      child: Column(
//                        crossAxisAlignment: _cStart,
//                        mainAxisAlignment: _mStart,
//                        children: <Widget>[
//                          WidgetPage.itemNameText(productData.name),
//                          Constants.height(15),
//                          _ratingWidget(),
//                          Row(
//                            crossAxisAlignment: CrossAxisAlignment.end,
//                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                            children: <Widget>[
//                              Column(
//                                crossAxisAlignment: CrossAxisAlignment.start,
//                                children: <Widget>[
//                                  _itemRealPriceText(),
//                                  Constants.height(2),
//                                  _itemDiscountPriceText(),
//                                ],
//                              ),
//                              _addButton(),
//                            ],
//                          ),
//                        ],
//                      ),
//                    )
//                  ],
//                ),
//              ),
//              actionPane: SlidableScrollActionPane(),
//              actionExtentRatio: 0.25,
//              secondaryActions: <Widget>[
//                IconSlideAction(
//                  iconWidget: Column(
//                    mainAxisAlignment: MainAxisAlignment.center,
//                    children: <Widget>[
//                      Icon(
//                        Icons.delete,
//                        color: Constants.myWhite,
//                      ),
//                      Constants.height(8.0),
//                      Column(
//                        children: <Widget>[
//                          Text(
//                            "Remove",
//                            style: _textStyle,
//                          ),
//                          Text("Item", style: _textStyle),
//                        ],
//                      ),
//                    ],
//                  ),
//                  color: Colors.black54,
//                  onTap: () => _removeWishList(),
//                ),
//              ],
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
//  Widget _wishListBodyViewBuilder(final Map<String, dynamic> _snapshot) {
//    return SingleChildScrollView(
//      scrollDirection: Axis.vertical,
//      child: Column(
//          crossAxisAlignment: _cStart,
//          mainAxisAlignment: _mStart,
//          children: <Widget>[
//            _snapshot != null ? _wishListBuilder(_snapshot) : Container(),
//            Divider(
//              height: 0.0,
//              thickness: 1.0,
//            ),
//          ]),
//    );
//  }
//
//  FutureBuilder _futureBuilder() {
//    return FutureBuilder<dynamic>(
//      future: _getListData(),
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
//              return _wishListBodyViewBuilder(snapshot.data);
//            }
//        }
//      },
//    );
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
//}

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gwaliorkart/models/cart_data.dart';
import 'package:gwaliorkart/models/category_model.dart';
import 'package:gwaliorkart/models/landing_model.dart';
import 'package:gwaliorkart/models/wish_list_data.dart';
import 'package:gwaliorkart/screens/search_screen.dart';
import 'package:gwaliorkart/utils/auth_utils.dart';
import 'package:gwaliorkart/utils/constants.dart';
import 'package:gwaliorkart/widgets/error_screen.dart';
import 'package:gwaliorkart/widgets/loader.dart';
import 'package:gwaliorkart/widgets/widget_page.dart';
import 'dart:math';

class WishList extends StatefulWidget {
  final Map<String, dynamic> snapshot;

  WishList(this.snapshot);

  @override
  _WishListState createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  Future<dynamic> _listDataHolder;
  bool _isAdded = false;
  int numOfAddedItem = 1;
  CrossAxisAlignment _cStart = CrossAxisAlignment.start;
  CrossAxisAlignment _cCenter = CrossAxisAlignment.center;
  MainAxisAlignment _mStart = MainAxisAlignment.start;
  MainAxisAlignment _mCenter = MainAxisAlignment.center;
  WishListData _wishData;
  WishListProductsData _wishProduct;
  int _quantity, _itemInCart, _productCartId;
  List<dynamic> optionList = [];
  List<int> _cartIdDic = [];
  String _customerId, _vouchers, _coupon, _reward, _categoryName, _cartId;
//  SubCategoryData _subCatData;
//  CategoriesData _catData;
//  ProductsData _productsData;
  CartData _cartData;
  CartProductsData _cartProductsData;

  @override
  void initState() {
    _customerId = AuthUtils.userId;
    _coupon = AuthUtils.coupon;
    _vouchers = AuthUtils.voucher;
    _reward = AuthUtils.reward;
    widget.snapshot != null ? _wishData = WishListData.fromJson(widget.snapshot) : _wishData = null;
    _getCartListData();
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

  Future<dynamic> _getWishList() async {
    await WishListUtils.getWishList(_customerId).then((dynamic _listRes) {
      if (_listRes != null) {
        if (_listRes.containsKey('success')) {
          setState(() {
            _wishData = WishListData.fromJson(_listRes);
          });
        }
      }
    }).catchError((_onError) {
      print("\n\ngetWishList catchError:=> $_onError\n\n");
    });
  }

  Future<dynamic> _removeWishList(
      final int _productId, final String _customerId) async {
    Constants.showMessageLoader(context, 'Please wait item is removing...');
    await WishListUtils.removeWishList(_productId, _customerId)
        .then((dynamic _removeRes) async {
      if (_removeRes != null && _removeRes.containsKey("success")) {
        await _getWishList();
        Navigator.of(context).pop();
        Constants.showShortToastBuilder('Item removed successfully');
      }
    }).catchError((_onError) {
      Navigator.of(context).pop();
      print("\nremoveWishList catchError:=> $_onError\n");
      Constants.showShortToastBuilder('Oops! Something went wrong');
    });
  }

  /*Future _firstTimeAddToCart(BuildContext context) async {
    if (_product.options != null && _product.options.length > 0) {
      if (_formKey.currentState.validate()) {
        _formKey.currentState.save();
        Constants.showLoadingIndicator(context);

        _product.options.forEach((_optionItem) {
          if (_optionItem != null && _optionItem.length > 0) {
            _options = Options.fromJson(_optionItem);
            if (_options.type == 'select') {
              optionList.add({_options.productOptionId: _selectInput});
            } else if (_options.type == 'radio') {
              optionList.add({_options.productOptionId: _radioInput});
            } else if (_options.type == 'checkbox') {
              optionList.add({
                _options.productOptionId: [
                  _options.productOptionValue[0]['product_option_value_id']
                ]
              });
            } else if (_options.type == 'text') {
              optionList.add({_options.productOptionId: _textController.text});
            } else if (_options.type == 'textarea') {
              optionList
                  .add({_options.productOptionId: _textAreaController.text});
            } else if (_options.type == 'file') {
              optionList.add({_options.productOptionId: _imageCode});
            } else if (_options.type == 'date') {
              optionList.add({_options.productOptionId: _dateController.text});
            } else if (_options.type == 'datetime') {
              optionList
                  .add({_options.productOptionId: _dateTimeController.text});
            } else if (_options.type == 'time') {
              optionList.add({_options.productOptionId: _timeController.text});
            }
          }
        });

        CartData _cartParams = CartData(
            _product.productId,
            _customerId,
            _quantity,
            optionList,
            _vouchers != null ? _vouchers : "",
            _coupon != null ? _coupon : "",
            _reward != null ? _reward : "",
            null);

        await CartUtils.addToCart(_cartParams).then((dynamic _cartRes) {
          if (_cartRes != null && _cartRes.containsKey("success")) {
            setState(() {
              _isAdded = true;
              _itemInCart = _cartRes['count'];
            });
            _getCartListDataOnAdd();
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
      } else {
        return null;
      }
    } else {
      Constants.showLoadingIndicator(context);
      CartData _cartParams = CartData(
          _product.productId,
          _customerId,
          _quantity,
          optionList,
          _vouchers != null ? _vouchers : "",
          _coupon != null ? _coupon : "",
          _reward != null ? _reward : "",
          null);

      await CartUtils.addToCart(_cartParams).then((dynamic _cartRes) {
        if (_cartRes != null && _cartRes.containsKey("success")) {
          setState(() {
            _isAdded = true;
            _itemInCart = _cartRes['count'];
          });
          _getCartListDataOnAdd();
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
  }*/

  AppBar _appBar() {
    return AppBar(
      elevation: 0.0,
      centerTitle: true,
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.search,
            size: 25.0,
          ),
          onPressed: () async =>
              Navigator.push(context, MaterialPageRoute(builder: (context) {
            return SearchScreen();
          })),
        ),
      ],
      title: Text(
        "Shopping List",
        style: TextStyle(color: Constants.myWhite,fontSize: 16.0),
      ),
    );
  }

  Widget _wishListBuilder(final List<dynamic> _products) {
    Widget _listWidget;
    if (_products != null && _products.length > 0) {
      final List<dynamic> _wishList = _products.map((items) {
        return WishListProductsData.fromJson(items);
      }).toList();

      _listWidget = ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          primary: false,
          itemCount: _wishList == null ? 0 : _wishList.length,
          itemBuilder: (BuildContext context, int index) {
            WishListProductsData _wishProduct = _wishList[index];

            /*Widget _addButton(final bool _isCartAdded) {
              Widget buttonSection;
              if (_isCartAdded == false) {
                buttonSection = InkWell(
                  onTap: () async => _firstTimeAddToCart(context),
                  child: WidgetPage.addButtonWidget(),
                );
              } else {
                buttonSection = Row(
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        setState(() {
                          _isAdded = false;
                        });
                        Constants.showShortToastBuilder('Item removed');
                      },
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
                      numOfAddedItem.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.red,
                      ),
                    ),
                    Constants.width(10.0),
                    InkWell(
                      onTap: () {
                        Constants.showShortToastBuilder('Item added');
                      },
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
              }
              return buttonSection;
            }*/

            TextStyle _textStyle = TextStyle(
                color: Constants.myWhite, fontWeight: FontWeight.w500);

            List<Widget> _secondaryActionsWidget(
                final int _productId, final String _customerId) {
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
                onTap: () async => _removeWishList(_productId, _customerId),
              ));
              return _actionWidgets;
            }

            Widget _addButton(bool isAdded) {
              return InkWell(
                onTap: () async => Constants.goToProductDetailsPage(
                    _wishProduct.productId,
                    _customerId != null ? _customerId : "-",
                    context),
                child: WidgetPage.addButtonWidget(),
              );
            }

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

            return Slidable(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                decoration: BoxDecoration(
                  color: Constants.myWhite,
                  border: Border.all(width: 0.1, color: Colors.grey),
                ),
                child: InkWell(
                  onTap: () async => Constants.goToProductDetailsPage(
                      _wishProduct.productId,
                      _customerId != null && _customerId != ""
                          ? _customerId
                          : "-",
                      context),
                  child: Row(
                    mainAxisAlignment: _mStart,
                    crossAxisAlignment: _cStart,
                    children: <Widget>[
                      _wishProduct != null
                          ? WidgetPage.productImageStack(
                          _wishProduct.productId,
                          _wishProduct.thumb,
                          _customerId,
                          _wishProduct.savedPrice,
                          context)
                          : Container(),
                      Constants.width(10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: _cStart,
                          mainAxisAlignment: _mStart,
                          children: <Widget>[
                            _wishProduct.name != null && _wishProduct.name != ''
                                ? WidgetPage.itemNameText(_wishProduct.name)
                                : Container(),
                            Constants.height(15),
                            _wishProduct.rating != null &&
                                _wishProduct.rating >= 0
                                ? WidgetPage.productRating(_wishProduct.rating)
                                : Container(),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    _wishProduct.specialPrice() != null &&
                                        _wishProduct.specialPrice() != ''
                                        ? _wishProduct.price != null &&
                                        _wishProduct.price != ''
                                        ? WidgetPage
                                        .productRealPriceWithSpecial(
                                        _wishProduct.price)
                                        : Container()
                                        : _wishProduct.price != null &&
                                        _wishProduct.price != ''
                                        ? WidgetPage
                                        .productRealPriceWithoutSpecial(
                                        _wishProduct.price)
                                        : Container(),
                                    Constants.height(2),
                                    _wishProduct.specialPrice() != null &&
                                        _wishProduct.specialPrice() != ''
                                        ? WidgetPage.productDiscountPriceText(
                                        _wishProduct.specialPrice())
                                        : Container(),
                                  ],
                                ),
                                _addToCartButtonWidget(
                                    _wishProduct.isAdded,
                                    _wishProduct.options,
                                    _wishProduct.productId,
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
              ),
              actionPane: SlidableScrollActionPane(),
              actionExtentRatio: 0.25,
              secondaryActions: _wishProduct != null
                  ? _secondaryActionsWidget(
                      int.parse(_wishProduct.productId), _customerId)
                  : Container(),
            );
          });
    } else {
      _listWidget = WidgetPage.noItemFoundWidget();
    }
    return _listWidget;
  }

  Widget _wishListBodyViewBuilder(final List<dynamic> _wishProducts) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
          crossAxisAlignment: _cStart,
          mainAxisAlignment: _mStart,
          children: <Widget>[
            _wishProducts != null && _wishProducts.length > 0
                ? _wishListBuilder(_wishProducts)
                : WidgetPage.noItemFoundWidget(),
            Divider(
              height: 0.0,
              thickness: 1.0,
            ),
          ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.grey300,
      appBar: _appBar(),
      body: _wishData != null &&
              _wishData.products != null &&
              _wishData.products.length > 0
          ? _wishListBodyViewBuilder(_wishData.products)
          : WidgetPage.noItemFoundWidget(),
    );
  }
}

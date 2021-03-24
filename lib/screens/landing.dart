import 'package:carousel_pro/carousel_pro.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gwaliorkart/models/cart_data.dart';
import 'package:gwaliorkart/models/landing_model.dart';
import 'package:gwaliorkart/models/product_detail_model.dart';
import 'package:gwaliorkart/models/shipping_address_data.dart';
import 'package:gwaliorkart/screens/auth_login.dart';
import 'package:gwaliorkart/screens/backup_file.dart';
import 'package:gwaliorkart/screens/dummy_product_details.dart';
import 'package:gwaliorkart/screens/product_details.dart';
import 'package:gwaliorkart/screens/shipping_address.dart';
import 'package:gwaliorkart/screens/subcategory_page.dart';
import 'package:gwaliorkart/screens/view_more.dart';
import 'package:gwaliorkart/utils/auth_utils.dart';
import 'package:gwaliorkart/utils/constants.dart';
import 'package:gwaliorkart/widgets/error_screen.dart';
import 'package:gwaliorkart/widgets/loader.dart';
import 'package:gwaliorkart/widgets/widget_page.dart';
import 'dart:math';

class Landing extends StatefulWidget {
  final ScrollController _scrollBottomBarController;

  Landing(this._scrollBottomBarController);

  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  Future<dynamic> landingPageDataHolder;
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser _currentUser;
  int _quantity, _itemInCart, _productCartId;
  List<dynamic> optionList = [];
  List<int> _cartIdDic = [];
  String _customerId, _vouchers, _coupon, _reward, _categoryName, _cartId;

//  SubCategoryData _subCatData;
//  CategoriesData _catData;
//  ProductsData _productsData;
  CartData _cartData;
  CartProductsData _cartProductsData;

  TextStyle myStyle() {
    return TextStyle(fontFamily: 'Gotham', fontSize: 15);
  }

  final TextStyle myStyleSmall =
      TextStyle(fontFamily: 'Gotham', fontSize: 12, color: Colors.grey[600]);
  bool _isAdded;

  @override
  void initState() {
    _customerId = AuthUtils.userId;
    _coupon = AuthUtils.coupon;
    _vouchers = AuthUtils.voucher;
    _reward = AuthUtils.reward;
//    _loadCurrentUser();
    _customerId = AuthUtils.userId;
    landingPageDataHolder = _getLandingData();
    _isAdded = false;
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
      bool _isAdded, final String _cartId, final String _customerId) async {
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
      bool _isAdded,
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

  Future<void> _loadCurrentUser() async {
    await Constants.loadCurrentUser()
        .then((dynamic _val) {})
        .catchError((_err) {});
  }

  Future<dynamic> _getLandingData() async {
    return await LandingPageUtils.getLandingPageList();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData deviceData = MediaQuery.of(context);
    Orientation deviceOrientation = MediaQuery.of(context).orientation;
    EdgeInsets devicePadding = MediaQuery.of(context).padding;
    bool noAnimations = MediaQuery.of(context).disableAnimations;
    Brightness screenContrast = MediaQuery.of(context).platformBrightness;
    return FutureBuilder<dynamic>(
      future: landingPageDataHolder,
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
              return _bodyListViewBuilder(snapshot.data);
            }
        }
      },
    );
  }

  Widget _bodyListViewBuilder(Map<String, dynamic> snapshot) {
    return Container(
      child: SingleChildScrollView(
        controller: widget._scrollBottomBarController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _imgCarousel(snapshot['banners']),
            _divider(1),
            Constants.height(10.0),
            WidgetPage.label(8.0, 'Shop by Category'),
            _categorySection(snapshot['categories']),
            Constants.height(2.0),
            WidgetPage.label(0.0, 'Best Products'),
            _bestProductsView(snapshot['best_products']),
            Constants.height(8.0),
            WidgetPage.label(0.0, 'Latest Products'),
            _latestProductsView(snapshot['latest_products']),
            _thatAllFolks(),
          ],
        ),
      ),
    );
  }

  Widget _imgCarousel(final List<dynamic> carouselData) {
    return Container(
      height: 150.0,
      child: Carousel(
        dotIncreasedColor: Constants.primary_green,
        animationCurve: Curves.bounceInOut,
        dotBgColor: Colors.transparent,
        boxFit: BoxFit.cover,
        autoplay: true,
        dotSize: 5.0,
        images: carouselData.map((item) {
          BannerData banner = BannerData.fromJson(item);
          return InkWell(
            onTap: () => null,
            child: Image(
              image: NetworkImage(banner.image),
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

  Widget _categorySection(final List<dynamic> categoryData) {
    final List<dynamic> categoryList = categoryData.map((item) {
      return CategoryData.fromJson(item);
    }).toList();

    List<Widget> categoryActions = [];

    for (int i = 0; i < categoryList.length; i++) {
      CategoryData categoryData = categoryList[i];
      categoryActions.add(
        InkWell(
          onTap: () async => Constants.goToSubCategoryPage(
              categoryData.categoryId, categoryData.name, context),
          child: Container(
            color: Constants.myWhite,
            margin: EdgeInsets.only(right: 0.5, left: 0.5, bottom: 1),
            padding: EdgeInsets.all(2.0),
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  height: Constants.getHeight(context, .123),
                  width: Constants.getWidth(context, .3),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: categoryData.getImage(),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Constants.height(3.0),
                Text(
                  categoryData.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 8.0),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return GridView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      primary: false,
      padding: EdgeInsets.only(right: 8, left: 8, bottom: 8),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 200 / 200,
      ),
      children: categoryActions,
    );
  }

  Widget _bestProductsView(final List<dynamic> _productData) {
    final List<dynamic> bestProductList = _productData.map((item) {
      return BestProductData.fromJson(item);
    }).toList();

    int n;

    if (bestProductList.length >= 6) {
      n = 6;
    } else {
      n = bestProductList.length;
    }

    List<Widget> bestProductActions = [];

    /* Widget _addButton(final bool isAdded) {
      Widget buttonSection;
      if (isAdded == false) {
        buttonSection = Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InkWell(
              onTap: () {
                setState(() {
                  _isAdded = true;
                });
                Constants.showShortToastBuilder("Item added into the kart");
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Constants.red300,
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Text(
                  "ADD",
                  style: TextStyle(
                      color: Constants.myWhite, fontWeight: FontWeight.w500),
                ),
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 7.0),
              ),
            ),
          ],
        );
      } else {
        buttonSection = Row(
          mainAxisAlignment: MainAxisAlignment.center,
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
                  border: Border.all(width: 1, color: Constants.red300),
                ),
                child: Icon(
                  Icons.remove,
                  color: Constants.red300,
                ),
              ),
            ),
            Constants.width(10.0),
            Text(
              numOfAddedItem.toString(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Constants.red300,
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
                  border: Border.all(width: 1, color: Constants.red300),
                ),
                child: Icon(
                  Icons.add,
                  color: Constants.red300,
                ),
              ),
            ),
          ],
        );
      }
      return buttonSection;
    }*/

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
          onTap: () async {
            if (AuthUtils.authToken != null && AuthUtils.authToken != '') {
              await _firstTimeAddToCart(_isCartAdded, _options, _productId,
                  _customerId, _quantity, _vouchers, _coupon, _reward, context);
            } else {
              Constants.showLongToastBuilder('Please Login to add to cart');
              MaterialPageRoute authRoute =
                  MaterialPageRoute(builder: (context) => AuthLogin());
              Navigator.push(context, authRoute);
            }
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 13.0, vertical: 6.5),
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
                            _isCartAdded,
                            _cartProductsData.cartId,
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
      return _cartWidget;
    }

    for (int i = 0; i < n; i++) {
      BestProductData itemData = bestProductList[i];
      bestProductActions.add(
        InkWell(
          onTap: () async => Constants.goToProductDetailsPage(
              itemData.productId,
              _customerId != null ? _customerId : "-",
              context),
          child: Container(
            width: Constants.getWidth(context, 0.50),
            child: Card(
              elevation: 2.0,
              child: Padding(
                padding: EdgeInsets.all(5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.center,
                          height: Constants.getHeight(context, .17),
                          width: Constants.getWidth(context, .4),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: itemData.getImage(),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Constants.sizedBoxHeight(context, .005),
                    Container(
                      height: Constants.getHeight(context, .065),
                      child: Text(
                        itemData.name,
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: myStyle(),
                      ),
                    ),
                    Constants.sizedBoxHeight(context, .03),
                    WidgetPage.ratingWidgets(itemData.rating),
                    Constants.sizedBoxHeight(context, .006),
                    _realPriceText(itemData.specialPrice(), itemData.price),
                    Constants.sizedBoxHeight(context, .004),
                    _discountPriceText(itemData.specialPrice(), itemData.price),
                    Constants.sizedBoxHeight(context, .061),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        _addToCartButtonWidget(
                            itemData.isAdded,
                            itemData.options,
                            itemData.productId,
                            _customerId,
                            _quantity,
                            _vouchers,
                            _coupon,
                            _reward,
                            context)
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

      if (i == n - 1) {
        bestProductActions.add(
          InkWell(
            onTap: () async =>
                Constants.goToViewMorePage('best_products', context),
            child: Container(
              width: 180.0,
              child: Card(
                elevation: 2.0,
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        'View more',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13.0,
                          color: Constants.myGreen,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }
    }
    return SizedBox(
      height: Constants.getHeight(context, .52),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: bestProductActions,
      ),
    );
  }

  Widget _latestProductsView(final List<dynamic> _productData) {
    final List<dynamic> latestProductList = _productData.map((item) {
      return LatestProductData.fromJson(item);
    }).toList();

    int n;

    if (latestProductList.length >= 6) {
      n = 6;
    } else {
      n = latestProductList.length;
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
          onTap: () async {
            if (AuthUtils.authToken != null && AuthUtils.authToken != '') {
              _firstTimeAddToCart(_isCartAdded, _options, _productId,
                  _customerId, _quantity, _vouchers, _coupon, _reward, context);
            } else {
              Constants.showLongToastBuilder('Please Login to add to cart');
              MaterialPageRoute authRoute =
                  MaterialPageRoute(builder: (context) => AuthLogin());
              Navigator.push(context, authRoute);
            }
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 13.0, vertical: 6.5),
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
                            _isCartAdded,
                            _cartProductsData.cartId,
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
      return _cartWidget;
    }

    List<Widget> latestProductActions = [];

    for (int i = 0; i < n; i++) {
      LatestProductData itemData = latestProductList[i];
      latestProductActions.add(
        InkWell(
          onTap: () async => Constants.goToProductDetailsPage(
              itemData.productId,
              _customerId != null ? _customerId : "-",
              context),
          child: Container(
            width: Constants.getWidth(context, 0.50),
            child: Card(
              elevation: 2.0,
              child: Padding(
                padding: EdgeInsets.all(5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: Constants.getHeight(context, .17),
                          width: Constants.getWidth(context, .4),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: itemData.getImage(),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Constants.sizedBoxHeight(context, .005),
                    Container(
                      height: Constants.getHeight(context, .065),
                      child: Text(
                        itemData.name,
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: myStyle(),
                      ),
                    ),
                    Constants.sizedBoxHeight(context, .03),
                    WidgetPage.ratingWidgets(itemData.rating),
                    Constants.sizedBoxHeight(context, .006),
                    _realPriceText(itemData.specialPrice(), itemData.price),
                    Constants.sizedBoxHeight(context, .004),
                    _discountPriceText(itemData.specialPrice(), itemData.price),
                    Constants.sizedBoxHeight(context, .061),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        _addToCartButtonWidget(
                            itemData.isAdded,
                            itemData.options,
                            itemData.productId,
                            _customerId,
                            _quantity,
                            _vouchers,
                            _coupon,
                            _reward,
                            context)
                      ],
                    ),
//                    _addButton(_isAdded),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

      if (i == n - 1) {
        latestProductActions.add(
          InkWell(
            onTap: () async =>
                Constants.goToViewMorePage('latest_products', context),
            /*onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ViewMore('latest_products');
              }));
            },*/
            child: Container(
              width: 180.0,
              child: Card(
                elevation: 2.0,
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        'View more',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13.0,
                          color: Constants.myGreen,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }
    }
    return SizedBox(
      height: Constants.getHeight(context, .52),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: latestProductActions,
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

  Widget _realPriceText(final String specialPrice, final String price) {
    Widget _price;
    if (specialPrice != '' && specialPrice != null) {
      _price = RichText(
        textAlign: TextAlign.left,
        text: TextSpan(
            text: 'MRP: ',
            style: TextStyle(color: Colors.grey),
            children: [
              TextSpan(
                text: price,
                style: TextStyle(
                  color: Colors.grey,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            ]),
      );
    } else {
      _price = Text(
        price,
        textAlign: TextAlign.left,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15.0,
        ),
      );
    }
    return _price;
  }

  Widget _discountPriceText(
      final String _specialPrice, final String _realPrice) {
    Widget _price;
    if (_specialPrice != '' && _specialPrice != null) {
      _price = Text(
        _specialPrice,
        textAlign: TextAlign.left,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15.0,
        ),
      );
    } else {
      _price = RichText(
        textAlign: TextAlign.left,
        text: TextSpan(
            text: '',
            style: TextStyle(color: Constants.myWhite),
            children: [
              TextSpan(
                text: '',
                style: TextStyle(
                  color: Constants.myWhite,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            ]),
      );
    }
    return _price;
  }
}

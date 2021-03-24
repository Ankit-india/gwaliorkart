//import 'package:flutter/material.dart';
//import 'package:gwaliorkart/models/product_detail_model.dart';
//import 'package:gwaliorkart/screens/basket.dart';
//import 'package:gwaliorkart/screens/image_viewer.dart';
//import 'package:gwaliorkart/screens/product_ratings_and_reviews.dart';
//import 'package:gwaliorkart/screens/search_screen.dart';
//import 'package:gwaliorkart/screens/wish_list.dart';
//import 'package:gwaliorkart/utils/auth_utils.dart';
//import 'package:gwaliorkart/utils/constants.dart';
//import 'package:gwaliorkart/widgets/error_screen.dart';
//import 'package:gwaliorkart/widgets/loader.dart';
//
//class ProductDetails extends StatefulWidget {
//  final int productId;
//
//  ProductDetails(this.productId);
//
//  @override
//  _ProductDetailsState createState() => _ProductDetailsState();
//}
//
//class _ProductDetailsState extends State<ProductDetails>
//    with SingleTickerProviderStateMixin {
//  CrossAxisAlignment _cStart = CrossAxisAlignment.start;
//  MainAxisAlignment _mStart = MainAxisAlignment.start;
//  CrossAxisAlignment _cCenter = CrossAxisAlignment.center;
//  MainAxisAlignment _mCenter = MainAxisAlignment.center;
//  ScrollController _scrollBottomBarController;
//  Map<String, dynamic> _selectedProduct;
//  ProductDetailData _product;
//  Options _sizeOption;
//  Options _colorOption;
//  ProductOptionValue _optionValue;
//  AttributeGroups _attributeGroups;
//  Attribute _attribute;
//  Future<dynamic> _detailsDataHolder;
//  bool _isAdded, _isSaved;
//  int numOfAddedItem = 1;
//  TextStyle myStyle = TextStyle(fontFamily: 'Gotham', fontSize: 13);
//  TextStyle myStyleSmall =
//      TextStyle(fontFamily: 'Gotham', fontSize: 12, color: Colors.grey[600]);
//  String _customerId, _productSize, _productColor;
//  Size _deviceSize;
//
//  @override
//  void initState() {
//    super.initState();
//    _detailsDataHolder = _getProductDetailsData();
//    _customerId = AuthUtils.userId;
//    _isAdded = false;
//    _isSaved = false;
//  }
//
//  Future<dynamic> _getProductDetailsData() async {
//    return await ProductDetailUtils.getProductDetails(
//        widget.productId.toString());
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    _deviceSize = MediaQuery.of(context).size;
//    return Scaffold(
//      appBar: _appBar(),
//      body: Container(
//        color: Colors.grey[300],
//        child: _futureBuilder(),
//      ),
//      bottomNavigationBar: BottomAppBar(
//        elevation: 0.0,
//        child: _addButton(_isAdded),
//      ),
//    );
//  }
//
//  AppBar _appBar() {
//    return AppBar(
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
//        IconButton(
//          icon: Icon(
//            Icons.share,
//            size: 25.0,
//          ),
//          onPressed: () {},
//        ),
//        IconButton(
//          icon: Icon(
//            Icons.shopping_basket,
//            size: 25.0,
//          ),
//          onPressed: () =>
//              Navigator.push(context, MaterialPageRoute(builder: (context) {
//            return Basket(_scrollBottomBarController);
//          })),
//        ),
//      ],
//      title: Text(
//        "Gwaliorkart",
//        style: TextStyle(color: Constants.myWhite),
//      ),
//    );
//  }
//
//  FutureBuilder _futureBuilder() {
//    return FutureBuilder<dynamic>(
//      future: _detailsDataHolder,
//      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
//        switch (snapshot.connectionState) {
//          case ConnectionState.none:
//          case ConnectionState.active:
//          case ConnectionState.waiting:
//            return Loader();
//          case ConnectionState.done:
//          default:
//            if (snapshot.hasError) {
//              print("Error:=> ${snapshot.error}");
//              return ErrorScreen(snapshot.error, 1);
//            } else {
//              return _itemDetailViewBuilder(snapshot.data);
//            }
//        }
//      },
//    );
//  }
//
//  Widget _itemDetailViewBuilder(Map<String, dynamic> _snapshot) {
//    Widget _widget;
//    if (_snapshot != null && _snapshot.containsKey('text_error')) {
//      _widget = Container(
//        alignment: Alignment.center,
//        child: Text(
//          _snapshot['text_error'],
//          style: TextStyle(
//              fontSize: 18.0,
//              color: Constants.grey500,
//              fontWeight: FontWeight.w500),
//        ),
//      );
//    } else if (_snapshot != null) {
//      _product = ProductDetailData.fromJson(_snapshot);
//      if (_product.options != null && _product.options.length > 0) {
//        if (_product.options[0] != null && _product.options[0].length > 0) {
//          _sizeOption = Options.fromJson(_product.options[0]);
//          _productSize = '0';
//        }
//        if (_product.options[1] != null && _product.options[1].length > 0) {
//          _colorOption = Options.fromJson(_product.options[1]);
//          _productColor = '0';
//        }
//        print(
//            "price:= ${_product.price}, optPrice1:= ${_sizeOption.productOptionValue[1]['price']}, optPrice2:= ${_sizeOption.productOptionValue[2]['price']}, optPrice3:= ${_sizeOption.productOptionValue[3]['price']}");
//      }
//
//      if (_product.attributeGroups != null &&
//          _product.attributeGroups.length > 0) {
//        if (_product.attributeGroups[0] != null &&
//            _product.attributeGroups[0].length > 0) {
//          _attributeGroups =
//              AttributeGroups.fromJson(_product.attributeGroups[0]);
//          if (_attributeGroups.attribute != null &&
//              _attributeGroups.attribute.length > 0) {
//            if (_attributeGroups.attribute[0] != null &&
//                _attributeGroups.attribute[0].length > 0) {
//              _attribute = Attribute.fromJson(_attributeGroups.attribute[0]);
//            }
//          }
//        }
//      }
//      Widget _brandName() {
//        Widget _widget;
//        if (_product.manufacturer != null) {
//          _widget = Column(
//            children: <Widget>[
//              Container(
//                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
//                decoration: BoxDecoration(
//                  color: Colors.tealAccent,
//                  borderRadius: BorderRadius.circular(3),
//                ),
//                child: Text(
//                  _product.manufacturer,
//                  style: TextStyle(fontWeight: FontWeight.w500),
//                ),
//              ),
//              Constants.height(8.0),
//            ],
//          );
//        } else {
//          _widget = Container();
//        }
//        return _widget;
//      }
//
//      Container _productName = Container(
//        child: Text(
//          _product.headingTitle,
//          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300),
//        ),
//      );
//
//      Widget _itemRealPriceText() {
//        Widget _price;
//        if (_product.specialPrice() != '' && _product.specialPrice() != null) {
//          _price = RichText(
//            textAlign: TextAlign.center,
//            text: TextSpan(
//                text: 'MRP: ',
//                style: TextStyle(
//                  color: Colors.grey,
//                ),
//                children: [
//                  TextSpan(
//                    text: _product.price,
//                    style: TextStyle(
//                      color: Colors.grey,
//                      decoration: TextDecoration.lineThrough,
//                    ),
//                  ),
//                ]),
//          );
//        } else {
//          _price = Text(
//            _product.price,
//            style: TextStyle(
//              fontWeight: FontWeight.bold,
//              fontSize: 15,
//            ),
//          );
//        }
//        return _price;
//      }
//
//      Widget _discountPriceText() {
//        Widget _price;
//        if (_product.specialPrice() != '' && _product.specialPrice() != null) {
//          _price = Row(
//            mainAxisAlignment: MainAxisAlignment.start,
//            children: <Widget>[
//              Text(
//                _product.specialPrice(),
//                textAlign: TextAlign.left,
//                style: TextStyle(
//                  fontWeight: FontWeight.bold,
//                  fontSize: 15.0,
//                ),
//              ),
//              Constants.width(10.0),
//            ],
//          );
//        } else {
//          _price = Container();
//        }
//        return _price;
//      }
//
//      Widget _savedPrice() {
//        Widget _priceWidget;
//        if (_product.specialPrice() != '' && _product.savedPrice != null) {
//          _priceWidget = Container(
//            padding: EdgeInsets.all(1.0),
//            child: Text(_product.savedPrice.toString() + "% off"),
//            decoration: BoxDecoration(
//              color: Colors.red,
//              borderRadius: BorderRadius.circular(2),
//            ),
//          );
//        } else {
//          _priceWidget = Container();
//        }
//        return _priceWidget;
//      }
//
//      Widget _priceAndDiscount() {
//        return Row(
//          mainAxisAlignment: MainAxisAlignment.start,
//          children: <Widget>[
//            _discountPriceText(),
//            _itemRealPriceText(),
//            Constants.width(10.0),
//            _savedPrice(),
//          ],
//        );
//      }
//
//      Text _inclusive = Text(
//        "(Inclusive of all taxes)",
//        style: TextStyle(color: Constants.grey500, fontSize: 10.0),
//      );
//
//      Widget _ratingWidget() {
//        Widget _rating;
//        if (_product.rating != null && _product.rating >= 0) {
//          _rating = Column(
//            children: <Widget>[
//              Constants.height(5),
//              InkWell(
//                onTap: () {
//                  Constants.showShortToastBuilder("Product ratings & Reviews");
//                  Navigator.push(context, MaterialPageRoute(builder: (context) {
//                    return ProductRatingsAndReviews(_product);
//                  }));
//                },
//                child: Row(
//                  mainAxisAlignment: MainAxisAlignment.start,
//                  children: <Widget>[
//                    Text(
//                      _product.rating.toString() +
//                          " Ratings & " +
//                          _product.reviews.toString(),
//                      style:
//                          TextStyle(color: Constants.myGreen, fontSize: 10.0),
//                    ),
//                    Icon(
//                      Icons.navigate_next,
//                      size: 12.0,
//                      color: Constants.myGreen,
//                    )
//                  ],
//                ),
//              ),
//            ],
//          );
//        } else {
//          _rating = Container();
//        }
//        return _rating;
//      }
//
//      Row _productImage = Row(
//        mainAxisAlignment: MainAxisAlignment.center,
//        children: <Widget>[
//          InkWell(
//            onTap: () =>
//                Navigator.push(context, MaterialPageRoute(builder: (context) {
//              return ImageViewer(_product);
//            })),
//            child: Container(
//              height: 200.0,
//              width: 200.0,
//              decoration: BoxDecoration(
//                borderRadius: BorderRadius.circular(3),
//                image: DecorationImage(
//                  image: _product.getImage(),
//                  fit: BoxFit.cover,
//                ),
//              ),
//            ),
//          ),
//        ],
//      );
//
//      Widget _availableOptionsTitle() {
//        Widget _title;
//        if (_product.textOption != null && _product.textOption != '') {
//          _title = Column(
//            crossAxisAlignment: _cStart,
//            mainAxisAlignment: _mStart,
//            children: <Widget>[
//              Text(
//                _product.textOption.toUpperCase(),
//                style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500),
//              ),
//              Constants.height(5.0),
//            ],
//          );
//        } else {
//          _title = Container();
//        }
//        return _title;
//      }
//
//      TextStyle _ddNameStyle = TextStyle(
//          fontWeight: FontWeight.w500, fontSize: 14.5, color: Colors.black);
//
//      TextStyle _richTextStyle = TextStyle(
//          fontWeight: FontWeight.w500, fontSize: 16.5, color: Colors.black);
//      TextStyle _textSpanStyle = TextStyle(
//        color: Colors.red,
//        fontWeight: FontWeight.bold,
//        fontSize: 16.5,
//      );
//
//      List<DropdownMenuItem<String>> getVariants(final Options _option) {
//        List<DropdownMenuItem<String>> items = List();
//        _option.productOptionValue.forEach((optionValue) {
//          _optionValue = ProductOptionValue.fromJson(optionValue);
//          items.add(
//            DropdownMenuItem(
//              value: _optionValue.optionValueId,
//              child: Text(
//                _optionValue.name,
//                style: TextStyle(color: Colors.green),
//              ),
//            ),
//          );
//        });
//        return items;
//      }
//
//      Widget _productSizeWidget() {
//        return Column(
//          mainAxisAlignment: MainAxisAlignment.start,
//          crossAxisAlignment: CrossAxisAlignment.start,
//          children: <Widget>[
//            Constants.height(15.0),
//            _sizeOption.required != null && _sizeOption.required != ''
//                ? RichText(
//                    text: TextSpan(
//                        text: '* ',
//                        style: _textSpanStyle,
//                        children: [
//                          TextSpan(
//                            text: _sizeOption.name,
//                            style: _richTextStyle,
//                          ),
//                        ]),
//                  )
//                : Text(
//                    _sizeOption.name,
//                    style: _ddNameStyle,
//                  ),
//            Constants.height(10.0),
//            Container(
//                width: _deviceSize.width,
//                height: 40,
//                child: DropdownButton(
//                  elevation: 0,
//                  isDense: true,
//                  isExpanded: true,
//                  iconEnabledColor: Colors.green,
//                  items: getVariants(_sizeOption),
//                  onChanged: (_size) {
//                    setState(() {
//                      this._productSize = _size;
//                      print("changed size value:= $_productSize");
//                    });
//                  },
//                  value: _productSize,
//                )),
//            Constants.height(15.0),
//          ],
//        );
//      }
//
//      Widget _productColorWidget() {
//        return Column(
//          mainAxisAlignment: MainAxisAlignment.start,
//          crossAxisAlignment: CrossAxisAlignment.start,
//          children: <Widget>[
//            Constants.height(15.0),
//            _colorOption.required != null && _colorOption.required != ''
//                ? RichText(
//              text: TextSpan(
//                  text: '* ',
//                  style: _textSpanStyle,
//                  children: [
//                    TextSpan(
//                      text: _colorOption.name,
//                      style: _richTextStyle,
//                    ),
//                  ]),
//            )
//                : Text(
//              _colorOption.name,
//              style: _ddNameStyle,
//            ),
//            Constants.height(10.0),
//            Container(
//                width: _deviceSize.width,
//                height: 40,
//                child: DropdownButton(
//                  elevation: 0,
//                  isDense: true,
//                  isExpanded: true,
//                  iconEnabledColor: Colors.green,
//                  items: getVariants(_colorOption),
//                  onChanged: (_color) {
//                    setState(() {
//                      this._productColor = _color;
//                      print("changed color value:= $_productColor");
//                    });
//                  },
//                  value: _productColor,
//                )),
//            Constants.height(15.0),
//          ],
//        );
//      }
//
//      Container _aboutTheProductTitle() {
//        return Container(
//          padding: EdgeInsets.symmetric(horizontal: 10.0),
//          child: Column(
//            crossAxisAlignment: _cStart,
//            mainAxisAlignment: _mStart,
//            children: <Widget>[
//              Text(
//                "About This Product",
//                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 19.0),
//              ),
//              Divider(
//                height: 20.0,
//              ),
//            ],
//          ),
//        );
//      }
//
//      Widget _itemSpecificsWidget() {
//        return Container(
//          padding: EdgeInsets.symmetric(horizontal: 10.0),
//          child: Column(
//            crossAxisAlignment: _cStart,
//            mainAxisAlignment: _mStart,
//            children: <Widget>[
//              Constants.height(10.0),
//              Text(
//                "Item Specifics",
//                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17.0),
//              ),
//              Constants.height(5.0),
//              Text(
//                _attribute.name,
//                style: TextStyle(color: Constants.grey500),
//              ),
//              Divider(height: 40.0),
//            ],
//          ),
//        );
//      }
//
//      Container _productDescription() {
//        return Container(
//          padding: EdgeInsets.symmetric(horizontal: 10.0),
//          child: Column(
//            crossAxisAlignment: _cStart,
//            mainAxisAlignment: _mStart,
//            children: <Widget>[
//              Constants.height(10.0),
//              Text(
//                "Product Description",
//                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17.0),
//              ),
//              Divider(height: 20.0),
//              Text(
//                _product.description,
//                style: TextStyle(color: Constants.grey500),
//              ),
//            ],
//          ),
//        );
//      }
//
//      Widget _attributeWidget() {
//        return Container(
//          padding: EdgeInsets.symmetric(horizontal: 10.0),
//          child: Column(
//            crossAxisAlignment: _cStart,
//            mainAxisAlignment: _mStart,
//            children: <Widget>[
//              Divider(height: 30.0),
//              Text(
//                _attributeGroups.name,
//                style: _ddNameStyle,
//              ),
//              Constants.height(5.0),
//              Text(
//                _attribute.name,
//                style: TextStyle(color: Constants.grey500),
//              ),
//              Constants.height(10.0),
//            ],
//          ),
//        );
//      }
//
//      _widget = SingleChildScrollView(
//        scrollDirection: Axis.vertical,
//        child: Column(
//          children: <Widget>[
//            Container(
//              color: Constants.myWhite,
//              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
//              child: Column(
//                crossAxisAlignment: CrossAxisAlignment.start,
//                mainAxisAlignment: MainAxisAlignment.start,
//                children: <Widget>[
//                  _brandName(),
//                  _productName,
//                  Constants.height(5.0),
//                  _priceAndDiscount(),
//                  Constants.height(1.0),
//                  _inclusive,
//                  _ratingWidget(),
//                  Constants.height(15.0),
//                  _productImage,
//                  Constants.height(15.0),
//                  _product.options != null && _product.options.length > 0
//                      ? _availableOptionsTitle()
//                      : Container(),
//                  _sizeOption != null ? _productSizeWidget() : Container(),
//                  _colorOption != null ? _productColorWidget() : Container(),
//                  _sizeOption != null ? _productSizeWidget() : Container(),
//                  _colorOption != null ? _productColorWidget() : Container(),
//                  _sizeOption != null ? _productSizeWidget() : Container(),
//                  _colorOption != null ? _productColorWidget() : Container(),
//                  _sizeOption != null ? _productSizeWidget() : Container(),
//                  _colorOption != null ? _productColorWidget() : Container(),
//                  _sizeOption != null ? _productSizeWidget() : Container(),
//                  _colorOption != null ? _productColorWidget() : Container(),
//                ],
//              ),
//            ),
//            Constants.height(10.0),
//            Container(
//              color: Constants.myWhite,
//              child: Column(
//                crossAxisAlignment: _cStart,
//                children: <Widget>[
//                  Constants.height(10.0),
//                  _aboutTheProductTitle(),
//                  _attributeGroups != null
//                      ? _itemSpecificsWidget()
//                      : Container(),
//                  _product.description != null
//                      ? _productDescription()
//                      : Container(),
//                  _attributeGroups != null ? _attributeWidget() : Container(),
//                  Constants.height(10.0),
//                ],
//              ),
//            ),
//          ],
//        ),
//      );
//    } else {
//      _widget = Container(
//        alignment: Alignment.center,
//        child: Text(
//          _snapshot['text_error'],
//          style: TextStyle(
//              fontSize: 18.0,
//              color: Constants.grey500,
//              fontWeight: FontWeight.w500),
//        ),
//      );
//    }
//    return _widget;
//  }
//
//  Widget _addToWishList(final bool isSaved) {
//    Widget _widget;
//    if (isSaved == false) {
//      _widget = InkWell(
//        onTap: () {
//          setState(() {
//            _isSaved = true;
//          });
//          Constants.showShortToastBuilder('Added to wish list');
//        },
//        child: Container(
//          padding: EdgeInsets.symmetric(vertical: 13.0),
//          color: Colors.black87,
//          child: Row(
//            mainAxisAlignment: MainAxisAlignment.center,
//            children: <Widget>[
//              Icon(Icons.save, color: Constants.myWhite),
//              Constants.width(5.0),
//              Text(
//                "ADD TO WISH LIST",
//                style: TextStyle(
//                    fontSize: 12.0,
//                    fontWeight: FontWeight.w500,
//                    color: Constants.myWhite),
//              ),
//            ],
//          ),
//        ),
//      );
//    } else {
//      _widget = InkWell(
//        onTap: () =>
//            Navigator.push(context, MaterialPageRoute(builder: (context) {
//          return WishList(_customerId);
//        })),
//        child: Container(
//          padding: EdgeInsets.symmetric(vertical: 13.0),
//          color: Constants.grey600,
//          child: Row(
//            mainAxisAlignment: MainAxisAlignment.center,
//            children: <Widget>[
//              Icon(Icons.save, color: Constants.myWhite),
//              Constants.width(5.0),
//              Text(
//                "VIEW WISH LIST",
//                style: TextStyle(
//                    fontSize: 12.0,
//                    fontWeight: FontWeight.w500,
//                    color: Constants.myWhite),
//              ),
//            ],
//          ),
//        ),
//      );
//    }
//    return _widget;
//  }
//
//  Widget _addButton(final bool isAdded) {
//    Widget buttonSection;
//    if (isAdded == false) {
//      buttonSection = Row(
//        children: <Widget>[
//          Expanded(
//            child: _addToWishList(_isSaved),
//          ),
//          Expanded(
//            child: InkWell(
//              onTap: () {
//                setState(() {
//                  _isAdded = true;
//                });
//                Constants.showShortToastBuilder("Item added into the kart");
//              },
//              child: Container(
//                padding: EdgeInsets.symmetric(vertical: 13.0),
//                color: Colors.redAccent,
//                child: Row(
//                  mainAxisAlignment: MainAxisAlignment.center,
//                  children: <Widget>[
//                    Icon(Icons.shopping_basket, color: Constants.myWhite),
//                    Constants.width(5.0),
//                    Text(
//                      "ADD TO BASKET",
//                      style: TextStyle(
//                          fontSize: 12.0,
//                          fontWeight: FontWeight.w500,
//                          color: Constants.myWhite),
//                    ),
//                  ],
//                ),
//              ),
//            ),
//          ),
//        ],
//      );
//    } else {
//      buttonSection = Container(
//        padding: EdgeInsets.symmetric(vertical: 7.0),
//        color: Constants.grey200,
//        child: Row(
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: <Widget>[
//            InkWell(
//              onTap: () {
//                setState(() {
//                  _isAdded = false;
//                });
//                Constants.showShortToastBuilder('Item removed');
//              },
//              child: Container(
//                padding: EdgeInsets.all(5),
//                decoration: BoxDecoration(
//                  borderRadius: BorderRadius.circular(4),
//                  border: Border.all(width: 1, color: Constants.red300),
//                ),
//                child: Icon(
//                  Icons.remove,
//                  color: Constants.red300,
//                ),
//              ),
//            ),
//            Constants.width(20.0),
//            Text(
//              numOfAddedItem.toString(),
//              style: TextStyle(
//                fontWeight: FontWeight.bold,
//                fontSize: 20,
//                color: Constants.red300,
//              ),
//            ),
//            Constants.width(20.0),
//            InkWell(
//              onTap: () {
//                Constants.showShortToastBuilder('Item added');
//              },
//              child: Container(
//                padding: EdgeInsets.all(5),
//                decoration: BoxDecoration(
//                  borderRadius: BorderRadius.circular(4),
//                  border: Border.all(width: 1, color: Constants.red300),
//                ),
//                child: Icon(
//                  Icons.add,
//                  color: Constants.red300,
//                ),
//              ),
//            ),
//          ],
//        ),
//      );
//    }
//    return buttonSection;
//  }
//}

/*
// Form Validation check logic
void validator(BuildContext context) {
  if (biz_name.text != '' &&
      _bizCatSelVal != '' &&
      contact_name.text != '' &&
      mobile_number.text != '' &&
      _citySelVal != '' &&
      _pinCodeSelVal != '')
    return nextPage(context);
  else
    return null;
}*/

//import 'dart:ffi';
//import 'dart:io';
//
//import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter_form_builder/flutter_form_builder.dart';
//import 'package:gwaliorkart/models/cart_data.dart';
//import 'package:gwaliorkart/models/product_detail_model.dart';
//import 'package:gwaliorkart/models/wish_list_data.dart';
//import 'package:gwaliorkart/screens/basket.dart';
//import 'package:gwaliorkart/screens/image_viewer.dart';
//import 'package:gwaliorkart/screens/login.dart';
//import 'package:gwaliorkart/screens/search_screen.dart';
//import 'package:gwaliorkart/utils/auth_utils.dart';
//import 'package:gwaliorkart/utils/constants.dart';
//import 'package:gwaliorkart/widgets/widget_page.dart';
//import 'package:image_picker/image_picker.dart';
//import 'package:intl/intl.dart';
//import 'dart:math';
//
//class ProductDetails extends StatefulWidget {
//  final Map<String, dynamic> snapshot;
//
//  ProductDetails(this.snapshot);
//
//  @override
//  _ProductDetailsState createState() => _ProductDetailsState();
//}
//
//class _ProductDetailsState extends State<ProductDetails>
//    with SingleTickerProviderStateMixin {
//  CrossAxisAlignment _cStart = CrossAxisAlignment.start;
//  MainAxisAlignment _mStart = MainAxisAlignment.start;
//  CrossAxisAlignment _cCenter = CrossAxisAlignment.center;
//  MainAxisAlignment _mCenter = MainAxisAlignment.center;
//  ScrollController _scrollBottomBarController;
//  TextEditingController _textController,
//      _textAreaController,
//      _dateController,
//      _dateTimeController,
//      _timeController;
//  Map<String, dynamic> _selectedProduct;
//  ProductDetailData _product;
//  Options _options;
//  Options _selectOption;
//  Options _radioOption;
//  Options _checkboxOption;
//  Options _textOption;
//  Options _textAreaOption;
//  Options _fileOption;
//  Options _dateOption;
//  Options _dateTimeOption;
//  Options _timeOption;
//  ProductOptionValue _optionValue;
//  AttributeGroups _attributeGroups;
//  Attribute _attribute;
//  bool _isAdded = false,
//      _isSaved = false,
//      _autoValidate = false,
//      _productInWishList = false,
//      _fileError = false;
//  int _quantity, _itemInCart, _productCartId;
//  TextStyle myStyle = TextStyle(fontFamily: 'Gotham', fontSize: 13);
//  TextStyle myStyleSmall =
//  TextStyle(fontFamily: 'Gotham', fontSize: 12, color: Colors.grey[600]);
//  String _customerId,
//      _vouchers,
//      _coupon,
//      _reward,
//      _selectInput,
//      _radioInput,
//      _costPrice,
//      _imageCode = '',
//      _date,
//      _time,
//      _dateTime,
//      _sellingPrice,
//      _savedPercent,
//      _productImage,
//      _cartId;
//  Size _deviceSize;
//  File _image;
//  final DateFormat _dateFormat = DateFormat("yyyy-MM-dd"),
//      _dateTimeFormat = DateFormat("yyyy-MM-dd HH:mm"),
//      _timeFormat = DateFormat("HH:mm");
//  final GlobalKey<FormBuilderState> _radioKey = GlobalKey<FormBuilderState>();
//  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
//  List<dynamic> optionList = [], _checkInput = [];
//  List<int> _cartIdDic = [];
//  CartProductsData _cartProductsData;
//
//  @override
//  void initState() {
//    _customerId = AuthUtils.userId;
//    _textController = TextEditingController();
//    _textAreaController = TextEditingController();
//    _dateController = TextEditingController(text: Constants.currentDate);
//    _dateTimeController =
//        TextEditingController(text: Constants.currentDateTime);
//    _timeController = TextEditingController(text: Constants.currentTime);
//    if (widget.snapshot != null) {
//      _selectedProduct = widget.snapshot;
//      _product = ProductDetailData.fromJson(widget.snapshot);
//      _product.productInWishList == 1
//          ? _productInWishList = true
//          : _productInWishList = false;
//      _product.price != null && _product.price != '' ? _costPrice = _product.price : _costPrice = '';
//      _product.thumb != null && _product.thumb != ''
//          ? _productImage = _product.thumb
//          : _productImage = '';
//      _quantity = 1;
//    }
//    _date = DateTime.now().toLocal().toString().split(" ")[0];
//    _getCartListData();
//    super.initState();
//  }
//
//  Future<dynamic> _getCartListData() async {
//    await CartUtils.getCartList(
//        _customerId != null && _customerId != "" ? _customerId : "-",
//        _vouchers != null && _vouchers != "" ? _vouchers : "-",
//        _coupon != null && _coupon != "" ? _coupon : "-",
//        _reward != null && _reward != "" ? _reward : "-")
//        .then((dynamic _response) async {
//      if (_response != null) {
//        if (_response.containsKey('text_count')) {
//          setState(() {
//            _itemInCart = _response['text_count'];
//          });
//        }
//      }
//    }).catchError((_onError) {
//      print("\ngetCartData catchError:=> $_onError\n");
//    });
//  }
//
//  Future<dynamic> _getCartListDataOnAdd() async {
//    await CartUtils.getCartList(
//        _customerId != null && _customerId != "" ? _customerId : "-",
//        _vouchers != null && _vouchers != "" ? _vouchers : "-",
//        _coupon != null && _coupon != "" ? _coupon : "-",
//        _reward != null && _reward != "" ? _reward : "-")
//        .then((dynamic _response) async {
//      if (_response != null) {
//        if (_response.containsKey('text_count')) {
//          if (_response.containsKey('products') &&
//              _response['products'] != null &&
//              _response['products'].length > 0) {
//            _response['products'].forEach((dynamic _products) {
//              if (_products['id'] == _product.productId.toString()) {
//                setState(() {
//                  _cartProductsData = CartProductsData.fromJson(_products);
//                  _itemInCart = _response['text_count'];
//                  _cartIdDic.add(int.parse(_cartProductsData.cartId));
//                });
//              }
//            });
//            setState(() {
//              _productCartId = _cartIdDic.reduce(max);
//            });
//            _response['products'].forEach((dynamic _products) {
//              if (_products['cart_id'] == _productCartId.toString()) {
//                setState(() {
//                  _cartProductsData = CartProductsData.fromJson(_products);
//                  _quantity = _cartProductsData.quantity;
//                  _cartId = _cartProductsData.cartId;
//                  _itemInCart = _response['text_count'];
//                });
//              }
//            });
//          }
//        }
//      }
//    }).catchError((_onError) {
//      print("\n_getCartListDataOnAdd catchError:=> $_onError\n");
//    });
//  }
//
//  Future<dynamic> _getCartListDataOnUpdate() async {
//    await CartUtils.getCartList(
//        _customerId != null && _customerId != "" ? _customerId : "-",
//        _vouchers != null && _vouchers != "" ? _vouchers : "-",
//        _coupon != null && _coupon != "" ? _coupon : "-",
//        _reward != null && _reward != "" ? _reward : "-")
//        .then((dynamic _response) async {
//      if (_response != null) {
//        if (_response.containsKey('text_count')) {
//          if (_response.containsKey('products') &&
//              _response['products'] != null &&
//              _response['products'].length > 0) {
//            _response['products'].forEach((dynamic _products) {
//              if (_products['cart_id'] == _productCartId.toString()) {
//                setState(() {
//                  _cartProductsData = CartProductsData.fromJson(_products);
//                  _quantity = _cartProductsData.quantity;
//                  _cartId = _cartProductsData.cartId;
//                  _itemInCart = _response['text_count'];
//                });
//              }
//            });
//          }
//        }
//      }
//    }).catchError((_onError) {
//      print("\n_getCartListDataOnAdd catchError:=> $_onError\n");
//    });
//  }
//
//  Future _firstTimeAddToCart(BuildContext context) async {
//    if (_product.options != null && _product.options.length > 0) {
//      if (_formKey.currentState.validate()) {
//        _formKey.currentState.save();
//
//        if (_imageCode != null && _imageCode != '') {
//          setState(() {
//            _fileError = false;
//          });
//          Constants.showMessageLoader(context, 'Please wait item is adding...');
//          _product.options.forEach((_optionItem) {
//            if (_optionItem != null && _optionItem.length > 0) {
//              _options = Options.fromJson(_optionItem);
//              if (_options.type == 'select') {
//                optionList.add({_options.productOptionId: _selectInput});
//              } else if (_options.type == 'radio') {
//                optionList.add({_options.productOptionId: _radioInput});
//              } else if (_options.type == 'checkbox') {
//                optionList.add({
//                  _options.productOptionId: [
//                    _options.productOptionValue[0]['product_option_value_id']
//                  ]
//                });
//              } else if (_options.type == 'text') {
//                optionList.add({_options.productOptionId: _textController.text});
//              } else if (_options.type == 'textarea') {
//                optionList
//                    .add({_options.productOptionId: _textAreaController.text});
//              } else if (_options.type == 'file') {
//                optionList.add({_options.productOptionId: _imageCode});
//              } else if (_options.type == 'date') {
//                optionList.add({_options.productOptionId: _dateController.text});
//              } else if (_options.type == 'datetime') {
//                optionList
//                    .add({_options.productOptionId: _dateTimeController.text});
//              } else if (_options.type == 'time') {
//                optionList.add({_options.productOptionId: _timeController.text});
//              }
//            }
//          });
//          CartData _cartParams = CartData(
//              _product.productId,
//              _customerId,
//              _quantity,
//              optionList,
//              _vouchers != null ? _vouchers : "",
//              _coupon != null ? _coupon : "",
//              _reward != null ? _reward : "",
//              null);
//          await CartUtils.addToCart(_cartParams).then((dynamic _cartRes) async {
//            if (_cartRes != null && _cartRes.containsKey("success")) {
//              await _getCartListDataOnAdd();
//              setState(() {
//                _isAdded = true;
//                _itemInCart = _cartRes['count'];
//              });
//              Navigator.of(context).pop();
//              Constants.showShortToastBuilder(_cartRes["success"]);
//            } else if (_cartRes.containsKey("error")) {
//              Navigator.of(context).pop();
//              Constants.showShortToastBuilder(_cartRes["error"]);
//            }
//          }).catchError((_err) {
//            Navigator.of(context).pop();
//            print('addToCart catchError:= $_err');
//            Constants.showShortToastBuilder('Oops something is wrong..');
//          });
//          optionList.clear();
//        } else {
//          setState(() {
//            _fileError = true;
//          });
//        }
//
//      } else {
//        setState(() {
//          _autoValidate = true; //enable realtime validation
//        });
//      }
//    } else {
//      Constants.showMessageLoader(context, 'Please wait item is adding...');
//      CartData _cartParams = CartData(
//          _product.productId,
//          _customerId,
//          _quantity,
//          optionList,
//          _vouchers != null ? _vouchers : "",
//          _coupon != null ? _coupon : "",
//          _reward != null ? _reward : "",
//          null);
//
//      await CartUtils.addToCart(_cartParams).then((dynamic _cartRes) async {
//        if (_cartRes != null && _cartRes.containsKey("success")) {
//          await _getCartListDataOnAdd();
//          setState(() {
//            _isAdded = true;
//            _itemInCart = _cartRes['count'];
//          });
//          Navigator.of(context).pop();
//          Constants.showShortToastBuilder(_cartRes["success"]);
//        } else if (_cartRes.containsKey("error")) {
//          Navigator.of(context).pop();
//          Constants.showShortToastBuilder(_cartRes["error"]);
//        }
//      }).catchError((_err) {
//        Navigator.of(context).pop();
//        print('addToCart catchError:= $_err');
//        Constants.showShortToastBuilder('Oops something is wrong..');
//      });
//      optionList.clear();
//    }
//  }
//
//  Future<void> _buyNowAddToCart(BuildContext context) async {
//    if (_product.options != null && _product.options.length > 0) {
//      if (_formKey.currentState.validate()) {
//        _formKey.currentState.save();
//
//        if (_imageCode != null && _imageCode != '') {
//          setState(() {
//            _fileError = false;
//          });
//          Constants.showLoadingIndicator(context);
//          _product.options.forEach((_optionItem) {
//            if (_optionItem != null && _optionItem.length > 0) {
//              _options = Options.fromJson(_optionItem);
//              if (_options.type == 'select') {
//                optionList.add({_options.productOptionId: _selectInput});
//              } else if (_options.type == 'radio') {
//                optionList.add({_options.productOptionId: _radioInput});
//              } else if (_options.type == 'checkbox') {
//                optionList.add({
//                  _options.productOptionId: [
//                    _options.productOptionValue[0]['product_option_value_id']
//                  ]
//                });
//              } else if (_options.type == 'text') {
//                optionList
//                    .add({_options.productOptionId: _textController.text});
//              } else if (_options.type == 'textarea') {
//                optionList
//                    .add({_options.productOptionId: _textAreaController.text});
//              } else if (_options.type == 'file') {
//                optionList.add({_options.productOptionId: _imageCode});
//              } else if (_options.type == 'date') {
//                optionList
//                    .add({_options.productOptionId: _dateController.text});
//              } else if (_options.type == 'datetime') {
//                optionList
//                    .add({_options.productOptionId: _dateTimeController.text});
//              } else if (_options.type == 'time') {
//                optionList
//                    .add({_options.productOptionId: _timeController.text});
//              }
//            }
//          });
//          if (!_isAdded) {
//            CartData _cartParams = CartData(
//                _product.productId,
//                _customerId,
//                _quantity,
//                optionList,
//                _vouchers != null ? _vouchers : "",
//                _coupon != null ? _coupon : "",
//                _reward != null ? _reward : "",
//                null);
//            await CartUtils.addToCart(_cartParams).then((dynamic _cartRes) {
//              if (_cartRes != null && _cartRes.containsKey("success")) {
//                setState(() {
//                  _itemInCart = _cartRes['count'];
//                });
//                Constants.showShortToastBuilder(_cartRes["success"]);
//                Navigator.push(context, MaterialPageRoute(builder: (context) {
//                  return Basket(_scrollBottomBarController);
//                }));
//              } else if (_cartRes.containsKey("error")) {
//                Navigator.of(context).pop();
//                Constants.showShortToastBuilder(_cartRes["error"]);
//              }
//            }).catchError((_err) {
//              Navigator.of(context).pop();
//              print('addToCart catchError:= $_err');
//              Constants.showShortToastBuilder('Oops something is wrong..');
//            });
//          } else {
//            Navigator.push(context, MaterialPageRoute(builder: (context) {
//              return Basket(_scrollBottomBarController);
//            }));
//          }
//          optionList.clear();
//        } else {
//          setState(() {
//            _fileError = true;
//          });
//        }
//      } else {
//        setState(() {
//          _autoValidate = true; //enable realtime validation
//        });
//      }
//    } else {
//      Constants.showLoadingIndicator(context);
//      if (!_isAdded) {
//        CartData _cartParams = CartData(
//            _product.productId,
//            _customerId,
//            _quantity,
//            optionList,
//            _vouchers != null ? _vouchers : "",
//            _coupon != null ? _coupon : "",
//            _reward != null ? _reward : "",
//            null);
//        await CartUtils.addToCart(_cartParams).then((dynamic _cartRes) {
//          if (_cartRes != null && _cartRes.containsKey("success")) {
//            Constants.showShortToastBuilder(_cartRes["success"]);
//            Navigator.push(context, MaterialPageRoute(builder: (context) {
//              return Basket(_scrollBottomBarController);
//            }));
//          } else if (_cartRes.containsKey("error")) {
//            Navigator.of(context).pop();
//            Constants.showShortToastBuilder(_cartRes["error"]);
//          }
//        }).catchError((_err) {
//          Navigator.of(context).pop();
//          print('addToCart catchError:= $_err');
//          Constants.showShortToastBuilder('Oops something is wrong..');
//        });
//      } else {
//        Navigator.push(context, MaterialPageRoute(builder: (context) {
//          return Basket(_scrollBottomBarController);
//        }));
//      }
//      optionList.clear();
//    }
//  }
//
//  Future<dynamic> _removeFromCart(
//      final String _cartId, final String _customerId) async {
//    Constants.showMessageLoader(context, 'Please wait item is removing...');
//    CartData _removeParams =
//    CartData(null, _customerId, null, null, null, null, null, _cartId);
//    await CartUtils.removeCart(_removeParams).then((dynamic _removeRes) async {
//      if (_removeRes != null && _removeRes.containsKey("success")) {
//        await _getCartListDataOnUpdate();
//        await _getCartListData();
//        setState(() {
//          _isAdded = false;
//        });
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
//    Constants.showMessageLoader(context, 'Please wait item is updating...');
//    CartData _addParams = CartData(null, null, _addBtn.quantity + 1, null, null,
//        null, null, _addBtn.cartId);
//    await CartUtils.editCart(_addParams).then((dynamic _addRes) async {
//      if (_addRes != null && _addRes.containsKey("success")) {
//        await _getCartListDataOnUpdate();
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
//  Future<dynamic> _updateToRemove(final CartProductsData _removeBtn) async {
//    Constants.showMessageLoader(context, 'Please wait item is updating...');
//    CartData _addParams = CartData(null, null, _removeBtn.quantity - 1, null,
//        null, null, null, _removeBtn.cartId);
//    await CartUtils.editCart(_addParams).then((dynamic _addRes) async {
//      if (_addRes != null && _addRes.containsKey("success")) {
//        await _getCartListDataOnUpdate();
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
//  Future<dynamic> _addRemoveWishListBuilder() async {
//    if (!_productInWishList) {
//      if (AuthUtils.authToken == null) {
//        Constants.showShortToastBuilder('Please Login to add to wish list');
//        Navigator.push(context, MaterialPageRoute(builder: (context) {
//          return Login();
//        }));
//      } else {
//        WishListData _listParam =
//        WishListData(_product.productId.toString(), _customerId);
//        await WishListUtils.addToWishList(_listParam)
//            .then((dynamic _listRes) async {
//          if (_listRes != null && _listRes.containsKey("success")) {
//            setState(() {
//              _productInWishList = true;
//            });
//            Constants.showShortToastBuilder('Item added to wish list.');
//          } else {
//            Constants.showShortToastBuilder('Add to wish list failed!');
//          }
//        }).catchError((_onError) {
//          print("\naddToWishList catchError:=> $_onError\n");
//        });
//      }
//    } else {
//      await WishListUtils.removeWishList(_product.productId, _customerId)
//          .then((dynamic _removeRes) async {
//        if (_removeRes != null && _removeRes.containsKey("success")) {
//          setState(() {
//            _productInWishList = false;
//          });
//          Constants.showShortToastBuilder('Item deleted from wish list!');
//        } else {
//          Constants.showShortToastBuilder('remove to wish list failed!');
//        }
//      }).catchError((_onError) {
//        print("\nremoveWishList catchError:=> $_onError\n");
//        Constants.showShortToastBuilder('Oops! Something went wrong');
//      });
//    }
//  }
//
//  Future<dynamic> _uploadFile(BuildContext context) async {
//    Constants.showLoadingIndicator(context);
//    UploadFileData _fileParam = UploadFileData(_image);
//    await UploadFileUtils.uploadFile(_fileParam).then((dynamic _fileRes) async {
//      if (_fileRes != null && _fileRes != '' && _fileRes.containsKey("code")) {
//        setState(() {
//          _imageCode = _fileRes['code'];
//          if (_imageCode != null && _imageCode != '') {
//            setState(() {
//              _fileError = false;
//            });
//          }
//        });
//        Navigator.of(context).pop();
//        Constants.showLongToastBuilder('Your file was successfully uploaded.');
//      } else {
//        Navigator.of(context).pop();
//        Constants.showShortToastBuilder('File upload failed');
//      }
//    }).catchError((_err) {
//      Navigator.of(context).pop();
//      print('\n_uploadFile catchError:= $_err\n');
//    });
//  }
//
//  AppBar _appBar() {
//    return AppBar(
//      centerTitle: true,
//      title: Text(
//        "Item Details",
//        style: TextStyle(color: Constants.myWhite, fontSize: 16.0),
//      ),
//      actions: <Widget>[
//        IconButton(
//          icon: Icon(
//            Icons.search,
//            size: 25.0,
//          ),
//          onPressed: () async =>
//              Navigator.push(context, MaterialPageRoute(builder: (context) {
//                return SearchScreen();
//              })),
//        ),
//        /*IconButton(
//          icon: Icon(
//            Icons.share,
//            size: 25.0,
//          ),
//          onPressed: () {},
//        ),
//        IconButton(
//          icon: Icon(
//            Icons.shopping_basket,
//            size: 25.0,
//          ),
//          onPressed: () =>
//              Navigator.push(context, MaterialPageRoute(builder: (context) {
//            return Basket(_scrollBottomBarController);
//          })),
//        ),*/
//        WidgetPage.shoppingCartIconButton(
//            context, _itemInCart, _scrollBottomBarController),
//      ],
//    );
//  }
//
//  Widget _productDetailViewBuilder(Map<String, dynamic> snapshot) {
//    if (snapshot.containsKey('text_error')) {
//      return WidgetPage.errorWidget(snapshot);
//    } else {
//
//      Widget productImageWidget() {
//        return Stack(
//          children: <Widget>[
//            Container(
//              child: Row(
//                mainAxisAlignment: MainAxisAlignment.center,
//                children: <Widget>[
//                  Center(
//                    child: Container(
//                      alignment: Alignment.center,
//                      height: 300,
//                      width: 220,
//                      child: InkWell(
//                        onTap: () => Navigator.push(context,
//                            MaterialPageRoute(builder: (context) {
//                              return ImageViewer(_product);
//                            })),
//                        child: FadeInImage(
//                          fit: BoxFit.fill,
//                          image: NetworkImage(
//                              _product.thumb != null && _product.thumb != ''
//                                  ? _product.thumb
//                                  : ''),
//                          placeholder: AssetImage(
//                              'assets/placeholders/no-product-image.png'),
//                        ),
//                      ),
//                    ),
//                  )
//                ],
//              ),
//            ),
//            Container(
//              alignment: Alignment.topRight,
//              child: IconButton(
//                padding: EdgeInsets.only(top: 40, right: 15.0),
//                alignment: Alignment.topRight,
//                icon: Icon(Icons.favorite),
//                color: _productInWishList ? Colors.orange : Colors.grey,
//                onPressed: () async => _addRemoveWishListBuilder(),
//              ),
//            )
//          ],
//        );
//      }
//
//      Widget _discountPriceText() {
//        Widget _price;
//        if (_product.specialPrice() != '') {
//          _price = Row(
//            mainAxisAlignment: MainAxisAlignment.start,
//            children: <Widget>[
//              Text(
//                _product.specialPrice(),
//                textAlign: TextAlign.left,
//                style: TextStyle(
//                  fontWeight: FontWeight.bold,
//                  fontSize: 15.0,
//                ),
//              ),
//              Constants.width(10.0),
//            ],
//          );
//        } else {
//          _price = Container();
//        }
//        return _price;
//      }
//
//      Widget _itemRealPriceText() {
//        Widget _price;
//        if (_product.specialPrice() != '') {
//          _price = RichText(
//            textAlign: TextAlign.center,
//            text: TextSpan(
//                text: 'MRP: ',
//                style: TextStyle(
//                  color: Colors.grey,
//                ),
//                children: [
//                  TextSpan(
//                    text: _costPrice,
//                    style: TextStyle(
//                      color: Colors.grey,
//                      decoration: TextDecoration.lineThrough,
//                    ),
//                  ),
//                ]),
//          );
//        } else {
//          _price = Text(
//            _costPrice,
//            style: TextStyle(
//              fontWeight: FontWeight.bold,
//              fontSize: 15,
//            ),
//          );
//        }
//        return _price;
//      }
//
//      Widget _savedPrice() {
//        Widget _priceWidget;
//        if (_product.specialPrice() != '' && _product.savedPrice != null) {
//          _priceWidget = Container(
//            padding: EdgeInsets.all(1.0),
//            child: Text(_product.savedPrice.toString() + "% off"),
//            decoration: BoxDecoration(
//              color: Colors.red,
//              borderRadius: BorderRadius.circular(2),
//            ),
//          );
//        } else {
//          _priceWidget = Container();
//        }
//        return _priceWidget;
//      }
//
//      Widget _buildPriceAndDiscountWidget() {
//        return Row(
//          mainAxisAlignment: MainAxisAlignment.start,
//          children: <Widget>[
//            _discountPriceText(),
//            _itemRealPriceText(),
//            Constants.width(10.0),
//            _savedPrice(),
//          ],
//        );
//      }
//
//      TextStyle _ddNameStyle = TextStyle(
//          fontWeight: FontWeight.w500, fontSize: 14.5, color: Colors.black);
//      TextStyle _radioTextStyle = TextStyle(
//          fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black);
//      TextStyle _richTextStyle = TextStyle(
//          fontWeight: FontWeight.w500, fontSize: 16.5, color: Colors.black);
//      TextStyle _textSpanStyle = TextStyle(
//        color: Colors.red,
//        fontWeight: FontWeight.bold,
//        fontSize: 16.5,
//      );
//      TextStyle _labelStyle = TextStyle(
//          color: Constants.myGreen,
//          letterSpacing: 0.5,
//          fontWeight: FontWeight.w500);
//
//      Widget _selectTypeWidget(final Options _selectData) {
//        if (_selectInput == null) {
//          setState(() {
//            _selectInput =
//            _selectData.productOptionValue[0]['product_option_value_id'];
////            _costPrice = _selectData.productOptionValue[0]['price'];
//            _selectData.productOptionValue[0]['price'] != '' &&
//                _selectData.productOptionValue[0]['price'] != 'false'
//                ? _costPrice = _selectData.productOptionValue[0]['price']
//                : _costPrice = _costPrice;
//          });
//        }
//        return Column(
//          mainAxisAlignment: _mStart,
//          crossAxisAlignment: _cStart,
//          children: <Widget>[
//            Constants.height(20.0),
//            _selectData.required != null && _selectData.required != ''
//                ? RichText(
//              text:
//              TextSpan(text: '* ', style: _textSpanStyle, children: [
//                TextSpan(
//                  text: _selectData.name,
//                  style: _richTextStyle,
//                ),
//              ]),
//            )
//                : Text(
//              _selectData.name,
//              style: _ddNameStyle,
//            ),
//            Constants.height(10.0),
//            Container(
//              width: _deviceSize.width,
//              child: DropdownButtonFormField(
//                value: _selectInput,
//                elevation: 0,
//                isDense: true,
//                isExpanded: true,
//                iconEnabledColor: Colors.green,
//                items: WidgetPage.selectMenuItems(_selectData),
//                onChanged: (_newSelectVal) {
//                  _selectData.productOptionValue.forEach((optionElement) {
//                    ProductOptionValue _optionElement =
//                    ProductOptionValue.fromJson(optionElement);
//                    if (_optionElement.productOptionValueId == _newSelectVal) {
//                      setState(() {
//                        _selectInput = _newSelectVal;
//                        _optionElement.price != '' &&
//                            _optionElement.price != 'false'
//                            ? _costPrice = _optionElement.price
//                            : _costPrice = _product.price;
//                        _optionElement.image != '' &&
//                            _optionElement.image != null
//                            ? _productImage = _optionElement.image
//                            : _productImage =
//                        _product.thumb != null && _product.thumb != ''
//                            ? _product.thumb
//                            : '';
//                      });
//                    }
//                  });
//                },
//                validator: (String _value) {
//                  if (_selectData.required == '1') {
//                    if (_value == null) {
//                      return 'Please select an option!';
//                    }
//                  }
//                  return null;
//                },
//              ),
//            ),
//            Constants.height(20.0),
//          ],
//        );
//      }
//
//      Widget _radioTypeWidget(final Options _radioData) {
//        if (_radioInput == null) {
//          setState(() {
//            this._radioInput =
//            _radioData.productOptionValue[0]['product_option_value_id'];
//          });
//        }
//        return Column(
//          mainAxisAlignment: _mStart,
//          crossAxisAlignment: _cStart,
//          children: <Widget>[
//            Constants.height(10.0),
//            FormBuilder(
//              // context,
//              key: _radioKey, autovalidate: true,
//              readOnly: false,
//              child: Column(crossAxisAlignment: _cStart, children: <Widget>[
//                _radioData.required != null && _radioData.required != ''
//                    ? RichText(
//                  text: TextSpan(
//                      text: '* ',
//                      style: _textSpanStyle,
//                      children: [
//                        TextSpan(
//                          text: _radioData.name,
//                          style: _richTextStyle,
//                        ),
//                      ]),
//                )
//                    : Text(
//                  _radioData.name,
//                  style: _ddNameStyle,
//                ),
//                FormBuilderRadioGroup(
//                  initialValue: _radioInput,
//                  attribute: "best_language",
//                  activeColor: Constants.myGreen,
//                  options: WidgetPage.radioButton(_radioData),
//                  onChanged: (_newRadioVal) {
//                    _radioData.productOptionValue.forEach((optionElement) {
//                      ProductOptionValue _optionElement =
//                      ProductOptionValue.fromJson(optionElement);
//                      if (_optionElement.productOptionValueId == _newRadioVal) {
//                        setState(() {
//                          _radioInput = _newRadioVal;
//                          _optionElement.price != '' &&
//                              _optionElement.price != 'false'
//                              ? _costPrice = _optionElement.price
//                              : _costPrice = _product.price;
//                          _optionElement.image != '' &&
//                              _optionElement.image != null
//                              ? _productImage = _optionElement.image
//                              : _productImage =
//                          _product.thumb != null && _product.thumb != ''
//                              ? _product.thumb
//                              : '';
//                        });
//                      }
//                    });
//                  },
//                  validators: [
//                    _radioData.required == '1'
//                        ? FormBuilderValidators.required(
//                        errorText: 'Please select an ' +
//                            _radioData.name.toLowerCase() +
//                            '!')
//                        : null,
//                  ],
//                ),
//              ]),
//            ),
//            Constants.height(20.0),
//          ],
//        );
//      }
//
//      Widget _checkboxTypeWidget(final Options _checkboxData) {
//        if(_checkInput == null){
//          _checkInput = _checkboxData.productOptionValue[0]['product_option_value_id'];
//        }
//        return Column(
//          mainAxisAlignment: _mStart,
//          crossAxisAlignment: _cStart,
//          children: <Widget>[
//            Constants.height(20.0),
//            _checkboxData.required != null && _checkboxData.required != ''
//                ? RichText(
//              text:
//              TextSpan(text: '* ', style: _textSpanStyle, children: [
//                TextSpan(
//                  text: _checkboxData.name,
//                  style: _richTextStyle,
//                ),
//              ]),
//            )
//                : Text(
//              _checkboxData.name,
//              style: _ddNameStyle,
//            ),
//            Constants.height(10.0),
//            FormBuilderCheckboxGroup(
//              attribute: "tempered",
//              initialValue: _checkInput,
//              activeColor: Constants.myGreen,
//              options: WidgetPage.checkboxGroup(_checkboxData),
//              onChanged: (dynamic _newVal) {
//                setState(() {
//                  _checkInput = _newVal;
//                  print("changedLanguage:= $_checkInput");
//                });
//              },
//            ),
//            Constants.height(20.0),
//          ],
//        );
//      }
//
//      /*Widget _checkboxTypeWidget(final Options _checkboxData) {
//        return Column(
//          mainAxisAlignment: _mStart,
//          crossAxisAlignment: _cStart,
//          children: <Widget>[
//            Constants.height(20.0),
//            _checkboxData.required != null && _checkboxData.required != ''
//                ? RichText(
//              text:
//              TextSpan(text: '* ', style: _textSpanStyle, children: [
//                TextSpan(
//                  text: _checkboxData.name,
//                  style: _richTextStyle,
//                ),
//              ]),
//            )
//                : Text(
//              _checkboxData.name,
//              style: _ddNameStyle,
//            ),
//            Constants.height(10.0),
//            Container(
//              width: _deviceSize.width,
//              child: Row(
//                mainAxisAlignment: _mStart,
//                children: _checkboxButton(_checkboxData),
//              ),
//            ),
//            Constants.height(20.0),
//          ],
//        );
//      }*/
//
//      Widget _textTypeWidget(final Options _textData) {
//        return Column(
//          crossAxisAlignment: _cStart,
//          mainAxisAlignment: _mStart,
//          children: <Widget>[
//            Constants.height(20.0),
//            TextFormField(
//              controller: _textController,
//              autofocus: false,
//              cursorColor: Constants.primary_green,
//              decoration: InputDecoration(
//                focusedBorder: OutlineInputBorder(
//                  borderRadius: BorderRadius.circular(5.0),
//                  borderSide: const BorderSide(
//                      color: Constants.primary_green, width: 1.5),
//                ),
//                hintText: 'Text Field',
//                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
//                border: OutlineInputBorder(
//                    borderRadius: BorderRadius.circular(5.0)),
//              ),
//              validator: (_newText) {
//                if (_textData.required == '1') {
//                  if (_newText.isEmpty) {
//                    return 'Please enter text.';
//                  }
//                }
//                return null;
//              },
//            ),
//            Constants.height(20.0),
//          ],
//        );
//      }
//
//      Widget _textAreaTypeWidget(final Options _textAreaData) {
//        return Column(
//          crossAxisAlignment: _cStart,
//          mainAxisAlignment: _mStart,
//          children: <Widget>[
//            Constants.height(20.0),
//            TextFormField(
//              maxLines: 8,
//              maxLength: 1000,
//              controller: _textAreaController,
//              keyboardType: TextInputType.text,
//              autofocus: false,
//              cursorColor: Constants.primary_green,
//              decoration: InputDecoration(
//                focusedBorder: OutlineInputBorder(
//                  borderRadius: BorderRadius.circular(5.0),
//                  borderSide: const BorderSide(
//                      color: Constants.primary_green, width: 1.5),
//                ),
//                hintText: 'Text Area Field',
//                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
//                border: OutlineInputBorder(
//                    borderRadius: BorderRadius.circular(5.0)),
//              ),
//              validator: (_newTextArea) {
//                if (_textAreaData.required == '1') {
//                  if (_newTextArea.isEmpty) {
//                    return 'Please enter text.';
//                  }
//                }
//                return null;
//              },
//            ),
//            Constants.height(20.0),
//          ],
//        );
//      }
//
//      Future<void> _getImage() async {
//        await ImagePicker.pickImage(
//          source: ImageSource.gallery,
//        ).then((final File _res) async {
//          print("Selected File:= $_res");
//          if (_res != null) {
//            setState(() {
//              _image = _res;
//            });
//            await _uploadFile(context);
//          }
//        }).catchError((_err) {
//          print("ImagePicker catchError:=> $_err");
//        });
//      }
//
//      Widget _fileTypeWidget(final Options _fileData) {
//        return Column(
//          crossAxisAlignment: _cStart,
//          children: <Widget>[
//            Constants.height(20.0),
//            FlatButton(
//              padding: EdgeInsets.symmetric(vertical: 12.0),
//              color: Constants.myGreen,
//              onPressed: () async => _getImage(),
//              child: Row(
//                mainAxisAlignment: _mCenter,
//                children: <Widget>[
//                  Icon(
//                    Icons.file_upload,
//                    color: Constants.myWhite,
//                  ),
//                  Constants.width(5.0),
//                  Text(
//                    _fileData.name,
//                    style: TextStyle(
//                      fontWeight: FontWeight.bold,
//                      color: Constants.myWhite,
//                    ),
//                  ),
//                ],
//              ),
//            ),
//            _fileData.required == '1'
//                ? _fileError
//                ? Container(
//              padding: EdgeInsets.only(top: 3.0),
//              child: Text(
//                "This field is required.",
//                overflow: TextOverflow.ellipsis,
//                style: TextStyle(
//                    fontSize: 12.0,
//                    color: Colors.red,
//                    letterSpacing: 0.5),
//              ),
//            )
//                : Container()
//                : Container(),
//            Constants.height(20.0),
//          ],
//        );
//      }
//
//      Widget _dateTypeWidget(final Options _dateData) {
//        return Column(
//          crossAxisAlignment: _cStart,
//          mainAxisAlignment: _mStart,
//          children: <Widget>[
//            Constants.height(20.0),
//            DateTimeField(
//              controller: _dateController,
//              initialValue: DateTime.now(),
//              decoration: InputDecoration(
//                labelText: 'Choose ' + _dateData.name,
//                labelStyle: _labelStyle,
//                border: OutlineInputBorder(
//                    borderRadius: BorderRadius.circular(5.0)),
//              ),
//              onChanged: (_changedDate) {
//                if (_changedDate != null) {
//                  setState(() {
//                    _date = _changedDate.toLocal().toString().split(" ")[0];
//                  });
//                }
//              },
//              format: _dateFormat,
//              onShowPicker: (context, currentValue) {
//                return showDatePicker(
//                    context: context,
//                    firstDate: DateTime(1900),
//                    initialDate: currentValue ?? DateTime.now(),
//                    lastDate: DateTime(2100));
//              },
//              validator: (DateTime _newDate) {
//                if (_dateData.required == '1') {
//                  if (_newDate == null) {
//                    return 'Please choose ' + _dateData.name + '.';
//                  }
//                }
//                return null;
//              },
//            ),
//            Constants.height(20.0),
//          ],
//        );
//      }
//
//      Widget _datetimeTypeWidget(final Options _dateTimeData) {
//        return Column(
//          children: <Widget>[
//            Constants.height(20.0),
//            DateTimeField(
//              controller: _dateTimeController,
//              initialValue: DateTime.now(),
//              decoration: InputDecoration(
//                labelText: 'Choose ' + _dateTimeData.name,
//                labelStyle: _labelStyle,
//                border: OutlineInputBorder(
//                    borderRadius: BorderRadius.circular(5.0)),
//              ),
//              onChanged: (_changedDateTime) {
//                if (_changedDateTime != null) {
//                  setState(() {
//                    _dateTime =
//                    _changedDateTime.toLocal().toString().split(".")[0];
//                  });
//                }
//              },
//              format: _dateTimeFormat,
//              onShowPicker: (context, currentValue) async {
//                final date = await showDatePicker(
//                    context: context,
//                    firstDate: DateTime(1900),
//                    initialDate: currentValue ?? DateTime.now(),
//                    lastDate: DateTime(2100));
//                if (date != null) {
//                  final time = await showTimePicker(
//                    context: context,
//                    initialTime:
//                    TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
//                  );
//                  return DateTimeField.combine(date, time);
//                } else {
//                  return currentValue;
//                }
//              },
//              validator: (DateTime _newDateTime) {
//                if (_dateTimeData.required == '1') {
//                  if (_newDateTime == null) {
//                    return 'Please choose ' + _dateTimeData.name + '.';
//                  }
//                }
//                return null;
//              },
//            ),
//            Constants.height(20.0),
//          ],
//        );
//      }
//
//      Widget _timeTypeWidget(final Options _timeData) {
//        return Column(
//          children: <Widget>[
//            Constants.height(20.0),
//            DateTimeField(
//              controller: _timeController,
//              initialValue: DateTime.now(),
//              decoration: InputDecoration(
//                labelText: 'Select ' + _timeData.name,
//                labelStyle: _labelStyle,
//                border: OutlineInputBorder(
//                    borderRadius: BorderRadius.circular(5.0)),
//              ),
//              onChanged: (_changedTime) {
//                if (_changedTime != null) {
//                  setState(() {
//                    _time = _changedTime
//                        .toLocal()
//                        .toString()
//                        .split(".")[0]
//                        .split(" ")[1];
//                  });
//                }
//              },
//              format: _timeFormat,
//              onShowPicker: (context, currentValue) async {
//                final time = await showTimePicker(
//                  context: context,
//                  initialTime:
//                  TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
//                );
//                return DateTimeField.convert(time);
//              },
//              validator: (DateTime _newTime) {
//                if (_timeData.required == '1') {
//                  if (_newTime == null) {
//                    return 'Please choose ' + _timeData.name + '.';
//                  }
//                }
//                return null;
//              },
//            ),
//            Constants.height(20.0),
//          ],
//        );
//      }
//
//      Widget _listOfOptionsWidgets(final List<dynamic> _optionsDataList) {
//        List<Widget> _optionsWidgets() {
//          List<Widget> _widgetItems = List();
//          _product.textOption != null && _product.textOption != ''
//              ? _widgetItems
//              .add(WidgetPage.availableOptionsTitle(_product.textOption))
//              : Container();
//          _optionsDataList.forEach((_optionItem) {
//            if (_optionItem != null && _optionItem.length > 0) {
//              _options = Options.fromJson(_optionItem);
//              if (_options.type == 'select') {
//                _selectOption = Options.fromJson(_optionItem);
//                if (_selectOption.productOptionValue != null &&
//                    _selectOption.productOptionValue.length > 0) {
//                  _selectOption != null
//                      ? _widgetItems.add(_selectTypeWidget(_selectOption))
//                      : Container();
//                }
//              }
//              if (_options.type == 'radio') {
//                _radioOption = Options.fromJson(_optionItem);
//                if (_radioOption.productOptionValue != null &&
//                    _radioOption.productOptionValue.length > 0) {
//                  _radioOption != null
//                      ? _widgetItems.add(_radioTypeWidget(_radioOption))
//                      : Container();
//                }
//              }
//              if (_options.type == 'checkbox') {
//                _checkboxOption = Options.fromJson(_optionItem);
//                if (_checkboxOption.productOptionValue != null &&
//                    _checkboxOption.productOptionValue.length > 0) {
//                  _checkboxOption != null
//                      ? _widgetItems.add(_checkboxTypeWidget(_checkboxOption))
//                      : Container();
//                }
//              }
//              if (_options.type == 'text') {
//                _textOption = Options.fromJson(_optionItem);
//                _textOption != null
//                    ? _widgetItems.add(_textTypeWidget(_textOption))
//                    : Container();
//              }
//              if (_options.type == 'textarea') {
//                _textAreaOption = Options.fromJson(_optionItem);
//                _textAreaOption != null
//                    ? _widgetItems.add(_textAreaTypeWidget(_textAreaOption))
//                    : Container();
//              }
//              if (_options.type == 'file') {
//                _fileOption = Options.fromJson(_optionItem);
//                _fileOption != null
//                    ? _widgetItems.add(_fileTypeWidget(_fileOption))
//                    : Container();
//              }
//              if (_options.type == 'date') {
//                _dateOption = Options.fromJson(_optionItem);
//                _dateOption != null
//                    ? _widgetItems.add(_dateTypeWidget(_dateOption))
//                    : Container();
//              }
//              if (_options.type == 'datetime') {
//                _dateTimeOption = Options.fromJson(_optionItem);
//                _dateTimeOption != null
//                    ? _widgetItems.add(_datetimeTypeWidget(_dateTimeOption))
//                    : Container();
//              }
//              if (_options.type == 'time') {
//                _timeOption = Options.fromJson(_optionItem);
//                _timeOption != null
//                    ? _widgetItems.add(_timeTypeWidget(_timeOption))
//                    : Container();
//              }
//            }
//          });
//          return _widgetItems;
//        }
//
//        return Form(
//          key: _formKey,
//          autovalidate: _autoValidate,
//          child: Column(
//            crossAxisAlignment: _cStart,
//            mainAxisAlignment: _mStart,
//            children: _optionsWidgets(),
//          ),
//        );
//      }
//
//      Widget _itemSpecificsWidget(final List<dynamic> _attributeDataList) {
//        List<Widget> _specificsWidgets() {
//          List<Widget> _specificsWidgetsItems = List();
//          _attributeDataList.forEach((_specificItem) {
//            if (_specificItem != null && _specificItem.length > 0) {
//              _attributeGroups = AttributeGroups.fromJson(_specificItem);
//              _attributeGroups != null
//                  ? _specificsWidgetsItems.add(
//                Column(
//                  crossAxisAlignment: _cStart,
//                  mainAxisAlignment: _mStart,
//                  children: <Widget>[
//                    Constants.height(10.0),
//                    Text(
//                      "Item Specifics",
//                      style: TextStyle(
//                          fontWeight: FontWeight.w500, fontSize: 17.0),
//                    ),
//                    Constants.height(5.0),
//                    Text(
//                      _attributeGroups.name,
//                      style: TextStyle(color: Constants.grey500),
//                    ),
//                    Divider(height: 40.0),
//                  ],
//                ),
//              )
//                  : Container();
//            }
//          });
//
//          return _specificsWidgetsItems;
//        }
//
//        return Container(
//          padding: EdgeInsets.symmetric(horizontal: 10.0),
//          child: Column(
//            crossAxisAlignment: _cStart,
//            mainAxisAlignment: _mStart,
//            children: _specificsWidgets(),
//          ),
//        );
//      }
//
//      Widget _attributeWidget(final List<dynamic> _attributeGroupList) {
//        List<Widget> _attributeWidgetList() {
//          List<Widget> _attributeWidgetItems = List();
//          _attributeGroupList.forEach((_attributeGroupItem) {
//            if (_attributeGroupItem != null && _attributeGroupItem.length > 0) {
//              _attributeGroups = AttributeGroups.fromJson(_attributeGroupItem);
//              if (_attributeGroups.attribute != null &&
//                  _attributeGroups.attribute.length > 0) {
//                _attributeGroups.attribute.forEach((_attributeItems) {
//                  _attribute = Attribute.fromJson(_attributeItems);
//                  _attributeGroups != null && _attribute != null
//                      ? _attributeWidgetItems.add(Column(
//                    crossAxisAlignment: _cStart,
//                    mainAxisAlignment: _mStart,
//                    children: <Widget>[
//                      Divider(height: 30.0),
//                      Text(
//                        _attributeGroups.name,
//                        style: _ddNameStyle,
//                      ),
//                      Constants.height(5.0),
//                      Text(
//                        _attribute.name,
//                        style: TextStyle(color: Constants.grey500),
//                      ),
//                      Constants.height(10.0),
//                    ],
//                  ))
//                      : Container();
//                });
//              }
//            }
//          });
//
//          return _attributeWidgetItems;
//        }
//
//        return Container(
//          padding: EdgeInsets.symmetric(horizontal: 10.0),
//          child: Column(
//            crossAxisAlignment: _cStart,
//            mainAxisAlignment: _mStart,
//            children: _attributeWidgetList(),
//          ),
//        );
//      }
//
//      return SingleChildScrollView(
//        scrollDirection: Axis.vertical,
//        child: Column(
//          crossAxisAlignment: _cStart,
//          mainAxisAlignment: _mStart,
//          children: <Widget>[
//            Container(
//              color: Constants.myWhite,
//              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
//              child: Column(
//                crossAxisAlignment: _cStart,
//                mainAxisAlignment: _mStart,
//                children: <Widget>[
//                  _product.manufacturer != null && _product.manufacturer != ''
//                      ? WidgetPage.productBrandName(_product.manufacturer)
//                      : Container(),
//                  _product.headingTitle != null && _product.headingTitle != ''
//                      ? WidgetPage.productName(_product.headingTitle)
//                      : Container(),
//                  Constants.height(5.0),
//                  _buildPriceAndDiscountWidget(),
//                  Constants.height(1.0),
//                  WidgetPage.inclusive(),
//                  _product != null
//                      ? _product.rating != null &&
//                      _product.rating != null &&
//                      _product.rating >= 0
//                      ? WidgetPage.ratingWidget(_product.rating,
//                      _product.reviews, _product, context)
//                      : Container()
//                      : Container(),
//                  _product != null ? productImageWidget() : Container(),
//                  /*Constants.height(30.0),
//                  _product != null
//                      ? _product.thumb != null
//                          ? _productImage != null
//                              ? WidgetPage.productImageWidget(
//                                  _productImage, _product, context)
//                              : Container()
//                          : Container()
//                      : Container(),
//                  Constants.height(30.0),*/
//                  _product.options != null && _product.options.length > 0
//                      ? _listOfOptionsWidgets(_product.options)
//                      : Container(),
//                ],
//              ),
//            ),
//            Constants.height(10.0),
//            Container(
//              color: Constants.myWhite,
//              child: Column(
//                crossAxisAlignment: _cStart,
//                children: <Widget>[
//                  Constants.height(10.0),
//                  WidgetPage.aboutTheProductTitle(),
//                  _product.attributeGroups != null &&
//                      _product.attributeGroups.length > 0
//                      ? _itemSpecificsWidget(_product.attributeGroups)
//                      : Container(),
//                  _product.description != null
//                      ? WidgetPage.productDescription(_product.description)
//                      : Container(),
//                  _product.attributeGroups != null &&
//                      _product.attributeGroups.length > 0
//                      ? _attributeWidget(_product.attributeGroups)
//                      : Container(),
//                  Constants.height(10.0),
//                ],
//              ),
//            ),
//          ],
//        ),
//      );
//    }
//  }
//
//  Widget _buyNowButtonWidget(final bool isSaved) {
//    return InkWell(
//      onTap: _product.stock == 'In Stock'
//          ? () async => _buyNowAddToCart(context)
//          : () {},
//      child: Container(
//        padding: EdgeInsets.symmetric(vertical: 13.0),
//        color: _product.stock == 'In Stock' ? Constants.myGreen : Colors.grey,
//        child: Row(
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: <Widget>[
//            Icon(
//                _product.stock == 'In Stock'
//                    ? Icons.shopping_cart
//                    : Icons.remove_shopping_cart,
//                color: Constants.myWhite),
//            Constants.width(5.0),
//            Text(
//              _product != null
//                  ? _product.stock == 'In Stock' ? 'BUY NOW' : 'OUT OF STOCK'
//                  : "BUY NOW",
//              style: TextStyle(
//                fontSize: 12.0,
//                fontWeight: FontWeight.w500,
//                color: Constants.myWhite,
//              ),
//            ),
//          ],
//        ),
//      ),
//    );
//  }
//
//  Widget _addToCartButtonWidget(final bool _isCartAdded) {
//    Widget _cartWidget;
//    if (_isCartAdded == false) {
//      _cartWidget = InkWell(
//        onTap: () async => _firstTimeAddToCart(context),
//        child: Container(
//          padding: EdgeInsets.symmetric(vertical: 13.0),
//          color: Colors.deepOrange,
//          child: Row(
//            mainAxisAlignment: MainAxisAlignment.center,
//            children: <Widget>[
//              Icon(Icons.shopping_basket, color: Constants.myWhite),
//              Constants.width(5.0),
//              Text(
//                _product != null && _product.buttonCart != null
//                    ? _product.buttonCart.toUpperCase()
//                    : "ADD TO BASKET",
//                style: TextStyle(
//                    fontSize: 12.0,
//                    fontWeight: FontWeight.w500,
//                    color: Constants.myWhite),
//              ),
//            ],
//          ),
//        ),
//      );
//    } else if (_isCartAdded == true) {
//      _cartWidget = Container(
//        padding: EdgeInsets.symmetric(vertical: 9.0),
//        color: Constants.grey200,
//        child: Row(
//          mainAxisAlignment: _mCenter,
//          children: <Widget>[
//            InkWell(
////              onTap: () async => _removeToCartButton(),
//              onTap: () async => _cartProductsData != null &&
//                  _cartProductsData.quantity != null
//                  ? _cartProductsData.quantity >= 2
//                  ? _updateToRemove(_cartProductsData)
//                  : _removeFromCart(
//                  _cartProductsData.cartId,
//                  _customerId != null && _customerId != ""
//                      ? _customerId
//                      : "-")
//                  : null,
//              child: Container(
//                padding: EdgeInsets.all(3),
//                decoration: BoxDecoration(
//                  borderRadius: BorderRadius.circular(4),
//                  border: Border.all(width: 1, color: Constants.red300),
//                ),
//                child: Icon(
//                  Icons.remove,
//                  color: Constants.red300,
//                ),
//              ),
//            ),
//            Constants.width(20.0),
//            Text(
//              _quantity.toString(),
//              style: TextStyle(
//                fontWeight: FontWeight.w500,
//                fontSize: 18,
//                color: Constants.red300,
//              ),
//            ),
//            Constants.width(20.0),
//            InkWell(
////              onTap: () async => _addToCartButton(),
//              onTap: () async => _cartProductsData != null &&
//                  _cartProductsData.quantity != null &&
//                  _cartProductsData.quantity > 0
//                  ? _updateToAdd(_cartProductsData)
//                  : null,
//              child: Container(
//                padding: EdgeInsets.all(3),
//                decoration: BoxDecoration(
//                  borderRadius: BorderRadius.circular(4),
//                  border: Border.all(width: 1, color: Constants.red300),
//                ),
//                child: Icon(
//                  Icons.add,
//                  color: Constants.red300,
//                ),
//              ),
//            ),
//          ],
//        ),
//      );
//    }
//    return _cartWidget;
//  }
//
//  Widget _bottomAppBarButton(final bool isSaved, final bool isAdded) {
//    return BottomAppBar(
//      elevation: 0.0,
//      child: Row(
//        children: <Widget>[
//          Expanded(
//            child: _addToCartButtonWidget(isAdded),
//          ),
//          Expanded(
//            child: _buyNowButtonWidget(isSaved),
//          ),
//        ],
//      ),
//    );
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    _deviceSize = MediaQuery.of(context).size;
//    return Scaffold(
//      appBar: _appBar(),
//      body: Container(
//        color: Constants.grey200,
//        child: _selectedProduct != null
//            ? _productDetailViewBuilder(_selectedProduct)
//            : WidgetPage.errorWidget(_selectedProduct),
//      ),
//      bottomNavigationBar: _bottomAppBarButton(_isSaved, _isAdded),
//    );
//  }
//}

import 'dart:ffi';
import 'dart:io';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:gwaliorkart/models/cart_data.dart';
import 'package:gwaliorkart/models/product_detail_model.dart';
import 'package:gwaliorkart/models/wish_list_data.dart';
import 'package:gwaliorkart/screens/auth_login.dart';
import 'package:gwaliorkart/screens/basket.dart';
import 'package:gwaliorkart/screens/image_viewer.dart';
import 'package:gwaliorkart/screens/login.dart';
import 'package:gwaliorkart/screens/search_screen.dart';
import 'package:gwaliorkart/utils/auth_utils.dart';
import 'package:gwaliorkart/utils/constants.dart';
import 'package:gwaliorkart/widgets/widget_page.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'dart:math';

class ProductDetails extends StatefulWidget {
  final Map<String, dynamic> snapshot;

  ProductDetails(this.snapshot);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails>
    with SingleTickerProviderStateMixin {
  CrossAxisAlignment _cStart = CrossAxisAlignment.start;
  MainAxisAlignment _mStart = MainAxisAlignment.start;
  CrossAxisAlignment _cCenter = CrossAxisAlignment.center;
  MainAxisAlignment _mCenter = MainAxisAlignment.center;
  ScrollController _scrollBottomBarController;
  TextEditingController _textController,
      _textAreaController,
      _dateController,
      _dateTimeController,
      _timeController;
  Map<String, dynamic> _selectedProduct;
  ProductDetailData _product;
  Options _options;
  Options _selectOption;
  Options _radioOption;
  Options _checkboxOption;
  Options _textOption;
  Options _textAreaOption;
  Options _fileOption;
  Options _dateOption;
  Options _dateTimeOption;
  Options _timeOption;
  ProductOptionValue _optionValue;
  AttributeGroups _attributeGroups;
  Attribute _attribute;
  bool _isAdded = false,
      _isSaved = false,
      _autoValidate = false,
      _productInWishList = false,
      _fileError = false,
      _isFileType = false;
  int _quantity, _itemInCart, _productCartId;
  TextStyle myStyle = TextStyle(fontFamily: 'Gotham', fontSize: 13);
  TextStyle myStyleSmall =
      TextStyle(fontFamily: 'Gotham', fontSize: 12, color: Colors.grey[600]);
  String _customerId,
      _vouchers,
      _coupon,
      _reward,
      _selectInput,
      _radioInput,
      _costPrice,
      _imageCode = '',
      _date,
      _time,
      _dateTime,
      _sellingPrice,
      _savedPercent,
      _productImage,
      _cartId;
  Size _deviceSize;
  File _image;
  final DateFormat _dateFormat = DateFormat("yyyy-MM-dd"),
      _dateTimeFormat = DateFormat("yyyy-MM-dd HH:mm"),
      _timeFormat = DateFormat("HH:mm");
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<dynamic> optionList = [], _checkInput = [];
  List<int> _cartIdDic = [];
  CartProductsData _cartProductsData;

  @override
  void initState() {
    _customerId = AuthUtils.userId;
    _textController = TextEditingController();
    _textAreaController = TextEditingController();
    _dateController = TextEditingController(text: Constants.currentDate);
    _dateTimeController =
        TextEditingController(text: Constants.currentDateTime);
    _timeController = TextEditingController(text: Constants.currentTime);
    if (widget.snapshot != null) {
      _selectedProduct = widget.snapshot;
      _product = ProductDetailData.fromJson(widget.snapshot);
      _product.productInWishList == 1
          ? _productInWishList = true
          : _productInWishList = false;
      _product.price != '' ? _costPrice = _product.price : _costPrice = '';
      _product.thumb != null && _product.thumb != ''
          ? _productImage = _product.thumb
          : _productImage = '';
      _quantity = 1;
    }
    _date = DateTime.now().toLocal().toString().split(" ")[0];
    _getCartListData();
    super.initState();
  }

  Future<dynamic> _getCartListData() async {
    await CartUtils.getCartList(
            _customerId != null && _customerId != "" ? _customerId : "-",
            _vouchers != null && _vouchers != "" ? _vouchers : "-",
            _coupon != null && _coupon != "" ? _coupon : "-",
            _reward != null && _reward != "" ? _reward : "-")
        .then((dynamic _response) async {
      if (_response != null) {
        if (_response.containsKey('text_count')) {
          setState(() {
            _itemInCart = _response['text_count'];
          });
        }
      }
    }).catchError((_onError) {
      print("\ngetCartData catchError:=> $_onError\n");
    });
  }

  Future<dynamic> _getCartListDataOnAdd() async {
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
              if (_products['id'] == _product.productId.toString()) {
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

  Future _firstTimeAddToCart(BuildContext context) async {
    if (_product.options != null && _product.options.length > 0) {
      if (_formKey.currentState.validate()) {
        _formKey.currentState.save();

        if (_isFileType) {
          if (_imageCode != null && _imageCode != '') {
            setState(() {
              _fileError = false;
            });
            Constants.showMessageLoader(
                context, 'Please wait item is adding...');
            _product.options.forEach((_optionItem) {
              if (_optionItem != null && _optionItem.length > 0) {
                _options = Options.fromJson(_optionItem);
                if (_options.type == 'select') {
                  optionList.add({_options.productOptionId: _selectInput});
                } else if (_options.type == 'radio') {
                  optionList.add({_options.productOptionId: _radioInput});
                } else if (_options.type == 'checkbox') {
                  optionList.add({_options.productOptionId: _checkInput});
                } else if (_options.type == 'text') {
                  optionList
                      .add({_options.productOptionId: _textController.text});
                } else if (_options.type == 'textarea') {
                  optionList.add(
                      {_options.productOptionId: _textAreaController.text});
                } else if (_options.type == 'file') {
                  optionList.add({_options.productOptionId: _imageCode});
                } else if (_options.type == 'date') {
                  optionList
                      .add({_options.productOptionId: _dateController.text});
                } else if (_options.type == 'datetime') {
                  optionList.add(
                      {_options.productOptionId: _dateTimeController.text});
                } else if (_options.type == 'time') {
                  optionList
                      .add({_options.productOptionId: _timeController.text});
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
            await CartUtils.addToCart(_cartParams)
                .then((dynamic _cartRes) async {
              if (_cartRes != null && _cartRes.containsKey("success")) {
                await _getCartListDataOnAdd();
                setState(() {
                  _isAdded = true;
                  _itemInCart = _cartRes['count'];
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
          } else {
            setState(() {
              _fileError = true;
            });
          }
        } else {
          Constants.showMessageLoader(context, 'Please wait item is adding...');
          _product.options.forEach((_optionItem) {
            if (_optionItem != null && _optionItem.length > 0) {
              _options = Options.fromJson(_optionItem);
              if (_options.type == 'select') {
                optionList.add({_options.productOptionId: _selectInput});
              } else if (_options.type == 'radio') {
                optionList.add({_options.productOptionId: _radioInput});
              } else if (_options.type == 'checkbox') {
                optionList.add({_options.productOptionId: _checkInput});
              } else if (_options.type == 'text') {
                optionList
                    .add({_options.productOptionId: _textController.text});
              } else if (_options.type == 'textarea') {
                optionList
                    .add({_options.productOptionId: _textAreaController.text});
              } else if (_options.type == 'file') {
                optionList.add({_options.productOptionId: _imageCode});
              } else if (_options.type == 'date') {
                optionList
                    .add({_options.productOptionId: _dateController.text});
              } else if (_options.type == 'datetime') {
                optionList
                    .add({_options.productOptionId: _dateTimeController.text});
              } else if (_options.type == 'time') {
                optionList
                    .add({_options.productOptionId: _timeController.text});
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
          await CartUtils.addToCart(_cartParams).then((dynamic _cartRes) async {
            if (_cartRes != null && _cartRes.containsKey("success")) {
              await _getCartListDataOnAdd();
              setState(() {
                _isAdded = true;
                _itemInCart = _cartRes['count'];
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
      } else {
        setState(() {
          _autoValidate = true; //enable realtime validation
        });
      }
    } else {
      Constants.showMessageLoader(context, 'Please wait item is adding...');
      CartData _cartParams = CartData(
          _product.productId,
          _customerId,
          _quantity,
          optionList,
          _vouchers != null ? _vouchers : "",
          _coupon != null ? _coupon : "",
          _reward != null ? _reward : "",
          null);

      await CartUtils.addToCart(_cartParams).then((dynamic _cartRes) async {
        if (_cartRes != null && _cartRes.containsKey("success")) {
          await _getCartListDataOnAdd();
          setState(() {
            _isAdded = true;
            _itemInCart = _cartRes['count'];
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

  /*Future _firstTimeAddToCart(BuildContext context) async {
    if (_product.options != null && _product.options.length > 0) {
      if (_formKey.currentState.validate()) {
        _formKey.currentState.save();

        Constants.showMessageLoader(context, 'Please wait item is adding...');
        _product.options.forEach((_optionItem) {
          if (_optionItem != null && _optionItem.length > 0) {
            _options = Options.fromJson(_optionItem);
            if (_options.type == 'select') {
              optionList.add({_options.productOptionId: _selectInput});
            } else if (_options.type == 'radio') {
              optionList.add({_options.productOptionId: _radioInput});
            } else if (_options.type == 'checkbox') {
              optionList.add({_options.productOptionId: _checkInput});
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
        await CartUtils.addToCart(_cartParams).then((dynamic _cartRes) async {
          if (_cartRes != null && _cartRes.containsKey("success")) {
            await _getCartListDataOnAdd();
            setState(() {
              _isAdded = true;
              _itemInCart = _cartRes['count'];
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
      } else {
        setState(() {
          _autoValidate = true; //enable realtime validation
        });
      }
    } else {
      Constants.showMessageLoader(context, 'Please wait item is adding...');
      CartData _cartParams = CartData(
          _product.productId,
          _customerId,
          _quantity,
          optionList,
          _vouchers != null ? _vouchers : "",
          _coupon != null ? _coupon : "",
          _reward != null ? _reward : "",
          null);

      await CartUtils.addToCart(_cartParams).then((dynamic _cartRes) async {
        if (_cartRes != null && _cartRes.containsKey("success")) {
          await _getCartListDataOnAdd();
          setState(() {
            _isAdded = true;
            _itemInCart = _cartRes['count'];
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
  }*/

  /*Future<void> _buyNowAddToCart(BuildContext context) async {
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
              optionList.add({_options.productOptionId: _checkInput});
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
        if (!_isAdded) {
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
                _itemInCart = _cartRes['count'];
              });
              Constants.showShortToastBuilder(_cartRes["success"]);
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Basket(_scrollBottomBarController);
              }));
            } else if (_cartRes.containsKey("error")) {
              Navigator.of(context).pop();
              Constants.showShortToastBuilder(_cartRes["error"]);
            }
          }).catchError((_err) {
            Navigator.of(context).pop();
            print('addToCart catchError:= $_err');
            Constants.showShortToastBuilder('Oops something is wrong..');
          });
        } else {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return Basket(_scrollBottomBarController);
          }));
        }
        optionList.clear();
      } else {
        setState(() {
          _autoValidate = true; //enable realtime validation
        });
      }
    } else {
      Constants.showLoadingIndicator(context);
      if (!_isAdded) {
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
            Constants.showShortToastBuilder(_cartRes["success"]);
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return Basket(_scrollBottomBarController);
            }));
          } else if (_cartRes.containsKey("error")) {
            Navigator.of(context).pop();
            Constants.showShortToastBuilder(_cartRes["error"]);
          }
        }).catchError((_err) {
          Navigator.of(context).pop();
          print('addToCart catchError:= $_err');
          Constants.showShortToastBuilder('Oops something is wrong..');
        });
      } else {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return Basket(_scrollBottomBarController);
        }));
      }
      optionList.clear();
    }
  }*/

  Future<void> _buyNowAddToCart(BuildContext context) async {
    if (_product.options != null && _product.options.length > 0) {
      if (_formKey.currentState.validate()) {
        _formKey.currentState.save();

        if (_isFileType) {
          if (_imageCode != null && _imageCode != '') {
            setState(() {
              _fileError = false;
            });
            Constants.showLoadingIndicator(context);
            _product.options.forEach((_optionItem) {
              if (_optionItem != null && _optionItem.length > 0) {
                _options = Options.fromJson(_optionItem);
                if (_options.type == 'select') {
                  optionList.add({_options.productOptionId: _selectInput});
                } else if (_options.type == 'radio') {
                  optionList.add({_options.productOptionId: _radioInput});
                } else if (_options.type == 'checkbox') {
                  optionList.add({_options.productOptionId: _checkInput});
                } else if (_options.type == 'text') {
                  optionList
                      .add({_options.productOptionId: _textController.text});
                } else if (_options.type == 'textarea') {
                  optionList.add(
                      {_options.productOptionId: _textAreaController.text});
                } else if (_options.type == 'file') {
                  optionList.add({_options.productOptionId: _imageCode});
                } else if (_options.type == 'date') {
                  optionList
                      .add({_options.productOptionId: _dateController.text});
                } else if (_options.type == 'datetime') {
                  optionList.add(
                      {_options.productOptionId: _dateTimeController.text});
                } else if (_options.type == 'time') {
                  optionList
                      .add({_options.productOptionId: _timeController.text});
                }
              }
            });
            if (!_isAdded) {
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
                    _itemInCart = _cartRes['count'];
                  });
                  Constants.showShortToastBuilder(_cartRes["success"]);
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return Basket(_scrollBottomBarController);
                  }));
                } else if (_cartRes.containsKey("error")) {
                  Navigator.of(context).pop();
                  Constants.showShortToastBuilder(_cartRes["error"]);
                }
              }).catchError((_err) {
                Navigator.of(context).pop();
                print('addToCart catchError:= $_err');
                Constants.showShortToastBuilder('Oops something is wrong..');
              });
            } else {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Basket(_scrollBottomBarController);
              }));
            }
            optionList.clear();
          } else {
            setState(() {
              _fileError = true;
            });
          }
        } else {
          Constants.showLoadingIndicator(context);
          _product.options.forEach((_optionItem) {
            if (_optionItem != null && _optionItem.length > 0) {
              _options = Options.fromJson(_optionItem);
              if (_options.type == 'select') {
                optionList.add({_options.productOptionId: _selectInput});
              } else if (_options.type == 'radio') {
                optionList.add({_options.productOptionId: _radioInput});
              } else if (_options.type == 'checkbox') {
                optionList.add({_options.productOptionId: _checkInput});
              } else if (_options.type == 'text') {
                optionList
                    .add({_options.productOptionId: _textController.text});
              } else if (_options.type == 'textarea') {
                optionList
                    .add({_options.productOptionId: _textAreaController.text});
              } else if (_options.type == 'file') {
                optionList.add({_options.productOptionId: _imageCode});
              } else if (_options.type == 'date') {
                optionList
                    .add({_options.productOptionId: _dateController.text});
              } else if (_options.type == 'datetime') {
                optionList
                    .add({_options.productOptionId: _dateTimeController.text});
              } else if (_options.type == 'time') {
                optionList
                    .add({_options.productOptionId: _timeController.text});
              }
            }
          });
          if (!_isAdded) {
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
                  _itemInCart = _cartRes['count'];
                });
                Constants.showShortToastBuilder(_cartRes["success"]);
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Basket(_scrollBottomBarController);
                }));
              } else if (_cartRes.containsKey("error")) {
                Navigator.of(context).pop();
                Constants.showShortToastBuilder(_cartRes["error"]);
              }
            }).catchError((_err) {
              Navigator.of(context).pop();
              print('addToCart catchError:= $_err');
              Constants.showShortToastBuilder('Oops something is wrong..');
            });
          } else {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return Basket(_scrollBottomBarController);
            }));
          }
          optionList.clear();
        }
      } else {
        setState(() {
          _autoValidate = true; //enable realtime validation
        });
      }
    } else {
      Constants.showLoadingIndicator(context);
      if (!_isAdded) {
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
            Constants.showShortToastBuilder(_cartRes["success"]);
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return Basket(_scrollBottomBarController);
            }));
          } else if (_cartRes.containsKey("error")) {
            Navigator.of(context).pop();
            Constants.showShortToastBuilder(_cartRes["error"]);
          }
        }).catchError((_err) {
          Navigator.of(context).pop();
          print('addToCart catchError:= $_err');
          Constants.showShortToastBuilder('Oops something is wrong..');
        });
      } else {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return Basket(_scrollBottomBarController);
        }));
      }
      optionList.clear();
    }
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

  Future<dynamic> _addRemoveWishListBuilder() async {
    if (!_productInWishList) {
      if (AuthUtils.authToken == null) {
        Constants.showLongToastBuilder('Please Login to add to wish list');
        MaterialPageRoute authRoute =
        MaterialPageRoute(builder: (context) => AuthLogin());
        Navigator.push(context, authRoute);
      } else {
        WishListData _listParam =
            WishListData(_product.productId.toString(), _customerId);
        await WishListUtils.addToWishList(_listParam)
            .then((dynamic _listRes) async {
          if (_listRes != null && _listRes.containsKey("success")) {
            setState(() {
              _productInWishList = true;
            });
            Constants.showShortToastBuilder('Item added to wish list.');
          } else {
            Constants.showShortToastBuilder('Add to wish list failed!');
          }
        }).catchError((_onError) {
          print("\naddToWishList catchError:=> $_onError\n");
        });
      }
    } else {
      await WishListUtils.removeWishList(_product.productId, _customerId)
          .then((dynamic _removeRes) async {
        if (_removeRes != null && _removeRes.containsKey("success")) {
          setState(() {
            _productInWishList = false;
          });
          Constants.showShortToastBuilder('Item deleted from wish list!');
        } else {
          Constants.showShortToastBuilder('remove to wish list failed!');
        }
      }).catchError((_onError) {
        print("\nremoveWishList catchError:=> $_onError\n");
        Constants.showShortToastBuilder('Oops! Something went wrong');
      });
    }
  }

  Future<dynamic> _uploadFile(BuildContext context) async {
    Constants.showLoadingIndicator(context);
    UploadFileData _fileParam = UploadFileData(_image);
    await UploadFileUtils.uploadFile(_fileParam).then((dynamic _fileRes) async {
      if (_fileRes != null && _fileRes != '' && _fileRes.containsKey("code")) {
        setState(() {
          _imageCode = _fileRes['code'];
          if (_imageCode != null && _imageCode != '') {
            setState(() {
              _fileError = false;
            });
          }
        });
        Navigator.of(context).pop();
        Constants.showLongToastBuilder('Your file was successfully uploaded.');
      } else {
        Navigator.of(context).pop();
        Constants.showShortToastBuilder('File upload failed');
      }
    }).catchError((_err) {
      Navigator.of(context).pop();
      print('\n_uploadFile catchError:= $_err\n');
    });
  }

  Future<dynamic> _changePrice() async {
    _product.options.forEach((_optionItem) {
      if (_optionItem != null && _optionItem.length > 0) {
        _options = Options.fromJson(_optionItem);
        if (_options.type == 'select') {
          optionList.add({_options.productOptionId: _selectInput});
        } else if (_options.type == 'radio') {
          optionList.add({_options.productOptionId: _radioInput});
        } else if (_options.type == 'checkbox') {
          optionList.add({_options.productOptionId: _checkInput});
        }
      }
    });
    ChangePriceData _priceParams =
        ChangePriceData(_product.productId, optionList);
    await ChangePriceUtils.changePrice(_priceParams).then((dynamic _res) {
      if (_res != null &&
          _res.containsKey('new_price') &&
          _res['new_price'] != null &&
          _res.containsKey('success') &&
          _res['success'] != null &&
          _res['success'] == true) {
        setState(() {
          _costPrice = _res['new_price']['price'];
          print("Changes cost Price:=> $_costPrice");
        });
      }
    }).catchError((dynamic _err) {
      print("\n\n_changePrice catchError:=> $_err\n\n");
      Constants.showLongToastBuilder('Oops something went wrong!');
    });
    optionList.clear();
  }

  AppBar _appBar() {
    return AppBar(
      centerTitle: true,
      title: Text(
        "Item Details",
        style: TextStyle(color: Constants.myWhite, fontSize: 16.0),
      ),
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
        /*IconButton(
          icon: Icon(
            Icons.share,
            size: 25.0,
          ),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(
            Icons.shopping_basket,
            size: 25.0,
          ),
          onPressed: () =>
              Navigator.push(context, MaterialPageRoute(builder: (context) {
            return Basket(_scrollBottomBarController);
          })),
        ),*/
        WidgetPage.shoppingCartIconButton(
            context, _itemInCart, _scrollBottomBarController),
      ],
    );
  }

  Widget _productDetailViewBuilder(Map<String, dynamic> snapshot) {
    if (snapshot.containsKey('text_error')) {
      return WidgetPage.errorWidget(snapshot);
    } else {
      Widget productImageWidget() {
        return Stack(
          children: <Widget>[
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Container(
                      alignment: Alignment.center,
                      height: 300,
                      width: 220,
                      child: InkWell(
                        onTap: () => Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return ImageViewer(_product);
                        })),
                        child: FadeInImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(
                              _product.thumb != null && _product.thumb != ''
                                  ? _product.thumb
                                  : ''),
                          placeholder: AssetImage(
                              'assets/placeholders/no-product-image.png'),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              alignment: Alignment.topRight,
              child: IconButton(
                padding: EdgeInsets.only(top: 40, right: 15.0),
                alignment: Alignment.topRight,
                icon: Icon(Icons.favorite),
                color: _productInWishList ? Colors.orange : Colors.grey,
                onPressed: () async => _addRemoveWishListBuilder(),
              ),
            )
          ],
        );
      }

      Widget _discountPriceText() {
        Widget _price;
        if (_product.specialPrice() != '') {
          _price = Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                _product.specialPrice(),
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                ),
              ),
              Constants.width(10.0),
            ],
          );
        } else {
          _price = Container();
        }
        return _price;
      }

      Widget _itemRealPriceText() {
        Widget _price;
        if (_product.specialPrice() != '') {
          _price = RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                text: 'MRP: ',
                style: TextStyle(
                  color: Colors.grey,
                ),
                children: [
                  TextSpan(
                    text: _costPrice,
                    style: TextStyle(
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                ]),
          );
        } else {
          _price = Text(
            _costPrice,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          );
        }
        return _price;
      }

      Widget _savedPrice() {
        Widget _priceWidget;
        if (_product.specialPrice() != '' && _product.savedPrice != null) {
          _priceWidget = Container(
            padding: EdgeInsets.all(1.0),
            child: Text(_product.savedPrice.toString() + "% off"),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(2),
            ),
          );
        } else {
          _priceWidget = Container();
        }
        return _priceWidget;
      }

      Widget _buildPriceAndDiscountWidget() {
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _discountPriceText(),
            _itemRealPriceText(),
            Constants.width(10.0),
            _savedPrice(),
          ],
        );
      }

      TextStyle _ddNameStyle = TextStyle(
          fontWeight: FontWeight.w500, fontSize: 14.5, color: Colors.black);
      TextStyle _radioTextStyle = TextStyle(
          fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black);
      TextStyle _richTextStyle = TextStyle(
          fontWeight: FontWeight.w500, fontSize: 16.5, color: Colors.black);
      TextStyle _textSpanStyle = TextStyle(
        color: Colors.red,
        fontWeight: FontWeight.bold,
        fontSize: 16.5,
      );
      TextStyle _labelStyle = TextStyle(
          color: Constants.myGreen,
          letterSpacing: 0.5,
          fontWeight: FontWeight.w500);

      Widget _selectTypeWidget(final Options _selectData) {
        if (_selectInput == null) {
          setState(() {
            _selectInput =
                _selectData.productOptionValue[0]['product_option_value_id'];
            print("_selectInput:= $_selectInput");
          });
        }
        return Column(
          mainAxisAlignment: _mStart,
          crossAxisAlignment: _cStart,
          children: <Widget>[
            Constants.height(20.0),
            _selectData.required != null && _selectData.required != ''
                ? RichText(
                    text:
                        TextSpan(text: '* ', style: _textSpanStyle, children: [
                      TextSpan(
                        text: _selectData.name,
                        style: _richTextStyle,
                      ),
                    ]),
                  )
                : Text(
                    _selectData.name,
                    style: _ddNameStyle,
                  ),
            Constants.height(10.0),
            Container(
              width: _deviceSize.width,
              child: DropdownButtonFormField(
                value: _selectInput,
                elevation: 0,
                isDense: true,
                isExpanded: true,
                iconEnabledColor: Colors.green,
                items: WidgetPage.selectMenuItems(_selectData),
                onChanged: (_newSelectVal) async {
                  setState(() {
                    _selectInput = _newSelectVal;
                  });
                  print("calling _selectInput:== $_selectInput");
                  await _changePrice();
                  _selectData.productOptionValue.forEach((optionElement) async {
                    ProductOptionValue _optionElement =
                        ProductOptionValue.fromJson(optionElement);
                    if (_optionElement.productOptionValueId == _newSelectVal) {
                      setState(() {
                        /*_optionElement.price != '' &&
                                _optionElement.price != 'false'
                            ? _costPrice = _optionElement.price
                            : _costPrice = _product.price;*/
                        _optionElement.image != '' &&
                                _optionElement.image != null
                            ? _productImage = _optionElement.image
                            : _productImage =
                                _product.thumb != null && _product.thumb != ''
                                    ? _product.thumb
                                    : '';
                      });
                    }
                  });
                },
                validator: (String _value) {
                  if (_selectData.required == '1') {
                    if (_value == null || _value == '0') {
                      return 'Please select an option!';
                    }
                  }
                  return null;
                },
              ),
            ),
            Constants.height(20.0),
          ],
        );
      }

      Widget _radioTypeWidget(final Options _radioData) {
        /*if (_radioInput == null) {
          setState(() {
            this._radioInput =
                _radioData.productOptionValue[0]['product_option_value_id'];
          });
        }*/
        return Column(
          mainAxisAlignment: _mStart,
          crossAxisAlignment: _cStart,
          children: <Widget>[
            Constants.height(10.0),
            _radioData.required != null && _radioData.required != ''
                ? RichText(
                    text:
                        TextSpan(text: '* ', style: _textSpanStyle, children: [
                      TextSpan(
                        text: _radioData.name,
                        style: _richTextStyle,
                      ),
                    ]),
                  )
                : Text(
                    _radioData.name,
                    style: _ddNameStyle,
                  ),
            FormBuilderRadioGroup(
              initialValue: _radioInput,
              attribute: "best_language",
              activeColor: Constants.myGreen,
              options: WidgetPage.radioButton(_radioData),
              onChanged: (_newRadioVal) async {
                setState(() {
                  _radioInput = _newRadioVal;
                });
                await _changePrice();
                _radioData.productOptionValue.forEach((optionElement) async {
                  ProductOptionValue _optionElement =
                      ProductOptionValue.fromJson(optionElement);
                  if (_optionElement.productOptionValueId == _newRadioVal) {
                    setState(() {
                      /*_optionElement.price != '' &&
                                  _optionElement.price != 'false'
                              ? _costPrice = _optionElement.price
                              : _costPrice = _product.price;*/
                      _optionElement.image != '' && _optionElement.image != null
                          ? _productImage = _optionElement.image
                          : _productImage =
                              _product.thumb != null && _product.thumb != ''
                                  ? _product.thumb
                                  : '';
                    });
                  }
                });
              },
              validators: [
                _radioData.required == '1'
                    ? FormBuilderValidators.required(
                        errorText: 'Please select an ' +
                            _radioData.name.toLowerCase() +
                            '!')
                    : null,
              ],
            ),
            Constants.height(20.0),
          ],
        );
      }

      Widget _checkboxTypeWidget(final Options _checkboxData) {
        /*if (_checkInput.length == 0) {
          print("groupVal:=> $_checkInput");
          _checkInput = [
            _checkboxData.productOptionValue[0]['product_option_value_id']
          ];
        }*/
        return Column(
          mainAxisAlignment: _mStart,
          crossAxisAlignment: _cStart,
          children: <Widget>[
            Constants.height(20.0),
            _checkboxData.required != null && _checkboxData.required != ''
                ? RichText(
                    text:
                        TextSpan(text: '* ', style: _textSpanStyle, children: [
                      TextSpan(
                        text: _checkboxData.name,
                        style: _richTextStyle,
                      ),
                    ]),
                  )
                : Text(
                    _checkboxData.name,
                    style: _ddNameStyle,
                  ),
            FormBuilderCheckboxGroup(
              readOnly: true,
              attribute: "Accessories",
              initialValue: _checkInput,
              activeColor: Constants.myGreen,
              options: WidgetPage.checkboxGroup(_checkboxData),
              onChanged: (dynamic _newVal) async {
                setState(() {
                  _checkInput = _newVal;
                });
                await _changePrice();

                _checkboxData.productOptionValue.forEach((optionElement) async {
                  ProductOptionValue _optionElement =
                      ProductOptionValue.fromJson(optionElement);
                  if (_optionElement.productOptionValueId == _newVal) {
                    setState(() {
                      _optionElement.image != '' && _optionElement.image != null
                          ? _productImage = _optionElement.image
                          : _productImage =
                              _product.thumb != null && _product.thumb != ''
                                  ? _product.thumb
                                  : '';
                    });
                  }
                });
              },
              validators: [
                _checkboxData.required == '1'
                    ? FormBuilderValidators.required(
                        errorText: 'Please select an ' +
                            _checkboxData.name.toLowerCase() +
                            '!')
                    : null,
              ],
            ),
            Constants.height(20.0),
          ],
        );
      }

      Widget _textTypeWidget(final Options _textData) {
        return Column(
          crossAxisAlignment: _cStart,
          mainAxisAlignment: _mStart,
          children: <Widget>[
            Constants.height(20.0),
            TextFormField(
              controller: _textController,
              autofocus: false,
              cursorColor: Constants.primary_green,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: const BorderSide(
                      color: Constants.primary_green, width: 1.5),
                ),
                hintText: 'Text Field',
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0)),
              ),
              validator: (_newText) {
                if (_textData.required == '1') {
                  if (_newText.isEmpty) {
                    return 'Please enter text.';
                  }
                }
                return null;
              },
            ),
            Constants.height(20.0),
          ],
        );
      }

      Widget _textAreaTypeWidget(final Options _textAreaData) {
        return Column(
          crossAxisAlignment: _cStart,
          mainAxisAlignment: _mStart,
          children: <Widget>[
            Constants.height(20.0),
            TextFormField(
              maxLines: 8,
              maxLength: 1000,
              controller: _textAreaController,
              keyboardType: TextInputType.text,
              autofocus: false,
              cursorColor: Constants.primary_green,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: const BorderSide(
                      color: Constants.primary_green, width: 1.5),
                ),
                hintText: 'Text Area Field',
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0)),
              ),
              validator: (_newTextArea) {
                if (_textAreaData.required == '1') {
                  if (_newTextArea.isEmpty) {
                    return 'Please enter text.';
                  }
                }
                return null;
              },
            ),
            Constants.height(20.0),
          ],
        );
      }

      Future<void> _getImage() async {
        await ImagePicker.pickImage(
          source: ImageSource.gallery,
        ).then((final File _res) async {
          print("Selected File:= $_res");
          if (_res != null) {
            setState(() {
              _image = _res;
            });
            await _uploadFile(context);
          }
        }).catchError((_err) {
          print("ImagePicker catchError:=> $_err");
        });
      }

      Widget _fileTypeWidget(final Options _fileData) {
        return Column(
          crossAxisAlignment: _cStart,
          children: <Widget>[
            Constants.height(20.0),
            FlatButton(
              padding: EdgeInsets.symmetric(vertical: 12.0),
              color: Constants.myGreen,
              onPressed: () async => _getImage(),
              child: Row(
                mainAxisAlignment: _mCenter,
                children: <Widget>[
                  Icon(
                    Icons.file_upload,
                    color: Constants.myWhite,
                  ),
                  Constants.width(5.0),
                  Text(
                    _fileData.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Constants.myWhite,
                    ),
                  ),
                ],
              ),
            ),
            _fileData.required == '1'
                ? _fileError
                    ? Container(
                        padding: EdgeInsets.only(top: 3.0),
                        child: Text(
                          "This field is required.",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 12.0,
                              color: Colors.red,
                              letterSpacing: 0.5),
                        ),
                      )
                    : Container()
                : Container(),
            Constants.height(20.0),
          ],
        );
      }

      Widget _dateTypeWidget(final Options _dateData) {
        return Column(
          crossAxisAlignment: _cStart,
          mainAxisAlignment: _mStart,
          children: <Widget>[
            Constants.height(20.0),
            DateTimeField(
              controller: _dateController,
              initialValue: DateTime.now(),
              decoration: InputDecoration(
                labelText: 'Choose ' + _dateData.name,
                labelStyle: _labelStyle,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0)),
              ),
              onChanged: (_changedDate) {
                if (_changedDate != null) {
                  setState(() {
                    _date = _changedDate.toLocal().toString().split(" ")[0];
                  });
                }
              },
              format: _dateFormat,
              onShowPicker: (context, currentValue) {
                return showDatePicker(
                    context: context,
                    firstDate: DateTime(1900),
                    initialDate: currentValue ?? DateTime.now(),
                    lastDate: DateTime(2100));
              },
              validator: (DateTime _newDate) {
                if (_dateData.required == '1') {
                  if (_newDate == null) {
                    return 'Please choose ' + _dateData.name + '.';
                  }
                }
                return null;
              },
            ),
            Constants.height(20.0),
          ],
        );
      }

      Widget _datetimeTypeWidget(final Options _dateTimeData) {
        return Column(
          children: <Widget>[
            Constants.height(20.0),
            DateTimeField(
              controller: _dateTimeController,
              initialValue: DateTime.now(),
              decoration: InputDecoration(
                labelText: 'Choose ' + _dateTimeData.name,
                labelStyle: _labelStyle,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0)),
              ),
              onChanged: (_changedDateTime) {
                if (_changedDateTime != null) {
                  setState(() {
                    _dateTime =
                        _changedDateTime.toLocal().toString().split(".")[0];
                  });
                }
              },
              format: _dateTimeFormat,
              onShowPicker: (context, currentValue) async {
                final date = await showDatePicker(
                    context: context,
                    firstDate: DateTime(1900),
                    initialDate: currentValue ?? DateTime.now(),
                    lastDate: DateTime(2100));
                if (date != null) {
                  final time = await showTimePicker(
                    context: context,
                    initialTime:
                        TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                  );
                  return DateTimeField.combine(date, time);
                } else {
                  return currentValue;
                }
              },
              validator: (DateTime _newDateTime) {
                if (_dateTimeData.required == '1') {
                  if (_newDateTime == null) {
                    return 'Please choose ' + _dateTimeData.name + '.';
                  }
                }
                return null;
              },
            ),
            Constants.height(20.0),
          ],
        );
      }

      Widget _timeTypeWidget(final Options _timeData) {
        return Column(
          children: <Widget>[
            Constants.height(20.0),
            DateTimeField(
              controller: _timeController,
              initialValue: DateTime.now(),
              decoration: InputDecoration(
                labelText: 'Select ' + _timeData.name,
                labelStyle: _labelStyle,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0)),
              ),
              onChanged: (_changedTime) {
                if (_changedTime != null) {
                  setState(() {
                    _time = _changedTime
                        .toLocal()
                        .toString()
                        .split(".")[0]
                        .split(" ")[1];
                  });
                }
              },
              format: _timeFormat,
              onShowPicker: (context, currentValue) async {
                final time = await showTimePicker(
                  context: context,
                  initialTime:
                      TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                );
                return DateTimeField.convert(time);
              },
              validator: (DateTime _newTime) {
                if (_timeData.required == '1') {
                  if (_newTime == null) {
                    return 'Please choose ' + _timeData.name + '.';
                  }
                }
                return null;
              },
            ),
            Constants.height(20.0),
          ],
        );
      }

      Widget _listOfOptionsWidgets(final List<dynamic> _optionsDataList) {
        List<Widget> _optionsWidgets() {
          List<Widget> _widgetItems = List();
          _product.textOption != null && _product.textOption != ''
              ? _widgetItems
                  .add(WidgetPage.availableOptionsTitle(_product.textOption))
              : Container();
          _optionsDataList.forEach((_optionItem) {
            if (_optionItem != null && _optionItem.length > 0) {
              _options = Options.fromJson(_optionItem);
              if (_options.type == 'select') {
                _selectOption = Options.fromJson(_optionItem);
                if (_selectOption.productOptionValue != null &&
                    _selectOption.productOptionValue.length > 0) {
                  _selectOption != null
                      ? _widgetItems.add(_selectTypeWidget(_selectOption))
                      : Container();
                }
              }
              if (_options.type == 'radio') {
                _radioOption = Options.fromJson(_optionItem);
                if (_radioOption.productOptionValue != null &&
                    _radioOption.productOptionValue.length > 0) {
                  _radioOption != null
                      ? _widgetItems.add(_radioTypeWidget(_radioOption))
                      : Container();
                }
              }
              if (_options.type == 'checkbox') {
                _checkboxOption = Options.fromJson(_optionItem);
                if (_checkboxOption.productOptionValue != null &&
                    _checkboxOption.productOptionValue.length > 0) {
                  _checkboxOption != null
                      ? _widgetItems.add(_checkboxTypeWidget(_checkboxOption))
                      : Container();
                }
              }
              if (_options.type == 'text') {
                _textOption = Options.fromJson(_optionItem);
                _textOption != null
                    ? _widgetItems.add(_textTypeWidget(_textOption))
                    : Container();
              }
              if (_options.type == 'textarea') {
                _textAreaOption = Options.fromJson(_optionItem);
                _textAreaOption != null
                    ? _widgetItems.add(_textAreaTypeWidget(_textAreaOption))
                    : Container();
              }
              if (_options.type == 'file') {
                _fileOption = Options.fromJson(_optionItem);
                _fileOption != null
                    ? _widgetItems.add(_fileTypeWidget(_fileOption))
                    : Container();
                if (_options.required == '1') {
                  setState(() {
                    _isFileType = true;
                  });
                }
              }
              if (_options.type == 'date') {
                _dateOption = Options.fromJson(_optionItem);
                _dateOption != null
                    ? _widgetItems.add(_dateTypeWidget(_dateOption))
                    : Container();
              }
              if (_options.type == 'datetime') {
                _dateTimeOption = Options.fromJson(_optionItem);
                _dateTimeOption != null
                    ? _widgetItems.add(_datetimeTypeWidget(_dateTimeOption))
                    : Container();
              }
              if (_options.type == 'time') {
                _timeOption = Options.fromJson(_optionItem);
                _timeOption != null
                    ? _widgetItems.add(_timeTypeWidget(_timeOption))
                    : Container();
              }
            }
          });
          return _widgetItems;
        }

        return Form(
          key: _formKey,
          autovalidate: _autoValidate,
          child: Column(
            crossAxisAlignment: _cStart,
            mainAxisAlignment: _mStart,
            children: _optionsWidgets(),
          ),
        );
      }

      Widget _itemSpecificsWidget(final List<dynamic> _attributeDataList) {
        List<Widget> _specificsWidgets() {
          List<Widget> _specificsWidgetsItems = List();
          _attributeDataList.forEach((_specificItem) {
            if (_specificItem != null && _specificItem.length > 0) {
              _attributeGroups = AttributeGroups.fromJson(_specificItem);
              _attributeGroups != null
                  ? _specificsWidgetsItems.add(
                      Column(
                        crossAxisAlignment: _cStart,
                        mainAxisAlignment: _mStart,
                        children: <Widget>[
                          Constants.height(10.0),
                          Text(
                            "Item Specifics",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 17.0),
                          ),
                          Constants.height(5.0),
                          Text(
                            _attributeGroups.name,
                            style: TextStyle(color: Constants.grey500),
                          ),
                          Divider(height: 40.0),
                        ],
                      ),
                    )
                  : Container();
            }
          });

          return _specificsWidgetsItems;
        }

        return Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: _cStart,
            mainAxisAlignment: _mStart,
            children: _specificsWidgets(),
          ),
        );
      }

      Widget _attributeWidget(final List<dynamic> _attributeGroupList) {
        List<Widget> _attributeWidgetList() {
          List<Widget> _attributeWidgetItems = List();
          _attributeGroupList.forEach((_attributeGroupItem) {
            if (_attributeGroupItem != null && _attributeGroupItem.length > 0) {
              _attributeGroups = AttributeGroups.fromJson(_attributeGroupItem);
              if (_attributeGroups.attribute != null &&
                  _attributeGroups.attribute.length > 0) {
                _attributeGroups.attribute.forEach((_attributeItems) {
                  _attribute = Attribute.fromJson(_attributeItems);
                  _attributeGroups != null && _attribute != null
                      ? _attributeWidgetItems.add(Column(
                          crossAxisAlignment: _cStart,
                          mainAxisAlignment: _mStart,
                          children: <Widget>[
                            Divider(height: 30.0),
                            Text(
                              _attributeGroups.name,
                              style: _ddNameStyle,
                            ),
                            Constants.height(5.0),
                            Text(
                              _attribute.name,
                              style: TextStyle(color: Constants.grey500),
                            ),
                            Constants.height(10.0),
                          ],
                        ))
                      : Container();
                });
              }
            }
          });

          return _attributeWidgetItems;
        }

        return Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: _cStart,
            mainAxisAlignment: _mStart,
            children: _attributeWidgetList(),
          ),
        );
      }

      return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: _cStart,
          mainAxisAlignment: _mStart,
          children: <Widget>[
            Container(
              color: Constants.myWhite,
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
              child: Column(
                crossAxisAlignment: _cStart,
                mainAxisAlignment: _mStart,
                children: <Widget>[
                  _product.manufacturer != null && _product.manufacturer != ''
                      ? WidgetPage.productBrandName(_product.manufacturer)
                      : Container(),
                  _product.headingTitle != null && _product.headingTitle != ''
                      ? WidgetPage.productName(_product.headingTitle)
                      : Container(),
                  Constants.height(5.0),
                  _buildPriceAndDiscountWidget(),
                  Constants.height(1.0),
                  WidgetPage.inclusive(),
                  _product != null
                      ? _product.rating != null &&
                              _product.rating != null &&
                              _product.rating >= 0
                          ? WidgetPage.ratingWidget(_product.rating,
                              _product.reviews, _product, context)
                          : Container()
                      : Container(),
                  _product != null ? productImageWidget() : Container(),
                  /*Constants.height(30.0),
                  _product != null
                      ? _product.thumb != null
                          ? _productImage != null
                              ? WidgetPage.productImageWidget(
                                  _productImage, _product, context)
                              : Container()
                          : Container()
                      : Container(),
                  Constants.height(30.0),*/
                  _product.options != null && _product.options.length > 0
                      ? _listOfOptionsWidgets(_product.options)
                      : Container(),
                ],
              ),
            ),
            Constants.height(10.0),
            Container(
              color: Constants.myWhite,
              child: Column(
                crossAxisAlignment: _cStart,
                children: <Widget>[
                  Constants.height(10.0),
                  WidgetPage.aboutTheProductTitle(),
                  _product.attributeGroups != null &&
                          _product.attributeGroups.length > 0
                      ? _itemSpecificsWidget(_product.attributeGroups)
                      : Container(),
                  _product.description != null
                      ? WidgetPage.productDescription(_product.description)
                      : Container(),
                  _product.attributeGroups != null &&
                          _product.attributeGroups.length > 0
                      ? _attributeWidget(_product.attributeGroups)
                      : Container(),
                  Constants.height(10.0),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }

  Widget _buyNowButtonWidget(final bool isSaved) {
    return InkWell(
      onTap: _product.stock == 'In Stock'
          ? () async {
        if (AuthUtils.authToken != null &&
            AuthUtils.authToken != '') {
          _buyNowAddToCart(context);
        }else{
          Constants.showLongToastBuilder('Please Login to buy now');
          MaterialPageRoute authRoute =
          MaterialPageRoute(builder: (context) => AuthLogin());
          Navigator.push(context, authRoute);
        }
      }
          : () {},
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 13.0),
        color: _product.stock == 'In Stock' ? Constants.myGreen : Colors.grey,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
                _product.stock == 'In Stock'
                    ? Icons.shopping_cart
                    : Icons.remove_shopping_cart,
                color: Constants.myWhite),
            Constants.width(5.0),
            Text(
              _product != null
                  ? _product.stock == 'In Stock' ? 'BUY NOW' : 'OUT OF STOCK'
                  : "BUY NOW",
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w500,
                color: Constants.myWhite,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _addToCartButtonWidget(final bool _isCartAdded) {
    Widget _cartWidget;
    if (_isCartAdded == false) {
      _cartWidget = InkWell(
        onTap: () async {
          if (AuthUtils.authToken != null &&
              AuthUtils.authToken != '') {
            _firstTimeAddToCart(context);
          }else{
            Constants.showLongToastBuilder('Please Login to add to cart');
            MaterialPageRoute authRoute =
            MaterialPageRoute(builder: (context) => AuthLogin());
            Navigator.push(context, authRoute);
          }
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 13.0),
          color: Colors.deepOrange,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.shopping_basket, color: Constants.myWhite),
              Constants.width(5.0),
              Text(
                _product != null && _product.buttonCart != null
                    ? _product.buttonCart.toUpperCase()
                    : "ADD TO BASKET",
                style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                    color: Constants.myWhite),
              ),
            ],
          ),
        ),
      );
    } else if (_isCartAdded == true) {
      _cartWidget = Container(
        padding: EdgeInsets.symmetric(vertical: 9.0),
        color: Constants.grey200,
        child: Row(
          mainAxisAlignment: _mCenter,
          children: <Widget>[
            InkWell(
//              onTap: () async => _removeToCartButton(),
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
//              onTap: () async => _addToCartButton(),
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

  Widget _bottomAppBarButton(final bool isSaved, final bool isAdded) {
    return BottomAppBar(
      elevation: 0.0,
      child: Row(
        children: <Widget>[
          Expanded(
            child: _addToCartButtonWidget(isAdded),
          ),
          Expanded(
            child: _buyNowButtonWidget(isSaved),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: _appBar(),
      body: Container(
        color: Constants.grey200,
        child: _selectedProduct != null
            ? _productDetailViewBuilder(_selectedProduct)
            : WidgetPage.errorWidget(_selectedProduct),
      ),
      bottomNavigationBar: _bottomAppBarButton(_isSaved, _isAdded),
    );
  }
}

import 'dart:async';
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gwaliorkart/models/cart_data.dart';
import 'package:gwaliorkart/models/location_data.dart';
import 'package:gwaliorkart/models/order_data.dart';
import 'package:gwaliorkart/models/payment_data.dart';
import 'package:gwaliorkart/models/product_detail_model.dart';
import 'package:gwaliorkart/screens/basket.dart';
import 'package:gwaliorkart/screens/dummy_product_details.dart';
import 'package:gwaliorkart/screens/home.dart';
import 'package:gwaliorkart/screens/image_viewer.dart';
import 'package:gwaliorkart/screens/product_details.dart';
import 'package:gwaliorkart/screens/product_ratings_and_reviews.dart';
import 'package:gwaliorkart/screens/search_screen.dart';
import 'package:gwaliorkart/utils/auth_utils.dart';
import 'package:gwaliorkart/utils/constants.dart';
import 'package:gwaliorkart/utils/storage_utils.dart';

class WidgetPage {
  static CrossAxisAlignment _cStart = CrossAxisAlignment.start;
  static MainAxisAlignment _mStart = MainAxisAlignment.start;
  static CrossAxisAlignment _cCenter = CrossAxisAlignment.center;
  static MainAxisAlignment _mCenter = MainAxisAlignment.center;
  static ProductDetailData _product;
  static Options _options;
  static Options _selectOption;
  static Options _radioOption;
  static Options _checkboxOption;
  static Options _textOption;
  static Options _textAreaOption;
  static Options _fileOption;
  static Options _dateOption;
  static Options _dateTimeOption;
  static Options _timeOption;
  static ProductOptionValue _optionValue;
  static AttributeGroups _attributeGroups;
  static Attribute _attribute;
  static TextStyle _labelStyle = TextStyle(fontSize: 12.0);
  static EdgeInsets _padding = EdgeInsets.all(0);
  static String paymentMethodCode,
      paymentMethodTitle,
      paymentMethodTerms,
      paymentMethodSortOrder;

  static final List<dynamic> _addressTypeList1 = [
    {"id": "new", "name": "I want to use a new address"}
  ];

  static final List<dynamic> _addressTypeList2 = [
    {"id": "existing", "name": "I want to use an existing address"},
    {"id": "new", "name": "I want to use a new address"}
  ];

  static final TextStyle _addressStyle = TextStyle(
      fontSize: 14.0, fontWeight: FontWeight.w400, color: Constants.grey700);

  static final TextStyle _titleStyle =
      TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0);

  static final TextStyle _noItemStyle = TextStyle(
      fontSize: 18.0, color: Constants.grey500, fontWeight: FontWeight.w500);

  static final TextStyle _headingStyle =
      TextStyle(color: Constants.grey800, fontWeight: FontWeight.w600);

  static Text expansionTitle(final String _title) {
    return Text(
      _title,
      style: _titleStyle,
    );
  }

  static Widget ratingWidgets(final int rating) {
    Widget _rating;
    _rating = Text(
      "Rating: " + rating.toString(),
      textAlign: TextAlign.left,
      style: TextStyle(color: Constants.myGreen),
    );
    return _rating;
  }

  static Widget productRating(final int rating) {
    return Column(
      children: <Widget>[
        Text(
          "Rating: " + rating.toString(),
          style: TextStyle(color: Constants.myGreen),
        ),
        Constants.height(5),
      ],
    );
  }

  static Widget productRealPriceWithSpecial(final String _price) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'MRP: ',
          style: TextStyle(
            color: Colors.grey,
          ),
          children: [
            TextSpan(
              text: _price,
              style: TextStyle(
                color: Colors.grey,
                decoration: TextDecoration.lineThrough,
              ),
            ),
          ]),
    );
  }

  static Widget productRealPriceWithoutSpecial(final String _price) {
    return Text(
      _price,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 15,
      ),
    );
  }

  static Widget productDiscountPriceText(final String _specialPrice) {
    return Text(
      _specialPrice,
      textAlign: TextAlign.left,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 15.0,
      ),
    );
  }

  static Widget label(final double _horizontal, final String _title) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: _horizontal),
      padding: EdgeInsets.all(10.0),
      color: Colors.lightBlueAccent.withAlpha(60),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            _title,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  static Widget productBrandName(final String _manufacturer) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
          decoration: BoxDecoration(
            color: Colors.tealAccent,
            borderRadius: BorderRadius.circular(3),
          ),
          child: Text(
            _manufacturer,
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        Constants.height(8.0),
      ],
    );
  }

  static Widget productName(final String _headingTitle) {
    return Container(
      child: Text(
        _headingTitle,
        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300),
      ),
    );
  }

  static Widget inclusive() {
    return Text(
      "(Inclusive of all taxes)",
      style: TextStyle(color: Constants.grey500, fontSize: 10.0),
    );
  }

  static Widget ratingWidget(
      final int _productRating,
      final String _productReview,
      ProductDetailData product,
      BuildContext context) {
    return Column(
      children: <Widget>[
        Constants.height(5),
        InkWell(
          onTap: () {
            Constants.showShortToastBuilder("Product ratings & Reviews");
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ProductRatingsAndReviews(product);
            }));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                _productRating.toString() +
                    " Ratings & " +
                    _productReview.toString(),
                style: TextStyle(color: Constants.myGreen, fontSize: 10.0),
              ),
              Icon(
                Icons.navigate_next,
                size: 12.0,
                color: Constants.myGreen,
              )
            ],
          ),
        ),
      ],
    );
  }

  static ImageProvider<dynamic> getProductImage(final String _productImage) {
    ImageProvider<dynamic> imageUrl;
    if (_productImage != null && _productImage != '') {
      imageUrl = NetworkImage(_productImage);
    } else {
      imageUrl = AssetImage("assets/placeholders/no-product-image.png");
    }
    return imageUrl;
  }

  static Widget productImageWidget(final String _productImg,
      ProductDetailData product, BuildContext context) {
    return Row(
      mainAxisAlignment: _mCenter,
      children: <Widget>[
        InkWell(
          onTap: () =>
              Navigator.push(context, MaterialPageRoute(builder: (context) {
            return ImageViewer(product);
          })),
          child: Container(
            height: 200.0,
            width: 200.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              image: DecorationImage(
                image: getProductImage(_productImg),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }

  static Widget discountPriceText(final String _specialPrice) {
    return Row(
      mainAxisAlignment: _mStart,
      children: <Widget>[
        Text(
          _specialPrice,
          textAlign: TextAlign.left,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15.0,
          ),
        ),
        Constants.width(10.0),
      ],
    );
  }

  static Widget itemRealPriceText(
      final String _specialPrice, final String _costPrice) {
    Widget _price;
    if (_specialPrice != '') {
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

  static Widget savedPrice(final String _specialPrice, final int _savedPrice) {
    return Container(
      padding: EdgeInsets.all(1.0),
      child: Text(_savedPrice.toString() + "% off"),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  static Widget buildPriceAndDiscountWidget(
      final String specialPrice, final String costPrice, final int savePrice) {
    return Row(
      mainAxisAlignment: _mStart,
      children: <Widget>[
        specialPrice != '' ? discountPriceText(specialPrice) : Container(),
        specialPrice != '' && specialPrice != null && costPrice != null
            ? itemRealPriceText(specialPrice, costPrice)
            : Container(),
        Constants.width(10.0),
        specialPrice != '' && specialPrice != null && savePrice != null
            ? savedPrice(specialPrice, savePrice)
            : Container(),
      ],
    );
  }

  static Widget availableOptionsTitle(final String _textOption) {
    return Column(
      crossAxisAlignment: _cStart,
      mainAxisAlignment: _mStart,
      children: <Widget>[
        Text(
          _textOption.toUpperCase(),
          style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500),
        ),
        Constants.height(5.0),
      ],
    );
  }

  static Widget aboutTheProductTitle() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: _cStart,
        mainAxisAlignment: _mStart,
        children: <Widget>[
          Text(
            "About This Product",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 19.0),
          ),
          Divider(
            height: 20.0,
          ),
        ],
      ),
    );
  }

  static Widget productDescription(final String _description) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: _cStart,
        mainAxisAlignment: _mStart,
        children: <Widget>[
          Constants.height(10.0),
          Text(
            "Product Description",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17.0),
          ),
          Divider(height: 20.0),
          Text(
            _description,
            style: TextStyle(color: Constants.grey500),
          ),
        ],
      ),
    );
  }

  static Widget errorWidget(final Map<String, dynamic> _snapshot) {
    return Container(
      alignment: Alignment.center,
      child: Text(
        _snapshot['text_error'],
        style: TextStyle(
            fontSize: 18.0,
            color: Constants.grey500,
            fontWeight: FontWeight.w500),
      ),
    );
  }

  static List<DropdownMenuItem<String>> selectMenuItems(final Options _select) {
    List<DropdownMenuItem<String>> items = List();
    _select.productOptionValue.forEach((optionValue) {
      _optionValue = ProductOptionValue.fromJson(optionValue);
      items.add(
        DropdownMenuItem(
          value: _optionValue.productOptionValueId,
          child: Text(
            _optionValue.price != '' && _optionValue.price != 'false'
                ? _optionValue.name +
                    ' (' +
                    _optionValue.pricePrefix +
                    _optionValue.price +
                    ')'
                : _optionValue.name,
            style: TextStyle(color: Colors.green, fontSize: 13.0),
          ),
        ),
      );
    });
    return items;
  }

  static List<DropdownMenuItem<String>> countryMenuItems(
      final List<dynamic> _countries) {
    List<DropdownMenuItem<String>> items = List();
    _countries.forEach((_countryItem) {
      Countries _country = Countries.fromJson(_countryItem);
      items.add(
        DropdownMenuItem<String>(
          value: _country.countryId,
          child: Text(
            _country.name,
            style: TextStyle(color: Colors.green, fontSize: 13.0),
          ),
        ),
      );
    });
    return items;
  }

  static List<DropdownMenuItem<String>> addressMenuItems(
      final dynamic _addresses) {
    List<DropdownMenuItem<String>> items = List();
    _addresses.forEach((_key, _value) {
      items.add(
        DropdownMenuItem<String>(
          value: _value['address_id'],
          child: Text(
            '${_value['firstname']} ${_value['lastname']}, ${_value['address_1']}, ${_value['city']}, ${_value['zone']}, ${_value['country']}',
            style: TextStyle(color: Colors.green, fontSize: 12.0),
          ),
        ),
      );
    });
    return items;
  }

  static List<DropdownMenuItem<String>> stateMenuItems(
      final List<dynamic> _states) {
    List<DropdownMenuItem<String>> items = List();
    _states.forEach((_stateItem) {
      Zones _zone = Zones.fromJson(_stateItem);
      items.add(
        DropdownMenuItem<String>(
          value: _zone.zoneId.toString(),
          child: Text(
            _zone.name,
            style: TextStyle(color: Colors.green, fontSize: 13.0),
          ),
          onTap: () {
            print("onTapId:= ${_zone.zoneId}, name:= ${_zone.name}");
          },
        ),
      );
    });
    return items;
  }

  static List<FormBuilderFieldOption> radioButton(final Options _radio) {
    List<FormBuilderFieldOption> items = List();
    _radio.productOptionValue.forEach((optionValue) {
      _optionValue = ProductOptionValue.fromJson(optionValue);
      items.add(
        FormBuilderFieldOption(
            value: _optionValue.productOptionValueId,
            child: Text(
              _optionValue.name,
              style: TextStyle(fontSize: 13.0),
            )),
      );
    });
    return items;
  }

  static List<FormBuilderFieldOption> paymentMethodRadioGroup(
      final Map<String, dynamic> _method) {
    List<FormBuilderFieldOption> _items = List();
    _method.forEach((_key, _methodItem) {
      _items.add(
        FormBuilderFieldOption(
            value: _methodItem['code'],
            child: Text(
              _methodItem['title'],
              style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                  color: Constants.grey700),
            )),
      );
    });
    return _items;
  }

  static List<FormBuilderFieldOption> paymentTypeRadioGroup(
      final Map<String, dynamic> _types) {
    List<FormBuilderFieldOption> _items = List();
    _types.forEach((_key, _typeItem) {
      _items.add(
        FormBuilderFieldOption(
          value: _typeItem['prod_opt'],
          child: Text(
            _typeItem['text_prod_opt'],
            style: TextStyle(fontSize: 13.0, color: Constants.grey600),
          ),
        ),
      );
    });
    return _items;
  }

  static List<FormBuilderFieldOption> checkboxGroup(final Options _checkbox) {
    List<FormBuilderFieldOption> items = List();
    _checkbox.productOptionValue.forEach((optionValue) {
      _optionValue = ProductOptionValue.fromJson(optionValue);
      items.add(
        FormBuilderFieldOption(
          value: _optionValue.productOptionValueId,
          child: Text(
            _optionValue.name,
            style: TextStyle(
              fontSize: 13.0,
            ),
          ),
        ),
      );
    });
    return items;
  }

  static List<FormBuilderFieldOption> addressTypeOptions(
      final dynamic _addresses) {
    List<FormBuilderFieldOption> _items = List();
    _addresses != null && _addresses.length > 0
        ? _addressTypeList2.forEach((_item) {
            _items.add(
              FormBuilderFieldOption(
                value: _item['id'],
                child: Text(
                  _item['name'],
                  style: _addressStyle,
                ),
              ),
            );
          })
        : _addressTypeList1.forEach((_item) {
            _items.add(
              FormBuilderFieldOption(
                value: _item['id'],
                child: Text(
                  _item['name'],
                  style: _addressStyle,
                ),
              ),
            );
          });
    return _items;
  }

  static List<Widget> cartOptionWidget(final List<dynamic> _options) {
    List<Widget> _widgets = List();
    _options.forEach((optionValue) {
      CartProductsOptionData _cartProductsOptionData =
          CartProductsOptionData.fromJson(optionValue);
      _widgets.add(
        Column(
          crossAxisAlignment: _cStart,
          mainAxisAlignment: _mStart,
          children: <Widget>[
            RichText(
              textAlign: TextAlign.left,
              text: TextSpan(
                  text: _cartProductsOptionData.name + ": ",
                  style: TextStyle(
                    color: Constants.grey800,
                    fontSize: 15.0,
                  ),
                  children: [
                    TextSpan(
                      text: _cartProductsOptionData.value,
                      style: TextStyle(
                        color: Constants.grey600,
                      ),
                    ),
                  ]),
            ),
            Constants.height(4),
          ],
        ),
      );
    });
    return _widgets;
  }

  static List<Widget> totalsWidget(final List<dynamic> _options) {
    List<Widget> _widgets = List();
    _options.forEach((optionValue) {
      CartTotalsData _cartTotalsData = CartTotalsData.fromJson(optionValue);
      _widgets.add(
        Table(
          border: TableBorder.all(width: 0.5),
          children: [
            TableRow(children: [
              TableCell(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
                  child: Text(
                    _cartTotalsData.title + ": ",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Constants.grey700,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                    ),
                  ),
                ),
              ),
              TableCell(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                  child: Text(
                    _cartTotalsData.text,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Constants.grey500,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                      fontSize: 14.0,
                    ),
                  ),
                ),
              ),
            ]),
          ],
        ),
      );
    });
    return _widgets;
  }

  static Widget orderDetails(final OrderData _order, BuildContext context) {
    final EdgeInsets _padding =
        EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0);
    final TextStyle _textStyle1 = TextStyle(
      color: Constants.grey700,
      fontWeight: FontWeight.w700,
      fontSize: 16.0,
    );
    final TextStyle _textStyle2 = TextStyle(
      color: Constants.grey600,
      fontWeight: FontWeight.w500,
      fontSize: 16.0,
    );
    return Column(
      children: [
        Center(
          child: Container(
            alignment: Alignment.center,
            height: 40.0,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Constants.grey300,
              border: Border(
                  left: BorderSide(width: 0.5, color: Constants.grey800),
                  right: BorderSide(width: 0.5, color: Constants.grey800),
                  top: BorderSide(width: 0.5, color: Constants.grey800)),
            ),
            child: Text(
              "Order Details",
              style: _headingStyle,
            ),
          ),
        ),
        Table(
          border: TableBorder.all(width: 0.5),
          children: [
            TableRow(children: [
              TableCell(
                child: Padding(
                  padding: _padding,
                  child: RichText(
                    text: TextSpan(
                        text: "Order ID: ",
                        style: _textStyle1,
                        children: [
                          TextSpan(
                            text: _order.orderId,
                            style: _textStyle2,
                          ),
                        ]),
                  ),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: _padding,
                  child: RichText(
                    text: TextSpan(
                        text: "Payment Method: ",
                        style: _textStyle1,
                        children: [
                          TextSpan(
                            text: _order.paymentMethod,
                            style: _textStyle2,
                          ),
                        ]),
                  ),
                ),
              ),
            ]),
            TableRow(children: [
              TableCell(
                child: Padding(
                  padding: _padding,
                  child: RichText(
                    text: TextSpan(
                        text: "Date Added: ",
                        style: _textStyle1,
                        children: [
                          TextSpan(
                            text: _order.dateAdded,
                            style: _textStyle2,
                          ),
                        ]),
                  ),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: _padding,
                  child: RichText(
                    text: TextSpan(
                        text: "Shipping Method: ",
                        style: _textStyle1,
                        children: [
                          TextSpan(
                            text: _order.shippingMethod,
                            style: _textStyle2,
                          ),
                        ]),
                  ),
                ),
              ),
            ]),
          ],
        ),
      ],
    );
  }

  static Widget addressSection(final OrderData _order, BuildContext context) {
    final EdgeInsets _padding =
        EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0);
    return Table(
      border: TableBorder.all(width: 0.5),
      children: [
        TableRow(
            decoration: BoxDecoration(
              color: Constants.grey300,
            ),
            children: [
              TableCell(
                child: Padding(
                  padding: _padding,
                  child: Text(
                    "Payment Address",
                    textAlign: TextAlign.left,
                    style: _headingStyle,
                  ),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: _padding,
                  child: Text(
                    "Shipping Address",
                    textAlign: TextAlign.left,
                    style: _headingStyle,
                  ),
                ),
              ),
            ]),
        TableRow(children: [
          TableCell(
            child: Padding(
              padding: _padding,
              child: Text(
                _order.paymentAddress,
                textAlign: TextAlign.left,
                style: TextStyle(color: Constants.grey600),
              ),
            ),
          ),
          TableCell(
            child: Padding(
              padding: _padding,
              child: Text(
                _order.shippingAddress,
                textAlign: TextAlign.left,
                style: TextStyle(color: Constants.grey600),
              ),
            ),
          ),
        ]),
      ],
    );
  }

  static Widget _productWidget(final List<dynamic> _products, BuildContext context) {
    TextStyle _keyStyle = TextStyle(
      color: Constants.grey800,
      fontSize: 17.5,
    );
    TextStyle _valueStyle = TextStyle(
      color: Constants.grey600,
      fontSize: 18.0,
    );
    List<Widget> _productList() {
      List<Widget> _widgets = List();
      _products.forEach((_element) {
        Products _product = Products.fromJson(_element);
        _widgets.add(
          Column(
            crossAxisAlignment: _cStart,
            mainAxisAlignment: _mStart,
            children: [
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: "Product Name: ",
                    style: _keyStyle,
                    children: [
                      TextSpan(
                        text: _product.name,
                        style: _valueStyle,
                      ),
                    ]),
              ),
              Constants.height(5.0),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(text: "Model: ", style: _keyStyle, children: [
                  TextSpan(
                    text: _product.model,
                    style: _valueStyle,
                  ),
                ]),
              ),
              Constants.height(5.0),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(text: "Quantity: ", style: _keyStyle, children: [
                  TextSpan(
                    text: _product.quantity,
                    style: _valueStyle,
                  ),
                ]),
              ),
              Constants.height(5.0),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(text: "Price: ", style: _keyStyle, children: [
                  TextSpan(
                    text: _product.price,
                    style: _valueStyle,
                  ),
                ]),
              ),
              Constants.height(5.0),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(text: "Total: ", style: _keyStyle, children: [
                  TextSpan(
                    text: _product.total,
                    style: _valueStyle,
                  ),
                ]),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    child: WidgetPage.reorder(),
                    onTap: () async {
                      Constants.showShortToastBuilder('Added');
                      /*MaterialPageRoute _route =
                      MaterialPageRoute(builder: (context) => ProductDetails());
                      Navigator.push(context, _route);*/
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      });
      return _widgets;
    }

    return Column(
      crossAxisAlignment: _cStart,
      mainAxisAlignment: _mStart,
      children: _productList(),
    );
  }

  static Widget _priceWidget(final List<dynamic> _totals) {
    TextStyle _keyStyle = TextStyle(
      color: Constants.grey800,
      fontSize: 17.5,
    );
    TextStyle _valueStyle = TextStyle(
      color: Constants.grey600,
      fontSize: 18.0,
    );
    List<Widget> _priceList() {
      List<Widget> _widgets = List();
      _totals.forEach((_element) {
        Totals _price = Totals.fromJson(_element);
        _widgets.add(
          Column(
            crossAxisAlignment: _cStart,
            mainAxisAlignment: _mStart,
            children: [
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: "${_price.title}: ",
                    style: _keyStyle,
                    children: [
                      TextSpan(
                        text: _price.text,
                        style: _valueStyle,
                      ),
                    ]),
              ),
              Constants.height(5.0),
            ],
          ),
        );
      });
      return _widgets;
    }

    return Column(
      crossAxisAlignment: _cStart,
      mainAxisAlignment: _mStart,
      children: _priceList(),
    );
  }

  static Widget productDetailSection(
      final OrderData _order, BuildContext context) {
    return Column(
      crossAxisAlignment: _cStart,
      mainAxisAlignment: _mStart,
      children: [
        Center(
          child: Container(
            alignment: Alignment.center,
            height: 40.0,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Constants.grey300,
              border: Border(
                  left: BorderSide(width: 0.5, color: Constants.grey800),
                  right: BorderSide(width: 0.5, color: Constants.grey800),
                  top: BorderSide(width: 0.5, color: Constants.grey800)),
            ),
            child: Text(
              "Product Details",
              style: _headingStyle,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(5.0),
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Constants.myWhite,
            border: Border.all(width: 0.7, color: Constants.grey800),
          ),
          child: Column(
            crossAxisAlignment: _cStart,
            mainAxisAlignment: _mStart,
            children: [
              _productWidget(_order.products, context),
              Divider(
                height: 20.0,
                color: Constants.grey500,
              ),
              _priceWidget(_order.totals),
            ],
          ),
        ),
      ],
    );
  }

  static Widget historySection(final OrderData _order, BuildContext context) {
    final EdgeInsets _padding =
        EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0);
    List<TableRow> _tableRows() {
      List<TableRow> _rows = List();
      _rows.add(TableRow(
          decoration: BoxDecoration(
            color: Constants.grey300,
          ),
          children: [
            TableCell(
              child: Padding(
                padding: _padding,
                child: Text(
                  "Product Name",
                  textAlign: TextAlign.left,
                  style: _headingStyle,
                ),
              ),
            ),
            TableCell(
              child: Padding(
                padding: _padding,
                child: Text(
                  "Date Added",
                  textAlign: TextAlign.left,
                  style: _headingStyle,
                ),
              ),
            ),
            TableCell(
              child: Padding(
                padding: _padding,
                child: Text(
                  "Status",
                  textAlign: TextAlign.left,
                  style: _headingStyle,
                ),
              ),
            ),
            TableCell(
              child: Padding(
                padding: _padding,
                child: Text(
                  "Comment",
                  textAlign: TextAlign.left,
                  style: _headingStyle,
                ),
              ),
            ),
            TableCell(
              child: Padding(
                padding: _padding,
                child: Text(
                  "Updated By",
                  textAlign: TextAlign.left,
                  style: _headingStyle,
                ),
              ),
            ),
          ]));
      _order.histories.forEach((_cellValue) {
        Histories _historyData = Histories.fromJson(_cellValue);
        _rows.add(
          TableRow(children: [
            TableCell(
              child: Padding(
                padding: _padding,
                child: Text(
                  "All",
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Constants.grey600),
                ),
              ),
            ),
            TableCell(
              child: Padding(
                padding: _padding,
                child: Text(
                  _historyData.dateAdded,
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Constants.grey600),
                ),
              ),
            ),
            TableCell(
              child: Padding(
                padding: _padding,
                child: Text(
                  _historyData.status,
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Constants.grey600),
                ),
              ),
            ),
            TableCell(
              child: Padding(
                padding: _padding,
                child: Text(
                  _historyData.comment,
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Constants.grey600),
                ),
              ),
            ),
            TableCell(
              child: Padding(
                padding: _padding,
                child: Text(
                  "Admin",
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Constants.grey600),
                ),
              ),
            ),
          ]),
        );
      });
      return _rows;
    }

    return Column(
      crossAxisAlignment: _cStart,
      mainAxisAlignment: _mStart,
      children: [
        Text("Order History",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0),),
        Constants.height(5.0),
        Table(
          border: TableBorder.all(width: 0.5),
          children: _tableRows(),
        ),
      ],
    );
  }

  static Widget shoppingCartIconButton(BuildContext context, int _itemInCart,
      ScrollController _scrollBottomBarController) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0, right: 20),
      child: Container(
        height: 150.0,
        width: 30.0,
        child: GestureDetector(
          onTap: () =>
              Navigator.push(context, MaterialPageRoute(builder: (context) {
            return Basket(_scrollBottomBarController);
          })),
          child: Stack(
            children: <Widget>[
              IconButton(
                iconSize: 30,
                icon: Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                ),
                onPressed: null,
              ),
              Positioned(
                child: Container(
                  width: 21.0,
                  height: 21.0,
                  child: Stack(
                    children: <Widget>[
                      Icon(Icons.brightness_1,
                          size: 21.0, color: Colors.yellow),
                      Center(
                        child: Text(
                          _itemInCart != null ? _itemInCart.toString() : '0',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 11.0,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  static Widget addButtonWidget() {
    return Container(
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
    );
  }

  static Widget reorder() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: Constants.red300,
        borderRadius: BorderRadius.circular(3),
      ),
      child: Text(
        "Reorder",
        style: TextStyle(
            color: Constants.myWhite,
            fontSize: 12.0,
            fontWeight: FontWeight.w500),
      ),
    );
  }

  static Widget textFormField(final TextEditingController _controller,
      final TextInputType _type, final String _label, final String _validator) {
    return TextFormField(
      controller: _controller,
      keyboardType: _type,
      autofocus: false,
      cursorColor: Constants.primary_green,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        labelText: _label,
        labelStyle: _labelStyle,
        contentPadding: _padding,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Constants.grey400, width: 0.5),
        ),
      ),
      validator: (_newVal) {
        if (_newVal.isEmpty) {
          return _validator;
        } else if (_label == 'Mobile') {
          if (_newVal.length < 10 || _newVal.length > 10) {
            return 'Mobile number must be 10 digits.';
          } else if (int.parse(_newVal[0]) == 6 ||
              int.parse(_newVal[0]) == 7 ||
              int.parse(_newVal[0]) == 8 ||
              int.parse(_newVal[0]) == 9) {
            return null;
          } else {
            return 'First digit must be either 6,7,8,9.';
          }
        } else if (_label == 'Post Code') {
          if (_newVal.length > 6 || _newVal.length < 6) {
            return 'post code must be 6 digit.';
          }
        }
        return null;
      },
    );
  }

  static Widget textFormFieldWithoutValidation(
      final TextEditingController _controller,
      final TextInputType _type,
      final String _label) {
    return TextFormField(
      controller: _controller,
      keyboardType: _type,
      autofocus: false,
      cursorColor: Constants.primary_green,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        labelText: _label,
        labelStyle: _labelStyle,
        contentPadding: _padding,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Constants.grey400, width: 0.5),
        ),
      ),
    );
  }

  static Widget _savedPriceStackView(final int _savedPrice) {
    return Positioned(
      left: 0,
      top: 0,
      child: Container(
        width: 45.0,
        height: 45.0,
        decoration: new BoxDecoration(
          color: Colors.redAccent,
          shape: BoxShape.circle,
        ),
        child: Column(
          mainAxisAlignment: _mCenter,
          crossAxisAlignment: _cCenter,
          children: <Widget>[
            Text(
              "$_savedPrice%\noff",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 9,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }

  static EdgeInsets _stackPadding(final int _savedPrice) {
    EdgeInsets _padding;
    if (_savedPrice != null && _savedPrice > 0) {
      _padding = EdgeInsets.only(top: 10.0);
    } else {
      _padding = EdgeInsets.only(top: 0);
    }
    return _padding;
  }

  static Widget productImageStack(final String _productId, final String _thumb,
      final String _customerId, final int _savedPrice, BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: _stackPadding(_savedPrice),
          height: 120.0,
          width: 100.0,
          child: InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () async => Constants.goToProductDetailsPage(
                _productId,
                _customerId != null && _customerId != "" ? _customerId : "-",
                context),
            child: FadeInImage(
              fit: BoxFit.fill,
              image: NetworkImage(_thumb != null && _thumb != '' ? _thumb : ''),
              placeholder:
                  AssetImage('assets/placeholders/no-product-image.png'),
            ),
          ),
        ),
        _savedPrice != null && _savedPrice > 0
            ? _savedPriceStackView(_savedPrice)
            : Container(),
      ],
    );
  }

  static Widget savedProductImage(final String _thumb) {
    return Container(
      height: 100.0,
      width: 100.0,
      child: FadeInImage(
        fit: BoxFit.fill,
        image: _thumb != null && _thumb != ''
            ? NetworkImage(_thumb != null && _thumb != '' ? _thumb : '')
            : AssetImage('assets/placeholders/no-product-image.png'),
        placeholder: AssetImage('assets/placeholders/no-product-image.png'),
      ),
    );
  }

  static Widget itemNameText(final String _productName) {
    return Column(
      crossAxisAlignment: _cStart,
      mainAxisAlignment: _mStart,
      children: <Widget>[
        Text(
          _productName,
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        Constants.height(5),
      ],
    );
  }

  static Widget itemQuantityText(
      final CartData _cartMap, final String _quantity) {
    return Column(
      crossAxisAlignment: _cStart,
      mainAxisAlignment: _mStart,
      children: <Widget>[
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              text: _cartMap != null &&
                      _cartMap.columnQuantity != null &&
                      _cartMap.columnQuantity != ""
                  ? _cartMap.columnQuantity + ": "
                  : "Quantity: ",
              style: TextStyle(
                color: Constants.grey800,
                fontSize: 15.0,
              ),
              children: [
                TextSpan(
                  text: _quantity,
                  style: TextStyle(
                    color: Constants.grey600,
                  ),
                ),
              ]),
        ),
        Constants.height(4),
      ],
    );
  }

  static Widget savedItemQuantityText(
      final SavedOrderData _savedMap, final String _quantity) {
    return Column(
      crossAxisAlignment: _cStart,
      mainAxisAlignment: _mStart,
      children: <Widget>[
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              text: _savedMap != null &&
                      _savedMap.columnQuantity != null &&
                      _savedMap.columnQuantity != ""
                  ? _savedMap.columnQuantity + ": "
                  : "Quantity: ",
              style: TextStyle(
                color: Constants.grey800,
                fontSize: 15.0,
              ),
              children: [
                TextSpan(
                  text: _quantity,
                  style: TextStyle(
                    color: Constants.grey600,
                  ),
                ),
              ]),
        ),
        Constants.height(4),
      ],
    );
  }

  static Widget optionWidget(final List<dynamic> _options) {
    return Column(
      crossAxisAlignment: _cStart,
      mainAxisAlignment: _mStart,
      children: WidgetPage.cartOptionWidget(_options),
    );
  }

  static Widget unitPrice(final CartData _cartMap, final String _price) {
    return Column(
      crossAxisAlignment: _cStart,
      mainAxisAlignment: _mStart,
      children: <Widget>[
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              text: _cartMap != null &&
                      _cartMap.columnPrice != null &&
                      _cartMap.columnPrice != ""
                  ? _cartMap.columnPrice + ": "
                  : "Unit Price: ",
              style: TextStyle(
                color: Constants.grey800,
                fontSize: 15.0,
              ),
              children: [
                TextSpan(
                  text: _price,
                  style: TextStyle(
                    color: Constants.grey600,
                  ),
                ),
              ]),
        ),
        Constants.height(4.0),
      ],
    );
  }

  static Widget savedOrderUnitPrice(
      final SavedOrderData _savedMap, final String _price) {
    return Column(
      crossAxisAlignment: _cStart,
      mainAxisAlignment: _mStart,
      children: <Widget>[
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              text: _savedMap != null &&
                      _savedMap.columnPrice != null &&
                      _savedMap.columnPrice != ""
                  ? _savedMap.columnPrice + ": "
                  : "Unit Price: ",
              style: TextStyle(
                color: Constants.grey800,
                fontSize: 15.0,
              ),
              children: [
                TextSpan(
                  text: _price,
                  style: TextStyle(
                    color: Constants.grey600,
                  ),
                ),
              ]),
        ),
        Constants.height(4.0),
      ],
    );
  }

  static Widget totalPrice(final CartData _cartMap, final String _price) {
    return Column(
      crossAxisAlignment: _cStart,
      mainAxisAlignment: _mStart,
      children: <Widget>[
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              text: _cartMap != null &&
                      _cartMap.columnTotal != null &&
                      _cartMap.columnTotal != ""
                  ? _cartMap.columnTotal + ": "
                  : "Total: ",
              style: TextStyle(
                color: Constants.grey800,
                fontSize: 15.0,
              ),
              children: [
                TextSpan(
                  text: _price,
                  style: TextStyle(
                    color: Constants.grey600,
                  ),
                ),
              ]),
        ),
        Constants.height(4.0),
      ],
    );
  }

  static Widget savedOrderTotalPrice(
      final SavedOrderData _savedMap, final String _price) {
    return Column(
      crossAxisAlignment: _cStart,
      mainAxisAlignment: _mStart,
      children: <Widget>[
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              text: _savedMap != null &&
                      _savedMap.columnTotal != null &&
                      _savedMap.columnTotal != ""
                  ? _savedMap.columnTotal + ": "
                  : "Total: ",
              style: TextStyle(
                color: Constants.grey800,
                fontSize: 15.0,
              ),
              children: [
                TextSpan(
                  text: _price,
                  style: TextStyle(
                    color: Constants.grey600,
                  ),
                ),
              ]),
        ),
        Constants.height(4.0),
      ],
    );
  }

  static Widget continueToShopping(
      final String _textError, BuildContext context) {
    return Container(
      color: Constants.myWhite,
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: _cCenter,
        mainAxisAlignment: _mCenter,
        children: <Widget>[
          Text(
            _textError,
            style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                color: Constants.grey700),
          ),
          Constants.height(25.0),
          RaisedButton(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
            textColor: Constants.myWhite,
            elevation: 0.0,
            color: Constants.myGreen,
            splashColor: Constants.myGreen,
            highlightColor: Constants.myGreen,
            onPressed: () =>
                Navigator.push(context, MaterialPageRoute(builder: (context) {
              return Home();
            })),
            child: Text(
              "Continue Shopping".toUpperCase(),
              style: TextStyle(fontSize: 12.0),
            ),
          )
        ],
      ),
    );
  }

  static Widget noItemFoundWidget() {
    return Container(
      alignment: Alignment.center,
      color: Constants.myWhite,
      child: Text(
        "No item found.",
        style: _noItemStyle,
      ),
    );
  }

  static Widget noItemFound(final String _message) {
    return Container(
      alignment: Alignment.center,
      color: Constants.myWhite,
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Text(
        _message,
        textAlign: TextAlign.center,
        style: _noItemStyle,
      ),
    );
  }

  static Widget noAddressFound(final String _message) {
    return Container(
      alignment: Alignment.center,
      color: Constants.myWhite,
      child: Text(
        _message,
        style: _noItemStyle,
      ),
    );
  }

  static Widget thatAllFolks(final int _listLen, final int _applyLen) {
    Widget _widget;
    if (_listLen >= _applyLen) {
      _widget = Container(
        padding: EdgeInsets.symmetric(vertical: 25.0),
        child: Row(
          mainAxisAlignment: _mCenter,
          children: <Widget>[
            Text("That's All folks!"),
          ],
        ),
      );
    } else {
      _widget = Container();
    }
    return _widget;
  }

  static Widget couponGiftAndRewardTextField(
      final TextEditingController _controller,
      final TextInputType _type,
      final String _label,
      final String _validator) {
    return TextFormField(
      controller: _controller,
      keyboardType: _type,
      autofocus: false,
      cursorColor: Constants.primary_green,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2.0),
          borderSide:
              const BorderSide(color: Constants.primary_green, width: 1),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2.0),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
        labelText: _label,
        labelStyle: _labelStyle,
      ),
      validator: (_newVal) {
        if (_newVal.isEmpty) {
          return _validator;
        }
        return null;
      },
    );
  }

  static Widget renderCartList(
      final Map<String, dynamic> _snapshot, BuildContext context) {
    Timer(Duration(seconds: 0), () async {
      await Constants.goToCartListPage(_snapshot, context);
    });
    return Container();
  }

  static richText(final String _text1, final String _text2) {
    return RichText(
      text: TextSpan(
          text: _text1,
          style: TextStyle(
            color: Constants.grey700,
            fontSize: 18.0,
          ),
          children: [
            TextSpan(
              text: _text2,
              style: TextStyle(
                color: Constants.grey800,
              ),
            ),
          ]),
    );
  }

  static AppBar viewMoreAppBar(
      final String _title, final BuildContext context) {
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
        _title,
        style: TextStyle(color: Constants.myWhite, fontSize: 16.0),
      ),
    );
  }

  static AppBar dynamicAppBar(final String _title) {
    return AppBar(
      elevation: 0.0,
      centerTitle: true,
      title: Text(
        _title,
        style: TextStyle(
            color: Constants.myWhite,
            fontSize: 16.0,
            fontWeight: FontWeight.w500),
      ),
    );
  }

  static AppBar updateProfileAppBar() {
    return AppBar(
      elevation: 0.0,
      centerTitle: true,
      title: Text(
        "Update Profile",
        style: TextStyle(
            color: Constants.myWhite,
            fontSize: 16.0,
            fontWeight: FontWeight.w500),
      ),
    );
  }

  static AppBar orderHistoryAppBar() {
    return AppBar(
      elevation: 0.0,
      centerTitle: true,
      title: Text(
        "Order History",
        style: TextStyle(
            color: Constants.myWhite,
            fontSize: 16.0,
            fontWeight: FontWeight.w500),
      ),
    );
  }

  static AppBar passwordAppBar() {
    return AppBar(
      elevation: 0.0,
      centerTitle: true,
      title: Text(
        "Password Change",
        style: TextStyle(
            color: Constants.myWhite,
            fontSize: 16.0,
            fontWeight: FontWeight.w500),
      ),
    );
  }

  static AppBar addNewAddressAppBar() {
    return AppBar(
      elevation: 0.0,
      centerTitle: true,
      title: Text(
        'Add New Address',
        style: TextStyle(fontFamily: 'Gotham', fontSize: 16.0),
      ),
    );
  }

  static AppBar checkoutAppBar() {
    return AppBar(
      elevation: 0.0,
      centerTitle: true,
      title: Text(
        "Gwalior Cart",
        style: TextStyle(fontSize: 15.0),
      ),
    );
  }

  static AppBar addressBookAppBar() {
    return AppBar(
      elevation: 0.0,
      centerTitle: true,
      title: Text(
        "Address Book Entries",
        style: TextStyle(fontSize: 14.0),
      ),
    );
  }
}

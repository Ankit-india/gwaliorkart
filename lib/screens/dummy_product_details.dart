//import 'dart:convert';
//import 'dart:io';
//
//import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter_form_builder/flutter_form_builder.dart';
//import 'package:gwaliorkart/models/add_to_cart.dart';
//import 'package:gwaliorkart/models/product_detail_model.dart';
//import 'package:gwaliorkart/screens/basket.dart';
//import 'package:gwaliorkart/screens/check_box_page.dart';
//import 'package:gwaliorkart/screens/image_viewer.dart';
//import 'package:gwaliorkart/screens/product_ratings_and_reviews.dart';
//import 'package:gwaliorkart/screens/search_screen.dart';
//import 'package:gwaliorkart/screens/wish_list.dart';
//import 'package:gwaliorkart/utils/auth_utils.dart';
//import 'package:gwaliorkart/utils/constants.dart';
//import 'package:gwaliorkart/widgets/widget_page.dart';
//import 'package:image_picker/image_picker.dart';
//import 'package:intl/intl.dart';
//
//class DummyProductDetails extends StatefulWidget {
//  final Map<String, dynamic> snapshot;
//
//  DummyProductDetails(this.snapshot);
//
//  @override
//  _DummyProductDetailsState createState() => _DummyProductDetailsState();
//}
//
//class _DummyProductDetailsState extends State<DummyProductDetails>
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
//  bool _isAdded, _isSaved, _checkInput = false, _isClicked = false;
//  int _quantity;
//  TextStyle myStyle = TextStyle(fontFamily: 'Gotham', fontSize: 13);
//  TextStyle myStyleSmall =
//      TextStyle(fontFamily: 'Gotham', fontSize: 12, color: Colors.grey[600]);
//  String _customerId,
//      _selectInput,
//      _radioInput,
//      _date,
//      _time,
//      _dateTime,
//      _sellingPrice,
//      _costPrice,
//      _savedPercent,
//      _productImage,
//      vouchers,
//      coupon,
//      reward, _imageCode = '6f6eb498fe0c06ccaa9a6bac890b8399b6bdcd3e';
//  Size _deviceSize;
//  File _image;
//  final DateFormat _dateFormat = DateFormat("yyyy-MM-dd"),
//      _dateTimeFormat = DateFormat("yyyy-MM-dd HH:mm"),
//      _timeFormat = DateFormat("HH:mm");
//  final GlobalKey<FormBuilderState> _radioKey = GlobalKey<FormBuilderState>();
//  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
//  Map<String, dynamic> option = {};
//
//  @override
//  void initState() {
//    super.initState();
//    _customerId = AuthUtils.userId;
//    _textController = TextEditingController();
//    _textAreaController = TextEditingController();
//    _dateController = TextEditingController(
//        text:
//            '${DateTime.now().toLocal().year.toString()}-${DateTime.now().toLocal().month.toString()}-${DateTime.now().toLocal().day.toString()}');
//    _dateTimeController = TextEditingController(
//        text:
//            '${DateTime.now().toLocal().year.toString()}-${DateTime.now().month.toString()}-${DateTime.now().day.toString()} ${DateTime.now().hour.toString()}:${DateTime.now().minute.toString()}');
//    _timeController = TextEditingController(
//        text:
//            '${DateTime.now().toLocal().hour.toString()}:${DateTime.now().toLocal().minute.toString()}');
//    if (widget.snapshot != null) {
//      _selectedProduct = widget.snapshot;
//      _product = ProductDetailData.fromJson(widget.snapshot);
//      _product.price != '' ? _costPrice = _product.price : _costPrice = '';
//      _product.thumb != null && _product.thumb != ''
//          ? _productImage = _product.thumb
//          : _productImage = '';
//      _quantity = 1;
//      _isAdded = false;
//      _isSaved = false;
//    }
//    _date = DateTime.now().toLocal().toString().split(" ")[0];
//  }
//
//  void _uploadFile(BuildContext context) {
//    Constants.showLoadingIndicator(context);
//    UploadFileData _fileParam = UploadFileData(_image);
//
//    UploadFileUtils.uploadFile(_fileParam).then((dynamic _res) {
//      if (_res != null && _res != '') {
//        print("\n_uploadFile_res:= $_res\n");
//        Navigator.of(context).pop();
//        Constants.showShortToastBuilder('Your file was successfully uploaded.');
//      } else {
//        print("\n_uploadFile_res:= $_res\n");
//        Navigator.of(context).pop();
//        Constants.showShortToastBuilder('File upload failed');
//      }
//    }).catchError((_err) {
//      Navigator.of(context).pop();
//      print('\n_uploadFile catchError:= $_err\n');
//    });
//  }
//
//  Future _addToCartProduct(BuildContext context) async {
//    if(_product.options != null && _product.options.length > 0){
//      if(_formKey.currentState.validate()){
//        _formKey.currentState.save();
//        Constants.showLoadingIndicator(context);
////        print("\nproductId:= ${_product.productId}, customerId:= $_customerId, quantity:= $_quantity, selectInput:= $_selectInput, radioInput:= $_radioInput, checkInput:= $_checkInput, textController:= ${_textController.text}, textAreaController:= ${_textAreaController.text}, image:= $_image, dateController:= ${_dateController.text}, dateTimeController:= ${_dateTimeController.text}, timeController:= ${_timeController.text}\n");
//
//        _product.options.forEach((_optionItem) {
//          if (_optionItem != null && _optionItem.length > 0) {
//            _options = Options.fromJson(_optionItem);
//            if (_options.type == 'select') {
//              option['option'+_options.productOptionId] = _selectInput;
//            }else if (_options.type == 'radio') {
//              option['option'+_options.productOptionId] = _radioInput;
//            }else if (_options.type == 'checkbox') {
//              option['option'+_options.productOptionId] = _checkInput;
//            }else if (_options.type == 'text') {
//              option['option'+_options.productOptionId] = _textController.text;
//            }else if (_options.type == 'textarea') {
//              option['option'+_options.productOptionId] = _textAreaController.text;
//            }else if (_options.type == 'file') {
//              option['option'+_options.productOptionId] = _imageCode;
//            }else if (_options.type == 'date') {
//              option['option'+_options.productOptionId] = _dateController.text;
//            }else if (_options.type == 'datetime') {
//              option['option'+_options.productOptionId] = _dateTimeController.text;
//            }else if (_options.type == 'time') {
//              option['option'+_options.productOptionId] = _timeController.text;
//            }
//          }
//        });
//
//        AddToCartData _cartParams = AddToCartData(_product.productId, _customerId,
//            _quantity, option.toString(), vouchers, coupon, reward);
//
//        await AddToCartUtils.addToCart(_cartParams).then((dynamic _cartRes) {
//          if (_cartRes != null) {
//            print("addToCart_res:= $_cartRes");
//            setState(() {
//              _isAdded = true;
//            });
//            Navigator.of(context).pop();
//            Constants.showShortToastBuilder("Item added into the kart");
//          } else {
//            print("addToCart_res:= $_cartRes");
//            Navigator.of(context).pop();
//            Constants.showShortToastBuilder('Add to cart failed');
//          }
//        }).catchError((_err) {
//          Navigator.of(context).pop();
//          print('addToCart catchError:= $_err');
//          Constants.showShortToastBuilder('Oops something is wrong..');
//        });
//      }else{
//        return null;
//      }
//    }else{
//      Constants.showLoadingIndicator(context);
////      print("\nproductId:= ${_product.productId}, customerId:= $_customerId, quantity:= $_quantity, selectInput:= $_selectInput, radioInput:= $_radioInput, checkInput:= $_checkInput, textController:= ${_textController.text}, textAreaController:= ${_textAreaController.text}, image:= $_image, dateController:= ${_dateController.text}, dateTimeController:= ${_dateTimeController.text}, timeController:= ${_timeController.text}\n");
//      AddToCartData _cartParams = AddToCartData(_product.productId, _customerId,
//          _quantity, json.decode(option.toString()), vouchers, coupon, reward);
//
//      await AddToCartUtils.addToCart(_cartParams).then((dynamic _cartRes) {
//        if (_cartRes != null) {
//          print("addToCart_res:= $_cartRes");
//          setState(() {
//            _isAdded = true;
//          });
//          Navigator.of(context).pop();
//          Constants.showShortToastBuilder("Item added into the kart");
//        } else {
//          print("addToCart_res:= $_cartRes");
//          Navigator.of(context).pop();
//          Constants.showShortToastBuilder('Add to cart failed');
//        }
//      }).catchError((_err) {
//        Navigator.of(context).pop();
//        print('addToCart catchError:= $_err');
//        Constants.showShortToastBuilder('Oops something is wrong..');
//      });
//    }
//  }
//
//  void _removeToCartButton() {
//    if (_quantity != null && _quantity >= 1) {
//      setState(() {
//        _quantity = _quantity - 1;
//      });
//      if (_quantity != null && _quantity == 0) {
//        setState(() {
//          _isAdded = false;
//          _quantity = _quantity + 1;
//          Constants.showShortToastBuilder('Item removed');
//        });
//      }
//    }
//  }
//
//  void _addToCartButton() {
//    if (_quantity != null && _quantity >= 1) {
//      setState(() {
//        _quantity = _quantity + 1;
//      });
//    }
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
//  Widget _productDetailViewBuilder(Map<String, dynamic> snapshot) {
//    if (snapshot.containsKey('text_error')) {
//      return WidgetPage.errorWidget(snapshot);
//    } else {
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
//      TextStyle _richTextStyle = TextStyle(
//          fontWeight: FontWeight.w500, fontSize: 16.5, color: Colors.black);
//      TextStyle _radioTextStyle = TextStyle(
//          fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black);
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
//      List<Widget> _checkboxButton(final Options _checkbox) {
//        List<Widget> items = List();
////        if (_checkInput == false) {
////          setState(() {
////            this._checkInput = true;
////          });
////        }
//        _checkbox.productOptionValue.forEach((optionValue) {
//          _optionValue = ProductOptionValue.fromJson(optionValue);
//          items.add(
//            Row(
//              mainAxisAlignment: _mStart,
//              children: <Widget>[
//                Text(
//                  _optionValue.name,
//                  style: TextStyle(
//                    fontSize: 13.0,
//                  ),
//                ),
////                Checkbox(
////                  visualDensity: VisualDensity.compact,
////                  activeColor: Constants.myGreen,
////                  value: _checkInput,
//////                  value: _checkbox.productOptionValue[0]['product_option_value_id'],
////                  onChanged: (_val) {
////                    setState(() {
////                      this._checkInput = _val;
////                      print("changed value:= $_checkInput");
////                    });
////                  },
////                ),
//                FormField(
//                  validator: (bool _value) {
//                    if (_checkbox.required == '1') {
//                      if (_value == false) {
//                        return 'Please select an option!';
//                      }
//                    }
//                    return null;
//                  },
//                  builder: (FormFieldState<dynamic> field) {
//                    return Checkbox(
//                      visualDensity: VisualDensity.compact,
//                      activeColor: Constants.myGreen,
//                      value: _checkInput,
////                  value: _checkbox.productOptionValue[0]['product_option_value_id'],
//                      onChanged: (_newCheckVal) {
//                        setState(() {
//                          _checkInput = _newCheckVal;
//                          print("_newCheckVal:= $_checkInput");
//                        });
//                      },
//                    );
//                  },
//                ),
//              ],
//            ),
//          );
//        });
//        return items;
//      }
//
//      Widget _selectTypeWidget(final Options _selectData) {
//        if (_selectInput == null) {
//          setState(() {
//            _selectInput =
//                _selectData.productOptionValue[0]['product_option_value_id'];
//          });
//        }
//        return Column(
//          mainAxisAlignment: _mStart,
//          crossAxisAlignment: _cStart,
//          children: <Widget>[
//            Constants.height(20.0),
//            _selectData.required != null && _selectData.required != ''
//                ? RichText(
//                    text:
//                        TextSpan(text: '* ', style: _textSpanStyle, children: [
//                      TextSpan(
//                        text: _selectData.name,
//                        style: _richTextStyle,
//                      ),
//                    ]),
//                  )
//                : Text(
//                    _selectData.name,
//                    style: _ddNameStyle,
//                  ),
//            Constants.height(10.0),
//            Container(
//              width: _deviceSize.width,
////              height: 40,
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
//                        ProductOptionValue.fromJson(optionElement);
//                    if (_optionElement.productOptionValueId == _newSelectVal) {
//                      setState(() {
//                        _optionElement.price != '' &&
//                                _optionElement.price != 'false'
//                            ? _costPrice = _optionElement.price
//                            : _costPrice = _product.price;
//                        _optionElement.image != '' &&
//                                _optionElement.image != null
//                            ? _productImage = _optionElement.image
//                            : _productImage =
//                                _product.thumb != null && _product.thumb != ''
//                                    ? _product.thumb
//                                    : '';
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
//                _radioData.productOptionValue[0]['product_option_value_id'];
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
//                        text: TextSpan(
//                            text: '* ',
//                            style: _textSpanStyle,
//                            children: [
//                              TextSpan(
//                                text: _radioData.name,
//                                style: _richTextStyle,
//                              ),
//                            ]),
//                      )
//                    : Text(
//                        _radioData.name,
//                        style: _ddNameStyle,
//                      ),
//                FormBuilderRadioGroup(
//                  initialValue: _radioInput,
//                  attribute: "best_language",
//                  activeColor: Constants.myGreen,
//                  options: WidgetPage.radioButton(_radioData),
//                  onChanged: (_newRadioVal) {
//                    _radioData.productOptionValue.forEach((optionElement) {
//                      ProductOptionValue _optionElement =
//                          ProductOptionValue.fromJson(optionElement);
//                      if (_optionElement.productOptionValueId == _newRadioVal) {
//                        setState(() {
//                          _optionElement.price != '' &&
//                                  _optionElement.price != 'false'
//                              ? _costPrice = _optionElement.price
//                              : _costPrice = _product.price;
//                          _optionElement.image != '' &&
//                                  _optionElement.image != null
//                              ? _productImage = _optionElement.image
//                              : _productImage =
//                                  _product.thumb != null && _product.thumb != ''
//                                      ? _product.thumb
//                                      : '';
//                        });
//                      }
//                    });
//                  },
//                  validators: [
//                    _radioData.required == '1'
//                        ? FormBuilderValidators.required(
//                            errorText: 'Please select an ' +
//                                _radioData.name.toLowerCase() +
//                                '!')
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
//        return Column(
//          mainAxisAlignment: _mStart,
//          crossAxisAlignment: _cStart,
//          children: <Widget>[
//            Constants.height(20.0),
//            _checkboxData.required != null && _checkboxData.required != ''
//                ? RichText(
//                    text:
//                        TextSpan(text: '* ', style: _textSpanStyle, children: [
//                      TextSpan(
//                        text: _checkboxData.name,
//                        style: _richTextStyle,
//                      ),
//                    ]),
//                  )
//                : Text(
//                    _checkboxData.name,
//                    style: _ddNameStyle,
//                  ),
//            Constants.height(10.0),
//            Container(
//              width: _deviceSize.width,
////              height: 30,
//              child: Row(
//                mainAxisAlignment: _mStart,
//                children: _checkboxButton(_checkboxData),
//              ),
//            ),
//            Constants.height(20.0),
//          ],
//        );
//      }
//
//      Widget _textTypeWidget(final Options _textData) {
//        return Column(
//          crossAxisAlignment: _cStart,
//          mainAxisAlignment: _mStart,
//          children: <Widget>[
//            Constants.height(20.0),
//            TextFormField(
//              controller: _textController,
//              keyboardType: TextInputType.text,
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
//        ).then((final File _res) {
//          print("Selected File:= $_res");
//          if (_res != null) {
//            setState(() {
//              _image = _res;
//              _isClicked = true;
//              _uploadFile(context);
//            });
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
//              onPressed: _getImage,
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
//                ? _image == null
//                    ? Container(
//                        padding: EdgeInsets.only(top: 3.0),
//                        child: Text(
//                          "This field is required.",
//                          style: TextStyle(
//                              fontSize: 13.0,
//                              color: Colors.red,
//                              letterSpacing: 0.5),
//                        ),
//                      )
//                    : Container()
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
//                    print("dateFormat:= $_changedDate, Date:= $_date");
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
//                print("_newDate:= $_newDate");
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
//                        _changedDateTime.toLocal().toString().split(".")[0];
//                    print(
//                        "dateFormat:= $_changedDateTime, DateTime:= $_dateTime");
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
//                        TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
//                  );
//                  return DateTimeField.combine(date, time);
//                } else {
//                  return currentValue;
//                }
//              },
//              validator: (DateTime _newDateTime) {
//                print("_newDateTime:= $_newDateTime");
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
//                    print("dateFormat:= $_changedTime, Time:= $_time");
//                  });
//                }
//              },
//              format: _timeFormat,
//              onShowPicker: (context, currentValue) async {
//                final time = await showTimePicker(
//                  context: context,
//                  initialTime:
//                      TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
//                );
//                return DateTimeField.convert(time);
//              },
//              validator: (DateTime _newTime) {
//                print("_newTime:= $_newTime");
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
//                  .add(WidgetPage.availableOptionsTitle(_product.textOption))
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
//                    ? _widgetItems.add(_textAreaTypeWidget(_textOption))
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
//          autovalidate: false,
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
//                      Column(
//                        crossAxisAlignment: _cStart,
//                        mainAxisAlignment: _mStart,
//                        children: <Widget>[
//                          Constants.height(10.0),
//                          Text(
//                            "Item Specifics",
//                            style: TextStyle(
//                                fontWeight: FontWeight.w500, fontSize: 17.0),
//                          ),
//                          Constants.height(5.0),
//                          Text(
//                            _attributeGroups.name,
//                            style: TextStyle(color: Constants.grey500),
//                          ),
//                          Divider(height: 40.0),
//                        ],
//                      ),
//                    )
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
//                          crossAxisAlignment: _cStart,
//                          mainAxisAlignment: _mStart,
//                          children: <Widget>[
//                            Divider(height: 30.0),
//                            Text(
//                              _attributeGroups.name,
//                              style: _ddNameStyle,
//                            ),
//                            Constants.height(5.0),
//                            Text(
//                              _attribute.name,
//                              style: TextStyle(color: Constants.grey500),
//                            ),
//                            Constants.height(10.0),
//                          ],
//                        ))
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
//                              _product.rating != null &&
//                              _product.rating >= 0
//                          ? WidgetPage.ratingWidget(_product.rating,
//                              _product.reviews, _product, context)
//                          : Container()
//                      : Container(),
////                  _ratingWidget(),
//                  Constants.height(30.0),
//                  _product != null
//                      ? _product.thumb != null
//                          ? _productImage != null
//                              ? WidgetPage.productImageWidget(
//                                  _productImage, _product, context)
//                              : Container()
//                          : Container()
//                      : Container(),
////                  _productImageWidget,
//                  Constants.height(30.0),
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
//                          _product.attributeGroups.length > 0
//                      ? _itemSpecificsWidget(_product.attributeGroups)
//                      : Container(),
//                  _product.description != null
//                      ? WidgetPage.productDescription(_product.description)
//                      : Container(),
//                  _product.attributeGroups != null &&
//                          _product.attributeGroups.length > 0
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
//          ? () {
//              setState(() {
//                _isSaved = true;
//                Constants.showShortToastBuilder('Added to wish list');
//              });
//            }
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
//        onTap: () async => _addToCartProduct(context),
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
//              onTap: () async => _removeToCartButton(),
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
//              onTap: () async => _addToCartButton(),
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

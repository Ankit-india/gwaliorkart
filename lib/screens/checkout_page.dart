// import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:gwaliorkart/models/billing_address_data.dart';
// import 'package:gwaliorkart/models/location_data.dart';
// import 'package:gwaliorkart/models/payment_data.dart';
// import 'package:gwaliorkart/models/shipping_address_data.dart';
// import 'package:gwaliorkart/screens/auth_login.dart';
// import 'package:gwaliorkart/screens/confirm_order.dart';
// import 'package:gwaliorkart/utils/auth_utils.dart';
// import 'package:gwaliorkart/utils/constants.dart';
// import 'package:gwaliorkart/widgets/widget_page.dart';
//
// class CheckoutPage extends StatefulWidget {
//   final dynamic addresses;
//   final CountryData countryData;
//   final ZoneData zoneData;
//
//   CheckoutPage(this.addresses, this.countryData, this.zoneData);
//
//   @override
//   _CheckoutPageState createState() => _CheckoutPageState();
// }
//
// class _CheckoutPageState extends State<CheckoutPage> {
//   MainAxisAlignment _mStart = MainAxisAlignment.start;
//   MainAxisAlignment _mCenter = MainAxisAlignment.center;
//   CrossAxisAlignment _cStart = CrossAxisAlignment.start;
//   CrossAxisAlignment _cCenter = CrossAxisAlignment.center;
//   dynamic _addresses;
//   Size _deviceSize;
//   int _totalEWalletStatus;
//   String _token,
//       _customerId,
//       _countryId,
//       _zoneId,
//       _initialValue,
//       _shippingMethodTitle,
//       _shippingMethodFlatCode,
//       _shippingMethodFlatTitle,
//       _shippingMethodFlatCost,
//       _shippingMethodFlatTaxClassId,
//       _shippingMethodFlatText,
//       _textShippingMethod,
//       _textComments,
//       _billingAddressId,
//       _shippingAddressId,
//       _paymentMethodCode,
//       _paymentMethodTitle,
//       _paymentMethodTerms,
//       _paymentMethodSortOrder,
//       _paymentMethodMerchantKey,
//       _paymentMethodSalt,
//       _totalProdStatus,
//       _textProdOpt,
//       _prodOpt,
//       _vouchers,
//       _coupon,
//       _reward;
//   TextEditingController _firstName,
//       _lastName,
//       _company,
//       _email,
//       _address1,
//       _address2,
//       _city,
//       _postCode,
//       _shippingMethodComment,
//       _paymentMethodComment,
//       _saveOrderComment;
//   GlobalKey<FormState> _billingAddressKey,
//       _billingAddressListKey,
//       _deliveryAddressListKey,
//       _deliveryAddressKey,
//       _deliveryMethodKey,
//       _paymentMethodKey,
//       _confirmOrderKey;
//   bool _billingAddressValidate = false,
//       _billingAddressListValidate = false,
//       _deliveryAddressListValidate = false,
//       _deliveryAddressValidate = false,
//       _deliveryMethodValidate = false,
//       _paymentMethodValidate = false,
//       _confirmOrderValidate = false,
//       _termsAndConditions = false,
//       _checkoutOptionAbsorbing = true,
//       _billingAbsorbing = false,
//       _deliveryAbsorbing = true,
//       _deliveryMethodAbsorbing = true,
//       _paymentAbsorbing = true,
//       _confirmAbsorbing = true,
//       _billingAddressExpanded = true,
//       _deliveryAddressExpanded = false,
//       _stateError = false,
//       _termsError = false;
//   CountryData _countryData;
//   ZoneData _zoneData;
//
//   Map<String, dynamic> _paymentMethods = {};
//
//   final TextStyle _richTextStyle = TextStyle(
//       fontWeight: FontWeight.w400, fontSize: 12.0, color: Constants.grey600);
//   final TextStyle _textSpanStyle = TextStyle(
//     color: Colors.red,
//     fontWeight: FontWeight.bold,
//     fontSize: 16.5,
//   );
//
//   final EdgeInsets _margin =
//       EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0);
//
//   final InputDecoration _radioGroupDecoration = InputDecoration(
//     enabledBorder: OutlineInputBorder(
//       borderSide: BorderSide(color: Colors.transparent, width: 0.0),
//     ),
//     contentPadding: EdgeInsets.all(0.0),
//   );
//
//   final BoxDecoration _boxDecoration = BoxDecoration(
//     color: Constants.myWhite,
//     border: Border.all(width: 0.5, color: Colors.grey),
//   );
//
//   final InputDecoration _radioDecoration = InputDecoration(
//     enabledBorder: OutlineInputBorder(
//       borderSide: BorderSide(color: Colors.transparent, width: 0.0),
//     ),
//     contentPadding: EdgeInsets.all(0.0),
//   );
//
//   @override
//   void initState() {
//     widget.addresses != null
//         ? this._addresses = widget.addresses
//         : this._addresses = null;
//     _token = AuthUtils.authToken;
//     _customerId = AuthUtils.userId;
//     widget.countryData != null
//         ? this._countryData = widget.countryData
//         : this._countryData = null;
//     widget.zoneData != null
//         ? this._zoneData = widget.zoneData
//         : this._zoneData = null;
//     this._addresses != null && this._addresses.length > 0
//         ? this._initialValue = 'existing'
//         : this._initialValue = 'new';
//     _billingAddressKey = GlobalKey<FormState>();
//     _billingAddressListKey = GlobalKey<FormState>();
//     _deliveryAddressListKey = GlobalKey<FormState>();
//     _deliveryAddressKey = GlobalKey<FormState>();
//     _deliveryMethodKey = GlobalKey<FormState>();
//     _paymentMethodKey = GlobalKey<FormState>();
//     _confirmOrderKey = GlobalKey<FormState>();
//     _firstName = TextEditingController();
//     _lastName = TextEditingController();
//     _company = TextEditingController();
//     _email = TextEditingController();
//     _address1 = TextEditingController();
//     _address2 = TextEditingController();
//     _city = TextEditingController(
//         text: AuthUtils.currentCity != null ? AuthUtils.currentCity : '');
//     _postCode = TextEditingController(
//         text: AuthUtils.currentPinCode != null ? AuthUtils.currentPinCode : '');
//     _shippingMethodComment = TextEditingController();
//     _paymentMethodComment = TextEditingController();
//     _saveOrderComment = TextEditingController();
//     this._countryId = '99';
//     this._zoneId = this._zoneData.zone[0]['zone_id'];
//     _shippingMethodTitle = 'Flat Rate';
//     _shippingMethodFlatCode = 'flat.flat';
//     _shippingMethodFlatTitle = 'Flat Shipping Rate';
//     _shippingMethodFlatCost = '5.00';
//     _shippingMethodFlatTaxClassId = '';
//     _shippingMethodFlatText = '₹5.00';
//     _textShippingMethod =
//         'Please select the preferred shipping method to use on this order.';
//     _textComments = 'Add Comments About Your Order';
//     _totalProdStatus = '';
//     _textProdOpt = 'Partial Payment';
//     this._addresses != null
//         ? _billingAddressId =
//             this._addresses.values.toList()[0]['address_id'].toString()
//         : _billingAddressId = null;
//     this._addresses != null
//         ? _shippingAddressId =
//             this._addresses.values.toList()[0]['address_id'].toString()
//         : _shippingAddressId = null;
//     AuthUtils.voucher != null && AuthUtils.voucher != ''
//         ? this._vouchers = AuthUtils.voucher
//         : this._vouchers = null;
//     AuthUtils.coupon != null && AuthUtils.coupon != ''
//         ? this._coupon = AuthUtils.coupon
//         : this._coupon = null;
//     AuthUtils.reward != null && AuthUtils.reward != ''
//         ? this._reward = AuthUtils.reward
//         : this._reward = null;
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     _firstName.dispose();
//     _lastName.dispose();
//     _company.dispose();
//     _email.dispose();
//     _address1.dispose();
//     _address2.dispose();
//     _city.dispose();
//     _postCode.dispose();
//     _shippingMethodComment.dispose();
//     _paymentMethodComment.dispose();
//     _saveOrderComment.dispose();
//     super.dispose();
//   }
//
//   Future<dynamic> _getBillingAddress(
//       final String _customerId, final String _addressId) async {
//     if (_customerId != null && _customerId != '') {
//       await BillingAddressUtils.getBillingAddress(_customerId)
//           .then((dynamic _res) async {
//         if (_res != null &&
//             _res.containsKey('addresses') &&
//             _res['addresses'] != null &&
//             _res['addresses'].length > 0) {
//           setState(() {
//             this._addresses = _res['addresses'];
//             this._billingAddressId = _addressId;
//             this._initialValue = 'existing';
//           });
//           setState(() {});
//         } else {
//           print("get Billing Address Failed");
//           Constants.showLongToastBuilder("get Billing Address Failed");
//         }
//       }).catchError((_err) {
//         print("getBillingAddress catchError:=> $_err");
//         Constants.showLongToastBuilder(_err);
//       });
//     }
//   }
//
//   Future<dynamic> _getShippingAddress(
//       final String _customerId, final String _addressId) async {
//     if (_customerId != null && _customerId != '') {
//       await ShippingAddressUtils.getShippingAddress(_customerId)
//           .then((dynamic _res) async {
//         if (_res != null &&
//             _res.containsKey('addresses') &&
//             _res['addresses'] != null &&
//             _res['addresses'].length > 0) {
//           setState(() {
//             this._addresses = _res['addresses'];
//             this._shippingAddressId = _addressId;
//             this._initialValue = 'existing';
//           });
//           setState(() {});
//         } else {
//           print("\ngetShippingAddress Failed\n");
//           Constants.showLongToastBuilder("get Shipping Address Failed");
//         }
//       }).catchError((_err) {
//         print("\ngetShippingAddress catchError:=> $_err\n");
//         Constants.showLongToastBuilder(_err);
//       });
//     }
//   }
//
//   Future<void> _saveBillingAddress(BuildContext context) async {
//     if (_billingAddressKey.currentState.validate()) {
//       _billingAddressKey.currentState.save();
//       if (_zoneId != null && _zoneId != '0' && _zoneId != '') {
//         setState(() {
//           _stateError = false;
//         });
//         if (_token != null &&
//             _token != '' &&
//             _customerId != null &&
//             _customerId != '') {
//           Constants.showLoadingIndicator(context);
//           BillingAddressData _addParams = BillingAddressData(
//               _customerId,
//               _firstName.text,
//               _lastName.text,
//               _company.text,
//               _email.text,
//               _address1.text,
//               _address2.text,
//               _city.text,
//               _postCode.text,
//               _countryId,
//               _zoneId,
//               null);
//
//           await BillingAddressUtils.saveNewBillingAddress(_addParams)
//               .then((dynamic _shipRes) async {
//             if (_shipRes != null &&
//                 _shipRes.containsKey("payment_address") &&
//                 _shipRes['payment_address'] != null &&
//                 _shipRes.containsKey("address_id") &&
//                 _shipRes['address_id'] != null) {
//               await _getBillingAddress(
//                   _customerId, _shipRes['address_id'].toString());
//               Navigator.of(context).pop();
//               Constants.showShortToastBuilder(
//                   'Billing address saved successfully.');
//               _billingAddressKey.currentState.reset();
//             } else {
//               Navigator.of(context).pop();
//               Constants.showShortToastBuilder('Oops something went wrong!');
//               print('\nsaveNewBillingAddress:= $_shipRes\n');
//             }
//           }).catchError((_shipErr) {
//             Navigator.of(context).pop();
//             Constants.showShortToastBuilder('Oops something went wrong!');
//             print('\nsaveNewBillingAddress catchError:= $_shipErr\n');
//           });
//         } else {
//           MaterialPageRoute authRoute =
//               MaterialPageRoute(builder: (context) => AuthLogin());
//           Navigator.push(context, authRoute);
//         }
//       } else {
//         setState(() {
//           _stateError = true;
//         });
//       }
//     } else {
//       setState(() {
//         _billingAddressValidate = true; //enable realtime validation
//       });
//     }
//   }
//
//   Future<void> _applyBillingAddress(final String _customerId,
//       final String _billingAddressId, BuildContext context) async {
//     if (_billingAddressListKey.currentState.validate()) {
//       _billingAddressListKey.currentState.save();
//       if (_customerId != null &&
//           _customerId != '' &&
//           _billingAddressId != null &&
//           _billingAddressId != '') {
//         Constants.showLoadingIndicator(context);
//         BillingAddressData _applyParam = BillingAddressData(
//             _customerId,
//             null,
//             null,
//             null,
//             null,
//             null,
//             null,
//             null,
//             null,
//             null,
//             null,
//             _billingAddressId);
//
//         await BillingAddressUtils.applyBillingAddress(_applyParam)
//             .then((dynamic _applyRes) {
//           if (_applyRes != null &&
//               _applyRes.containsKey('address_id') &&
//               _applyRes != null &&
//               _applyRes['address_id'] == _billingAddressId) {
//             setState(() {
//               _deliveryAbsorbing = false;
//               _deliveryMethodAbsorbing = true;
//               _paymentAbsorbing = true;
//               _confirmAbsorbing = true;
//               _billingAddressExpanded = false;
//               _deliveryAddressExpanded = true;
//             });
//             Navigator.of(context).pop();
//             Constants.showShortToastBuilder("Billing Address Applied");
//           }
//         }).catchError((_err) {
//           Navigator.of(context).pop();
//           print("applyBillingAddress catchError:=> $_err");
//           Constants.showShortToastBuilder("Oops something went wrong!");
//         });
//       }
//     } else {
//       setState(() {
//         _billingAddressListValidate = true; //enable realtime validation
//       });
//     }
//   }
//
//   Future<void> _saveShippingAddress(BuildContext context) async {
//     if (_deliveryAddressKey.currentState.validate()) {
//       _deliveryAddressKey.currentState.save();
//       if (_zoneId != null && _zoneId != '0' && _zoneId != '') {
//         setState(() {
//           _stateError = false;
//         });
//         if (_token != null &&
//             _token != '' &&
//             _customerId != null &&
//             _customerId != '') {
//           Constants.showLoadingIndicator(context);
//           ShippingAddressData _addParams = ShippingAddressData(
//               _customerId,
//               _firstName.text,
//               _lastName.text,
//               _company.text,
//               _email.text,
//               _address1.text,
//               _address2.text,
//               _city.text,
//               _postCode.text,
//               _countryId,
//               _zoneId,
//               null,
//               null,
//               null);
//
//           await ShippingAddressUtils.saveNewShippingAddress(_addParams)
//               .then((dynamic _shipRes) async {
//             if (_shipRes != null &&
//                 _shipRes.containsKey("payment_address") &&
//                 _shipRes['payment_address'] != null &&
//                 _shipRes.containsKey("address_id") &&
//                 _shipRes['address_id'] != null) {
//               await _getShippingAddress(
//                   _customerId, _shipRes['address_id'].toString());
//               Navigator.of(context).pop();
//               Constants.showShortToastBuilder(
//                   'Shipping address saved successfully.');
//               _deliveryAddressKey.currentState.reset();
//             } else {
//               Navigator.of(context).pop();
//               Constants.showShortToastBuilder('Oops something went wrong!');
//             }
//           }).catchError((_shipErr) {
//             Navigator.of(context).pop();
//             Constants.showShortToastBuilder('Oops something went wrong!');
//             print('\nsaveNewShippingAddress catchError:= $_shipErr\n');
//           });
//         } else {
//           MaterialPageRoute authRoute =
//               MaterialPageRoute(builder: (context) => AuthLogin());
//           Navigator.push(context, authRoute);
//         }
//       } else {
//         setState(() {
//           _stateError = true;
//         });
//       }
//     } else {
//       setState(() {
//         _deliveryAddressValidate = true; //enable realtime validation
//       });
//     }
//   }
//
//   Future<dynamic> _getShippingMethod(
//       final String _shippingAddressId, final String _customerId) async {
//     if (_shippingAddressId != null &&
//         _shippingAddressId != '' &&
//         _customerId != null &&
//         _customerId != '') {
//       await ShippingAddressUtils.getShippingMethod(
//               _shippingAddressId, _customerId)
//           .then((dynamic _getRes) {
//         if (_getRes != null && _getRes.containsKey('shipping_methods')) {
//           setState(() {
//             _shippingMethodTitle = _getRes['shipping_methods']['flat']['title'];
//             _shippingMethodFlatCode =
//                 _getRes['shipping_methods']['flat']['quote']['flat']['code'];
//             _shippingMethodFlatTitle =
//                 _getRes['shipping_methods']['flat']['quote']['flat']['title'];
//             _shippingMethodFlatCost =
//                 _getRes['shipping_methods']['flat']['quote']['flat']['cost'];
//             _shippingMethodFlatTaxClassId = _getRes['shipping_methods']['flat']
//                 ['quote']['flat']['tax_class_id'];
//             _shippingMethodFlatText =
//                 _getRes['shipping_methods']['flat']['quote']['flat']['text'];
//             _textShippingMethod = _getRes['text_shipping_method'];
//             _textComments = _getRes['text_comments'];
//           });
//           print("\n\ngetShippingMethod Success.\n\n");
//           Constants.showShortToastBuilder("getShippingMethod Success.");
//         }
//       }).catchError((_err) {
//         Constants.showLongToastBuilder("getShippingMethod failed!");
//         print("_getShippingMethod catchError:=> $_err");
//       });
//     }
//   }
//
//   Future<void> _applyShippingAddress(BuildContext context) async {
//     if (_deliveryAddressListKey.currentState.validate()) {
//       _deliveryAddressListKey.currentState.save();
//       if (_customerId != null &&
//           _customerId != '' &&
//           this._shippingAddressId != null &&
//           this._shippingAddressId != '') {
//         Constants.showLoadingIndicator(context);
//         ShippingAddressData _applyParam = ShippingAddressData(
//             _customerId,
//             null,
//             null,
//             null,
//             null,
//             null,
//             null,
//             null,
//             null,
//             null,
//             null,
//             this._shippingAddressId,
//             null,
//             null);
//         await ShippingAddressUtils.applyShippingAddress(_applyParam)
//             .then((dynamic _applyRes) async {
//           if (_applyRes != null &&
//               _applyRes.containsKey('address_id') &&
//               _applyRes != null &&
//               _applyRes['address_id'] == this._shippingAddressId) {
//             await _getShippingMethod(this._shippingAddressId, _customerId);
//             setState(() {
//               _deliveryMethodAbsorbing = false;
//               _paymentAbsorbing = true;
//               _confirmAbsorbing = true;
//             });
//             Navigator.of(context).pop();
//             Constants.showShortToastBuilder("Delivery Address Applied");
//             _deliveryAddressListKey.currentState.reset();
//           }
//         }).catchError((_err) {
//           Navigator.of(context).pop();
//           print("applyBillingAddress catchError:=> $_err");
//           Constants.showShortToastBuilder("Oops something went wrong!");
//         });
//       }
//     } else {
//       setState(() {
//         _deliveryAddressListValidate = true; //enable realtime validation
//       });
//     }
//   }
//
//   Future<void> _applyShippingMethod(BuildContext context) async {
//     if (_deliveryMethodKey.currentState.validate()) {
//       _deliveryMethodKey.currentState.save();
//       if (_customerId != null &&
//           _customerId != '' &&
//           _shippingMethodFlatCode != null &&
//           _shippingMethodFlatCode != '' &&
//           _shippingAddressId != null &&
//           _shippingAddressId != '') {
//         Constants.showLoadingIndicator(context);
//         ShippingAddressData _applyParam = ShippingAddressData(
//             _customerId,
//             null,
//             null,
//             null,
//             null,
//             null,
//             null,
//             null,
//             null,
//             null,
//             null,
//             _shippingAddressId,
//             _shippingMethodFlatCode,
//             _shippingMethodComment.text);
//         await ShippingAddressUtils.applyShippingMethod(_applyParam)
//             .then((dynamic _applyRes) async {
//           if (_applyRes != null && _applyRes.containsKey('shipping_method')) {
//             await _getPaymentMethod(_billingAddressId, _customerId);
//             setState(() {
//               _paymentAbsorbing = false;
//               _confirmAbsorbing = true;
//             });
//             Navigator.of(context).pop();
//             print("applyShippingMethod success.");
//             Constants.showShortToastBuilder("applyShippingMethod success.");
//             _deliveryMethodKey.currentState.reset();
//           } else {
//             Navigator.of(context).pop();
//             print("applyShippingMethod failed.");
//             Constants.showLongToastBuilder("applyShippingMethod failed.");
//           }
//         }).catchError((_err) {
//           Navigator.of(context).pop();
//           print("applyShippingMethod catchError:=> $_err");
//           Constants.showLongToastBuilder("Oops something went wrong!");
//         });
//       }
//     } else {
//       setState(() {
//         _deliveryMethodValidate = true; //enable realtime validation
//       });
//     }
//   }
//
//   Future<dynamic> _getPaymentMethod(
//       final String _billingAddressId, final String _customerId) async {
//     if (_billingAddressId != null &&
//         _billingAddressId != '' &&
//         _customerId != null &&
//         _customerId != '') {
//       await PaymentUtils.getPaymentMethod(_billingAddressId, _customerId)
//           .then((dynamic _getRes) async {
//         if (_getRes != null && _getRes.containsKey('payment_methods')) {
//           setState(() {
//             _paymentMethods = _getRes['payment_methods'];
//             _totalProdStatus = _getRes['total_prod_status'];
//             _textProdOpt = _getRes['text_prod_opt'];
//             _getRes['prod_opt'] == false ? _prodOpt = '0' : _prodOpt = '1';
//             _totalEWalletStatus = _getRes['total_ewallet_status'];
//           });
//           print("\n\ngetPaymentMethod Success.\n\n");
//           Constants.showShortToastBuilder("getPaymentMethod Success.");
//         }
//       }).catchError((_err) {
//         Constants.showLongToastBuilder("getPaymentMethod failed!");
//         print("getPaymentMethod catchError:=> $_err");
//       });
//     }
//   }
//
//   Future<void> _applyPaymentMethod() async {
//     if (_paymentMethodKey.currentState.validate()) {
//       _paymentMethodKey.currentState.save();
//       if (_termsAndConditions == true) {
//         setState(() {
//           _termsError = false;
//         });
//         if (_customerId != null &&
//             _customerId != '' &&
//             _paymentMethodCode != null &&
//             _paymentMethodCode != '') {
//           Constants.showLoadingIndicator(context);
//           PaymentData _paymentParam = PaymentData(
//               _customerId, _paymentMethodCode, _paymentMethodComment.text);
//           await PaymentUtils.applyPaymentMethod(_paymentParam)
//               .then((dynamic _paymentRes) {
//             if (_paymentRes != null &&
//                 _paymentRes.containsKey('payment_method') &&
//                 _paymentRes.containsKey('success')) {
//               setState(() {
//                 _confirmAbsorbing = false;
//               });
//               Navigator.of(context).pop();
//               print("\n\napplyPaymentMethod Success.\n\n");
//               Constants.showLongToastBuilder(_paymentRes['success']);
//               _paymentMethodKey.currentState.reset();
//
//               /*Navigator.push(context, MaterialPageRoute(builder: (context) {
//                 return ConfirmOrder();
//               })).then((value) {
//                 setState(() {
//                   _deliveryAbsorbing = true;
//                   _deliveryMethodAbsorbing = true;
//                   _paymentAbsorbing = true;
//                   _confirmAbsorbing = true;
//                 });
//                 Navigator.of(context).pop();
//                 Navigator.of(context).pop();
//               });*/
//
//             } else {
//               Navigator.of(context).pop();
//               print("\n\napplyPaymentMethod failed.\n\n");
//               Constants.showLongToastBuilder("applyPaymentMethod failed.");
//             }
//           }).catchError((_err) {
//             Navigator.of(context).pop();
//             print("\n\napplyPaymentMethod catchError:=> $_err\n\n");
//             Constants.showLongToastBuilder("Oops something went wrong!");
//           });
//         }
//       } else {
//         setState(() {
//           _termsError = true;
//         });
//       }
//     } else {
//       setState(() {
//         _paymentMethodValidate = true; //enable realtime validation
//       });
//     }
//   }
//
//   Future<void> _applyConfirmOrder() async {
//     if (_confirmOrderKey.currentState.validate()) {
//       _confirmOrderKey.currentState.save();
//       if (_customerId != null &&
//           _customerId != '' &&
//           _billingAddressId != null &&
//           _billingAddressId != '' &&
//           _shippingAddressId != null &&
//           _shippingAddressId != '' &&
//           _shippingMethodFlatCode != null &&
//           _shippingMethodFlatCode != '' &&
//           _paymentMethodCode != null &&
//           _paymentMethodCode != '') {
//         Constants.showLoadingIndicator(context);
//         SaveOrderData _orderParam = SaveOrderData(
//             _customerId,
//             _billingAddressId,
//             _shippingAddressId,
//             _shippingMethodFlatCode,
//             _paymentMethodCode,
//             _vouchers != null && _vouchers != '' ? _vouchers : '-',
//             _coupon != null && _coupon != '' ? _coupon : '-',
//             _reward != null && _reward != '' ? _reward : '-',
//             _prodOpt,
//             _totalEWalletStatus.toString(),
//             _saveOrderComment.text);
//         await SaveOrderUtils.saveOrder(_orderParam).then((dynamic _saveRes) {
//           if (_saveRes != null &&
//               _saveRes.containsKey('order_id') &&
//               _saveRes['order_id'] != null) {
//             print("\n\nsaveOrder Success.\n\n");
//             Navigator.of(context).pop();
//             Constants.showLongToastBuilder(
//                 'Your order are successfully saved.');
//
//             Navigator.push(context, MaterialPageRoute(builder: (context) {
//               return ConfirmOrder();
//             })).then((value) {
//               setState(() {
//                 _checkoutOptionAbsorbing = false;
//                 _billingAbsorbing = false;
//                 _deliveryAbsorbing = true;
//                 _deliveryMethodAbsorbing = true;
//                 _paymentAbsorbing = true;
//                 _confirmAbsorbing = true;
//               });
//               Navigator.of(context).pop();
// //              Navigator.of(context).pop();
//               _confirmOrderKey.currentState.reset();
//             });
//           } else {
//             Navigator.of(context).pop();
//             print("\n\nsaveOrder failed.\n\n");
//             Constants.showLongToastBuilder("saveOrder failed.");
//           }
//         }).catchError((_err) {
//           Navigator.of(context).pop();
//           print("\n\nsaveOrder catchError:=> $_err\n\n");
//           Constants.showLongToastBuilder("Oops something went wrong!");
//         });
//       }
//     } else {
//       setState(() {
//         _confirmOrderValidate = true; //enable realtime validation
//       });
//     }
//   }
//
//   Future<dynamic> _updateState(final String _newCountryId) async {
//     if (_newCountryId != null && _newCountryId != '') {
//       await LocationUtils.getStates(_newCountryId)
//           .then((final dynamic _newStateRes) {
//         if (_newStateRes != null && _newStateRes.containsKey('zone')) {
//           if (_newStateRes['zone'] != null && _newStateRes['zone'].length > 0) {
//             setState(() {
//               this._zoneId = null;
//               this._zoneData = ZoneData.fromJson(_newStateRes);
//               this._zoneId = this._zoneData.zone[0]['zone_id'];
//             });
//           }
//         } else {
//           print("getStates Failed");
//           Constants.showLongToastBuilder("State not found!");
//         }
//       }).catchError((_err) {
//         print("\ngetStates catchError:=> $_err\n");
//         Constants.showLongToastBuilder(_err.toString());
//       });
//     }
//   }
//
//   Form _billingAddressFormBuilder() {
//     return Form(
//       key: _billingAddressKey,
//       autovalidate: _billingAddressValidate,
//       child: SingleChildScrollView(
//         padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
//         scrollDirection: Axis.vertical,
//         child: Column(
//           mainAxisAlignment: _mStart,
//           children: <Widget>[
//             WidgetPage.textFormField(
//                 _firstName,
//                 TextInputType.text,
//                 'First Name',
//                 'First Name must be between 1 and 32 characters!'),
//             Constants.height(30.0),
//             WidgetPage.textFormField(_lastName, TextInputType.text, 'Last Name',
//                 'Last Name must be between 1 and 32 characters!'),
//             Constants.height(30.0),
//             WidgetPage.textFormFieldWithoutValidation(
//                 _company, TextInputType.text, 'Company'),
//             Constants.height(30.0),
//             WidgetPage.textFormField(_email, TextInputType.emailAddress,
//                 'Email', 'Please enter email.'),
//             Constants.height(30.0),
//             WidgetPage.textFormField(_address1, TextInputType.text, 'Address 1',
//                 'Address must be between 3 and 128 characters!'),
//             Constants.height(30.0),
//             WidgetPage.textFormFieldWithoutValidation(
//                 _address2, TextInputType.text, 'Address 2'),
//             Constants.height(30.0),
//             WidgetPage.textFormField(_city, TextInputType.text, 'City',
//                 'City must be between 2 and 128 characters!'),
//             Constants.height(30.0),
//             WidgetPage.textFormField(_postCode, TextInputType.number,
//                 'Post Code', 'City must be 6 characters!'),
//             Constants.height(30.0),
//             Column(
//               mainAxisAlignment: _mStart,
//               crossAxisAlignment: _cStart,
//               children: <Widget>[
//                 RichText(
//                   text: TextSpan(text: '* ', style: _textSpanStyle, children: [
//                     TextSpan(
//                       text: 'Country',
//                       style: _richTextStyle,
//                     ),
//                   ]),
//                 ),
//                 Container(
//                   width: _deviceSize.width,
//                   child: DropdownButtonFormField(
//                     value: this._countryId,
//                     elevation: 0,
//                     isDense: true,
//                     isExpanded: true,
//                     iconEnabledColor: Colors.green,
//                     items: WidgetPage.countryMenuItems(
//                         this._countryData.countries),
//                     onChanged: (dynamic _newCountryVal) async {
//                       if (_newCountryVal != null && _newCountryVal != '') {
//                         setState(() {
//                           this._countryId = _newCountryVal.toString();
//                           print("onChanged countryId:=> $_newCountryVal");
//                         });
//                         await _updateState(this._countryId);
//                       }
//                     },
//                     validator: (dynamic _value) => _value == null
//                         ? 'Please select a country!'
//                         : _value == '0' ? 'Please select a country!' : null,
//                   ),
//                 ),
//               ],
//             ),
//             Constants.height(30.0),
//             Column(
//               mainAxisAlignment: _mStart,
//               crossAxisAlignment: _cStart,
//               children: <Widget>[
//                 RichText(
//                   text: TextSpan(text: '* ', style: _textSpanStyle, children: [
//                     TextSpan(
//                       text: 'Region / State',
//                       style: _richTextStyle,
//                     ),
//                   ]),
//                 ),
//                 Container(
//                   width: _deviceSize.width,
//                   child: DropdownButton(
//                     elevation: 0,
//                     isExpanded: true,
//                     iconEnabledColor: Constants.myGreen,
//                     items: WidgetPage.stateMenuItems(this._zoneData.zone),
//                     onChanged: (dynamic _newStateVal) {
//                       setState(() {
//                         this._zoneId = _newStateVal;
//                         if (_zoneId != null &&
//                             _zoneId != '0' &&
//                             _zoneId != '') {
//                           setState(() {
//                             _stateError = false;
//                           });
//                         }
//                         print("onChanged ZoneId:=> ${this._zoneId}");
//                       });
//                     },
//                     value: this._zoneId,
//                   ),
//                   /*child: DropdownButtonFormField(
//                     value: this._zoneId,
//                     elevation: 0,
//                     isDense: true,
//                     isExpanded: true,
//                     iconEnabledColor: Colors.green,
//                     items: WidgetPage.stateMenuItems(this._zoneData.zone),
//                     onChanged: (dynamic _newStateVal) {
//                       setState(() {
//                         this._zoneId = _newStateVal;
//                         print("onChanged ZoneId:=> $this._zoneId");
//                       });
//                     },
//                     validator: (dynamic _value) => _value == null
//                         ? 'Please select a region / state!'
//                         : _value == '0'
//                             ? 'Please select a region / state!'
//                             : null,
//                   ),*/
//                 ),
//                 _stateError
//                     ? Text(
//                         "Please select a region / state!",
//                         style: TextStyle(fontSize: 12.0, color: Colors.red),
//                       )
//                     : Container(),
//               ],
//             ),
//             Constants.height(30.0),
//             InkWell(
//               onTap: () async => _saveBillingAddress(context),
//               child: Container(
//                 color: Constants.primary_green,
//                 width: MediaQuery.of(context).size.width,
//                 padding: EdgeInsets.symmetric(vertical: 14),
//                 child: Text(
//                   'SAVE ADDRESS',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),
//             ),
//             Constants.height(15.0),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _billingAddressListBuilder() {
//     return Form(
//       key: _billingAddressListKey,
//       autovalidate: _billingAddressListValidate,
//       child: Column(
//         crossAxisAlignment: _cStart,
//         mainAxisAlignment: _mStart,
//         children: <Widget>[
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 20.0),
//             child: DropdownButtonFormField(
//               value: this._billingAddressId,
//               elevation: 0,
//               isDense: false,
//               isExpanded: true,
//               iconEnabledColor: Colors.green,
//               items: WidgetPage.addressMenuItems(this._addresses),
//               onChanged: (dynamic _newVal) async {
//                 if (_newVal != null && _newVal != '') {
//                   setState(() {
//                     this._billingAddressId = _newVal.toString();
//                     print(
//                         "onChanged billingAddressId:=> ${this._billingAddressId}");
//                   });
//                 }
//               },
//               validator: (dynamic _value) => _value == null
//                   ? 'Please select a billingAddress!'
//                   : _value == '0' ? 'Please select a billingAddress!' : null,
//             ),
//           ),
//           Constants.height(20.0),
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
//             child: InkWell(
//               onTap: () async =>
//                   _applyBillingAddress(_customerId, _billingAddressId, context),
//               child: Container(
//                 color: Constants.primary_green,
//                 width: MediaQuery.of(context).size.width,
//                 padding: EdgeInsets.symmetric(vertical: 12),
//                 child: Text(
//                   'CONTINUE',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Form _deliveryAddressFormBuilder() {
//     return Form(
//       key: _deliveryAddressKey,
//       autovalidate: _deliveryAddressValidate,
//       child: SingleChildScrollView(
//         padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
//         scrollDirection: Axis.vertical,
//         child: Column(
//           mainAxisAlignment: _mStart,
//           children: <Widget>[
//             WidgetPage.textFormField(
//                 _firstName,
//                 TextInputType.text,
//                 'First Name',
//                 'First Name must be between 1 and 32 characters!'),
//             Constants.height(30.0),
//             WidgetPage.textFormField(_lastName, TextInputType.text, 'Last Name',
//                 'Last Name must be between 1 and 32 characters!'),
//             Constants.height(30.0),
//             WidgetPage.textFormFieldWithoutValidation(
//                 _company, TextInputType.text, 'Company'),
//             Constants.height(30.0),
//             WidgetPage.textFormField(_email, TextInputType.emailAddress,
//                 'Email', 'Please enter email.'),
//             Constants.height(30.0),
//             WidgetPage.textFormField(_address1, TextInputType.text, 'Address 1',
//                 'Address must be between 3 and 128 characters!'),
//             Constants.height(30.0),
//             WidgetPage.textFormFieldWithoutValidation(
//                 _address2, TextInputType.text, 'Address 2'),
//             Constants.height(30.0),
//             WidgetPage.textFormField(_city, TextInputType.text, 'City',
//                 'City must be between 2 and 128 characters!'),
//             Constants.height(30.0),
//             WidgetPage.textFormField(_postCode, TextInputType.number,
//                 'Post Code', 'City must be 6 characters!'),
//             Constants.height(30.0),
//             Column(
//               mainAxisAlignment: _mStart,
//               crossAxisAlignment: _cStart,
//               children: <Widget>[
//                 RichText(
//                   text: TextSpan(text: '* ', style: _textSpanStyle, children: [
//                     TextSpan(
//                       text: 'Country',
//                       style: _richTextStyle,
//                     ),
//                   ]),
//                 ),
//                 Container(
//                   width: _deviceSize.width,
//                   child: DropdownButtonFormField(
//                     value: this._countryId,
//                     elevation: 0,
//                     isDense: true,
//                     isExpanded: true,
//                     iconEnabledColor: Colors.green,
//                     items: WidgetPage.countryMenuItems(
//                         this._countryData.countries),
//                     onChanged: (dynamic _newVal) async {
//                       if (_newVal != null && _newVal != '') {
//                         setState(() {
//                           this._countryId = _newVal.toString();
//                           print("onChanged countryId:=> ${this._countryId}");
//                         });
//                         await _updateState(this._countryId);
//                       }
//                     },
//                     validator: (dynamic _value) => _value == null
//                         ? 'Please select a country!'
//                         : _value == '0' ? 'Please select a country!' : null,
//                   ),
//                 ),
//               ],
//             ),
//             Constants.height(30.0),
//             Column(
//               mainAxisAlignment: _mStart,
//               crossAxisAlignment: _cStart,
//               children: <Widget>[
//                 RichText(
//                   text: TextSpan(text: '* ', style: _textSpanStyle, children: [
//                     TextSpan(
//                       text: 'Region / State',
//                       style: _richTextStyle,
//                     ),
//                   ]),
//                 ),
//                 Container(
//                   width: _deviceSize.width,
//                   child: DropdownButton(
//                     value: this._zoneId,
//                     elevation: 0,
//                     isDense: true,
//                     isExpanded: true,
//                     iconEnabledColor: Colors.green,
//                     items: WidgetPage.stateMenuItems(this._zoneData.zone),
//                     onChanged: (dynamic _newStateVal) {
//                       setState(() {
//                         this._zoneId = _newStateVal;
//                         if (_zoneId != null &&
//                             _zoneId != '0' &&
//                             _zoneId != '') {
//                           setState(() {
//                             _stateError = false;
//                           });
//                         }
//                         print("onChanged ZoneId:=> $this._zoneId");
//                       });
//                     },
//                   ),
//                   /*child: DropdownButtonFormField(
//                     value: this._zoneId,
//                     elevation: 0,
//                     isDense: true,
//                     isExpanded: true,
//                     iconEnabledColor: Colors.green,
//                     items: WidgetPage.stateMenuItems(this._zoneData.zone),
//                     onChanged: (dynamic _newStateVal) {
//                       setState(() {
//                         this._zoneId = _newStateVal;
//                         print("onChanged ZoneId:=> $this._zoneId");
//                       });
//                     },
//                     validator: (dynamic _value) => _value == null
//                         ? 'Please select a region / state!'
//                         : _value == '0'
//                             ? 'Please select a region / state!'
//                             : null,
//                   ),*/
//                 ),
//                 _stateError
//                     ? Text(
//                         "Please select a region / state!",
//                         style: TextStyle(fontSize: 12.0, color: Colors.red),
//                       )
//                     : Container(),
//               ],
//             ),
//             Constants.height(30.0),
//             InkWell(
//               onTap: () async => _saveShippingAddress(context),
//               child: Container(
//                 color: Constants.primary_green,
//                 width: MediaQuery.of(context).size.width,
//                 padding: EdgeInsets.symmetric(vertical: 14),
//                 child: Text(
//                   'SAVE ADDRESS',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),
//             ),
//             Constants.height(15.0),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _deliveryAddressListBuilder() {
//     return Form(
//       key: _deliveryAddressListKey,
//       autovalidate: _deliveryAddressListValidate,
//       child: Column(
//         crossAxisAlignment: _cStart,
//         mainAxisAlignment: _mStart,
//         children: <Widget>[
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 20.0),
//             child: DropdownButtonFormField(
//               value: this._shippingAddressId,
//               elevation: 0,
//               isDense: false,
//               isExpanded: true,
//               iconEnabledColor: Colors.green,
//               items: WidgetPage.addressMenuItems(this._addresses),
//               onChanged: (dynamic _newVal) async {
//                 if (_newVal != null && _newVal != '') {
//                   setState(() {
//                     this._shippingAddressId = _newVal.toString();
//                     print(
//                         "onChanged shippingAddressId:=> ${this._shippingAddressId}");
//                   });
//                 }
//               },
//               validator: (dynamic _value) => _value == null
//                   ? 'Please select a shippingAddress!'
//                   : _value == '0' ? 'Please select a shippingAddress!' : null,
//             ),
//           ),
//           Constants.height(20.0),
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
//             child: InkWell(
//               onTap: () async => _applyShippingAddress(context),
//               child: Container(
//                 color: Constants.primary_green,
//                 width: MediaQuery.of(context).size.width,
//                 padding: EdgeInsets.symmetric(vertical: 12),
//                 child: Text(
//                   'CONTINUE',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _deliveryMethodBuilder() {
//     return Form(
//       key: _deliveryMethodKey,
//       autovalidate: _deliveryMethodValidate,
//       child: Column(
//         crossAxisAlignment: _cStart,
//         mainAxisAlignment: _mStart,
//         children: <Widget>[
//           Padding(
//             padding: EdgeInsets.only(left: 20.0),
//             child: Text(
//               _textShippingMethod,
//               style: TextStyle(
//                   fontSize: 12.0,
//                   fontWeight: FontWeight.w400,
//                   color: Constants.grey600),
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.only(left: 20.0, top: 20.0),
//             child: Text(
//               _shippingMethodTitle,
//               style: TextStyle(
//                   fontSize: 14.0,
//                   fontWeight: FontWeight.w500,
//                   color: Constants.grey600),
//             ),
//           ),
//           RadioListTile(
//             title: Text(
//               "$_shippingMethodFlatTitle - $_shippingMethodFlatText",
//               style: TextStyle(
//                   fontSize: 14.0,
//                   fontWeight: FontWeight.w400,
//                   color: Constants.grey600),
//             ),
//             value: _shippingMethodFlatCode,
//             groupValue: _shippingMethodFlatCode,
//             onChanged: (dynamic _val) {
//               setState(() {
//                 _shippingMethodFlatCode = _val;
//                 print("new shippingMethodFlatCode:=> $_val");
//               });
//             },
//             activeColor: Constants.myGreen,
//           ),
//           Padding(
//             padding: EdgeInsets.only(left: 20.0, top: 10.0),
//             child: Text(
//               _textComments,
//               style: TextStyle(
//                   fontSize: 14.0,
//                   fontWeight: FontWeight.w500,
//                   color: Constants.grey600),
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
//             child: TextField(
//               maxLines: 4,
//               maxLength: 500,
//               controller: _shippingMethodComment,
//               keyboardType: TextInputType.text,
//               autofocus: false,
//               decoration: InputDecoration(
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(5.0),
//                   borderSide: const BorderSide(
//                       color: Constants.primary_green, width: 1.5),
//                 ),
//                 contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
//                 border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(5.0)),
//               ),
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 20.0),
//             child: InkWell(
//               onTap: () async => _applyShippingMethod(context),
//               child: Container(
//                 color: Constants.primary_green,
//                 width: MediaQuery.of(context).size.width,
//                 padding: EdgeInsets.symmetric(vertical: 12),
//                 child: Text(
//                   'CONTINUE',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),
//             ),
//           ),
//           Constants.height(20.0),
//         ],
//       ),
//     );
//   }
//
//   Widget _paymentMethodRadioWidget() {
//     if(_paymentMethodCode == null){
//       _paymentMethodCode = _paymentMethods.values.toList()[0]['code'];
//     }
//     return FormBuilderRadioGroup(
//       decoration: _radioDecoration,
//       initialValue: _paymentMethodCode,
//       attribute: "payment_method",
//       activeColor: Constants.myGreen,
//       options: WidgetPage.paymentMethodRadioGroup(_paymentMethods),
//       onChanged: (dynamic _newRadioVal) {
//         _paymentMethods.forEach((_key, _value) {
//           if(_value['code'] == _paymentMethodCode){
//             setState(() {
//               _paymentMethodCode = _newRadioVal;
//               _paymentMethodTitle = _value['title'];
//               _paymentMethodTerms = _value['terms'];
//               _paymentMethodSortOrder = _value['sort_order'];
//               print("\nnew paymentMethodVal:=> $_paymentMethodCode\n");
//             });
//           }
//         });
//         },
//     );
//   }
//
//   Widget _paymentTypeRadioWidget() {
//     final Map<String, dynamic> _paymentTypes = {
//       "partial_payment": {"text_prod_opt": "Partial Payment", "prod_opt": "0"},
//       "full_payment": {"text_prod_opt": "Full Payment", "prod_opt": '1'}
//     };
//     if(_prodOpt == null){
//       _prodOpt = _paymentTypes.values.toList()[1]['prod_opt'];
//     }
//     return FormBuilderRadioGroup(
//       decoration: _radioDecoration,
//       initialValue: _prodOpt,
//       attribute: "payment_type",
//       activeColor: Constants.myGreen,
//       options: WidgetPage.paymentTypeRadioGroup(_paymentTypes),
//       onChanged: (_newTypeVal) {
//         setState(() {
//           _prodOpt = _newTypeVal;
//           print("\nnew paymentTypeVal:=> $_prodOpt\n");
//         });
//       },
//     );
//   }
//
//   Widget _paymentMethodBuilder() {
//     return Form(
//       key: _paymentMethodKey,
//       autovalidate: _paymentMethodValidate,
//       child: Column(
//         crossAxisAlignment: _cStart,
//         mainAxisAlignment: _mStart,
//         children: <Widget>[
//           Padding(
//             padding: EdgeInsets.only(left: 20.0),
//             child: Text(
//               "Please select the preferred payment method to use on this order.",
//               style: TextStyle(
//                   fontSize: 12.0,
//                   fontWeight: FontWeight.w400,
//                   color: Constants.grey600),
//             ),
//           ),
//           _paymentMethods != null ? _paymentMethodRadioWidget() : Container(),
//           Constants.height(10.0),
//           _prodOpt != null && _prodOpt != '' ? _paymentTypeRadioWidget() : Container(),
//           Padding(
//             padding: EdgeInsets.only(left: 20.0, top: 10.0),
//             child: Text(
//               "Add Comments About Your Order",
//               style: TextStyle(
//                   fontSize: 14.0,
//                   fontWeight: FontWeight.w500,
//                   color: Constants.grey600),
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
//             child: TextField(
//               maxLines: 4,
//               maxLength: 500,
//               controller: _paymentMethodComment,
//               keyboardType: TextInputType.text,
//               autofocus: false,
//               decoration: InputDecoration(
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(5.0),
//                   borderSide: const BorderSide(
//                       color: Constants.primary_green, width: 1.5),
//                 ),
//                 contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
//                 border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(5.0)),
//               ),
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 20.0),
//             child: Text(
//               'I have read and agree to the ',
//               style: TextStyle(fontSize: 12.0),
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 20.0),
//             child: Row(
//               crossAxisAlignment: _cCenter,
//               mainAxisAlignment: _mStart,
//               children: <Widget>[
//                 InkWell(
//                   onTap: () async {
//                     Constants.showShortToastBuilder('Terms & Conditions');
//                   },
//                   child: Text(
//                     'Terms & Conditions',
//                     style:
//                         TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0),
//                   ),
//                 ),
//                 FormField(
//                   validator: (bool _value) => _value == false
//                       ? 'You must agree to the Terms & Conditions!'
//                       : null,
//                   builder: (FormFieldState<dynamic> field) {
//                     return Checkbox(
//                       visualDensity: VisualDensity.compact,
//                       activeColor: Constants.myGreen,
//                       value: _termsAndConditions,
//                       onChanged: (_newCheckVal) {
//                         setState(() {
//                           _termsAndConditions = _newCheckVal;
//                           if (_termsAndConditions == true) {
//                             setState(() {
//                               _termsError = false;
//                             });
//                           }
//                           print("termsAndConditions:= $_termsAndConditions");
//                         });
//                       },
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ),
//           _termsError
//               ? Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 20.0),
//                   child: Text(
//                     "You must agree to the Terms & Conditions!",
//                     overflow: TextOverflow.ellipsis,
//                     style: TextStyle(fontSize: 12.0, color: Colors.red),
//                   ),
//                 )
//               : Container(),
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
//             child: InkWell(
//               onTap: () async => _applyPaymentMethod(),
//               child: Container(
//                 color: Constants.primary_green,
//                 width: MediaQuery.of(context).size.width,
//                 padding: EdgeInsets.symmetric(vertical: 12),
//                 child: Text(
//                   'CONTINUE',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _confirmOrderBuilder() {
//     return Form(
//       key: _confirmOrderKey,
//       autovalidate: _confirmOrderValidate,
//       child: Column(
//           crossAxisAlignment: _cStart,
//           mainAxisAlignment: _mStart,
//           children: <Widget>[
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
//               child: InkWell(
//                 onTap: () async => _applyConfirmOrder(),
//                 child: Container(
//                   color: Constants.primary_green,
//                   width: MediaQuery.of(context).size.width,
//                   padding: EdgeInsets.symmetric(vertical: 12),
//                   child: Text(
//                     'CONTINUE',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//               ),
//             ),
//           ]),
//     );
//   }
//
//   Widget _checkoutOptions() {
//     return AbsorbPointer(
//       absorbing: _checkoutOptionAbsorbing,
//       child: Container(
//         width: _deviceSize.width,
//         margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
//         decoration: BoxDecoration(
//           color: Constants.myWhite,
//           border: Border.all(width: 0.5, color: Colors.grey),
//         ),
//         child: ExpansionTile(
//           title: WidgetPage.expansionTitle("Step 1: Checkout Options"),
//         ),
//       ),
//     );
//   }
//
//   Widget _billingAddress() {
//     return AbsorbPointer(
//       absorbing: _billingAbsorbing,
//       child: Container(
//         width: _deviceSize.width,
//         margin: _margin,
//         decoration: _boxDecoration,
//         child: ExpansionTile(
//           initiallyExpanded: _billingAddressExpanded,
//           title: WidgetPage.expansionTitle("Step 2: Billing Details"),
//           children: <Widget>[
//             FormBuilderRadioGroup(
//               decoration: _radioGroupDecoration,
//               initialValue: this._initialValue,
//               attribute: "selected_address",
//               activeColor: Constants.myGreen,
//               options: WidgetPage.addressTypeOptions(_addresses),
//               onChanged: (dynamic _newRadioVal) {
//                 setState(() {
//                   this._initialValue = _newRadioVal;
//                   print("selectedAddressType:=> $_newRadioVal");
//                 });
//               },
//             ),
//             this._initialValue == 'new'
//                 ? _billingAddressFormBuilder()
//                 : _billingAddressListBuilder(),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _deliveryAddress() {
//     return AbsorbPointer(
//       absorbing: _deliveryAbsorbing,
//       child: Container(
//         margin: _margin,
//         decoration: _boxDecoration,
//         child: ExpansionTile(
//           initiallyExpanded: _deliveryAddressExpanded,
//           title: WidgetPage.expansionTitle("Step 3: Delivery Details"),
//           children: <Widget>[
//             FormBuilderRadioGroup(
//               decoration: _radioGroupDecoration,
//               initialValue: this._initialValue,
//               attribute: "selected_address",
//               activeColor: Constants.myGreen,
//               options: WidgetPage.addressTypeOptions(_addresses),
//               onChanged: (dynamic _newRadioVal) {
//                 setState(() {
//                   this._initialValue = _newRadioVal;
//                   print("selectedAddressType:=> ${this._initialValue}");
//                 });
//               },
//             ),
//             this._initialValue == 'new'
//                 ? _deliveryAddressFormBuilder()
//                 : _deliveryAddressListBuilder(),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _deliveryMethod() {
//     return AbsorbPointer(
//       absorbing: _deliveryMethodAbsorbing,
//       child: Container(
//         margin: _margin,
//         decoration: _boxDecoration,
//         child: ExpansionTile(
//           title: WidgetPage.expansionTitle("Step 4: Delivery Method"),
//           children: <Widget>[
//             _deliveryMethodBuilder(),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _paymentMethod() {
//     return AbsorbPointer(
//       absorbing: _paymentAbsorbing,
//       child: Container(
//         margin: _margin,
//         decoration: _boxDecoration,
//         child: ExpansionTile(
//           title: WidgetPage.expansionTitle("Step 5: Payment Method"),
//           children: <Widget>[
//             _paymentMethods != null && _prodOpt != null ? _paymentMethodBuilder() : Container(),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _confirmOrder() {
//     return AbsorbPointer(
//       absorbing: _confirmAbsorbing,
//       child: Container(
//         margin: _margin,
//         decoration: _boxDecoration,
//         child: ExpansionTile(
//           title: WidgetPage.expansionTitle("Step 6: Confirm Order"),
//           children: <Widget>[
//             _confirmOrderBuilder(),
//           ],
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     _deviceSize = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: WidgetPage.checkoutAppBar(),
//       body: SingleChildScrollView(
//         scrollDirection: Axis.vertical,
//         child: Column(
//           children: <Widget>[
//             Constants.height(8.0),
//             _checkoutOptions(),
//             _billingAddress(),
//             _deliveryAddress(),
//             _deliveryMethod(),
//             _paymentMethod(),
//             _confirmOrder(),
//           ],
//         ),
//       ),
//     );
//   }
// }

//%%%%%%%  Create save order List and call RazorPay on confirm Button   %%%%%%%//

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:gwaliorkart/models/billing_address_data.dart';
import 'package:gwaliorkart/models/location_data.dart';
import 'package:gwaliorkart/models/payment_data.dart';
import 'package:gwaliorkart/models/shipping_address_data.dart';
import 'package:gwaliorkart/screens/payment_success.dart';
import 'package:gwaliorkart/screens/auth_login.dart';
import 'package:gwaliorkart/screens/confirm_order.dart';
import 'package:gwaliorkart/utils/auth_utils.dart';
import 'package:gwaliorkart/utils/constants.dart';
import 'package:gwaliorkart/widgets/widget_page.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'dart:async';
import 'dart:math';
import 'dart:convert';
import 'package:crypto/crypto.dart';

class CheckoutPage extends StatefulWidget {
  final dynamic addresses;
  final CountryData countryData;
  final ZoneData zoneData;

  CheckoutPage(this.addresses, this.countryData, this.zoneData);

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  MainAxisAlignment _mStart = MainAxisAlignment.start;
  MainAxisAlignment _mCenter = MainAxisAlignment.center;
  CrossAxisAlignment _cStart = CrossAxisAlignment.start;
  CrossAxisAlignment _cCenter = CrossAxisAlignment.center;
  dynamic _addresses;
  Size _deviceSize;
  int _totalEWalletStatus, _totalPrice, _orderId;
  double _totalAmount;
  String _token,
      _customerId,
      _countryId,
      _zoneId,
      _initialValue,
      _shippingMethodTitle,
      _shippingMethodFlatCode,
      _shippingMethodFlatTitle,
      _shippingMethodFlatCost,
      _shippingMethodFlatTaxClassId,
      _shippingMethodFlatText,
      _textShippingMethod,
      _textComments,
      _billingAddressId,
      _shippingAddressId,
      _paymentMethodCode,
      _paymentMethodTitle,
      _paymentMethodTerms,
      _paymentMethodSortOrder,
      _payUMerchant,
      _payUSalt,
      _razorPayKey,
      _razorPaySecret,
      _paymentMethodMerchantKey,
      _paymentMethodSalt,
      _totalProdStatus,
      _textProdOpt,
      _prodOpt,
      _vouchers,
      _coupon,
      _reward;
  TextEditingController _firstName,
      _lastName,
      _company,
      _email,
      _address1,
      _address2,
      _city,
      _postCode,
      _shippingMethodComment,
      _paymentMethodComment,
      _saveOrderComment;
  GlobalKey<FormState> _billingAddressKey,
      _billingAddressListKey,
      _deliveryAddressListKey,
      _deliveryAddressKey,
      _deliveryMethodKey,
      _paymentMethodKey,
      _confirmOrderKey;
  bool _billingAddressValidate = false,
      _billingAddressListValidate = false,
      _deliveryAddressListValidate = false,
      _deliveryAddressValidate = false,
      _deliveryMethodValidate = false,
      _paymentMethodValidate = false,
      _confirmOrderValidate = false,
      _termsAndConditions = false,
      _checkoutOptionAbsorbing = true,
      _billingAbsorbing = false,
      _deliveryAbsorbing = true,
      _deliveryMethodAbsorbing = true,
      _paymentAbsorbing = true,
      _confirmAbsorbing = true,
      _billingAddressExpanded = true,
      _deliveryAddressExpanded = false,
      _stateError = false,
      _termsError = false;
  CountryData _countryData;
  ZoneData _zoneData;
  Razorpay _razorPay;

  Map<String, dynamic> _paymentMethods = {};
  SavedOrderData _savedOrder;
  SavedOrderProducts _savedProducts;

  final TextStyle _richTextStyle = TextStyle(
      fontWeight: FontWeight.w400, fontSize: 12.0, color: Constants.grey600);
  final TextStyle _textSpanStyle = TextStyle(
    color: Colors.red,
    fontWeight: FontWeight.bold,
    fontSize: 16.5,
  );

  final EdgeInsets _margin =
      EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0);

  final InputDecoration _radioGroupDecoration = InputDecoration(
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent, width: 0.0),
    ),
    contentPadding: EdgeInsets.all(0.0),
  );

  final BoxDecoration _boxDecoration = BoxDecoration(
    color: Constants.myWhite,
    border: Border.all(width: 0.5, color: Colors.grey),
  );

  final InputDecoration _radioDecoration = InputDecoration(
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent, width: 0.0),
    ),
    contentPadding: EdgeInsets.all(0.0),
  );

  @override
  void initState() {
    widget.addresses != null
        ? this._addresses = widget.addresses
        : this._addresses = null;
    _token = AuthUtils.authToken;
    _customerId = AuthUtils.userId;
    widget.countryData != null
        ? this._countryData = widget.countryData
        : this._countryData = null;
    widget.zoneData != null
        ? this._zoneData = widget.zoneData
        : this._zoneData = null;
    this._addresses != null && this._addresses.length > 0
        ? this._initialValue = 'existing'
        : this._initialValue = 'new';
    _billingAddressKey = GlobalKey<FormState>();
    _billingAddressListKey = GlobalKey<FormState>();
    _deliveryAddressListKey = GlobalKey<FormState>();
    _deliveryAddressKey = GlobalKey<FormState>();
    _deliveryMethodKey = GlobalKey<FormState>();
    _paymentMethodKey = GlobalKey<FormState>();
    _confirmOrderKey = GlobalKey<FormState>();
    _firstName = TextEditingController();
    _lastName = TextEditingController();
    _company = TextEditingController();
    _email = TextEditingController();
    _address1 = TextEditingController();
    _address2 = TextEditingController();
    _city = TextEditingController(
        text: AuthUtils.currentCity != null ? AuthUtils.currentCity : '');
    _postCode = TextEditingController(
        text: AuthUtils.currentPinCode != null ? AuthUtils.currentPinCode : '');
    _shippingMethodComment = TextEditingController();
    _paymentMethodComment = TextEditingController();
    _saveOrderComment = TextEditingController();
    this._countryId = '99';
    this._zoneId = this._zoneData.zone[0]['zone_id'];
    _shippingMethodTitle = 'Flat Rate';
    _shippingMethodFlatCode = 'flat.flat';
    _shippingMethodFlatTitle = 'Flat Shipping Rate';
    _shippingMethodFlatCost = '5.00';
    _shippingMethodFlatTaxClassId = '';
    _shippingMethodFlatText = '₹5.00';
    _textShippingMethod =
        'Please select the preferred shipping method to use on this order.';
    _textComments = 'Add Comments About Your Order';
    _totalProdStatus = '';
    _textProdOpt = 'Partial Payment';
    this._addresses != null
        ? _billingAddressId =
            this._addresses.values.toList()[0]['address_id'].toString()
        : _billingAddressId = null;
    this._addresses != null
        ? _shippingAddressId =
            this._addresses.values.toList()[0]['address_id'].toString()
        : _shippingAddressId = null;
    AuthUtils.voucher != null && AuthUtils.voucher != ''
        ? this._vouchers = AuthUtils.voucher
        : this._vouchers = null;
    AuthUtils.coupon != null && AuthUtils.coupon != ''
        ? this._coupon = AuthUtils.coupon
        : this._coupon = null;
    AuthUtils.reward != null && AuthUtils.reward != ''
        ? this._reward = AuthUtils.reward
        : this._reward = null;
    _razorPay = Razorpay();
    _razorPay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlerPaymentSuccess);
    _razorPay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlerErrorFailure);
    _razorPay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handlerExternalWallet);
    super.initState();
  }

  @override
  void dispose() {
    _firstName.dispose();
    _lastName.dispose();
    _company.dispose();
    _email.dispose();
    _address1.dispose();
    _address2.dispose();
    _city.dispose();
    _postCode.dispose();
    _shippingMethodComment.dispose();
    _paymentMethodComment.dispose();
    _saveOrderComment.dispose();
    _razorPay.clear();
    super.dispose();
  }

  void _confirmPayment() {
    final Map<String, dynamic> _options = {
      "key": _paymentMethodMerchantKey,
      "amount": _totalPrice * 100,
      "name": Constants.appName,
      // "order_id": _orderId,
      "description": "Choose a payment method",
      'timeout': 180, // in seconds
      "prefill": {
        "contact": AuthUtils.userPhoneNo,
        "email": AuthUtils.userEmailId
      },
      "external": {"wallets": "paytm"}
    };

    print("\n\n_options:=> $_options\n\n");

    try {
      _razorPay.open(_options);
    } catch (_exp) {
      print("\n\ncatch exp:=> ${_exp.toString()}\n\n");
    }
  }

  void _handlerPaymentSuccess(PaymentSuccessResponse _success) {
    print(
        "\n\nSuccess OrderId:=> ${_success.orderId}, Success paymentId:=> ${_success.paymentId}, Success signature:=> ${_success.signature}\n\n");
    /*final _generatedSignature = hmac_sha256(_success.orderId + "|" + _success.paymentId, _paymentMethodSalt);
    if (_generatedSignature == _success.signature) {
      print("payment is successful");
    }*/
    if (_success.paymentId != null) {
      Constants.showShortToastBuilder("Payment Successful");
      MaterialPageRoute authRoute =
          MaterialPageRoute(builder: (context) => PaymentSuccess(1));
      Navigator.push(context, authRoute).then((value) {
        Navigator.of(context).pop();
      });
    }
  }

  void _handlerErrorFailure(PaymentFailureResponse _failure) {
    print(
        "\n\nFailure code:=> ${_failure.code}, Failure message:=> ${_failure.message}\n\n");
    if (_failure.code != null &&
        _failure.code == 2 &&
        _failure.message != null) {
      Constants.showShortToastBuilder(_failure.message);
      MaterialPageRoute _paymentRoute =
          MaterialPageRoute(builder: (context) => PaymentSuccess(2));
      Navigator.push(context, _paymentRoute).then((value) {
        Navigator.of(context).pop();
      });
    }
  }

  void _handlerExternalWallet(ExternalWalletResponse _wallet) {
    print("\n\nExternal Wallet Res:=> $_wallet\n\n");
    print(
        "\n\nwalletName:=> ${_wallet.walletName}, Wallet hashCode:=> ${_wallet.hashCode}, Wallet toString:=> ${_wallet.toString()}, Wallet runtimeType:=> ${_wallet.runtimeType}\n\n");
    Constants.showShortToastBuilder("External Wallet");
  }

  Future<dynamic> _getBillingAddress(
      final String _customerId, final String _addressId) async {
    if (_customerId != null && _customerId != '') {
      await BillingAddressUtils.getBillingAddress(_customerId)
          .then((dynamic _res) async {
        if (_res != null &&
            _res.containsKey('addresses') &&
            _res['addresses'] != null &&
            _res['addresses'].length > 0) {
          setState(() {
            this._addresses = _res['addresses'];
            this._billingAddressId = _addressId;
            this._initialValue = 'existing';
          });
          setState(() {});
        } else {
          print("get Billing Address Failed");
          Constants.showLongToastBuilder("get Billing Address Failed");
        }
      }).catchError((_err) {
        print("getBillingAddress catchError:=> $_err");
        Constants.showLongToastBuilder(_err);
      });
    }
  }

  Future<dynamic> _getShippingAddress(
      final String _customerId, final String _addressId) async {
    if (_customerId != null && _customerId != '') {
      await ShippingAddressUtils.getShippingAddress(_customerId)
          .then((dynamic _res) async {
        if (_res != null &&
            _res.containsKey('addresses') &&
            _res['addresses'] != null &&
            _res['addresses'].length > 0) {
          setState(() {
            this._addresses = _res['addresses'];
            this._shippingAddressId = _addressId;
            this._initialValue = 'existing';
          });
          setState(() {});
        } else {
          print("\ngetShippingAddress Failed\n");
          Constants.showLongToastBuilder("get Shipping Address Failed");
        }
      }).catchError((_err) {
        print("\ngetShippingAddress catchError:=> $_err\n");
        Constants.showLongToastBuilder(_err);
      });
    }
  }

  Future<void> _saveBillingAddress(BuildContext context) async {
    if (_billingAddressKey.currentState.validate()) {
      _billingAddressKey.currentState.save();
      if (_zoneId != null && _zoneId != '0' && _zoneId != '') {
        setState(() {
          _stateError = false;
        });
        if (_token != null &&
            _token != '' &&
            _customerId != null &&
            _customerId != '') {
          Constants.showLoadingIndicator(context);
          BillingAddressData _addParams = BillingAddressData(
              _customerId,
              _firstName.text,
              _lastName.text,
              _company.text,
              _email.text,
              _address1.text,
              _address2.text,
              _city.text,
              _postCode.text,
              _countryId,
              _zoneId,
              null);

          await BillingAddressUtils.saveNewBillingAddress(_addParams)
              .then((dynamic _shipRes) async {
            if (_shipRes != null &&
                _shipRes.containsKey("payment_address") &&
                _shipRes['payment_address'] != null &&
                _shipRes.containsKey("address_id") &&
                _shipRes['address_id'] != null) {
              await _getBillingAddress(
                  _customerId, _shipRes['address_id'].toString());
              Navigator.of(context).pop();
              Constants.showShortToastBuilder(
                  'Billing address saved successfully.');
              _billingAddressKey.currentState.reset();
            } else {
              Navigator.of(context).pop();
              Constants.showShortToastBuilder('Oops something went wrong!');
              print('\nsaveNewBillingAddress:= $_shipRes\n');
            }
          }).catchError((_shipErr) {
            Navigator.of(context).pop();
            Constants.showShortToastBuilder('Oops something went wrong!');
            print('\nsaveNewBillingAddress catchError:= $_shipErr\n');
          });
        } else {
          MaterialPageRoute authRoute =
              MaterialPageRoute(builder: (context) => AuthLogin());
          Navigator.push(context, authRoute);
        }
      } else {
        setState(() {
          _stateError = true;
        });
      }
    } else {
      setState(() {
        _billingAddressValidate = true; //enable realtime validation
      });
    }
  }

  Future<void> _applyBillingAddress(final String _customerId,
      final String _billingAddressId, BuildContext context) async {
    if (_billingAddressListKey.currentState.validate()) {
      _billingAddressListKey.currentState.save();
      if (_customerId != null &&
          _customerId != '' &&
          _billingAddressId != null &&
          _billingAddressId != '') {
        Constants.showLoadingIndicator(context);
        BillingAddressData _applyParam = BillingAddressData(
            _customerId,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            _billingAddressId);

        await BillingAddressUtils.applyBillingAddress(_applyParam)
            .then((dynamic _applyRes) {
          if (_applyRes != null &&
              _applyRes.containsKey('address_id') &&
              _applyRes != null &&
              _applyRes['address_id'] == _billingAddressId) {
            setState(() {
              _deliveryAbsorbing = false;
              _deliveryMethodAbsorbing = true;
              _paymentAbsorbing = true;
              _confirmAbsorbing = true;
              _billingAddressExpanded = false;
              _deliveryAddressExpanded = true;
            });
            Navigator.of(context).pop();
            Constants.showShortToastBuilder("Billing Address Applied");
          }
        }).catchError((_err) {
          Navigator.of(context).pop();
          print("applyBillingAddress catchError:=> $_err");
          Constants.showShortToastBuilder("Oops something went wrong!");
        });
      }
    } else {
      setState(() {
        _billingAddressListValidate = true; //enable realtime validation
      });
    }
  }

  Future<void> _saveShippingAddress(BuildContext context) async {
    if (_deliveryAddressKey.currentState.validate()) {
      _deliveryAddressKey.currentState.save();
      if (_zoneId != null && _zoneId != '0' && _zoneId != '') {
        setState(() {
          _stateError = false;
        });
        if (_token != null &&
            _token != '' &&
            _customerId != null &&
            _customerId != '') {
          Constants.showLoadingIndicator(context);
          ShippingAddressData _addParams = ShippingAddressData(
              _customerId,
              _firstName.text,
              _lastName.text,
              _company.text,
              _email.text,
              _address1.text,
              _address2.text,
              _city.text,
              _postCode.text,
              _countryId,
              _zoneId,
              null,
              null,
              null);

          await ShippingAddressUtils.saveNewShippingAddress(_addParams)
              .then((dynamic _shipRes) async {
            if (_shipRes != null &&
                _shipRes.containsKey("payment_address") &&
                _shipRes['payment_address'] != null &&
                _shipRes.containsKey("address_id") &&
                _shipRes['address_id'] != null) {
              await _getShippingAddress(
                  _customerId, _shipRes['address_id'].toString());
              Navigator.of(context).pop();
              Constants.showShortToastBuilder(
                  'Shipping address saved successfully.');
              _deliveryAddressKey.currentState.reset();
            } else {
              Navigator.of(context).pop();
              Constants.showShortToastBuilder('Oops something went wrong!');
            }
          }).catchError((_shipErr) {
            Navigator.of(context).pop();
            Constants.showShortToastBuilder('Oops something went wrong!');
            print('\nsaveNewShippingAddress catchError:= $_shipErr\n');
          });
        } else {
          MaterialPageRoute authRoute =
              MaterialPageRoute(builder: (context) => AuthLogin());
          Navigator.push(context, authRoute);
        }
      } else {
        setState(() {
          _stateError = true;
        });
      }
    } else {
      setState(() {
        _deliveryAddressValidate = true; //enable realtime validation
      });
    }
  }

  Future<dynamic> _getShippingMethod(
      final String _shippingAddressId, final String _customerId) async {
    if (_shippingAddressId != null &&
        _shippingAddressId != '' &&
        _customerId != null &&
        _customerId != '') {
      await ShippingAddressUtils.getShippingMethod(
              _shippingAddressId, _customerId)
          .then((dynamic _getRes) {
        if (_getRes != null && _getRes.containsKey('shipping_methods')) {
          setState(() {
            _shippingMethodTitle = _getRes['shipping_methods']['flat']['title'];
            _shippingMethodFlatCode =
                _getRes['shipping_methods']['flat']['quote']['flat']['code'];
            _shippingMethodFlatTitle =
                _getRes['shipping_methods']['flat']['quote']['flat']['title'];
            _shippingMethodFlatCost =
                _getRes['shipping_methods']['flat']['quote']['flat']['cost'];
            _shippingMethodFlatTaxClassId = _getRes['shipping_methods']['flat']
                ['quote']['flat']['tax_class_id'];
            _shippingMethodFlatText =
                _getRes['shipping_methods']['flat']['quote']['flat']['text'];
            _textShippingMethod = _getRes['text_shipping_method'];
            _textComments = _getRes['text_comments'];
          });
          print("\n\ngetShippingMethod Success.\n\n");
          Constants.showShortToastBuilder("getShippingMethod Success.");
        }
      }).catchError((_err) {
        Constants.showLongToastBuilder("getShippingMethod failed!");
        print("_getShippingMethod catchError:=> $_err");
      });
    }
  }

  Future<void> _applyShippingAddress(BuildContext context) async {
    if (_deliveryAddressListKey.currentState.validate()) {
      _deliveryAddressListKey.currentState.save();
      if (_customerId != null &&
          _customerId != '' &&
          this._shippingAddressId != null &&
          this._shippingAddressId != '') {
        Constants.showLoadingIndicator(context);
        ShippingAddressData _applyParam = ShippingAddressData(
            _customerId,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            this._shippingAddressId,
            null,
            null);
        await ShippingAddressUtils.applyShippingAddress(_applyParam)
            .then((dynamic _applyRes) async {
          if (_applyRes != null &&
              _applyRes.containsKey('address_id') &&
              _applyRes != null &&
              _applyRes['address_id'] == this._shippingAddressId) {
            await _getShippingMethod(this._shippingAddressId, _customerId);
            setState(() {
              _deliveryMethodAbsorbing = false;
              _paymentAbsorbing = true;
              _confirmAbsorbing = true;
            });
            Navigator.of(context).pop();
            Constants.showShortToastBuilder("Delivery Address Applied");
            _deliveryAddressListKey.currentState.reset();
          }
        }).catchError((_err) {
          Navigator.of(context).pop();
          print("applyBillingAddress catchError:=> $_err");
          Constants.showShortToastBuilder("Oops something went wrong!");
        });
      }
    } else {
      setState(() {
        _deliveryAddressListValidate = true; //enable realtime validation
      });
    }
  }

  Future<void> _applyShippingMethod(BuildContext context) async {
    if (_deliveryMethodKey.currentState.validate()) {
      _deliveryMethodKey.currentState.save();
      if (_customerId != null &&
          _customerId != '' &&
          _shippingMethodFlatCode != null &&
          _shippingMethodFlatCode != '' &&
          _shippingAddressId != null &&
          _shippingAddressId != '') {
        Constants.showLoadingIndicator(context);
        ShippingAddressData _applyParam = ShippingAddressData(
            _customerId,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            _shippingAddressId,
            _shippingMethodFlatCode,
            _shippingMethodComment.text);
        await ShippingAddressUtils.applyShippingMethod(_applyParam)
            .then((dynamic _applyRes) async {
          if (_applyRes != null && _applyRes.containsKey('shipping_method')) {
            await _getPaymentMethod(_billingAddressId, _customerId);
            setState(() {
              _paymentAbsorbing = false;
              _confirmAbsorbing = true;
            });
            Navigator.of(context).pop();
            print("applyShippingMethod success.");
            Constants.showShortToastBuilder("applyShippingMethod success.");
            _deliveryMethodKey.currentState.reset();
          } else {
            Navigator.of(context).pop();
            print("applyShippingMethod failed.");
            Constants.showLongToastBuilder("applyShippingMethod failed.");
          }
        }).catchError((_err) {
          Navigator.of(context).pop();
          print("applyShippingMethod catchError:=> $_err");
          Constants.showLongToastBuilder("Oops something went wrong!");
        });
      }
    } else {
      setState(() {
        _deliveryMethodValidate = true; //enable realtime validation
      });
    }
  }

  Future<dynamic> _getPaymentMethod(
      final String _billingAddressId, final String _customerId) async {
    if (_billingAddressId != null &&
        _billingAddressId != '' &&
        _customerId != null &&
        _customerId != '') {
      await PaymentUtils.getPaymentMethod(_billingAddressId, _customerId)
          .then((dynamic _getRes) async {
        if (_getRes != null && _getRes.containsKey('payment_methods')) {
          setState(() {
            _paymentMethods = _getRes['payment_methods'];
            _payUMerchant = _getRes['payu_merchant'];
            _payUSalt = _getRes['payu_salt'];
            _razorPayKey = _getRes['razorpay_key'];
            _razorPaySecret = _getRes['razorpay_secret'];
            _totalProdStatus = _getRes['total_prod_status'];
            _textProdOpt = _getRes['text_prod_opt'];
            _getRes['prod_opt'] == false ? _prodOpt = '0' : _prodOpt = '1';
            _totalEWalletStatus = _getRes['total_ewallet_status'];
          });
          print("\n\ngetPaymentMethod Success.\n\n");
          Constants.showShortToastBuilder("getPaymentMethod Success.");
        }
      }).catchError((_err) {
        Constants.showLongToastBuilder("getPaymentMethod failed!");
        print("getPaymentMethod catchError:=> $_err");
      });
    }
  }

  Future<void> _saveOrder() async {
    if (_customerId != null &&
        _customerId != '' &&
        _billingAddressId != null &&
        _billingAddressId != '' &&
        _shippingAddressId != null &&
        _shippingAddressId != '' &&
        _shippingMethodFlatCode != null &&
        _shippingMethodFlatCode != '' &&
        _paymentMethodCode != null &&
        _paymentMethodCode != '') {
      SaveOrderData _orderParam = SaveOrderData(
          _customerId,
          _billingAddressId,
          _shippingAddressId,
          _shippingMethodFlatCode,
          _paymentMethodCode,
          _vouchers != null && _vouchers != '' ? _vouchers : '-',
          _coupon != null && _coupon != '' ? _coupon : '-',
          _reward != null && _reward != '' ? _reward : '-',
          _prodOpt,
          _totalEWalletStatus.toString(),
          _saveOrderComment.text);
      await SaveOrderUtils.saveOrder(_orderParam).then((dynamic _saveRes) {
        if (_saveRes != null &&
            _saveRes.containsKey('order_id') &&
            _saveRes['order_id'] != null) {
          print("\n\nsaveOrder Success.\n\n");
          setState(() {
            _savedOrder = SavedOrderData.fromJson(_saveRes);
            _orderId = _saveRes['order_id'];
            if (_savedOrder != null &&
                _savedOrder.totals != null &&
                _savedOrder.totals.length > 0) {
              _savedOrder.totals.forEach((_element) {
                if (_element['title'] == 'Total') {
                  setState(() {
                    _totalPrice = _element['amount_float'];
                  });
                }
              });
            }
          });
        } else {
          print("\n\nsaveOrder failed.\n\n");
        }
      }).catchError((_err) {
        print("\n\nsaveOrder catchError:=> $_err\n\n");
      });
    }
  }

  Future<void> _applyPaymentMethod() async {
    if (_paymentMethodKey.currentState.validate()) {
      _paymentMethodKey.currentState.save();
      if (_termsAndConditions == true) {
        setState(() {
          _termsError = false;
        });
        if (_customerId != null &&
            _customerId != '' &&
            _paymentMethodCode != null &&
            _paymentMethodCode != '') {
          Constants.showLoadingIndicator(context);
          PaymentData _paymentParam = PaymentData(
              _customerId, _paymentMethodCode, _paymentMethodComment.text);
          await PaymentUtils.applyPaymentMethod(_paymentParam)
              .then((dynamic _paymentRes) async {
            if (_paymentRes != null &&
                _paymentRes.containsKey('payment_method') &&
                _paymentRes.containsKey('success')) {
              await _saveOrder();
              setState(() {
                _confirmAbsorbing = false;
              });
              Navigator.of(context).pop();
              print("\n\napplyPaymentMethod Success.\n\n");
              Constants.showShortToastBuilder(_paymentRes['success']);
              _savedOrder != null
                  ? Constants.showLongToastBuilder(
                      'Your order successfully saved.')
                  : Container();
              _paymentMethodKey.currentState.reset();
            } else {
              Navigator.of(context).pop();
              print("\n\napplyPaymentMethod failed.\n\n");
              Constants.showLongToastBuilder("applyPaymentMethod failed.");
            }
          }).catchError((_err) {
            Navigator.of(context).pop();
            print("\n\napplyPaymentMethod catchError:=> $_err\n\n");
            Constants.showLongToastBuilder("Oops something went wrong!");
          });
        }
      } else {
        setState(() {
          _termsError = true;
        });
      }
    } else {
      setState(() {
        _paymentMethodValidate = true; //enable realtime validation
      });
    }
  }

  Future<dynamic> _updateState(final String _newCountryId) async {
    if (_newCountryId != null && _newCountryId != '') {
      await LocationUtils.getStates(_newCountryId)
          .then((final dynamic _newStateRes) {
        if (_newStateRes != null && _newStateRes.containsKey('zone')) {
          if (_newStateRes['zone'] != null && _newStateRes['zone'].length > 0) {
            setState(() {
              this._zoneId = null;
              this._zoneData = ZoneData.fromJson(_newStateRes);
              this._zoneId = this._zoneData.zone[0]['zone_id'];
            });
          }
        } else {
          print("getStates Failed");
          Constants.showLongToastBuilder("State not found!");
        }
      }).catchError((_err) {
        print("\ngetStates catchError:=> $_err\n");
        Constants.showLongToastBuilder(_err.toString());
      });
    }
  }

  Form _billingAddressFormBuilder() {
    return Form(
      key: _billingAddressKey,
      autovalidate: _billingAddressValidate,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: _mStart,
          children: <Widget>[
            WidgetPage.textFormField(
                _firstName,
                TextInputType.text,
                'First Name',
                'First Name must be between 1 and 32 characters!'),
            Constants.height(30.0),
            WidgetPage.textFormField(_lastName, TextInputType.text, 'Last Name',
                'Last Name must be between 1 and 32 characters!'),
            Constants.height(30.0),
            WidgetPage.textFormFieldWithoutValidation(
                _company, TextInputType.text, 'Company'),
            Constants.height(30.0),
            WidgetPage.textFormField(_email, TextInputType.emailAddress,
                'Email', 'Please enter email.'),
            Constants.height(30.0),
            WidgetPage.textFormField(_address1, TextInputType.text, 'Address 1',
                'Address must be between 3 and 128 characters!'),
            Constants.height(30.0),
            WidgetPage.textFormFieldWithoutValidation(
                _address2, TextInputType.text, 'Address 2'),
            Constants.height(30.0),
            WidgetPage.textFormField(_city, TextInputType.text, 'City',
                'City must be between 2 and 128 characters!'),
            Constants.height(30.0),
            WidgetPage.textFormField(_postCode, TextInputType.number,
                'Post Code', 'City must be 6 characters!'),
            Constants.height(30.0),
            Column(
              mainAxisAlignment: _mStart,
              crossAxisAlignment: _cStart,
              children: <Widget>[
                RichText(
                  text: TextSpan(text: '* ', style: _textSpanStyle, children: [
                    TextSpan(
                      text: 'Country',
                      style: _richTextStyle,
                    ),
                  ]),
                ),
                Container(
                  width: _deviceSize.width,
                  child: DropdownButtonFormField(
                    value: this._countryId,
                    elevation: 0,
                    isDense: true,
                    isExpanded: true,
                    iconEnabledColor: Colors.green,
                    items: WidgetPage.countryMenuItems(
                        this._countryData.countries),
                    onChanged: (dynamic _newCountryVal) async {
                      if (_newCountryVal != null && _newCountryVal != '') {
                        setState(() {
                          this._countryId = _newCountryVal.toString();
                          print("onChanged countryId:=> $_newCountryVal");
                        });
                        await _updateState(this._countryId);
                      }
                    },
                    validator: (dynamic _value) => _value == null
                        ? 'Please select a country!'
                        : _value == '0' ? 'Please select a country!' : null,
                  ),
                ),
              ],
            ),
            Constants.height(30.0),
            Column(
              mainAxisAlignment: _mStart,
              crossAxisAlignment: _cStart,
              children: <Widget>[
                RichText(
                  text: TextSpan(text: '* ', style: _textSpanStyle, children: [
                    TextSpan(
                      text: 'Region / State',
                      style: _richTextStyle,
                    ),
                  ]),
                ),
                Container(
                  width: _deviceSize.width,
                  child: DropdownButton(
                    elevation: 0,
                    isExpanded: true,
                    iconEnabledColor: Constants.myGreen,
                    items: WidgetPage.stateMenuItems(this._zoneData.zone),
                    onChanged: (dynamic _newStateVal) {
                      setState(() {
                        this._zoneId = _newStateVal;
                        if (_zoneId != null &&
                            _zoneId != '0' &&
                            _zoneId != '') {
                          setState(() {
                            _stateError = false;
                          });
                        }
                        print("onChanged ZoneId:=> ${this._zoneId}");
                      });
                    },
                    value: this._zoneId,
                  ),
                ),
                _stateError
                    ? Text(
                        "Please select a region / state!",
                        style: TextStyle(fontSize: 12.0, color: Colors.red),
                      )
                    : Container(),
              ],
            ),
            Constants.height(30.0),
            InkWell(
              onTap: () async => _saveBillingAddress(context),
              child: Container(
                color: Constants.primary_green,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 14),
                child: Text(
                  'SAVE ADDRESS',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Constants.height(15.0),
          ],
        ),
      ),
    );
  }

  Widget _billingAddressListBuilder() {
    return Form(
      key: _billingAddressListKey,
      autovalidate: _billingAddressListValidate,
      child: Column(
        crossAxisAlignment: _cStart,
        mainAxisAlignment: _mStart,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: DropdownButtonFormField(
              value: this._billingAddressId,
              elevation: 0,
              isDense: false,
              isExpanded: true,
              iconEnabledColor: Colors.green,
              items: WidgetPage.addressMenuItems(this._addresses),
              onChanged: (dynamic _newVal) async {
                if (_newVal != null && _newVal != '') {
                  setState(() {
                    this._billingAddressId = _newVal.toString();
                    print(
                        "onChanged billingAddressId:=> ${this._billingAddressId}");
                  });
                }
              },
              validator: (dynamic _value) => _value == null
                  ? 'Please select a billingAddress!'
                  : _value == '0' ? 'Please select a billingAddress!' : null,
            ),
          ),
          Constants.height(20.0),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: InkWell(
              onTap: () async =>
                  _applyBillingAddress(_customerId, _billingAddressId, context),
              child: Container(
                color: Constants.primary_green,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  'CONTINUE',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Form _deliveryAddressFormBuilder() {
    return Form(
      key: _deliveryAddressKey,
      autovalidate: _deliveryAddressValidate,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: _mStart,
          children: <Widget>[
            WidgetPage.textFormField(
                _firstName,
                TextInputType.text,
                'First Name',
                'First Name must be between 1 and 32 characters!'),
            Constants.height(30.0),
            WidgetPage.textFormField(_lastName, TextInputType.text, 'Last Name',
                'Last Name must be between 1 and 32 characters!'),
            Constants.height(30.0),
            WidgetPage.textFormFieldWithoutValidation(
                _company, TextInputType.text, 'Company'),
            Constants.height(30.0),
            WidgetPage.textFormField(_email, TextInputType.emailAddress,
                'Email', 'Please enter email.'),
            Constants.height(30.0),
            WidgetPage.textFormField(_address1, TextInputType.text, 'Address 1',
                'Address must be between 3 and 128 characters!'),
            Constants.height(30.0),
            WidgetPage.textFormFieldWithoutValidation(
                _address2, TextInputType.text, 'Address 2'),
            Constants.height(30.0),
            WidgetPage.textFormField(_city, TextInputType.text, 'City',
                'City must be between 2 and 128 characters!'),
            Constants.height(30.0),
            WidgetPage.textFormField(_postCode, TextInputType.number,
                'Post Code', 'City must be 6 characters!'),
            Constants.height(30.0),
            Column(
              mainAxisAlignment: _mStart,
              crossAxisAlignment: _cStart,
              children: <Widget>[
                RichText(
                  text: TextSpan(text: '* ', style: _textSpanStyle, children: [
                    TextSpan(
                      text: 'Country',
                      style: _richTextStyle,
                    ),
                  ]),
                ),
                Container(
                  width: _deviceSize.width,
                  child: DropdownButtonFormField(
                    value: this._countryId,
                    elevation: 0,
                    isDense: true,
                    isExpanded: true,
                    iconEnabledColor: Colors.green,
                    items: WidgetPage.countryMenuItems(
                        this._countryData.countries),
                    onChanged: (dynamic _newVal) async {
                      if (_newVal != null && _newVal != '') {
                        setState(() {
                          this._countryId = _newVal.toString();
                          print("onChanged countryId:=> ${this._countryId}");
                        });
                        await _updateState(this._countryId);
                      }
                    },
                    validator: (dynamic _value) => _value == null
                        ? 'Please select a country!'
                        : _value == '0' ? 'Please select a country!' : null,
                  ),
                ),
              ],
            ),
            Constants.height(30.0),
            Column(
              mainAxisAlignment: _mStart,
              crossAxisAlignment: _cStart,
              children: <Widget>[
                RichText(
                  text: TextSpan(text: '* ', style: _textSpanStyle, children: [
                    TextSpan(
                      text: 'Region / State',
                      style: _richTextStyle,
                    ),
                  ]),
                ),
                Container(
                  width: _deviceSize.width,
                  child: DropdownButton(
                    value: this._zoneId,
                    elevation: 0,
                    isDense: true,
                    isExpanded: true,
                    iconEnabledColor: Colors.green,
                    items: WidgetPage.stateMenuItems(this._zoneData.zone),
                    onChanged: (dynamic _newStateVal) {
                      setState(() {
                        this._zoneId = _newStateVal;
                        if (_zoneId != null &&
                            _zoneId != '0' &&
                            _zoneId != '') {
                          setState(() {
                            _stateError = false;
                          });
                        }
                        print("onChanged ZoneId:=> $this._zoneId");
                      });
                    },
                  ),
                ),
                _stateError
                    ? Text(
                        "Please select a region / state!",
                        style: TextStyle(fontSize: 12.0, color: Colors.red),
                      )
                    : Container(),
              ],
            ),
            Constants.height(30.0),
            InkWell(
              onTap: () async => _saveShippingAddress(context),
              child: Container(
                color: Constants.primary_green,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 14),
                child: Text(
                  'SAVE ADDRESS',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Constants.height(15.0),
          ],
        ),
      ),
    );
  }

  Widget _deliveryAddressListBuilder() {
    return Form(
      key: _deliveryAddressListKey,
      autovalidate: _deliveryAddressListValidate,
      child: Column(
        crossAxisAlignment: _cStart,
        mainAxisAlignment: _mStart,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: DropdownButtonFormField(
              value: this._shippingAddressId,
              elevation: 0,
              isDense: false,
              isExpanded: true,
              iconEnabledColor: Colors.green,
              items: WidgetPage.addressMenuItems(this._addresses),
              onChanged: (dynamic _newVal) async {
                if (_newVal != null && _newVal != '') {
                  setState(() {
                    this._shippingAddressId = _newVal.toString();
                    print(
                        "onChanged shippingAddressId:=> ${this._shippingAddressId}");
                  });
                }
              },
              validator: (dynamic _value) => _value == null
                  ? 'Please select a shippingAddress!'
                  : _value == '0' ? 'Please select a shippingAddress!' : null,
            ),
          ),
          Constants.height(20.0),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: InkWell(
              onTap: () async => _applyShippingAddress(context),
              child: Container(
                color: Constants.primary_green,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  'CONTINUE',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _deliveryMethodBuilder() {
    return Form(
      key: _deliveryMethodKey,
      autovalidate: _deliveryMethodValidate,
      child: Column(
        crossAxisAlignment: _cStart,
        mainAxisAlignment: _mStart,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: Text(
              _textShippingMethod,
              style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w400,
                  color: Constants.grey600),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.0, top: 20.0),
            child: Text(
              _shippingMethodTitle,
              style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                  color: Constants.grey600),
            ),
          ),
          RadioListTile(
            title: Text(
              "$_shippingMethodFlatTitle - $_shippingMethodFlatText",
              style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                  color: Constants.grey600),
            ),
            value: _shippingMethodFlatCode,
            groupValue: _shippingMethodFlatCode,
            onChanged: (dynamic _val) {
              setState(() {
                _shippingMethodFlatCode = _val;
                print("new shippingMethodFlatCode:=> $_val");
              });
            },
            activeColor: Constants.myGreen,
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.0, top: 10.0),
            child: Text(
              _textComments,
              style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                  color: Constants.grey600),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: TextField(
              maxLines: 4,
              maxLength: 500,
              controller: _shippingMethodComment,
              keyboardType: TextInputType.text,
              autofocus: false,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: const BorderSide(
                      color: Constants.primary_green, width: 1.5),
                ),
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0)),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: InkWell(
              onTap: () async => _applyShippingMethod(context),
              child: Container(
                color: Constants.primary_green,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  'CONTINUE',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          Constants.height(20.0),
        ],
      ),
    );
  }

  Widget _paymentMethodRadioWidget() {
    if (_paymentMethodCode == null) {
      _paymentMethodCode = _paymentMethods.values.toList()[0]['code'];
    }
    return FormBuilderRadioGroup(
      decoration: _radioDecoration,
      initialValue: _paymentMethodCode,
      attribute: "payment_method",
      activeColor: Constants.myGreen,
      options: WidgetPage.paymentMethodRadioGroup(_paymentMethods),
      onChanged: (dynamic _newRadioVal) {
        _paymentMethods.forEach((_key, _value) {
          if (_value['code'] == _paymentMethodCode) {
            setState(() {
              _paymentMethodCode = _newRadioVal;
              _paymentMethodTitle = _value['title'];
              _paymentMethodTerms = _value['terms'];
              _paymentMethodSortOrder = _value['sort_order'];
              _paymentMethodCode == 'payu'
                  ? _paymentMethodMerchantKey = _payUMerchant
                  : _paymentMethodCode == 'razorpay'
                      ? _paymentMethodMerchantKey = _razorPayKey
                      : _paymentMethodMerchantKey = _paymentMethodMerchantKey;
              _paymentMethodCode == 'payu'
                  ? _paymentMethodSalt = _payUSalt
                  : _paymentMethodCode == 'razorpay'
                      ? _paymentMethodSalt = _razorPaySecret
                      : _paymentMethodSalt = _paymentMethodSalt;
              print("\nnew paymentMethodVal:=> $_paymentMethodCode\n");
            });
          }
        });
      },
    );
  }

  Widget _paymentTypeRadioWidget() {
    final Map<String, dynamic> _paymentTypes = {
      "partial_payment": {"text_prod_opt": "Partial Payment", "prod_opt": "0"},
      "full_payment": {"text_prod_opt": "Full Payment", "prod_opt": '1'}
    };
    if (_prodOpt == null) {
      _prodOpt = _paymentTypes.values.toList()[1]['prod_opt'];
    }
    return FormBuilderRadioGroup(
      decoration: _radioDecoration,
      initialValue: _prodOpt,
      attribute: "payment_type",
      activeColor: Constants.myGreen,
      options: WidgetPage.paymentTypeRadioGroup(_paymentTypes),
      onChanged: (_newTypeVal) {
        setState(() {
          _prodOpt = _newTypeVal;
          print("\nnew paymentTypeVal:=> $_prodOpt\n");
        });
      },
    );
  }

  Widget _paymentMethodBuilder() {
    return Form(
      key: _paymentMethodKey,
      autovalidateMode: AutovalidateMode.always,
      autovalidate: _paymentMethodValidate,
      child: Column(
        crossAxisAlignment: _cStart,
        mainAxisAlignment: _mStart,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: Text(
              "Please select the preferred payment method to use on this order.",
              style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w400,
                  color: Constants.grey600),
            ),
          ),
          _paymentMethods != null ? _paymentMethodRadioWidget() : Container(),
          Constants.height(10.0),
          _prodOpt != null && _prodOpt != ''
              ? _paymentTypeRadioWidget()
              : Container(),
          Padding(
            padding: EdgeInsets.only(left: 20.0, top: 10.0),
            child: Text(
              "Add Comments About Your Order",
              style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                  color: Constants.grey600),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: TextField(
              maxLines: 4,
              maxLength: 500,
              controller: _paymentMethodComment,
              keyboardType: TextInputType.text,
              autofocus: false,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: const BorderSide(
                      color: Constants.primary_green, width: 1.5),
                ),
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0)),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              'I have read and agree to the ',
              style: TextStyle(fontSize: 12.0),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              crossAxisAlignment: _cCenter,
              mainAxisAlignment: _mStart,
              children: <Widget>[
                InkWell(
                  onTap: () async {
                    Constants.showShortToastBuilder('Terms & Conditions');
                  },
                  child: Text(
                    'Terms & Conditions',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0),
                  ),
                ),
                FormField(
                  validator: (bool _value) => _value == false
                      ? 'You must agree to the Terms & Conditions!'
                      : null,
                  builder: (FormFieldState<dynamic> field) {
                    return Checkbox(
                      visualDensity: VisualDensity.compact,
                      activeColor: Constants.myGreen,
                      value: _termsAndConditions,
                      onChanged: (_newCheckVal) {
                        setState(() {
                          _termsAndConditions = _newCheckVal;
                          if (_termsAndConditions == true) {
                            setState(() {
                              _termsError = false;
                            });
                          }
                          print("termsAndConditions:= $_termsAndConditions");
                        });
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          _termsError
              ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    "You must agree to the Terms & Conditions!",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12.0, color: Colors.red),
                  ),
                )
              : Container(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: InkWell(
              onTap: () async => _applyPaymentMethod(),
              child: Container(
                color: Constants.primary_green,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  'CONTINUE',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _productListWidget(final List<dynamic> _savedProducts) {
    final List<dynamic> _productList = _savedProducts.map((_listItem) {
      return SavedOrderProducts.fromJson(_listItem);
    }).toList();
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        primary: false,
        itemCount: _productList == null ? 0 : _productList.length,
        itemBuilder: (BuildContext context, int _listIndex) {
          SavedOrderProducts _products = _productList[_listIndex];
          return Container(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
            decoration: BoxDecoration(
              color: Constants.myWhite,
              border: Border.all(width: 0.1, color: Colors.grey),
            ),
            child: Row(
                crossAxisAlignment: _cStart,
                mainAxisAlignment: _mStart,
                children: <Widget>[
                  _products != null
                      ? WidgetPage.savedProductImage(_products.thumb)
                      : Container(),
                  Constants.width(10.0),
                  Expanded(
                    child: Column(
                        crossAxisAlignment: _cStart,
                        mainAxisAlignment: _mStart,
                        children: <Widget>[
                          _products != null &&
                                  _products.name != null &&
                                  _products.name != ''
                              ? WidgetPage.itemNameText(_products.name)
                              : Container(),
                          _products != null &&
                                  _products.quantity != null &&
                                  int.parse(_products.quantity) > 0
                              ? WidgetPage.savedItemQuantityText(
                                  _savedOrder, _products.quantity.toString())
                              : Container(),
                          _products != null &&
                                  _products.price != null &&
                                  _products.price != ''
                              ? WidgetPage.savedOrderUnitPrice(
                                  _savedOrder, _products.price)
                              : Container(),
                          _products != null &&
                                  _products.total != null &&
                                  _products.total != ''
                              ? WidgetPage.savedOrderTotalPrice(
                                  _savedOrder, _products.total)
                              : Container(),
                        ]),
                  ),
                ]),
          );
        });
  }

  Widget _savedOrderTotalPriceWidget(final List<dynamic> _totals) {
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

  Widget _confirmOrderButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: InkWell(
        onTap: () async => _confirmPayment(),
        child: Container(
          color: Constants.primary_green,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(vertical: 12),
          child: Text(
            'CONFIRM',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _confirmOrderBuilder() {
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      primary: false,
      child: Column(
        crossAxisAlignment: _cStart,
        mainAxisAlignment: _mStart,
        children: [
          _savedOrder != null &&
                  _savedOrder.products != null &&
                  _savedOrder.products.length > 0
              ? _productListWidget(_savedOrder.products)
              : Container(),
          _savedOrder.totals != null && _savedOrder.totals.length > 0
              ? _savedOrderTotalPriceWidget(_savedOrder.totals)
              : Container(),
          _savedOrder != null &&
                  _savedOrder.products != null &&
                  _savedOrder.products.length > 0
              ? _confirmOrderButton()
              : Container(),
        ],
      ),
    );
  }

  Widget _checkoutOptions() {
    return AbsorbPointer(
      absorbing: _checkoutOptionAbsorbing,
      child: Container(
        width: _deviceSize.width,
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
        decoration: BoxDecoration(
          color: Constants.myWhite,
          border: Border.all(width: 0.5, color: Colors.grey),
        ),
        child: ExpansionTile(
          title: WidgetPage.expansionTitle("Step 1: Checkout Options"),
        ),
      ),
    );
  }

  Widget _billingAddress() {
    return AbsorbPointer(
      absorbing: _billingAbsorbing,
      child: Container(
        width: _deviceSize.width,
        margin: _margin,
        decoration: _boxDecoration,
        child: ExpansionTile(
          initiallyExpanded: _billingAddressExpanded,
          title: WidgetPage.expansionTitle("Step 2: Billing Details"),
          children: <Widget>[
            FormBuilderRadioGroup(
              decoration: _radioGroupDecoration,
              initialValue: this._initialValue,
              attribute: "selected_address",
              activeColor: Constants.myGreen,
              options: WidgetPage.addressTypeOptions(_addresses),
              onChanged: (dynamic _newRadioVal) {
                setState(() {
                  this._initialValue = _newRadioVal;
                  print("selectedAddressType:=> $_newRadioVal");
                });
              },
            ),
            this._initialValue == 'new'
                ? _billingAddressFormBuilder()
                : _billingAddressListBuilder(),
          ],
        ),
      ),
    );
  }

  Widget _deliveryAddress() {
    return AbsorbPointer(
      absorbing: _deliveryAbsorbing,
      child: Container(
        margin: _margin,
        decoration: _boxDecoration,
        child: ExpansionTile(
          initiallyExpanded: _deliveryAddressExpanded,
          title: WidgetPage.expansionTitle("Step 3: Delivery Details"),
          children: <Widget>[
            FormBuilderRadioGroup(
              decoration: _radioGroupDecoration,
              initialValue: this._initialValue,
              attribute: "selected_address",
              activeColor: Constants.myGreen,
              options: WidgetPage.addressTypeOptions(_addresses),
              onChanged: (dynamic _newRadioVal) {
                setState(() {
                  this._initialValue = _newRadioVal;
                  print("selectedAddressType:=> ${this._initialValue}");
                });
              },
            ),
            this._initialValue == 'new'
                ? _deliveryAddressFormBuilder()
                : _deliveryAddressListBuilder(),
          ],
        ),
      ),
    );
  }

  Widget _deliveryMethod() {
    return AbsorbPointer(
      absorbing: _deliveryMethodAbsorbing,
      child: Container(
        margin: _margin,
        decoration: _boxDecoration,
        child: ExpansionTile(
          title: WidgetPage.expansionTitle("Step 4: Delivery Method"),
          children: <Widget>[
            _deliveryMethodBuilder(),
          ],
        ),
      ),
    );
  }

  Widget _paymentMethod() {
    return AbsorbPointer(
      absorbing: _paymentAbsorbing,
      child: Container(
        margin: _margin,
        decoration: _boxDecoration,
        child: ExpansionTile(
          title: WidgetPage.expansionTitle("Step 5: Payment Method"),
          children: <Widget>[
            _paymentMethods != null && _prodOpt != null
                ? _paymentMethodBuilder()
                : Container(),
          ],
        ),
      ),
    );
  }

  Widget _confirmOrder() {
    return AbsorbPointer(
      absorbing: _confirmAbsorbing,
      child: Container(
        margin: _margin,
        decoration: _boxDecoration,
        child: ExpansionTile(
          title: WidgetPage.expansionTitle("Step 6: Confirm Order"),
          children: <Widget>[
            _savedOrder != null ? _confirmOrderBuilder() : Container(),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: WidgetPage.checkoutAppBar(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            Constants.height(8.0),
            _checkoutOptions(),
            _billingAddress(),
            _deliveryAddress(),
            _deliveryMethod(),
            _paymentMethod(),
            _confirmOrder(),
          ],
        ),
      ),
    );
  }
}

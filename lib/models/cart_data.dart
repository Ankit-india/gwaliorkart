import 'dart:io';
import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gwaliorkart/utils/network_utils.dart';
import 'package:path/path.dart' as p;

class CartData {
  File image;
  bool checkBoxInput;
  int productId, quantity, textCount;
  List<dynamic> option, products, vouchersList, totals, modules;
  String customerId,
      selectInput,
      radioInput,
      textInput,
      textAreaInput,
      date,
      dateTime,
      time,
      imagePath,
      price,
      pricePrefix,
      vouchers,
      coupon,
      reward,
      textError,
      headingTitle,
      textRecurringItem,
      textNext,
      textNextChoice,
      columnImage,
      columnName,
      columnModel,
      columnQuantity,
      columnPrice,
      columnTotal,
      buttonUpdate,
      buttonRemove,
      buttonShopping,
      buttonCheckout,
      errorWarning,
      attention,
      success,
      weight,
      cartId;

  CartData(this.productId, this.customerId, this.quantity, this.option,
      this.vouchers, this.coupon, this.reward, this.cartId);

  CartData.fromJson(Map<String, dynamic> json)
      : selectInput = json['select'],
        radioInput = json['radio'],
        checkBoxInput = json['checkbox'],
        textInput = json['text'],
        textAreaInput = json['text_area'],
        image = json['image'],
        date = json['date'],
        dateTime = json['date_time'],
        time = json['time'],
        textCount = json['text_count'],
        textError = json['text_error'],
        headingTitle = json['heading_title'],
        textRecurringItem = json['text_recurring_item'],
        textNext = json['text_next'],
        textNextChoice = json['text_next_choice'],
        columnImage = json['column_image'],
        columnName = json['column_name'],
        columnModel = json['column_model'],
        columnQuantity = json['column_quantity'],
        columnPrice = json['column_price'],
        columnTotal = json['column_total'],
        buttonUpdate = json['button_update'],
        buttonRemove = json['button_remove'],
        buttonShopping = json['button_shopping'],
        buttonCheckout = json['button_checkout'],
        errorWarning = json['error_warning'],
        attention = json['attention'],
        success = json['success'],
        weight = json['weight'],
        products = json['products'],
        vouchersList = json['vouchers'],
        totals = json['totals'],
        modules = json['modules'];

  Map<String, dynamic> toJson() => {
        'product_id': productId.toString(),
        'customer_id': customerId,
        'quantity': quantity.toString(),
        'option': option.toList(),
        'vouchers': vouchers,
        'coupon': coupon,
        'reward': reward
      };

  Map<String, dynamic> toJsonEdit() =>
      {'cart_id': cartId, 'quantity': quantity.toString()};

  Map<String, dynamic> toJsonRemove() =>
      {'cart_id': cartId, 'customer_id': customerId};

  Map<String, dynamic> toJsonCoupon() =>
      {'coupon': coupon, 'customer_id': customerId};

  Map<String, dynamic> toJsonVoucher() =>
      {'voucher': vouchers, 'customer_id': customerId};

  Map<String, dynamic> toJsonReward() =>
      {'reward': reward, 'customer_id': customerId};

  ImageProvider<dynamic> getImage() {
    ImageProvider<dynamic> imageUrl;
    if (imagePath != null && imagePath != '') {
      imageUrl = NetworkImage(imagePath);
    } else {
      imageUrl = AssetImage("assets/placeholders/no-product-image.png");
    }
    return imageUrl;
  }
}

class CartUtils {
  static Future<dynamic> addToCart(CartData _addData) async {
    dynamic res = await NetworkUtils.httpPost("addtocart", _addData.toJson());
    print("\n\naddToCart Response:=>  $res\n\n");
    return res;
  }

  static Future<dynamic> editCart(CartData _editData) async {
    dynamic res =
        await NetworkUtils.httpPost("editcart", _editData.toJsonEdit());
    print("\n\neditCart Response:=>  $res\n\n");
    return res;
  }

  static Future<dynamic> removeCart(CartData _removeData) async {
    dynamic res =
        await NetworkUtils.httpPost("removecart", _removeData.toJsonRemove());
    print("\n\nremoveCart Response:=>  $res\n\n");
    return res;
  }

  static Future<dynamic> applyCoupon(CartData _couponData) async {
    dynamic res =
        await NetworkUtils.httpPost("applycoupon", _couponData.toJsonCoupon());
    print("\n\napplyCoupon Response:=>  $res\n\n");
    return res;
  }

  static Future<dynamic> applyVoucher(CartData _voucherData) async {
    dynamic res = await NetworkUtils.httpPost(
        "applyvoucher", _voucherData.toJsonVoucher());
    print("\n\napplyVoucher Response:=>  $res\n\n");
    return res;
  }

  static Future<dynamic> applyReward(CartData _rewardData) async {
    dynamic res =
        await NetworkUtils.httpPost("applyreward", _rewardData.toJsonReward());
    print("\n\napplyReward Response:=>  $res\n\n");
    return res;
  }

  static Future<dynamic> getCartList(
      final String _customerId,
      final String _vouchers,
      final String _coupon,
      final String _reward) async {
    dynamic res = await NetworkUtils.httpGet(
        "getcartlist/" +
            _customerId +
            "/" +
            _vouchers +
            "/" +
            _coupon +
            "/" +
            _reward,
        null);
    print("\n\ngetCartList Response:=>  $res\n\n");
    return res;
  }
}

class CartProductsData {
  List<dynamic> option;
  String cartId, thumb, name, id, model, recurring, reward, price, total;
  bool stock;
  int quantity,savedPrice;

  CartProductsData(
      this.cartId,
      this.thumb,
      this.name,
      this.id,
      this.model,
      this.recurring,
      this.quantity,
      this.stock,
      this.reward,
      this.price,
      this.total,
      this.option);

  CartProductsData.fromJson(Map<String, dynamic> json)
      : cartId = json['cart_id'],
        thumb = json['thumb'],
        name = json['name'],
        id = json['id'],
        model = json['model'],
        recurring = json['recurring'],
        quantity = int.parse(json['quantity']),
        stock = json['stock'],
        reward = json['reward'],
        price = json['price'],
        savedPrice = json['saved_price'],
        total = json['total'],
        option = json['option'];

  Map<String, dynamic> toJson() => {
        'cart_id': cartId,
        'thumb': thumb,
        'name': name,
        'id': id,
        'model': model,
        'recurring': recurring,
        'quantity': quantity,
        'stock': stock,
        'reward': reward,
        'price': price,
        'total': total,
        'option': option
      };
}

class CartProductsOptionData {
  String name, value;

  CartProductsOptionData(this.name, this.value);

  CartProductsOptionData.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        value = json['value'];

  Map<String, dynamic> toJson() => {'name': name, 'value': value};
}

class CartVouchersData {}

class CartTotalsData {
  String title, text;

  CartTotalsData(this.title, this.text);

  CartTotalsData.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        text = json['text'];

  Map<String, dynamic> toJson() => {'title': title, 'text': text};
}

class CartModulesData {}

class UploadFileData {
  String imagePath;
  File image;

  UploadFileData(this.image);

  UploadFileData.fromJson(Map<String, dynamic> json)
      : imagePath = json["image"];

  Image getImage() {
    Image imageUrl;
    if (imagePath != null) {
      imageUrl = Image.network(
        imagePath,
        width: 410.0,
        height: 150,
        fit: BoxFit.fill,
      );
    } else {
      imageUrl = Image.asset(
        "assets/icons/biz_logo.png",
        width: 260.0,
        height: 150,
        fit: BoxFit.fill,
      );
    }
    return imageUrl;
  }

  Map<String, dynamic> toJson() => {'file': image};
}

class UploadFileUtils {
  static uploadFile(UploadFileData _fileData) async {
    FormData _formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(_fileData.image.path,
          filename: p.basename(_fileData.image.path)),
    });
    dynamic res = await NetworkUtils.dioPost("uploadfiles", _formData);
    print("uploadFile Response:  $res");
    return res;
  }
}

class CouponData {
  String coupon, voucher, reward, customerId;

  CouponData(this.coupon, this.voucher, this.reward, this.customerId);

  CouponData.fromJson(Map<String, dynamic> json)
      : coupon = json["coupon"],
        voucher = json["voucher"],
        reward = json["reward"],
        customerId = json['customer_id'];

  Map<String, dynamic> toJson() =>
      {'coupon': coupon, 'customer_id': customerId};

  Map<String, dynamic> toJsonVoucher() =>
      {'voucher': voucher, 'customer_id': customerId};

  Map<String, dynamic> toJsonReward() =>
      {'reward': reward, 'customer_id': customerId};
}

class CouponUtils {
  static Future<dynamic> applyCoupon(CouponData _couponData) async {
    dynamic _couponRes =
        await NetworkUtils.httpPost("applycoupon", _couponData.toJson());
    print("\n\napplyCoupon Response:=>  $_couponRes\n\n");
    return _couponRes;
  }

  static Future<dynamic> applyVoucher(CouponData _voucherData) async {
    dynamic _voucherRes = await NetworkUtils.httpPost(
        "applyvoucher", _voucherData.toJsonVoucher());
    print("\n\napplyVoucher Response:=>  $_voucherRes\n\n");
    return _voucherRes;
  }

  static Future<dynamic> applyReward(CouponData _rewardData) async {
    dynamic _rewardRes =
        await NetworkUtils.httpPost("applyreward", _rewardData.toJsonReward());
    print("\n\napplyReward Response:=>  $_rewardRes\n\n");
    return _rewardRes;
  }
}

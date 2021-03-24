import 'package:flutter/material.dart';
import 'package:gwaliorkart/utils/network_utils.dart';

class WishListData {
  String success,productId, customerId;
  List<dynamic> products;

  WishListData(this.productId, this.customerId);

  WishListData.fromJson(Map<String, dynamic> json)
      : success = json['success'],products = json['products'];

  Map<String, dynamic> toJson() =>
      {'product_id': productId, 'customer_id': customerId};
}

class WishListProductsData {
  int savedPrice, rating;
  String productId,
      thumb,
      name,model,
      price,
      special,
      stock,
      customerId;
  bool isAdded = false;
  List<dynamic> options;

  WishListProductsData(this.productId, this.customerId);

  WishListProductsData.fromJson(Map<String, dynamic> json)
      : productId = json['product_id'],
        thumb = json['thumb'],
        name = json['name'],
        model = json['model'],
        price = json['price'],
        special = json['special'] == false ? '' : json['special'],
        savedPrice = json['saved_price'],
        stock = json['stock'],
        rating = json['rating'],
        options = json['options'],
        isAdded = json['isAdded'] = false;

  Map<String, dynamic> toJson() =>
      {'product_id': productId, 'customer_id': customerId};

  Image getImage() {
    Image imageUrl;
    if (thumb != null && thumb != '') {
      imageUrl = Image.network(
        thumb,
        fit: BoxFit.fill,
      );
    } else {
      imageUrl = Image.asset(
        "assets/placeholders/no-product-image.png",
        fit: BoxFit.fill,
      );
    }
    return imageUrl;
  }

  String specialPrice() {
    String _specialPrice;
    if (special != '' && special != null) {
      _specialPrice = special;
    } else {
      _specialPrice = '';
    }
    return _specialPrice;
  }

  int saved() {
    int _savedPrice;
    if (savedPrice != null) {
      _savedPrice = savedPrice;
    } else {
      _savedPrice = 0;
    }
    return _savedPrice;
  }
}

class WishListUtils {
  static Future<dynamic> addToWishList(WishListData _listData) async {
    dynamic res =
        await NetworkUtils.httpPost("addwishlist", _listData.toJson());
    print("\n\naddToWishList Response:=>  $res\n\n");
    return res;
  }

  static Future<dynamic> getWishList(final String _customerId) async {
    dynamic res =
        await NetworkUtils.httpGet("getwishlist/" + _customerId, null);
    print("\n\ngetWishList Response:=>  $res\n\n");
    return res;
  }

  static Future<dynamic> removeWishList(
      final int _productId, final String _customerId) async {
    dynamic res = await NetworkUtils.httpGet(
        "removewishlist/" + _productId.toString() + "/" + _customerId, null);
    print("\n\nremoveWishList Response:=>  $res\n\n");
    return res;
  }
}

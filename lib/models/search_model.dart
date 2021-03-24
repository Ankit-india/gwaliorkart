import 'package:flutter/material.dart';
import 'package:gwaliorkart/utils/network_utils.dart';

class SearchData {
  int savedPrice,parent, count, rating;
  String productId,
      thumb,
      name,
      description,
      price,
      special,
      stock,
      minimum,
      tax,
      href;
  List<dynamic> options;
  bool isAdded = false;

  SearchData.fromJson(Map<String, dynamic> json)
      : productId = json['product_id'],
        thumb = json['thumb'],
        name = json['name'],
        description = json['description'],
        price = json['price'],
        special = json['special'],
        savedPrice = json['saved_price'],
        stock = json['stock'],
        minimum = json['minimum'],
        tax = json['tax'].toString(),
        rating = json['rating'],
        href = json['href'],
        options = json['options'],
        isAdded = json['is_added'] = false;

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

class SearchPageUtils {
  static getSearchingPageList(final String _keyword) async {
    dynamic res = await NetworkUtils.httpGet("search/"+_keyword, null);
    print("\n\ngetSearchingPageList Response:  $res\n\n");
    return res;
  }
}

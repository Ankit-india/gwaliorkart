import 'package:flutter/material.dart';
import 'package:gwaliorkart/utils/network_utils.dart';

class ProductDetailData {
  bool reviewGuest;
  int productId, savedPrice, rating, productInWishList;
  List<dynamic> discounts,
      options,
      products,
      images,
      attributeGroups,
      relatedProducts,
      tags,
      recurrings;
  String headingTitle,
      textSelect,
      textManufacturer,
      textModel,
      textReward,
      textStock,
      textOption,
      textRelated,
      textPaymentRecurring,
      textLoading,
      entryQty,
      entryRating,
      buttonCart,
      buttonWishList,
      buttonContinue,
      tabDescription,
      manufacturer,
      model,
      points,
      description,
      stock,
      popup,
      thumb,
      price,
      special,
      tax,
      minimum,
      reviewStatus,
      customerName,
      reviews,
      captcha,
      reward,
      link,
      brandName;

  ProductDetailData.fromJson(Map<String, dynamic> json)
      : productId = json['product_id'],
        headingTitle = json['heading_title'],
        textSelect = json['text_select'],
        textManufacturer = json['text_manufacturer'],
        textModel = json['text_model'],
        textReward = json['text_reward'],
        textStock = json['text_stock'],
        textOption = json['text_option'],
        textRelated = json['text_related'],
        textPaymentRecurring = json['text_payment_recurring'],
        textLoading = json['text_loading'],
        entryQty = json['entry_qty'],
        entryRating = json['entry_rating'],
        buttonCart = json['button_cart'],
        buttonWishList = json['button_wishlist'],
        buttonContinue = json['button_continue'],
        tabDescription = json['tab_description'],
        manufacturer = json['manufacturer'],
        model = json['model'],
        reward = json['reward'],
        points = json['points'],
        description = json['description'],
        stock = json['stock'],
        popup = json['popup'],
        thumb = json['thumb'],
        images = json['images'],
        price = json['price'],
        special = json['special'],
        savedPrice = json['saved_price'],
        tax = json['tax'].toString(),
        discounts = json['discounts'],
        options = json['options'],
        minimum = json['minimum'],
        reviewStatus = json['review_status'],
        reviewGuest = json['review_guest'],
        customerName = json['customer_name'],
        reviews = json['reviews'],
        rating = json['rating'],
        captcha = json['captcha'],
        attributeGroups = json['attribute_groups'],
        products = json['products'],
        tags = json['tags'],
        recurrings = json['recurrings'],
        productInWishList = json['product_in_wishlist'];

  ImageProvider<dynamic> getImage() {
    ImageProvider<dynamic> imageUrl;
    if (thumb != null && thumb != '') {
      imageUrl = NetworkImage(thumb);
    } else {
      imageUrl = AssetImage("assets/placeholders/no-product-image.png");
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
    if (savedPrice != null && savedPrice > 0) {
      _savedPrice = savedPrice;
    } else {
      _savedPrice = 0;
    }
    return _savedPrice;
  }
}

class Options {
  String productOptionId, optionId, name, type, value, required;
  List<dynamic> productOptionValue;

  Options.fromJson(Map<String, dynamic> json)
      : productOptionId = json['product_option_id'],
        productOptionValue = json['product_option_value'],
        optionId = json['option_id'],
        name = json['name'],
        type = json['type'],
        value = json['value'],
        required = json['required'];
}

class ProductOptionValue {
  String productOptionValueId, optionValueId, name, image, price, pricePrefix;

  ProductOptionValue.fromJson(Map<String, dynamic> json)
      : productOptionValueId = json['product_option_value_id'],
        optionValueId = json['option_value_id'],
        name = json['name'],
        image = json['image'],
        price = json['price'].toString(),
        pricePrefix = json['price_prefix'];

  ImageProvider<dynamic> getImage() {
    ImageProvider<dynamic> imageUrl;
    if (image != null && image != '') {
      imageUrl = NetworkImage(image);
    } else {
      imageUrl = AssetImage("assets/placeholders/no-product-image.png");
    }
    return imageUrl;
  }
}

class AttributeGroups {
  String attributeGroupId, name;
  List<dynamic> attribute;

  AttributeGroups.fromJson(Map<String, dynamic> json)
      : attributeGroupId = json['attribute_group_id'],
        name = json['name'],
        attribute = json['attribute'];
}

class Attribute {
  String attributeId, name, text;

  Attribute.fromJson(Map<String, dynamic> json)
      : attributeId = json['attribute_id'],
        name = json['name'],
        text = json['text'];
}

class ChangePriceData {
  int productId;
  String success;
  List<dynamic> option = [];
  Map<String, dynamic> newPrice = {};

  ChangePriceData(this.productId, this.option);

  ChangePriceData.fromJson(Map<String, dynamic> json)
      : newPrice = json['new_price'],
        success = json['success'];

  Map<String, dynamic> toJson() =>
      {'product_id': productId.toString(), 'option': option.toList()};
}

class NewPriceData {
  String price, special, tax;

  NewPriceData.fromJson(Map<String, dynamic> json)
      : price = json['price'],
        special = json['special'],
        tax = json['tax'];
}

class ChangePriceUtils {
  static Future<dynamic> changePrice(ChangePriceData _changeData) async {
    dynamic _priceRes =
        await NetworkUtils.httpPost("change_price", _changeData.toJson());
    print("\n\nchangePrice Response:=>  $_priceRes\n\n");
    return _priceRes;
  }
}

class ProductDetailUtils {
  static getProductDetails(
      final String _productId, final String _customerId) async {
    dynamic res = await NetworkUtils.httpGet(
        "productdetails/" + _productId + "/" + _customerId, null);
    if (res != null &&
        res.containsKey('options') &&
        res['options'] != null &&
        res['options'].length > 0) {
      res['options'].forEach((_optionItem) {
        if (_optionItem != null && _optionItem.length > 0) {
          Options _options = Options.fromJson(_optionItem);
          if (_options.type == 'select') {
            List<dynamic> _sizeList = _options.productOptionValue;
            _sizeList.insert(0, {
              'product_option_value_id': '0',
              'option_value_id': '0',
              'name': ' --- Please Select --- ', 'price': '', 'price_prefix': ''
            });
          }
        }
      });
    }
    print("\n\ngetProductDetails Response:  $res\n\n");
    print("\n\n Response:  ${res['options']}\n\n");
    return res;
  }
}

/*if (res != null) {
      if(res['options'] != null && res['options'].length > 0){
        List<dynamic> _sizeList = res['options'][0]['product_option_value'];
        _sizeList.insert(0, {'productOptionValueId': '0', 'option_value_id': '0', 'name': ' --- Please Select --- '});
      }
    }*/

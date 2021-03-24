//import 'package:flutter/material.dart';
//import 'package:gwaliorkart/utils/network_utils.dart';
//
//class CategoryListData {
//  int parent, count;
//  String id,
//      name,
//      description,
//      image,
//      savedPrice,
//      quantity,
//      realPrice,
//      discountPrice,
//      numOfItem,
//      rating,
//      link;
//
//  CategoryListData.fromJson(Map<String, dynamic> json)
//      : id = json['id'].toString(),
//        name = json['name'],
//        image = json['thumb'],
//        description = json['description'],
//        parent = json['parent'],
//        count = json['count'],
//        savedPrice = json['saved_price'],
//        quantity = json['quantity'],
//        realPrice = json['price'],
//        discountPrice = json['price'],
//        numOfItem = json['num_of_item'],
//        rating = json['rating'].toString(),
//        link = json['link'];
//
//  Image getImage() {
//    Image imageUrl;
//    if (image != null) {
//      imageUrl = Image.network(
//        image,
//        fit: BoxFit.fill,
//      );
//    } else {
//      imageUrl = Image.asset(
//        "assets/reserve.jpg",
//        fit: BoxFit.fill,
//      );
//    }
//    return imageUrl;
//  }
//
//  int saved() {
//    int _savedPrice;
//    if (realPrice != null && discountPrice != null) {
//      double _price;
//      print("realPrice:=> $realPrice");
//      print("discountPrice:=> $discountPrice");
//      print("doubleRealPrice:=> ${double.parse(realPrice)}");
//      print("doubleDiscountPrice:=> ${double.parse(discountPrice)}");
//      _price = double.parse(realPrice) - double.parse(discountPrice);
//      _savedPrice = _price.toInt();
//    } else {
//      _savedPrice = 0;
//    }
//    return _savedPrice;
//  }
//}
//
//class SubCategoryData {
//  String id, name, image;
//  List<dynamic> subcategory;
//
//  SubCategoryData.fromJson(Map<String, dynamic> json)
//      : id = json['id'].toString(),
//        name = json['name'],
//        image = json['image'],
//        subcategory = json['children'];
//
//  ImageProvider<dynamic> getImage() {
//    ImageProvider<dynamic> imageUrl;
//    if (image != null && image != '') {
//      imageUrl = NetworkImage(image);
//    } else {
//      imageUrl = AssetImage("assets/icons/category.png");
//    }
//    return imageUrl;
//  }
//
////  Image getImage() {
////    Image imageUrl;
////    if (image != null && image != '') {
////      imageUrl = Image.network(
////        image,
////        fit: BoxFit.fill,
////      );
////    } else {
////      imageUrl = Image.asset(
////        "assets/reserve.jpg",
////        fit: BoxFit.fill,
////      );
////    }
////    return imageUrl;
////  }
//
//  Map<String, dynamic> toJson() => {'name': name, 'image': image};
//}
//
//class SubCategoryProductListData {
//  int savedPrice,parent, count, rating;
//  String productId,
//      thumb,
//      name,
//      description,
//      price,
//      special,
//      stock,
//      minimum,
//      tax,
//      href;
//  List<dynamic> options;
//
//  SubCategoryProductListData.fromJson(Map<String, dynamic> json)
//      : productId = json['product_id'],
//        thumb = json['thumb'],
//        name = json['name'],
//        description = json['description'],
//        price = json['price'],
//        special = json['special'] == false ? '' : json['special'],
//        savedPrice = json['saved_price'],
//        stock = json['stock'],
//        minimum = json['minimum'],
//        tax = json['tax'].toString(),
//        rating = json['rating'],
//        href = json['href'],
//        options = json['options'];
//
//  Image getImage() {
//    Image imageUrl;
//    if (thumb != null && thumb != '') {
//      imageUrl = Image.network(
//        thumb,
//        fit: BoxFit.fill,
//      );
//    } else {
//      imageUrl = Image.asset(
//        "assets/placeholders/no-product-image.png",
//        fit: BoxFit.fill,
//      );
//    }
//    return imageUrl;
//  }
//
//  String specialPrice() {
//    String _specialPrice;
//    if (special != '' && special != null) {
//      _specialPrice = special;
//    } else {
//      _specialPrice = '';
//    }
//    return _specialPrice;
//  }
//
//  int saved() {
//    int _savedPrice;
//    if (savedPrice != null) {
//      _savedPrice = savedPrice;
//    } else {
//      _savedPrice = 0;
//    }
//    return _savedPrice;
//  }
//}
//
//class CategoryUtils {
//  static getCategoryList(final String categoryId) async {
//    dynamic res =
//        await NetworkUtils.httpGet("categorylist/" + categoryId, null);
//    print("\n\ngetCategoryList Response:  $res\n\n");
//    return res;
//  }
//}

import 'package:flutter/material.dart';
import 'package:gwaliorkart/utils/network_utils.dart';

//class CategoryListData {
//  int parent, count;
//  String id,
//      name,
//      description,
//      image,
//      savedPrice,
//      quantity,
//      realPrice,
//      discountPrice,
//      numOfItem,
//      rating,
//      link;
//
//  CategoryListData.fromJson(Map<String, dynamic> json)
//      : id = json['id'].toString(),
//        name = json['name'],
//        image = json['thumb'],
//        description = json['description'],
//        parent = json['parent'],
//        count = json['count'],
//        savedPrice = json['saved_price'],
//        quantity = json['quantity'],
//        realPrice = json['price'],
//        discountPrice = json['price'],
//        numOfItem = json['num_of_item'],
//        rating = json['rating'].toString(),
//        link = json['link'];
//
//  Image getImage() {
//    Image imageUrl;
//    if (image != null) {
//      imageUrl = Image.network(
//        image,
//        fit: BoxFit.fill,
//      );
//    } else {
//      imageUrl = Image.asset(
//        "assets/reserve.jpg",
//        fit: BoxFit.fill,
//      );
//    }
//    return imageUrl;
//  }
//
//  int saved() {
//    int _savedPrice;
//    if (realPrice != null && discountPrice != null) {
//      double _price;
//      print("realPrice:=> $realPrice");
//      print("discountPrice:=> $discountPrice");
//      print("doubleRealPrice:=> ${double.parse(realPrice)}");
//      print("doubleDiscountPrice:=> ${double.parse(discountPrice)}");
//      _price = double.parse(realPrice) - double.parse(discountPrice);
//      _savedPrice = _price.toInt();
//    } else {
//      _savedPrice = 0;
//    }
//    return _savedPrice;
//  }
//}

class SubCategoryData {
  String headingTitle, thumb, description;
  List<dynamic> categories, products;

  SubCategoryData.fromJson(Map<String, dynamic> json)
      : headingTitle = json['heading_title'],
        thumb = json['thumb'],
        description = json['description'],
        categories = json['categories'],
        products = json['products'];
}

class CategoriesData {
  int id, parent, count;
  String name, description, image;

  CategoriesData.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        description = json['description'],
        parent = json['parent'],
        count = json['count'],
        image = json['image'];

  ImageProvider<dynamic> getImage() {
    ImageProvider<dynamic> imageUrl;
    if (image != null && image != '') {
      imageUrl = NetworkImage(image);
    } else {
      imageUrl = AssetImage("assets/icons/category.png");
    }
    return imageUrl;
  }
}

class ProductsData {
  int savedPrice, parent, count, rating;
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

  ProductsData.fromJson(Map<String, dynamic> json)
      : productId = json['product_id'],
        thumb = json['thumb'],
        name = json['name'],
        description = json['description'],
        price = json['price'],
        special = json['special'] == false ? '' : json['special'],
        savedPrice = json['saved_price'],
        tax = json['tax'].toString(),
        stock = json['stock'],
        minimum = json['minimum'],
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

class SubCategoryProductListData {
  int savedPrice, parent, count, rating;
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

  SubCategoryProductListData.fromJson(Map<String, dynamic> json)
      : productId = json['product_id'],
        thumb = json['thumb'],
        name = json['name'],
        description = json['description'],
        price = json['price'],
        special = json['special'] == false ? '' : json['special'],
        savedPrice = json['saved_price'],
        stock = json['stock'],
        minimum = json['minimum'],
        tax = json['tax'].toString(),
        rating = json['rating'],
        href = json['href'],
        options = json['options'];

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

class CategoryUtils {
  static getCategoryList(final String categoryId) async {
    dynamic res =
        await NetworkUtils.httpGet("categorylist/" + categoryId, null);
    print("\n\ngetCategoryList Response:  $res\n\n");
    return res;
  }
}

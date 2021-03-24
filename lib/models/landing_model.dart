import 'package:flutter/material.dart';
import 'package:gwaliorkart/utils/network_utils.dart';

class BannerData {
  String title, image;

  BannerData.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        image = json['image'];

  ImageProvider getImage() {
    ImageProvider imageUrl;
    if (image != null && image != '') {
      imageUrl = NetworkImage(
        image,
      );
    } else {
      imageUrl = AssetImage(
        "assets/icons/Fruits_Collection.png",
      );
    }
    return imageUrl;
  }
}

class CategoryData {
  String name, categoryId, image;
  List<dynamic> children;

  CategoryData.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        categoryId = json['category_id'],
        image = json['image'],
        children = json['children'];

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

class BestProductData {
  int savedPrice, rating;
  String productId,
      thumb,
      name,
      description,
      price,
      minimum,
      stock,
      special,
      tax;
  List<dynamic> options;
  bool isAdded = false;

  BestProductData.fromJson(Map<String, dynamic> json)
      : productId = json['product_id'],
        thumb = json['thumb'],
        name = json['name'],
        description = json['description'],
        price = json['price'],
        savedPrice = json['saved_price'],
        minimum = json['minimum'],
        stock = json['stock'],
        special = json['special'],
        tax = json['tax'].toString(),
        rating = json['rating'],
        options = json['options'],
        isAdded = json['is_added'] = false;

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
    if (savedPrice != null) {
      _savedPrice = savedPrice;
    } else {
      _savedPrice = 0;
    }
    return _savedPrice;
  }
}

class LatestProductData {
  int savedPrice, rating;
  String productId,
      thumb,
      name,
      description,
      price,
      minimum,
      stock,
      special,
      tax,
      href;
  List<dynamic> options;
  bool isAdded = false;

  LatestProductData.fromJson(Map<String, dynamic> json)
      : productId = json['product_id'],
        thumb = json['thumb'],
        name = json['name'],
        description = json['description'],
        price = json['price'],
        savedPrice = json['saved_price'],
        minimum = json['minimum'],
        stock = json['stock'],
        special = json['special'],
        tax = json['tax'].toString(),
        rating = json['rating'],
        href = json['href'],
        options = json['options'],
        isAdded = json['is_added'] = false;

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
    if (savedPrice != null) {
      _savedPrice = savedPrice;
    } else {
      _savedPrice = 0;
    }
    return _savedPrice;
  }
}

class CategoriesListingData {
  String categoryId, name, image;
  List<dynamic> subcategory;

  CategoriesListingData.fromJson(Map<String, dynamic> json)
      : categoryId = json['category_id'],
        name = json['name'],
        image = json['image'],
        subcategory = json['children'];

  Image getImage(final int id) {
    Image imageUrl;
    if (id == 20) {
      imageUrl = Image.asset(
        "assets/categories/fruits_vegetables.png",
        fit: BoxFit.cover,
      );
    } else if (id == 18) {
      imageUrl = Image.asset(
        "assets/categories/eggs meat.png",
        fit: BoxFit.cover,
      );
    } else if (id == 25) {
      imageUrl = Image.asset(
        "assets/categories/foodgrains.png",
        fit: BoxFit.cover,
      );
    } else if (id == 57) {
      imageUrl = Image.asset(
        "assets/categories/pet-care.png",
        fit: BoxFit.cover,
      );
    } else if (id == 24) {
      imageUrl = Image.asset(
        "assets/categories/snacks-and-foods.png",
        fit: BoxFit.cover,
      );
    } else if (id == 34) {
      imageUrl = Image.asset(
        "assets/categories/kitchen-and-garden.png",
        fit: BoxFit.cover,
      );
    } else if (id == 17) {
      imageUrl = Image.asset(
        "assets/categories/beauty-and- hygine.png",
        fit: BoxFit.cover,
      );
    }
    return imageUrl;
  }
}

class CategoriesChildrenListingData {
  String categoryId, name, image;

  CategoriesChildrenListingData.fromJson(Map<String, dynamic> json)
      : categoryId = json['category_id'],
        name = json['name'],
        image = json['image'];
}

class LandingPageUtils {
  static getLandingPageList() async {
    dynamic res = await NetworkUtils.httpGet("gethomecontent", null);
    print("\n\ngetLandingPageList Response:  $res\n\n");
    return res;
  }
}

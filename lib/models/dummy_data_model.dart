import 'package:flutter/material.dart';

class DummyUserData {
  String id, name, age, height, gender, hairColor, image;

  DummyUserData(this.id, this.name, this.age, this.height, this.gender,
      this.hairColor, this.image);

  DummyUserData.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        age = json['age'],
        height = json["height"],
        gender = json['gender'],
        hairColor = json['hair_color'],
        image = json['image'];

  Image getImage() {
    Image imageUrl;
    if (image == null) {
      imageUrl = Image.network(
        image,
        width: 100.0,
        height: 100,
        fit: BoxFit.fill,
      );
    } else {
      imageUrl = Image.asset(
        "assets/icons/avatar7.png",
        width: 100.0,
        height: 100,
        fit: BoxFit.fill,
      );
    }
    return imageUrl;
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'age': age,
        'height': height,
        'gender': gender,
        'hair_color': hairColor,
        'image': image
      };
}

class BasketData {
  String id, categoryName;
  List<dynamic> product;

  BasketData(this.id, this.categoryName, this.product);

  BasketData.fromJson(Map<String, dynamic> json)
      : id = json['id'].toString(),
        categoryName = json['category_name'],
        product = json['product'];

  Map<String, dynamic> toJson() =>
      {'category_name': categoryName, 'product': product};
}

class BasketProductData {
  String id, name, image, discount, quantity, realPrice, discountPrice, numOfItem, link;

  BasketProductData(this.id, this.name, this.image, this.discount,
      this.quantity, this.realPrice, this.discountPrice, this.numOfItem, this.link);

  BasketProductData.fromJson(Map<String, dynamic> json)
      : id = json['id'].toString(),
        name = json['name'],
        image = json['image'],
        discount = json['discount'],
        quantity = json['quantity'],
        realPrice = json['real_price'],
        discountPrice = json['discount_price'],
        numOfItem = json['num_of_item'],
        link = json['link'];

  Image getImage() {
    Image imageUrl;
    if (image != null) {
      imageUrl = Image.network(
        image,
        fit: BoxFit.fill,
      );
    } else {
      imageUrl = Image.asset(
        "assets/reserve.jpg",
        fit: BoxFit.fill,
      );
    }
    return imageUrl;
  }

  Map<String, dynamic> toJson() => {'name': name, 'image': image};
}

class DummySearchData {
  String id, keyword;

  DummySearchData(this.id, this.keyword);

  DummySearchData.fromJson(Map<String, dynamic> json)
      : id = json['id'].toString(),
        keyword = json['keyword'];

  Map<String, dynamic> toJson() => {'keyword': keyword};
}

class DummyCarouselData {
  String id, name, image;

  DummyCarouselData(this.id, this.name, this.image);

  DummyCarouselData.fromJson(Map<String, dynamic> json)
      : id = json['id'].toString(),
        name = json['name'],
        image = json['image'];

  ImageProvider getImage() {
    ImageProvider imageUrl;
    if (image == null) {
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

  Map<String, dynamic> toJson() => {'name': name, 'image': image};
}

class DummyCategoryData {
  String id, categoryName, image;
  List<dynamic> subcategory;

  DummyCategoryData(this.id, this.categoryName, this.image);

  DummyCategoryData.fromJson(Map<String, dynamic> json)
      : id = json['id'].toString(),
        categoryName = json['category_name'],
        image = json['image'],
        subcategory = json['subcategory'];

  Image getImage() {
    Image imageUrl;
    if (image != null) {
      imageUrl = Image.network(
        image,
        fit: BoxFit.cover,
      );
    } else {
      imageUrl = Image.asset(
        "assets/reserve.jpg",
        fit: BoxFit.cover,
      );
    }
    return imageUrl;
  }

  Map<String, dynamic> toJson() =>
      {'category_name': categoryName, 'image': image};
}

class DummyMilkAndJuiceData {
  String id,
      name,
      image,
      discount,
      rating,
      totalRating,
      quantity,
      realPrice,
      discountPrice;

  DummyMilkAndJuiceData(
      this.id,
      this.name,
      this.image,
      this.discount,
      this.rating,
      this.totalRating,
      this.quantity,
      this.realPrice,
      this.discountPrice);

  DummyMilkAndJuiceData.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        image = json['image'],
        discount = json['discount'],
        rating = json['rating'],
        totalRating = json['total_rating'],
        quantity = json['quantity'],
        realPrice = json['real_price'],
        discountPrice = json['discount_price'];

  Image getImage() {
    Image imageUrl;
    if (image != null) {
      imageUrl = Image.network(
        image,
        width: 178.0,
      );
    } else {
      imageUrl = Image.asset(
        "assets/reserve.jpg",
        width: 178.0,
      );
    }
    return imageUrl;
  }

  Map<String, dynamic> toJson() => {'name': name, 'image': image};
}

class DummySubscriptionData {
  String id, image;

  DummySubscriptionData(this.id, this.image);

  DummySubscriptionData.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        image = json['image'];

  Image getImage() {
    Image imageUrl;
    if (image != null) {
      imageUrl = Image.network(
        image,
      );
    } else {
      imageUrl = Image.asset(
        "assets/subsci.jpg",
      );
    }
    return imageUrl;
  }

  Map<String, dynamic> toJson() => {'image': image};
}

class DummyFruitsAndVegetableData {
  String id,
      name,
      image,
      discount,
      rating,
      totalRating,
      quantity,
      realPrice,
      discountPrice;

  DummyFruitsAndVegetableData(
      this.id,
      this.name,
      this.image,
      this.discount,
      this.rating,
      this.totalRating,
      this.quantity,
      this.realPrice,
      this.discountPrice);

  DummyFruitsAndVegetableData.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        image = json['image'],
        discount = json['discount'],
        rating = json['rating'],
        totalRating = json['total_rating'],
        quantity = json['quantity'],
        realPrice = json['real_price'],
        discountPrice = json['discount_price'];

  ImageProvider<dynamic> getImage() {
    ImageProvider<dynamic> imageUrl;
    if (image != null) {
      imageUrl = NetworkImage(
          image
      );
    } else {
      imageUrl = AssetImage(
          "assets/reserve.jpg"
      );
    }
    return imageUrl;
  }

  Map<String, dynamic> toJson() => {'name': name, 'image': image};
}

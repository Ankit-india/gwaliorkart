// import 'package:gwaliorkart/utils/network_utils.dart';
//
// class OrderData {
//   String totalOrders;
//   List<dynamic> orders;
//
//   OrderData.fromJson(Map<String, dynamic> json)
//       : orders = json['orders'],
//         totalOrders = json['total_orders'];
// }
//
// class Orders {
//   String orderId,name,status,dateAdded,total;
//   int products;
//
//   Orders.fromJson(Map<String, dynamic> json)
//       : orderId = json['order_id'],
//         name = json['name'],
//         status = json['status'],
//         dateAdded = json['date_added'],
//         products = json['products'],
//         total = json['total'];
// }
//
// class OrderUtils {
//   static Future<dynamic> getOrder(final String _customerId, final int _pageNum) async {
//     final dynamic _orderRes = await NetworkUtils.httpGet(
//         "getorder/$_customerId/$_pageNum", null);
//     print("\n\ngetOrder Response:=>  $_orderRes\n\n");
//     return _orderRes;
//   }
// }

import 'package:gwaliorkart/utils/network_utils.dart';

class OrderData {
  String totalOrders,
      orderId,
      dateAdded,
      paymentAddress,
      paymentMethod,
      shippingAddress,
      shippingMethod,
      comment;
  List<dynamic> orders, products, vouchers, totals, histories;

  OrderData.fromJson(Map<String, dynamic> json)
      : orders = json['orders'],
        totalOrders = json['total_orders'],
        orderId = json['order_id'],
        dateAdded = json['date_added'],
        paymentAddress = json['payment_address'],
        paymentMethod = json['payment_method'],
        shippingAddress = json['shipping_address'],
        shippingMethod = json['shipping_method'],
        products = json['products'],
        vouchers = json['vouchers'],
        totals = json['totals'],
        comment = json['comment'],
        histories = json['histories'];
}

class Products {
  String name, model, quantity, price, total;

  Products.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        model = json['model'],
        quantity = json['quantity'],
        price = json['price'],
        total = json['total'];
}

class Vouchers {}

class Totals {
  String title, text;

  Totals.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        text = json['text'];
}

class Histories {
  String dateAdded, status, comment;

  Histories.fromJson(Map<String, dynamic> json)
      : dateAdded = json['date_added'],
        status = json['status'],
        comment = json['comment'];
}

class Orders {
  String orderId, name, status, dateAdded, total;
  int products;

  static List<Orders> fromJsonList(jsonList) {
    return jsonList.map<Orders>((obj) => Orders.fromJson(obj)).toList();
  }

  Orders.fromJson(Map<String, dynamic> json)
      : orderId = json['order_id'],
        name = json['name'],
        status = json['status'],
        dateAdded = json['date_added'],
        products = json['products'],
        total = json['total'];
}

class OrderUtils {
  static Future<List<Orders>> getOrder(
      final String _customerId, final int _pageNum) async {
    final dynamic _orderRes =
        await NetworkUtils.httpGet("getorder/$_customerId/$_pageNum", null);
    print("\n\ngetOrder Response:=>  $_orderRes\n\n");
    return Orders.fromJsonList(_orderRes['orders']);
  }

  static Future<dynamic> getOrderInfo(
      final String _customerId, final String _orderId) async {
    final dynamic _orderRes =
        await NetworkUtils.httpGet("getorderinfo/$_customerId/$_orderId", null);
    print("\n\ngetOrderInfo Response:=>  $_orderRes\n\n");
    return _orderRes;
  }
}

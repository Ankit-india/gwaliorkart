import 'package:gwaliorkart/utils/network_utils.dart';

class PaymentData {
  String customerId, paymentMethod, comment;

  PaymentData(this.customerId, this.paymentMethod, this.comment);

  PaymentData.fromJson(Map<String, dynamic> json)
      : customerId = json['customer_id'],
        paymentMethod = json['payment_method'],
        comment = json['comment'];

  Map<String, dynamic> toJson() => {
        'customer_id': customerId,
        'payment_method': paymentMethod,
        'comment': comment
      };
}

class PaymentUtils {
  static Future<dynamic> getPaymentMethod(
      final _billingAddressId, final String _customerId) async {
    final dynamic _getRes = await NetworkUtils.httpGet(
        "getPaymentMethod/" + _billingAddressId + "/" + _customerId, null);
    print("\n\ngetPaymentMethod Response:=>  $_getRes\n\n");
    return _getRes;
  }

  static Future<dynamic> applyPaymentMethod(PaymentData _paymentData) async {
    final dynamic _postRes = await NetworkUtils.httpPost(
        "applyPaymentMethod", _paymentData.toJson());
    print("\n\napplyPaymentMethod Response:=>  $_postRes\n\n");
    return _postRes;
  }
}

class SaveOrderData {
  String customerId,
      billingAddressId,
      shippingAddressId,
      shippingMethod,
      paymentMethod,
      vouchers,
      coupon,
      reward,
      prodOpt,
      eWallet,
      comment;

  SaveOrderData(
      this.customerId,
      this.billingAddressId,
      this.shippingAddressId,
      this.shippingMethod,
      this.paymentMethod,
      this.vouchers,
      this.coupon,
      this.reward,
      this.prodOpt,
      this.eWallet,
      this.comment);

  SaveOrderData.fromJson(Map<String, dynamic> json)
      : customerId = json['customer_id'],
        paymentMethod = json['payment_method'],
        comment = json['comment'];

  Map<String, dynamic> toJson() => {
        'customer_id': customerId,
        'billing_address_id': billingAddressId,
        'shipping_address_id': shippingAddressId,
        'shipping_method': shippingMethod,
        'payment_method': paymentMethod,
        'vouchers': vouchers,
        'coupon': coupon,
        'reward': reward,
        'prod_opt': prodOpt,
        'ewallet': eWallet,
        'comment': comment
      };
}

class SavedOrderData {
  int orderId;
  String textRecurringItem,
      textPaymentRecurring,
      columnName,
      columnModel,
      columnQuantity,
      columnPrice,
      columnTotal,
      payment,
      paymentCode;
  List<dynamic> products, vouchers, totals;

  SavedOrderData.fromJson(Map<String, dynamic> json)
      : orderId = json['order_id'],
        textRecurringItem = json['text_recurring_item'],
        textPaymentRecurring = json['text_payment_recurring'],
        columnName = json['column_name'],
        columnModel = json['column_model'],
        columnQuantity = json['column_quantity'],
        columnPrice = json['column_price'],
        columnTotal = json['column_total'],
        products = json['products'],
        vouchers = json['vouchers'],
        totals = json['totals'],
        payment = json['payment'],
        paymentCode = json['payment_code'];
}

class SavedOrderProducts {
  String cartId,
      productId,
      name,
      model,
      recurring,
      quantity,
      subtract,
      price,
      total,
      href,thumb;
  List<dynamic> option;

  SavedOrderProducts.fromJson(Map<String, dynamic> json)
      : cartId = json['cart_id'],
        productId = json['product_id'],
        name = json['name'],
        model = json['model'],
        option = json['option'],
        recurring = json['recurring'],
        quantity = json['quantity'],
        subtract = json['subtract'],
        price = json['price'],
        total = json['total'],
        href = json['href'],
        thumb = json['thumb'];
}

class SaveOrderUtils {
  static Future<dynamic> saveOrder(SaveOrderData _orderParam) async {
    final dynamic _saveRes =
        await NetworkUtils.httpPost("saveorder", _orderParam.toJson());
    print("\n\nsaveOrder Response:=>  $_saveRes\n\n");
    return _saveRes;
  }
}

import 'package:gwaliorkart/utils/network_utils.dart';

class ShippingAddressData {
  String customerId,
      addressId,
      paymentAddress,
      firstName,
      lastName,
      company,
      email,
      address_1,
      address_2,
      countryId,
      zoneId,
      city,
      postcode,
      country,
      state,
      code,
      comment;

  ShippingAddressData(
      this.customerId,
      this.firstName,
      this.lastName,
      this.company,
      this.email,
      this.address_1,
      this.address_2,
      this.city,
      this.postcode,
      this.countryId,
      this.zoneId,
      this.addressId,
      this.code,
      this.comment);

  ShippingAddressData.fromJson(Map<String, dynamic> json)
      : customerId = json['customer_id'],
        addressId = json['address_id'],
        paymentAddress = json['payment_address'],
        firstName = json['firstname'],
        lastName = json['lastname'],
        company = json['company'],
        email = json['email'],
        address_1 = json['address_1'],
        address_2 = json['address_2'],
        city = json['city'],
        postcode = json['postcode'],
        countryId = json['country_id'],
        zoneId = json['zone_id'];

  Map<String, dynamic> toJson() => {
        'customer_id': customerId,
        'firstname': firstName,
        'lastname': lastName,
        'company': company,
        'email': email,
        'address_1': address_1,
        'address_2': address_2,
        'city': city,
        'postcode': postcode,
        'country_id': countryId,
        'zone_id': zoneId
      };

  Map<String, dynamic> toApplyShippingAddressJson() =>
      {'customer_id': customerId, 'address_id': addressId};

  Map<String, dynamic> toApplyShippingMethodJson() => {
        'customer_id': customerId,
        'code': code,
        'address_id': addressId,
        'comment': comment
      };
}

class ShippingAddressUtils {

  static Future<dynamic> getShippingAddress(final String _customerId) async {
    dynamic res =
        await NetworkUtils.httpGet("getShippingAddress/" + _customerId, null);
    print("\n\ngetShippingAddress Response:=>  $res\n\n");
    return res;
  }

  static Future<dynamic> saveNewShippingAddress(
      ShippingAddressData _shipData) async {
    dynamic res = await NetworkUtils.httpPost(
        "savenewShippingAddress", _shipData.toJson());
    print("\n\nsaveNewShippingAddress Response:=>  $res\n\n");
    return res;
  }

  static Future<dynamic> applyShippingAddress(
      ShippingAddressData _shipData) async {
    dynamic res = await NetworkUtils.httpPost(
        "applyShippingAddress", _shipData.toApplyShippingAddressJson());
    print("\n\napplyShippingAddress Response:=>  $res\n\n");
    return res;
  }

  static Future<dynamic> getShippingMethod(
      final String _shippingAddressId, final String _customerId) async {
    dynamic res = await NetworkUtils.httpGet(
        "getShippingMethod/" + _shippingAddressId + "/" + _customerId, null);
    print("\n\ngetShippingMethod Response:=>  $res\n\n");
    return res;
  }

  static Future<dynamic> applyShippingMethod(
      ShippingAddressData _shipData) async {
    dynamic res = await NetworkUtils.httpPost(
        "applyShippingMethod", _shipData.toApplyShippingMethodJson());
    print("\n\napplyShippingMethod Response:=>  $res\n\n");
    return res;
  }

  static Future<dynamic> updateShippingAddress(
      ShippingAddressData _shipData) async {
    dynamic res = await NetworkUtils.httpPost(
        "updateShippingAddress", _shipData.toJson());
    print("\n\nupdateShippingAddress Response:=>  $res\n\n");
    return res;
  }
}

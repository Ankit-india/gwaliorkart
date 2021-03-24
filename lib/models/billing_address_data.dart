import 'package:gwaliorkart/utils/network_utils.dart';

class BillingAddressData {
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
      state;

  BillingAddressData(
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
      this.addressId);

  BillingAddressData.fromJson(Map<String, dynamic> json)
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

  Map<String, dynamic> toBillApplyJson() =>
      {'customer_id': customerId, 'address_id': addressId};
}

class BillingAddressUtils {
  static Future<dynamic> getBillingAddress(final String _customerId) async {
    dynamic res =
        await NetworkUtils.httpGet("getBillingAddress/" + _customerId, null);
    print("\n\ngetBillingAddress Response:=>  $res\n\n");
    return res;
  }

  static Future<dynamic> saveNewBillingAddress(
      BillingAddressData _billData) async {
    dynamic res = await NetworkUtils.httpPost(
        "savenewBillingAddress", _billData.toJson());
    print("\n\nsaveNewBillingAddress Response:=>  $res\n\n");
    return res;
  }

  static Future<dynamic> applyBillingAddress(
      BillingAddressData _billData) async {
    dynamic res = await NetworkUtils.httpPost(
        "applyBillingAddress", _billData.toBillApplyJson());
    print("\n\napplyBillingAddress Response:=>  $res\n\n");
    return res;
  }
}

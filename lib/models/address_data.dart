import 'package:gwaliorkart/utils/network_utils.dart';

class AddressData {
  String customerId,
      addressId,
      firstName,
      lastName,
      company,
      telephone,
      email,
      address1,
      address2,
      countryId,
      zone,
      zoneCode,
      zoneId,
      city,
      postcode,
      country,
      state,
      code,
      comment,
      defaults,
      textAddress,
      errorFirstName,
      errorLastName,
      errorAddress1,
      errorCity,
      errorPostcode,
      errorCountry,
      errorZone,
      emailData;

  List<dynamic> errorCustomField, countries, customFields, addressCustomField;

  AddressData(
      this.customerId,
      this.firstName,
      this.lastName,
      this.company,
      this.telephone,
      this.emailData,
      this.address1,
      this.address2,
      this.city,
      this.postcode,
      this.zoneId,
      this.countryId,
      this.defaults);

  AddressData.fromJson(Map<String, dynamic> json)
      : customerId = json['customer_id'],
        addressId = json['address_id'],
        firstName = json['firstname'],
        lastName = json['lastname'],
        company = json['company'],
        telephone = json['telephone'],
        email = json['email'],
        address1 = json['address_1'],
        address2 = json['address_2'],
        zone = json['zone'],
        zoneCode = json['zone_code'],
        zoneId = json['zone_id'],
        city = json['city'],
        postcode = json['postcode'],
        defaults = json['default'].toString(),
        country = json['country'],
        countryId = json['country_id'],
        emailData = json['emailData'],
        textAddress = json['text_address'],
        errorFirstName = json['error_firstname'],
        errorLastName = json['error_lastname'],
        errorAddress1 = json['error_address_1'],
        errorCity = json['error_city'],
        errorPostcode = json['error_postcode'],
        errorCountry = json['error_country'],
        errorZone = json['error_zone'],
        errorCustomField = json['error_custom_field'],
        countries = json['countries'],
        customFields = json['custom_fields'],
        addressCustomField = json['address_custom_field'];

  Map<String, dynamic> toJson() => {
        'customer_id': customerId,
        'firstname': firstName,
        'lastname': lastName,
        'company': company,
        'telephone': telephone,
        'email': email,
        'address_1': address1,
        'address_2': address2,
        'zone_id': zoneId,
        'city': city,
        'postcode': postcode,
        'default': defaults
      };
}

class AddressUtils {
  static Future<dynamic> getCustomerAddressList(
      final String _customerId) async {
    final dynamic _addressRes = await NetworkUtils.httpGet(
        "getCustomerAddressList/" + _customerId, null);
    print("\n\ngetCustomerAddressList Response:=>  $_addressRes\n\n");
    return _addressRes;
  }

  static Future<dynamic> getCustomerAddAddressForm(
      final String _customerId, final String _addressId) async {
    final dynamic _addressRes = await NetworkUtils.httpGet(
        "getCustomerAddAddressForm/$_customerId/$_addressId", null);
    print("\n\ngetCustomerAddAddressForm Response:=>  $_addressRes\n\n");
    return _addressRes;
  }

  /*static Future<dynamic> getOrder(final String _customerId, final int _pageNum) async {
    final dynamic _orderRes = await NetworkUtils.httpGet(
        "getorder/$_customerId/$_pageNum", null);
    print("\n\ngetOrder Response:=>  $_orderRes\n\n");
    return _orderRes;
  }

  static Future<dynamic> getOrderInfo(final String _customerId, final String _orderId) async {
    final dynamic _orderRes = await NetworkUtils.httpGet(
        "getorderinfo/$_customerId/$_orderId", null);
    print("\n\ngetOrderInfo Response:=>  $_orderRes\n\n");
    return _orderRes;
  }*/

  static Future<dynamic> saveCustomerAddressForm(
      AddressData _addressParam) async {
    final dynamic _saveRes = await NetworkUtils.httpPost(
        "saveCustomerAddressForm", _addressParam.toJson());
    print("\n\nsaveCustomerAddressForm Response:=>  $_saveRes\n\n");
    return _saveRes;
  }
}

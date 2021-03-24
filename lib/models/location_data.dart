import 'package:gwaliorkart/utils/network_utils.dart';

class CountryData {
  List<dynamic> countries, customFields, paymentAddressCustomField;
  String addressId, paymentAddress, countryId, zoneId;
  dynamic addresses;

  CountryData(
      this.addressId,
      this.paymentAddress,
      this.addresses,
      this.countryId,
      this.zoneId,
      this.countries,
      this.customFields,
      this.paymentAddressCustomField);

  CountryData.fromJson(Map<String, dynamic> json)
      : addressId = json['address_id'],
        paymentAddress = json['payment_address'],
        addresses = json['addresses'],
        countryId = json['country_id'],
        zoneId = json['zone_id'],
        countries = json['countries'],
        customFields = json['custom_fields'],
        paymentAddressCustomField = json['payment_address_custom_field'];

  Map<String, dynamic> toJson() => {
        'address_id': addressId,
        'payment_address': paymentAddress,
        'addresses': addresses,
        'country_id': countryId,
        'zone_id': zoneId,
        'countries': countries,
        'custom_fields': customFields,
        'payment_address_custom_field': paymentAddressCustomField
      };
}

class Countries {
  String countryId,
      name,
      isoCode2,
      isoCode3,
      addressFormat,
      postcodeRequired,
      status;

  Countries(this.countryId, name, this.isoCode2, this.isoCode3,
      this.addressFormat, this.postcodeRequired, this.status);

  Countries.fromJson(Map<String, dynamic> json)
      : countryId = json['country_id'],
        name = json['name'],
        isoCode2 = json['iso_code_2'],
        isoCode3 = json['iso_code_3'],
        addressFormat = json['address_format'],
        postcodeRequired = json['postcode_required'],
        status = json['status'];

  Map<String, dynamic> toJson() => {
        'country_id': countryId,
        'name': name,
        'iso_code_2': isoCode2,
        'iso_code_3': isoCode3,
        'address_format': addressFormat,
        'postcode_required': postcodeRequired,
        'status': status
      };
}

class ZoneData {
  List<dynamic> zone;
  String countryId,
      name,
      isoCode2,
      isoCode3,
      addressFormat,
      postcodeRequired,
      status;

  ZoneData(this.countryId, this.name, this.isoCode2, this.isoCode3,
      this.addressFormat, this.postcodeRequired, this.status);

  ZoneData.fromJson(Map<String, dynamic> json)
      : countryId = json['country_id'],
        name = json['name'],
        isoCode2 = json['iso_code_2'],
        isoCode3 = json['iso_code_3'],
        addressFormat = json['address_format'],
        postcodeRequired = json['postcode_required'],
        zone = json['zone'],
        status = json['status'];

  Map<String, dynamic> toJson() => {
        'country_id': countryId,
        'name': name,
        'iso_code_2': isoCode2,
        'iso_code_3': isoCode3,
        'address_format': addressFormat,
        'postcode_required': postcodeRequired,
        'zone': zone,
        'status': status
      };
}

class Zones {
  String zoneId, countryId, name, code, status;

  Zones(this.zoneId, this.countryId, this.name, this.code, this.status);

  Zones.fromJson(Map<String, dynamic> json)
      : zoneId = json['zone_id'],
        countryId = json['country_id'],
        name = json['name'],
        code = json['code'],
        status = json['status'];

  Map<String, dynamic> toJson() => {
        'zone_id': zoneId,
        'country_id': countryId,
        'name': name,
        'code': code,
        'status': status
      };
}

class LocationUtils {
  static Future<dynamic> getCountries(final String _customerId) async {
    dynamic _countryRes =
        await NetworkUtils.httpGet("getBillingAddress/" + _customerId, null);
    if (_countryRes != null &&
        _countryRes['countries'] != null &&
        _countryRes['countries'].length > 0) {
      _countryRes['countries'].insert(0, {
        'country_id': '0',
        'name': ' --- Please Select --- ',
        'iso_code_2': 'PS',
        'postcode_required': '0',
        'status': '0'
      });
    }
    print("\n\ngetCountries Response:=>  $_countryRes\n\n");
    return _countryRes;
  }

  static Future<dynamic> getStates(final String _countryId) async {
    dynamic _stateRes =
        await NetworkUtils.httpGet("getStateList/" + _countryId, null);
    if (_stateRes != null &&
        _stateRes['zone'] != null &&
        _stateRes['zone'].length > 0) {
      _stateRes['zone'].insert(0, {
        'zone_id': '0',
        'country_id': '0',
        'name': ' --- Please Select --- ',
        'code': 'PS',
        'status': '0'
      });
    }
    print("\n\ngetStates Response:=>  ${_stateRes['zone']}\n\n");
    return _stateRes;
  }
}

/*if (res != null) {
      if(res['options'] != null && res['options'].length > 0){
        List<dynamic> _sizeList = res['options'][0]['product_option_value'];
        _sizeList.insert(0, {'productOptionValueId': '0', 'option_value_id': '0', 'name': ' --- Please Select --- '});
      }
    }*/

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageProvider {
  static final FlutterSecureStorage _flutterSecureStorage =
      FlutterSecureStorage();

  static const String storageUserFirstNameKey = 'userFirstNameKey';
  static const String storageUserLastNameKey = 'userLastNameKey';
  static const String storageUserFullNameKey = 'userFullNameKey';
  static const String storageUserEmailKeyKey = 'userEmailKey';
  static const String storageUserPhoneKey = 'userPhoneKey';
  static const String storageUserImageKey = 'userImageKey';
  static const String storageUserPasswordKey = 'userPasswordKey';
  static const String storageUserIdKey = 'userIdKey';
  static const String storageUserTokenKey = 'userTokenKey';
  static const String storageUserTotalRewardKey = 'userTotalRewardKey';
  static const String storageUserCountryKey = 'userCountryKey';
  static const String _storageCurrentLocalityKey = 'currentLocalityKey';
  static const String _storageCurrentCityKey = 'currentCityKey';
  static const String _storageCurrentStateKey = 'currentStateKey';
  static const String _storageCurrentCountryKey = 'currentCountryKey';
  static const String _storageCurrentPinCodeKey = 'currentPinCodeKey';
  static const String _storageCartCouponKey = 'cartCouponKey';
  static const String _storageCartVoucherKey = 'cartVoucherKey';
  static const String _storageCartRewardKey = 'cartRewardKey';

  static Future<void> setToken(String _token) async {
    await _flutterSecureStorage.write(key: storageUserTokenKey, value: _token);
  }

  static Future<String> getUserToken() async {
    return await _flutterSecureStorage.read(key: storageUserTokenKey);
  }

  static Future<void> clearToken() async {
    await _flutterSecureStorage.delete(key: storageUserTokenKey);
  }

  static Future<void> setUserInfo(
      final String _firstName,
      final String _lastName,
      final String _fullName,
      final String _email,
      final String _phone,
      final String _image,
      final String _password,
      final String _userId,
      final String _userToken,
      final String _reward,
      final String _country) async {
    print(
        "\n\nsetUserInfo Params=> _firstName: $_firstName, _lastName: $_lastName, _fullName: $_fullName, _email: $_email, _phone: $_phone, _image: $_image, _password: $_password, _userId: $_userId, _userToken: $_userToken, _reward: $_reward, _country: $_country\n\n");
    if (_firstName != null) {
      await _flutterSecureStorage.write(
          key: storageUserFirstNameKey, value: _firstName);
    }
    if (_lastName != null) {
      await _flutterSecureStorage.write(
          key: storageUserLastNameKey, value: _lastName);
    }
    if (_fullName != null) {
      await _flutterSecureStorage.write(
          key: storageUserFullNameKey, value: _fullName);
    }
    if (_email != null) {
      await _flutterSecureStorage.write(
          key: storageUserEmailKeyKey, value: _email);
    }
    if (_phone != null) {
      await _flutterSecureStorage.write(
          key: storageUserPhoneKey, value: _phone);
    }
    if (_image != null) {
      await _flutterSecureStorage.write(
          key: storageUserImageKey, value: _image);
    }
    if (_password != null) {
      await _flutterSecureStorage.write(
          key: storageUserPasswordKey, value: _password);
    }
    if (_userId != null) {
      await _flutterSecureStorage.write(key: storageUserIdKey, value: _userId);
    }
    if (_userToken != null) {
      await _flutterSecureStorage.write(
          key: storageUserTokenKey, value: _userToken);
    }
    if (_reward != null) {
      await _flutterSecureStorage.write(
          key: storageUserTotalRewardKey, value: _reward);
    }
    if (_country != null) {
      await _flutterSecureStorage.write(
          key: storageUserCountryKey, value: _userToken);
    }
  }

  static Future<void> clearUserInfo() async {
    await _flutterSecureStorage.deleteAll();
  }

  static Future<Map<String, String>> getUserInformation() async {
    return await _flutterSecureStorage.readAll();
  }

  static Future<void> setCurrentLocationInfo(
      final String _locality,
      final String _city,
      final String _state,
      final String _country,
      final String _pinCode) async {
    if (_locality != null && _locality != '') {
      await _flutterSecureStorage.write(
          key: _storageCurrentLocalityKey, value: _locality);
    }
    if (_city != null && _city != '') {
      await _flutterSecureStorage.write(
          key: _storageCurrentCityKey, value: _city);
    }
    if (_state != null && _state != '') {
      await _flutterSecureStorage.write(
          key: _storageCurrentStateKey, value: _state);
    }
    if (_country != null && _country != '') {
      await _flutterSecureStorage.write(
          key: _storageCurrentCountryKey, value: _country);
    }
    if (_pinCode != null && _pinCode != '') {
      await _flutterSecureStorage.write(
          key: _storageCurrentPinCodeKey, value: _pinCode);
    }
  }

  static Future<List> getCurrentLocationInfo() async {
    return [
      await _flutterSecureStorage.read(key: _storageCurrentLocalityKey),
      await _flutterSecureStorage.read(key: _storageCurrentCityKey),
      await _flutterSecureStorage.read(key: _storageCurrentStateKey),
      await _flutterSecureStorage.read(key: _storageCurrentCountryKey),
      await _flutterSecureStorage.read(key: _storageCurrentPinCodeKey)
    ];
  }

  static Future<void> setCouponVoucherAndRewardInfo(
      final String _coupon, final String _voucher, final String _reward) async {
    if (_coupon != null && _coupon != '') {
      await _flutterSecureStorage.write(
          key: _storageCartCouponKey, value: _coupon);
    }
    if (_voucher != null && _voucher != '') {
      await _flutterSecureStorage.write(
          key: _storageCartVoucherKey, value: _voucher);
    }
    if (_reward != null && _reward != '') {
      await _flutterSecureStorage.write(
          key: _storageCartRewardKey, value: _reward);
    }
  }

  static Future<List> getCouponVoucherAndRewardInfo() async {
    return [
      await _flutterSecureStorage.read(key: _storageCartCouponKey),
      await _flutterSecureStorage.read(key: _storageCartVoucherKey),
      await _flutterSecureStorage.read(key: _storageCartRewardKey)
    ];
  }

  static Future<void> setCouponInfo(final String _coupon) async {
    if (_coupon != null && _coupon != '') {
      await _flutterSecureStorage.write(
          key: _storageCartCouponKey, value: _coupon);
    }
  }

  static Future<void> setVoucherInfo(final String _voucher) async {
    if (_voucher != null && _voucher != '') {
      await _flutterSecureStorage.write(
          key: _storageCartVoucherKey, value: _voucher);
    }
  }

  static Future<void> setRewardInfo(final String _reward) async {
    if (_reward != null && _reward != '') {
      await _flutterSecureStorage.write(
          key: _storageCartRewardKey, value: _reward);
    }
  }

  static Future<String> getCouponInfo() async {
    return await _flutterSecureStorage.read(key: _storageCartCouponKey);
  }

  static Future<String> getVoucherInfo() async {
    return await _flutterSecureStorage.read(key: _storageCartVoucherKey);
  }

  static Future<String> getRewardInfo() async {
    return await _flutterSecureStorage.read(key: _storageCartRewardKey);
  }

  static Future<void> clearCouponInfo() async {
    await _flutterSecureStorage.delete(key: _storageCartCouponKey);
  }

  static Future<void> clearVoucherInfo() async {
    await _flutterSecureStorage.delete(key: _storageCartVoucherKey);
  }

  static Future<void> clearRewardInfo() async {
    await _flutterSecureStorage.delete(key: _storageCartRewardKey);
  }
}

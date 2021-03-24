import 'package:flutter/material.dart';
import 'package:gwaliorkart/utils/constants.dart';
import 'package:gwaliorkart/utils/storage_utils.dart';

import 'network_utils.dart';

class AuthUtils {
  static String userFirstName,
      userLastName,
      userFullName,
      userEmailId,
      userPhoneNo,
      userImage,
      userPassword,
      userId,
      authToken,
      currentLocality,
      currentCity,
      currentState,
      currentCountry,
      currentPinCode,
      totalReward,
      country,
      coupon,
      voucher,
      reward;

  static Future<String> getToken() async {
    final String _token = await StorageProvider.getUserToken();
    _token != null && _token != '' ? authToken = _token : authToken = null;
    return _token;
  }

  static Future<String> getCoupon() async {
    final String _coupon = await StorageProvider.getCouponInfo();
    _coupon != null && _coupon != '' ? coupon = _coupon : coupon = null;
    return _coupon;
  }

  static Future<String> getVoucher() async {
    final String _voucher = await StorageProvider.getVoucherInfo();
    _voucher != null && _voucher != '' ? voucher = _voucher : voucher = null;
    return _voucher;
  }

  static Future<String> getReward() async {
    final String _reward = await StorageProvider.getRewardInfo();
    _reward != null && _reward != '' ? reward = _reward : reward = null;
    return _reward;
  }

  static Future<Map<String, String>> getUserInfo() async {
    final Map<String, String> _usrInfo =
        await StorageProvider.getUserInformation();
    userFirstName = _usrInfo['userFirstNameKey'];
    userLastName = _usrInfo['userLastNameKey'];
    userFullName = _usrInfo['userFullNameKey'];
    userEmailId = _usrInfo['userEmailKey'];
    userPhoneNo = _usrInfo['userPhoneKey'];
    userImage = _usrInfo['userImageKey'];
    userPassword = _usrInfo['userPasswordKey'];
    userId = _usrInfo['userIdKey'];
    authToken = _usrInfo['userTokenKey'];
    totalReward = _usrInfo['userTotalRewardKey'];
    country = _usrInfo['userCountryKey'];
    currentLocality = _usrInfo['currentLocalityKey'];
    currentCity = _usrInfo['currentCityKey'];
    currentState = _usrInfo['currentStateKey'];
    currentCountry = _usrInfo['currentCountryKey'];
    currentPinCode = _usrInfo['currentPinCodeKey'];
    coupon = _usrInfo['cartCouponKey'];
    voucher = _usrInfo['cartVoucherKey'];
    reward = _usrInfo['cartRewardKey'];
    print(
        "\n\ngetUserInfo Response:=>> userFirstName:= $userFirstName, userLastName:= $userLastName, userFullName:= $userFullName, userEmailId:= $userEmailId, userPhoneNo:= $userPhoneNo, userImage:= $userImage, userPassword:= $userPassword, userId:= $userId, authToken:= $authToken, totalReward:= $totalReward, country:= $country, currentLocality:= $currentLocality, currentCity:= $currentCity, currentState:= $currentState, currentCountry:= $currentCountry, currentPinCode:= $currentPinCode, coupon:= $coupon, voucher:= $voucher, reward:= $reward\n\n");
    return _usrInfo;
  }

  static Future<dynamic> loginUser(LoginData data) async {
    dynamic res =
        await NetworkUtils.httpSignInSignUpPost("custlogin", data.toJson());
    print("loginUser Response:=>  $res");
    if (res != null &&
        res.containsKey("success") &&
        res['customer_id'] != null &&
        res['token'] != null) {
      if (res['name'] != null && res['name'] != '') {
        final String _name = res['name'];
        List<String> nameArr = _name.split(' ');
        await Constants.setAndGetUserInfo(
                nameArr[0],
                nameArr[1],
                res['name'],
                res['email'],
                res['telephone'],
                res['image'],
                res['password'],
                res['customer_id'],
                res['token'],
                res['total_reward'].toString(),
                res['country'])
            .then((dynamic _result) {
          print("setAndGetUserInfo:= $_result");
        }).catchError((_err) {
          print("setAndGetUserInfo catchError:= $_err");
        });
      }
    }
    return res;
  }

  static Future<dynamic> forgotPassword(ForgotData data) async {
    dynamic res =
        await NetworkUtils.httpSignInSignUpPost("custforgotten", data.toJson());
    print("forgotPassword Response:=>  $res");
    return res;
  }

  static Future<dynamic> resetPassword(ResetData data) async {
    dynamic res = await NetworkUtils.httpSignInSignUpPost(
        "custresetpassword", data.toJson());
    print("resetPassword Response:=>  $res");
    return res;
  }

  static Future<dynamic> signUpUser(SignUpData data) async {
    dynamic res =
        await NetworkUtils.httpSignInSignUpPost("custregister", data.toJson());
    print("signUpUser Response:=>  $res");
    return res;
  }

  static Future<dynamic> signUpWithSocial(
      final SignUpData _data,
      final String _image,
      final String _password,
      final BuildContext context) async {
    dynamic res = await NetworkUtils.httpSignInSignUpPost(
        "registersocial", _data.toJsonSocial());
    print("\n\nsignUpWithSocial Response:=>  $res\n\n");
    if (res != null && res['customer_id'] != null && res['token'] != null) {
      await Constants.setAndGetUserInfo(
              _data.firstName,
              _data.lastName,
              res['name'],
              res['email'],
              res['phone'],
              _image,
              _password,
              res['customer_id'],
              res['token'],
              res['total_reward'],
              res['country'])
          .then((dynamic _res4) async {
        print("\n\nsetAndGetUserInfo Response:=> $_res4\n\n");
      }).catchError((_err) {
        print("\n\nsetAndGetUserInfo catchError:= $_err\n\n");
        Constants.showLongToastBuilder("setAndGetUserInfo failed.");
      });
    }
    return res;
  }

  static Future<dynamic> updateProfile(EditAccountData _updateParam) async {
    final dynamic _updateRes =
        await NetworkUtils.httpPost("custeditprofile", _updateParam.toJson());
    print("\nupdateProfile Response:=>  $_updateRes\n");
    return _updateRes;
  }

  static Future<dynamic> getCustomerAcc(final String _customerId) async {
    final dynamic _accRes =
        await NetworkUtils.httpGet("getcustacc/" + _customerId, null);
    print("\ngetCustomerAcc Response:=>  $_accRes\n");
    return _accRes;
  }

  static Future<dynamic> getEditProfile(final String _customerId) async {
    final dynamic _editRes =
        await NetworkUtils.httpGet("geteditprofile/" + _customerId, null);
    print("\ngetEditProfile Response:=>  $_editRes\n");
    return _editRes;
  }

  static Future<dynamic> getCustomerAddressList(
      final String _customerId) async {
    final dynamic _addressRes = await NetworkUtils.httpGet(
        "getCustomerAddressList/" + _customerId, null);
    print("\ngetCustomerAddressList Response:=>  $_addressRes\n");
    return _addressRes;
  }

  static Future<dynamic> getCustomerAddAddressForm(
      final String _customerId, final String _addressId) async {
    final dynamic _addressRes = await NetworkUtils.httpGet(
        "getCustomerAddAddressForm/" + _customerId + "/" + _addressId, null);
    print("\ngetCustomerAddAddressForm Response:=>  $_addressRes\n");
    return _addressRes;
  }

  static Future<dynamic> changePassword(PasswordData _passwordParam) async {
    final dynamic _updateRes =
        await NetworkUtils.httpPost("changepassacc", _passwordParam.toJson());
    print("\nchangePassword Response:=>  $_updateRes\n");
    return _updateRes;
  }
}

class LoginData {
  String email, password, name, phone, expiry, token;

  LoginData(this.email, this.password);

  LoginData.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        phone = json['phone'],
        email = json['email'],
        expiry = json['expiry'],
        token = json['token'];

  Map<String, dynamic> toJson() => {'email': email, 'password': password};
}

class FacebookLoginData {
  String name, firstName, lastName, picture, email;

  FacebookLoginData(
      this.name, this.firstName, this.lastName, this.picture, this.email);

  FacebookLoginData.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        firstName = json['first_name'],
        lastName = json['last_name'],
        picture = json['picture'],
        email = json['email'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'first_name': firstName,
        'last_name': lastName,
        'picture': picture,
        'email': email
      };
}

class GoogleLoginData {
  String name, firstName, lastName, picture, email;

  GoogleLoginData(
      this.name, this.firstName, this.lastName, this.picture, this.email);

  GoogleLoginData.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        firstName = json['first_name'],
        lastName = json['last_name'],
        picture = json['picture'],
        email = json['email'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'first_name': firstName,
        'last_name': lastName,
        'picture': picture,
        'email': email
      };
}

class ForgotData {
  String email;

  ForgotData(this.email);

  ForgotData.fromJson(Map<String, dynamic> json) : email = json['email'];

  Map<String, dynamic> toJson() => {'email': email};
}

class PasswordData {
  String _customerId, email, password, confirm;

  PasswordData(this._customerId, this.email, this.password, this.confirm);

  Map<String, dynamic> toJson() => {
        'customer_id': _customerId,
        'email': email,
        'password': password,
        'confirm': confirm
      };
}

class ResetData {
  String code, password, confirm;

  ResetData(this.code, this.password, this.confirm);

  ResetData.fromJson(Map<String, dynamic> json)
      : code = json['code'].toString(),
        password = json['password'],
        confirm = json['confirm'];

  Map<String, dynamic> toJson() =>
      {'code': code.toString(), 'password': password, 'confirm': confirm};
}

class SignUpData {
  String firstName,
      lastName,
      email,
      telephone,
      password,
      confirm,
      expiry,
      token;
  bool agree, newsletter;

  SignUpData(this.firstName, this.lastName, this.email, this.telephone,
      this.password, this.confirm, this.agree, this.newsletter);

  SignUpData.fromJson(Map<String, dynamic> json)
      : firstName = json['firstname'],
        lastName = json['lastname'],
        email = json['email'],
        telephone = json['telephone'],
        password = json['password'],
        confirm = json['confirm'],
        agree = json['agree'],
        newsletter = json['newsletter'],
        expiry = json['expiry'],
        token = json['token'];

  Map<String, dynamic> toJson() => {
        'firstname': firstName,
        'lastname': lastName,
        'email': email,
        'telephone': telephone,
        'password': password,
        'confirm': confirm,
        'agree': agree.toString(),
        'newsletter': newsletter.toString()
      };

  Map<String, dynamic> toJsonSocial() =>
      {'firstname': firstName, 'lastname': lastName, 'email': email};
}

class EditAccountData {
  String customerId, firstName, lastName, email, preEmail, telephone;

  EditAccountData(this.customerId, this.firstName, this.lastName, this.email,
      this.preEmail, this.telephone);

  EditAccountData.fromJson(Map<String, dynamic> json)
      : firstName = json['firstname'],
        lastName = json['lastname'],
        email = json['email'],
        preEmail = json['preemail'],
        telephone = json['telephone'];

  Map<String, dynamic> toJson() => {
        'customer_id': customerId,
        'firstname': firstName,
        'lastname': lastName,
        'email': email,
        'preemail': preEmail,
        'telephone': telephone
      };
}

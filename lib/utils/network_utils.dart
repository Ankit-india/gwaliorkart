import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:gwaliorkart/utils/auth_utils.dart';
import 'package:gwaliorkart/utils/errors.dart';
import 'package:http/http.dart' as http;

class NetworkUtils {
  static final String host = "https://www.servitudeindia.com/";
  static final String version1ApiPath = "gwaliorkart/api/";
  static final String basePath = host + version1ApiPath;
  static final String authToken = AuthUtils.authToken;

  static fetchGet(String path, Map<String, String> params) async {
    final String uri = path;
    print("\nurl path: => ${uri.toString()}\n");
    if (authToken == null) {
      try {
        final res = null;
        if (res == null) {
          throw UnAuthorizeException("User token not found or invalid");
        }
      } catch (exp) {
        throw exp;
      }
    } else {
      try {
        final response = await http.get(
          uri,
          headers: {HttpHeaders.authorizationHeader: "Token " + authToken},
        );

        if (response.statusCode == 404) {
          throw FormatException("FormatException io not found");
        } else if (response.statusCode == 401) {
          throw UnAuthorizeException("User token not found or invalid");
        } else if (response.statusCode == 502) {
          throw BadGatewayException(
              "Server on the internet received an invalid response");
        } else {
          final responseJson = json.decode(response.body);
          return responseJson;
        }
      } catch (e) {
        print("\nfetchGet catch e: => ${uri.toString()}\n");
        throw e;
      }
    }
  }

  static httpGet(String path, Map<String, String> params) async {
    final String uri = basePath + path;
    print("\n\nurl: => $uri\n\n");

    try {
      final response = await http.get(
        uri,
      );

      if (response.statusCode == 404) {
        throw FormatException("FormatException io not found");
      } else if (response.statusCode == 401) {
        throw UnAuthorizeException("User token not found or invalid");
      } else if (response.statusCode == 502) {
        throw BadGatewayException(
            "Server on the internet received an invalid response");
      } else if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        return responseJson;
      }
    } catch (e) {
      print("\n\nhttpGet catch e:=. $e\n\n");
      throw e;
    }
  }

  static httpPost(String path, Map<String, dynamic> params) async {
    final String uri = basePath + path;
    print('\n\nUrl:=> $uri, \n\nparams:=> ${json.encode(params)}\n\n');
    try {
      final response = await http.post(
        uri,
        body: json.encode(params),
//        body: params,
//        headers: {HttpHeaders.authorizationHeader: "Token " + authToken},
      );

      if (response.statusCode == 404) {
        throw FormatException("FormatException io not found");
      } else if (response.statusCode == 502) {
        throw BadGatewayException(
            "Server on the internet received an invalid response");
      } else if (response.statusCode == 401) {
        throw UnAuthorizeException("User token not found or invalid");
      } else {
        final responseJson = json.decode(response.body);
        return responseJson;
      }
    } catch (e) {
      print("\n\nhttpPost catch e:=> $e\n\n");
      throw e;
    }
  }

  static httpSignInSignUpPost(String path, Map<String, dynamic> params) async {
    final String uri = basePath + path;
    print('\n\nUrl:=> $uri,\n\n params:=> ${json.encode(params)}\n\n');
    try {
      final response = await http.post(
        uri,
        body: json.encode(params),
      );

      if (response.statusCode == 404) {
        throw FormatException("FormatException io not found");
      } else {
        final responseJson = json.decode(response.body);
        return responseJson;
      }
    } catch (e) {
      print('\n\nhttpSignInSignUpPost catch e:=> $params\n\n');
      if (e.runtimeType == SocketException) {
        final String ex = "SocketException";
        throw ex;
      } else {
        throw e;
      }
    }
  }

  static httpLogoutPost(String path, Map<String, dynamic> params) async {
    final String uri = basePath + path;
    print("\n\nUrl:=> $uri\n\n");
    try {
      final response = await http.post(
        uri,
        body: params,
        headers: {HttpHeaders.authorizationHeader: "Token " + authToken},
      );
      if (response.statusCode == 204) {
        return true;
      }
    } catch (e) {
      print("\n\nhttpLogoutPost catch e:=> $uri\n\n");
      throw e;
    }
  }

  static dioPost(String path, FormData formData) async {
    Dio dio = Dio();
    String uri = basePath + path;
    print("\n\nUrl:=> $uri,\n\n Token:=> $authToken\n\n");
    Map head = <String, dynamic>{"Authorization": "Token " + authToken};
    try {
      final response = await dio.post(
        uri,
        data: formData,
//        data: json.encode(formData),
//        options: Options(headers: head),
        options: Options(contentType: 'multipart/form-data'),
      );
      if (response.statusCode == 401) {
        throw UnAuthorizeException("User token not found or invalid");
      } else {
        return response.data;
      }
    } catch (_exp) {
      print("\n\ndioPost catch e:=> $_exp\n\n");
      throw _exp;
    }
  }

  static httpDelete(String path) async {
    final String uri = basePath + path;
    print("\n\nUrl:=> $uri\n\n");
    if (authToken == null) {
      try {
        final res = null;
        if (res == null) {
          throw UnAuthorizeException("User token not found or invalid");
        }
      } catch (exp) {
        throw exp;
      }
    } else {
      try {
        final response = await http.delete(
          uri,
          headers: {HttpHeaders.authorizationHeader: "Token " + authToken},
        );

        if (response.statusCode == 404) {
          throw FormatException("FormatException io not found");
        } else if (response.statusCode == 401) {
          throw UnAuthorizeException("User token not found or invalid");
        } else if (response.statusCode == 502) {
          throw BadGatewayException(
              "Server on the internet received an invalid response");
        } else {
          final responseJson = json.decode(response.body);
          return responseJson;
        }
      } catch (e) {
        print("\n\nhttpDelete catch e:=> $e\n\n");
        throw e;
      }
    }
  }
}

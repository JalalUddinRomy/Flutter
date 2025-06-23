import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../../Controller/auth_controller.dart';
import '../../app.dart';
import '../../screens/sign_in_screen.dart';
import '../Models/network_response.dart';

class NetworkCaller {
  static Future<NetworkResponse> getRequest({required String url}) async {
    try {
      Uri uri = Uri.parse(url);
      Map<String, String>? headers = {
        'token': AuthController.accessToken.toString(),
      };
      printRequest(url,null, headers);
      final Response response = await get(uri,headers: headers);
      printResponse(url, response);
      if (response.statusCode == 200) {
        final decodeData = jsonDecode(response.body);
        if (response.statusCode == 401) {
          return NetworkResponse(
            isSuccessful: false,
            statusCode: response.statusCode,
            errorMessage: decodeData['data'],
          );
        }
        return NetworkResponse(
          isSuccessful: true,
          statusCode: response.statusCode,
          responseData: decodeData,
        );
      }  else {
        return NetworkResponse(
          isSuccessful: false,
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      return NetworkResponse(
        isSuccessful: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  static Future<NetworkResponse> postRequest({
    required String url,
    Map<String, dynamic>? body,
  }) async {
    try {
      Uri uri = Uri.parse(url);
      debugPrint(url);
      Map<String, String>? headers = {
        'Content-Type': 'application/json',
        'token': AuthController.accessToken.toString(),
      };
      printRequest(url, body, headers);
      final Response response = await post(
        uri,
        headers: headers,
        body: jsonEncode(body),
      );
      printResponse(url, response);
      if (response.statusCode == 200) {
        final decodeData = jsonDecode(response.body);
        return NetworkResponse(
          isSuccessful: true,
          statusCode: response.statusCode,
          responseData: decodeData,
        );
      } else if (response.statusCode == 401) {
        _moveToSignIn();
        return NetworkResponse(
          isSuccessful: false,
          statusCode: response.statusCode,
          errorMessage: "Unauthorised",
        );
      } else {
        return NetworkResponse(
          isSuccessful: false,
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      return NetworkResponse(
        isSuccessful: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  static void printRequest(String url, Map<String, dynamic>? body, headers) {
    debugPrint("Url : $url\nBody: $body\n ResponseHeaders :$headers");
  }

  static void printResponse(String url, Response response) {
    debugPrint(
      "Url : $url\nResponse Code: ${response.statusCode}\n ResponseBody :${response.body}",
    );
  }

  static Future<void> _moveToSignIn() async {
    await AuthController.clearUserData();
    Navigator.pushAndRemoveUntil(
      TodoApp.navigatorKey.currentContext!,
      MaterialPageRoute(builder: (context) => signInScreen()),
      (_) => false,
    );
  }
}

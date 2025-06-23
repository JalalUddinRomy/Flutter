import 'package:get/get.dart';
import '../Data/Services/network_caller.dart';
import '../Data/Utils/urls.dart';
import '../Data/Models/network_response.dart';

class ResetPasswordController extends GetxController {
  bool _inProgess = false;
  String? _errorMessage;

  bool get inProgress => _inProgess;

  String? get errorMessage => _errorMessage;

  Future<bool> postResetPassword(String email, String OTP,
      String password) async {
    bool isSuccess = false;
    _inProgess = true;
    update();
    final Map<String, dynamic> requestBody = {
      "email": email,
      "OTP": OTP,
      "password": password,
    };
    final NetworkResponse response = await NetworkCaller.postRequest(
      url: Urls.resetPassword,
      body: requestBody,
    );
    final Map<String, dynamic> decodedData = response.responseData;
    if (response.isSuccessful) {
      isSuccess = true;
      }
    else {
      _errorMessage = decodedData["data"];
    }
    _inProgess = false;
    update();
    return isSuccess;
  }
}
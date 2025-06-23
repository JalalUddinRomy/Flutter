import 'package:get/get.dart';

import '../Data/Models/network_response.dart';
import '../Data/Services/network_caller.dart';
import '../Data/Utils/urls.dart';

class SignUpController extends GetxController{
  bool _inProgress=false;
  String? _errorMessage;
  bool get inProgress=>_inProgress;
  String? get errorMessage=>_errorMessage;
  Future<bool> signUpScreen(Map<String,dynamic> requestBody) async {
    bool isSuccess=false;
    _inProgress = true;
    update();
    NetworkResponse response = await NetworkCaller.postRequest(
        url: Urls.registration,body: requestBody
    );
    if (response.isSuccessful) {
      isSuccess=true;
    } else {
      _errorMessage=response.errorMessage;
    }
    _inProgress=false;
    update();
    return isSuccess;
  }
}
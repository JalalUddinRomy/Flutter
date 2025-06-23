import 'package:get/get.dart';

import '../Data/Models/network_response.dart';
import '../Data/Models/user_model.dart';
import '../Data/Services/network_caller.dart';
import '../Data/Utils/urls.dart';
import 'auth_controller.dart';

class UpdateProfileController extends GetxController{
  bool _inProgress=false;
  String? _errorMessage;
  bool get inProgress=>_inProgress;
  String? get errorMessage=>_errorMessage;
  Future<bool> getUpdateProfile(Map<String, dynamic> requestBody) async {
    bool isSuccess=false;
   _inProgress=true;
   update();
    final NetworkResponse response = await NetworkCaller.postRequest(
      url: Urls.updateProfile,
      body: requestBody,
    );
    if (response.isSuccessful) {
      UserModel userModel=UserModel.fromJson(requestBody);
      await AuthController.saveUserData(userModel);
      isSuccess=true;
    } else {
      _errorMessage=response.errorMessage;
    }
    _inProgress=false;
    update();
    return isSuccess;
  }
}

import 'package:get/get.dart';

import '../Data/Models/login_model.dart';
import '../Data/Models/network_response.dart';
import '../Data/Services/network_caller.dart';
import '../Data/Utils/urls.dart';
import 'auth_controller.dart';

class SignInController extends GetxController{
  String? _errorMessage;
  bool _inProgress=false;
  String? get errorMessage=>_errorMessage;
  bool get inProgress=>_inProgress;
  Future<bool> signIn(String email,String password) async{
    bool isSuccess=false;
    _inProgress=true;
    update();
    Map<String,dynamic> requestBody={
      "email":email,
      "password":password
    };
    NetworkResponse response=await NetworkCaller.postRequest(url:Urls.login,body: requestBody);
    if(response.isSuccessful){
      LoginModel loginModel=LoginModel.fromJson(response.responseData);
      await AuthController.saveAccessToken(loginModel.token!);
      await AuthController.saveUserData(loginModel.userModelData!);
      isSuccess=true;
    }
    else{
      _errorMessage=response.errorMessage;
    }
    _inProgress=false;
    update();
    return isSuccess;
  }
}

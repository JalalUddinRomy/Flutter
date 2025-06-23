import 'package:get/get.dart';

import '../Data/Models/network_response.dart';
import '../Data/Services/network_caller.dart';
import '../Data/Utils/urls.dart';

class PinVerificationController extends GetxController{
  bool _inProgress=false;
  String? _errorMessage;
  bool get inProgress=>_inProgress;
  String? get errorMessage=>_errorMessage;
  Future<bool> getPinCodeVerification(String email,String Otp) async {
    bool isSuccess=false;
   _inProgress=true;
   update();
    final NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.verifyOTP(email, Otp),
    );
    final receiveData=response.responseData;
    if (response.isSuccessful && receiveData['status']=="success"){
     isSuccess=true;
    }
    else{
     _errorMessage=receiveData['data'];
    }
    _inProgress=false;
    update();
    return isSuccess;
  }

}
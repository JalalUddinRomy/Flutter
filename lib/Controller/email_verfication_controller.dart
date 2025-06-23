import 'package:get/get.dart';

import '../Data/Models/network_response.dart';
import '../Data/Services/network_caller.dart';
import '../Data/Utils/urls.dart';

class EmailVerificationController extends GetxController{
  bool _inProgress=false;
  String? _errorMessage;
  bool get inProgress=>_inProgress;
  String? get errorMessage=>_errorMessage;
  Future<bool> getEmailVerification(String email) async {
    bool isSuccess=false;
    _inProgress=true;
    update();
    final NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.verifyEmail(email),
    );
    final Map<String,dynamic> decodedData = response.responseData;
    if(response.isSuccessful && decodedData['status'] == 'success') {
      isSuccess=true;
    }
    else{
     _errorMessage=decodedData['data'];
    }
    _inProgress=false;
    update();
    return isSuccess;
  }
}

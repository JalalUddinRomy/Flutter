import 'package:task_manager_getx/Data/Models/user_model.dart';

class LoginModel {
  String? status;
  String? token;
  UserModel? userModelData;

  LoginModel({this.status, this.token, this.userModelData});

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    token = json['token'];
    userModelData = json['data'] != null ? UserModel.fromJson(json['data']) : null;
  }

}



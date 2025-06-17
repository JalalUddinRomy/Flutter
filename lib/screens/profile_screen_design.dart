import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo_app/Controller/auth_controller.dart';
import 'package:todo_app/Data/Models/network_response.dart';
import 'package:todo_app/Data/Models/user_model.dart';
import 'package:todo_app/Data/Services/network_caller.dart';
import 'package:todo_app/Data/Utils/urls.dart';
import 'package:todo_app/widgets/center_circular_progress_indicator.dart';
import 'package:todo_app/widgets/snackbar_message.dart';
import 'package:todo_app/widgets/tm_app_bar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _phoneTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  XFile? _pickImage;
  bool _updateProfileInProgress = false;

  @override
  void initState() {
    super.initState();
    _setuserdata();
  }

  void _setuserdata() {
    _emailTEController.text = AuthController.userData?.email ?? '';
    _firstNameTEController.text = AuthController.userData?.firstName ?? '';
    _lastNameTEController.text = AuthController.userData?.lastName ?? '';
    _phoneTEController.text = AuthController.userData?.mobile ?? '';
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: TMAppBar(isProfileScreenOpen: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 32),
                Text(
                  "Update Profile",
                  style: textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 32),
                _buildsPhotoPickerSection(),
                SizedBox(height: 8),
                TextFormField(
                  enabled: false,
                  controller: _emailTEController,
                  decoration: InputDecoration(hintText: "Email"),
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return 'enter your email';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: _firstNameTEController,
                  decoration: InputDecoration(hintText: "First Name"),
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return 'enter your First Name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: _lastNameTEController,
                  decoration: InputDecoration(hintText: "Last Name"),
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return 'enter your Last Name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: _phoneTEController,
                  decoration: InputDecoration(hintText: "Phone"),
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return 'enter your Phone';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: _passwordTEController,
                  decoration: InputDecoration(hintText: "Password"),
                ),
                SizedBox(height: 16),
                Visibility(
                  visible: !_updateProfileInProgress,
                  replacement: CenterCircularProgressIndicator(),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formkey.currentState!.validate()) {
                        _getUpdateProfile();
                      }
                    },
                    child: Icon(Icons.arrow_forward_ios),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildsPhotoPickerSection() {
    return GestureDetector(
      onTap: _pickedImage,
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Container(
              height: 60,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  topLeft: Radius.circular(8),
                ),
              ),
              child: Center(
                child: Text(
                  "Photo",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SizedBox(width: 16),
            Text(_getSelectedPhotoTitle()),
          ],
        ),
      ),
    );
  }

  String _getSelectedPhotoTitle() {
    if (_pickImage != null) {
      return _pickImage!.name;
    } else {
      return 'Select Your Photo';
    }
  }

  Future<void> _pickedImage() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? selectedImage = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (selectedImage != null) {
      _pickImage = selectedImage;
      setState(() {});
    }
  }

  Future<void> _getUpdateProfile() async {
    _updateProfileInProgress = true;
    setState(() {});
    Map<String, dynamic> requestBody = {
      "email": _emailTEController.text.trim(),
      "firstName": _firstNameTEController.text.trim(),
      "lastName": _lastNameTEController.text.trim(),
      "mobile": _phoneTEController.text.trim(),
    };
    if (_passwordTEController.text.isNotEmpty) {
      requestBody['password'] = _passwordTEController.text;
    }
    if (_pickImage != null) {
      List<int> imageBytes = await _pickImage!.readAsBytes();
      String convertedImage = base64Encode(imageBytes);
      requestBody['photo'] = convertedImage;
    }
    final NetworkResponse response = await NetworkCaller.postRequest(
      url: Urls.updateProfile,
      body: requestBody,
    );
    _updateProfileInProgress = false;
    setState(() {});
    if (response.isSuccessful) {
      UserModel userModel=UserModel.fromJson(requestBody);
      await AuthController.saveUserData(userModel);
      showSnackbarMessage(context, 'Profile Updated Successfully');
      Navigator.pop(context,true);
    } else {
      showSnackbarMessage(context, response.errorMessage);
    }
  }
}

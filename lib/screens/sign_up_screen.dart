import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_getx/Controller/sign_up_controller.dart';
import 'package:task_manager_getx/screens/sign_in_screen.dart';

import '../Data/Models/network_response.dart';
import '../Data/Services/network_caller.dart';
import '../Data/Utils/urls.dart';
import '../utils/appColor.dart' show AppColor;
import '../widgets/screen_background.dart' show screenBackground;
import '../widgets/snackbar_message.dart';

class signUpScreen extends StatefulWidget {
  static const String name='/signupScreen';
  const signUpScreen({super.key});

  @override
  State<signUpScreen> createState() => _signUpScreenState();
}
class _signUpScreenState extends State<signUpScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _signUpformkey = GlobalKey<FormState>();
  SignUpController signUpController=Get.find<SignUpController>();
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SingleChildScrollView(
        child: screenBackground(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 106),
                  Text(
                    "Join with us!",
                    style: textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 24),
                  _buildSignUpFormSection(),
                  SizedBox(height: 24),
                  Center(child: _buildHaveAccountSection()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignUpFormSection() {
    return Form(
      key: _signUpformkey,
      child: Column(
        children: [
          TextFormField(
            controller: _emailTEController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(hintText: "Email"),
            keyboardType: TextInputType.emailAddress,
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return "Enter a valid Email Address";
              }
              return null;
            },
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: _firstNameTEController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(hintText: "First Name"),
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return "Enter a valid First Name";
              }
              return null;
            },
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: _lastNameTEController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(hintText: "Last Name"),
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return "Enter a valid Last Name";
              }
              return null;
            },
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: _mobileTEController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(hintText: "Mobile"),
            keyboardType: TextInputType.number,
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return "Enter a valid Mobile Number";
              }
              return null;
            },
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: _passwordTEController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(hintText: "Password"),
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return "Enter a valid Password";
              }
              return null;
            },
          ),
          SizedBox(height: 24),
          GetBuilder<SignUpController>(
            builder: (controller) {
              return Visibility(
                visible: !controller.inProgress,
                replacement: CircularProgressIndicator(),
                child: ElevatedButton(
                  onPressed: () {
                    _onTapNextButton();
                  },
                  child: Icon(Icons.arrow_forward_ios),
                ),
              );
            }
          ),
        ],
      ),
    );
  }

  Widget _buildHaveAccountSection() {
    return RichText(
      text: TextSpan(
        text: "Have An Account?",
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 18,
          letterSpacing: 0.5,
          color: Colors.black,
        ),
        children: [
          TextSpan(
            text: "Sign In",
            style: TextStyle(color: AppColor.themecolor),
            recognizer: TapGestureRecognizer()..onTap = _onTapSignInScreen,
          ),
        ],
      ),
    );
  }

  void _onTapNextButton() {
    if (_signUpformkey.currentState!.validate()) {
      _getsignUpScreen();
    }
  }

  Future<void> _getsignUpScreen() async {
    Map<String,dynamic> requestBody={
      "email":_emailTEController.text.trim(),
      "firstName":_firstNameTEController.text.trim(),
      "lastName":_lastNameTEController.text.trim(),
      "mobile":_mobileTEController.text.trim(),
      "password":_passwordTEController.text,
      "photo":""
    };
    final bool result=await signUpController.signUpScreen(requestBody);
    if (result) {
      _onClearTextField();
      return showSnackbarMessage(context, "User adder Successfully");
    } else {
      return showSnackbarMessage(context, signUpController.errorMessage!, true);
    }
  }
  void _onClearTextField(){
    _emailTEController.clear();
    _firstNameTEController.clear();
    _lastNameTEController.clear();
    _mobileTEController.clear();
    _passwordTEController.clear();
  }

  void _onTapSignInScreen() {
  Navigator.pushReplacementNamed(context, signInScreen.name);
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _mobileTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/Controller/auth_controller.dart';
import 'package:todo_app/Data/Models/login_model.dart';
import 'package:todo_app/Data/Models/network_response.dart';
import 'package:todo_app/Data/Services/network_caller.dart';
import 'package:todo_app/Data/Utils/urls.dart';
import 'package:todo_app/screens/main_bottom_nav_bar.dart';
import 'package:todo_app/screens/pin_verification_screen.dart';
import 'package:todo_app/screens/sign_in_screen.dart';
import 'package:todo_app/widgets/snackbar_message.dart';

import '../utils/appColor.dart' show AppColor;
import '../widgets/screen_background.dart' show screenBackground;

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({
    super.key,
    required this.emailedOTP,
    required this.userEmail,
  });

  final String emailedOTP;
  final String userEmail;

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _passwordTEController = TextEditingController();
  final TextEditingController _confirmPasswordTEController =
  TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool _passwordresetInProgress = false;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme
        .of(context)
        .textTheme;
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
                    "Set Password",
                    style: textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 24),
                  Text(
                    "Minimum number of password should be 8 letters",
                    style: textTheme.titleSmall?.copyWith(color: Colors.grey),
                  ),
                  SizedBox(height: 24),
                  _buildResetPasswordFormSection(),
                  SizedBox(height: 48),
                  Center(child: _buildHaveAccountSection()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildResetPasswordFormSection() {
    return Form(
      key: _formkey,
      child: Column(
        children: [
          TextFormField(
            controller: _passwordTEController,
            decoration: InputDecoration(hintText: "Password"),
            keyboardType: TextInputType.emailAddress,
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return 'Enter a value';
              }
              if (value!.length < 8) {
                return 'Enter a value more than 8 digit';
              }
              return null;
            },
          ),
          SizedBox(height: 8),
          TextFormField(
            controller: _confirmPasswordTEController,
            decoration: InputDecoration(hintText: "Confirm Password"),
            keyboardType: TextInputType.emailAddress,
            validator: (String? value) {
              if (value != _passwordTEController.text) {
                return 'Password is Not Matched';
              }
              return null;
            },
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              _onTapNextButton();
            },
            child: Icon(Icons.arrow_forward_ios),
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
            recognizer: TapGestureRecognizer()
              ..onTap = _onTapSignInScreen,
          ),
        ],
      ),
    );
  }

  void _onTapNextButton() {
    if(_formkey.currentState!.validate()){
      _postResetPassword();
    }
  }

  Future<void> _postResetPassword() async {
    _passwordresetInProgress = true;
    setState(() {});
    final Map<String, dynamic> requestBody = {
      "email": widget.userEmail,
      "OTP": widget.emailedOTP,
      "password": _passwordTEController.text,
    };
    debugPrint(widget.emailedOTP);
    final NetworkResponse response = await NetworkCaller.postRequest(
      url: Urls.resetPassword,
      body: requestBody,
    );
    final Map<String, dynamic> decodedData = response.responseData;
    _passwordresetInProgress = false;
    setState(() {});
    if (response.isSuccessful) {
      final NetworkResponse loginResponse=await NetworkCaller.postRequest(url: Urls.login,body: requestBody);
      if(loginResponse.isSuccessful){
        final LoginModel loginModel=LoginModel.fromJson(loginResponse.responseData);
        await AuthController.saveAccessToken(loginModel.token!);
        await AuthController.saveUserData(loginModel.userModelData!);
        Navigator.pushAndRemoveUntil(
            context, MaterialPageRoute(builder: (context) => MainBottomNavBar()),
                (_)=>false);
        showSnackbarMessage(context, 'Password reset Successfully');
      }
      }
    else {
      showSnackbarMessage(context, decodedData['data'] ?? 'Reset Unsuccessful');
    }
  }

  void _onTapSignInScreen() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => signInScreen()),
          (_) => false,
    );
  }
}

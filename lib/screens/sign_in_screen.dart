import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_getx/Controller/sign_in_controller.dart';
import 'package:task_manager_getx/screens/sign_up_screen.dart';

import '../utils/appColor.dart';
import '../widgets/screen_background.dart';
import '../widgets/snackbar_message.dart';
import 'email_verification_screen.dart';
import 'main_bottom_nav_bar.dart';
import 'package:get/get.dart';

class signInScreen extends StatefulWidget {
  static const String name='/signInScreen';

  const signInScreen({super.key});

  @override
  State<signInScreen> createState() => _signInScreenState();
}

class _signInScreenState extends State<signInScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passWordTEController = TextEditingController();
  final GlobalKey<FormState> _signInformKey = GlobalKey<FormState>();
  SignInController signInController=Get.find<SignInController>();

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
                    "Get Started With",
                    style: textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 24),
                  _buildSignInFormSection(),
                  SizedBox(height: 24),
                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            _onTapForgotPassword();
                          },
                          child: Text(
                            "Forgot Password ?",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        _buildSignUpSection(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignInFormSection() {
    return Form(
      key: _signInformKey,
      child: Column(
        children: [
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: _emailTEController,
            decoration: InputDecoration(hintText: "Email"),
            keyboardType: TextInputType.emailAddress,
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return 'Enter a valid Value';
              }
              return null;
            },
          ),
          SizedBox(height: 16),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: _passWordTEController,
            decoration: InputDecoration(hintText: "Password"),
            obscureText: true,
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return 'Enter a valid Value';
              }
              if (value!.length <= 6) {
                return 'Enter a password more than 6 character';
              }
              return null;
            },
          ),
          SizedBox(height: 24),
          GetBuilder<SignInController>(
            builder: (controller) {
              return Visibility(
                visible:!controller.inProgress,
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

  Widget _buildSignUpSection() {
    return RichText(
      text: TextSpan(
        text: "Don't Have An Account?",
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 18,
          letterSpacing: 0.5,
          color: Colors.black,
        ),
        children: [
          TextSpan(
            text: "Sign Up",
            style: TextStyle(color: AppColor.themecolor),
            recognizer: TapGestureRecognizer()
              ..onTap = _onTapSignUpScreen,
          ),
        ],
      ),
    );
  }

  void _onTapNextButton() {
    if (_signInformKey.currentState!.validate()) {
      _signIn();
    }
  }

  Future<void> _signIn() async {
    final bool result = await signInController.signIn(
        _emailTEController.text.trim(),_passWordTEController.text);
    if (result) {
      Get.offAllNamed(MainBottomNavBar.name);
    }
    else {
      showSnackbarMessage(context,signInController.errorMessage!, true);
    }
  }

  void _onTapForgotPassword() {
   Navigator.pushNamed(context,EmailVerificationScreen.name);
  }

  void _onTapSignUpScreen() {
    Get.offAllNamed(signUpScreen.name);
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _passWordTEController.dispose();
    super.dispose();
  }
}

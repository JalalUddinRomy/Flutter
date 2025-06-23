import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_getx/Controller/reset_password_controller.dart';
import 'package:task_manager_getx/screens/sign_in_screen.dart';
import 'package:task_manager_getx/widgets/center_circular_progress_indicator.dart';
import '../utils/appColor.dart' show AppColor;
import '../widgets/screen_background.dart' show screenBackground;
import '../widgets/snackbar_message.dart';
import 'main_bottom_nav_bar.dart';

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
  final TextEditingController _confirmPasswordTEController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  ResetPasswordController resetPasswordController = Get.find<
      ResetPasswordController>();

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
          GetBuilder<ResetPasswordController>(
            builder: (controller) {
              return Visibility(
                visible: !controller.inProgress,
                replacement: CenterCircularProgressIndicator(),
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
            recognizer: TapGestureRecognizer()
              ..onTap = _onTapSignInScreen,
          ),
        ],
      ),
    );
  }

  void _onTapNextButton() {
    if (_formkey.currentState!.validate()) {
      _postResetPassword();
    }
  }

  Future<void> _postResetPassword() async {
    bool result = await resetPasswordController.postResetPassword(
        widget.userEmail, widget.emailedOTP, _passwordTEController.text);

    if (result) {
      Navigator.pushNamedAndRemoveUntil(
          context, signInScreen.name, (_) => false);
      showSnackbarMessage(context, 'Password reset Successfully');
    } else {
      showSnackbarMessage(context,
          resetPasswordController.errorMessage ?? 'Reset Unsuccessful');
    }
  }

  void _onTapSignInScreen() {
    Navigator.pushNamedAndRemoveUntil(context, signInScreen.name, (_) => false);
  }
}


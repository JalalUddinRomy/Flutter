import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager_getx/Controller/pin_verification_controller.dart';
import 'package:task_manager_getx/screens/reset_password_screen.dart';
import 'package:task_manager_getx/screens/sign_in_screen.dart';
import '../utils/appColor.dart' show AppColor;
import '../widgets/center_circular_progress_indicator.dart';
import '../widgets/screen_background.dart' show screenBackground;
import '../widgets/snackbar_message.dart';

class PinVerificationScreen extends StatefulWidget {
  const PinVerificationScreen({super.key, required this.passEmail});

  final String passEmail;

  @override
  State<PinVerificationScreen> createState() => _PinVerificationScreenState();
}

class _PinVerificationScreenState extends State<PinVerificationScreen> {
  final TextEditingController _pinCodeTeController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  PinVerificationController pinVerificationController =
      Get.find<PinVerificationController>();

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
                    "Pin verification",
                    style: textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 24),
                  Text(
                    "A 6 digit verification OTP has been sent to your Email Address",
                    style: textTheme.titleSmall?.copyWith(color: Colors.grey),
                  ),
                  SizedBox(height: 24),
                  _buildVerifyPinSection(),
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

  Widget _buildVerifyPinSection() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          PinCodeTextField(
            controller: _pinCodeTeController,
            autoDisposeControllers: false,
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return 'Enter a 6 Digit PIN';
              }
              if (value!.length < 6) {
                return 'Enter 6 digit ';
              }
              return null;
            },
            length: 6,
            obscureText: false,
            keyboardType: TextInputType.number,
            animationType: AnimationType.fade,
            pinTheme: PinTheme(
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(5),
              fieldHeight: 50,
              fieldWidth: 50,
              activeFillColor: Colors.white,
              inactiveFillColor: Colors.white,
              selectedFillColor: Colors.white,
            ),
            animationDuration: Duration(milliseconds: 300),
            backgroundColor: Colors.transparent,
            enableActiveFill: true,
            appContext: context,
          ),
          SizedBox(height: 16),
          GetBuilder<PinVerificationController>(
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
            recognizer: TapGestureRecognizer()..onTap = _onTapSignInScreen,
          ),
        ],
      ),
    );
  }

  void _onTapNextButton() {
    if (_formKey.currentState!.validate()) {
      _getPinCodeVerification();
    }
  }

  Future<void> _getPinCodeVerification() async {
    bool result = await pinVerificationController.getPinCodeVerification(
      widget.passEmail,
      _pinCodeTeController.text.trim(),
    );
    if (result) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              (context) => ResetPasswordScreen(
                emailedOTP: _pinCodeTeController.text.trim(),
                userEmail: widget.passEmail,
              ),
        ),
      );
      showSnackbarMessage(context, 'OTP Verified Successfully');
    } else {
      showSnackbarMessage(context, pinVerificationController.errorMessage!);
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

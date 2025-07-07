import 'dart:async';

import 'package:ecommerceapp/app/app_color.dart';
import 'package:ecommerceapp/app/app_constant.dart';
import 'package:ecommerceapp/features/auth/Ui/screens/complete_profile_screen.dart';
import 'package:ecommerceapp/features/auth/Ui/widgets/app_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PinVerificationScreen extends StatefulWidget {
  const PinVerificationScreen({super.key});

  static const String name = '/pin_verification_screen';

  @override
  State<PinVerificationScreen> createState() => _PinVerificationScreenState();
}

class _PinVerificationScreenState extends State<PinVerificationScreen> {
  @override
  void initState() {
    super.initState();
    _startResentCodeTimer();
  }

  final TextEditingController _otpTEController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final RxInt _timeRemaining = AppConstant.resendTimeOutInSecs.obs;
  final RxBool _resentCodeButton = false.obs;
  late Timer timer;

  void _startResentCodeTimer() {
    _timeRemaining.value = AppConstant.resendTimeOutInSecs;
    _resentCodeButton.value = false;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _timeRemaining.value--;
      if (_timeRemaining.value == 0) {
        timer.cancel();
        _resentCodeButton.value = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                const SizedBox(height: 120),
                const Center(child: AppIconWidget()),
                const SizedBox(height: 16),
                Text(
                  'Enter Your OTP',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 10),
                Text(
                  'A Four Digit OTP has been sent to your Email ',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(color: Colors.grey),
                ),
                const SizedBox(height: 24),
                PinCodeTextField(
                  length: 6,
                  obscureText: false,
                  keyboardType: TextInputType.number,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(8),
                    activeColor: AppColor.themeColor,
                    inactiveColor: AppColor.themeColor,
                  ),
                  animationDuration: Duration(milliseconds: 300),
                  controller: _otpTEController,
                  appContext: context,
                  validator: (String? value) {
                    if (value?.isEmpty ?? true) {
                      return 'Enter Your OTP';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    if (_formkey.currentState!.validate()) {
                      Navigator.pushNamed(context, CompleteProfileScreen.name);
                    }
                  },
                  child: Text('Next'),
                ),
                SizedBox(height: 16),
                Obx(
                  () => RichText(
                    text: TextSpan(
                      text: 'This code will expired in ',
                      style: TextStyle(color: Colors.grey),
                      children: [
                        TextSpan(
                          text: '${_timeRemaining.value}s',
                          style: TextStyle(color: AppColor.themeColor),
                        ),
                      ],
                    ),
                  ),
                ),
                Obx(
                  () => TextButton(
                    onPressed:
                        _resentCodeButton.value
                            ? () => _startResentCodeTimer()
                            : null,
                    style: TextButton.styleFrom(
                      foregroundColor:
                          _resentCodeButton.value
                              ? AppColor.themeColor
                              : Colors.grey,
                    ),
                    child: Text('Resend Code'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}

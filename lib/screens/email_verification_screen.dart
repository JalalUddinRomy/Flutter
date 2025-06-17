import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/Data/Models/network_response.dart';
import 'package:todo_app/Data/Services/network_caller.dart';
import 'package:todo_app/Data/Utils/urls.dart';
import 'package:todo_app/screens/pin_verification_screen.dart';
import 'package:todo_app/widgets/center_circular_progress_indicator.dart';
import 'package:todo_app/widgets/snackbar_message.dart';

import '../utils/appColor.dart' show AppColor;
import '../widgets/screen_background.dart' show screenBackground;

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final TextEditingController _emailTeController = TextEditingController();
  bool _verifyEmailInprogress = false;
  final GlobalKey<FormState> _formkey=GlobalKey<FormState>();

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
                    "Your Email Address",
                    style: textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 24),
                  Text(
                    "A 6 digit verification OTP will be sent to your Email Address",
                    style: textTheme.titleSmall?.copyWith(color: Colors.grey),
                  ),
                  SizedBox(height: 24),
                  _buildVerifyEmailFormSection(),
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

  Widget _buildVerifyEmailFormSection() {
    return Form(
      key: _formkey,
      child: Column(
        children: [
          TextFormField(
            controller: _emailTeController,
            decoration: InputDecoration(hintText: "Email"),
            keyboardType: TextInputType.emailAddress,
            validator: (String? value){
              if(value?.isEmpty ?? true){
                return 'Enter Your Email';
              }
              if(!value!.contains('@')){
                return 'Enter a Valid email Address';
              }
              return null;
            },
          ),
          SizedBox(height: 16),
          Visibility(
            visible: !_verifyEmailInprogress,
            replacement: CenterCircularProgressIndicator(),
            child: ElevatedButton(
              onPressed: () {
                _onTapNextButton();
              },
              child: Icon(Icons.arrow_forward_ios),
            ),
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
    if(_formkey.currentState!.validate()){
      _getEmailVerification();
    }

  }

  Future<void> _getEmailVerification() async {
    _verifyEmailInprogress = true;
    setState(() {});
    String sentEmail = _emailTeController.text.trim();
    final NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.verifyEmail(sentEmail),
    );
    _verifyEmailInprogress = false;
    setState(() {});
    final Map<String,dynamic> decodedData = response.responseData;
    if(response.isSuccessful && decodedData['status'] == 'success') {
        showSnackbarMessage(context, 'Otp Sent to your Email');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PinVerificationScreen(passEmail: sentEmail,)),
        );
    }
    else{
      showSnackbarMessage(context,decodedData['data']);
    }
  }

  void _onTapSignInScreen() {
    Navigator.pop(context);
  }
}

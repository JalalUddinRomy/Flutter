import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/Controller/auth_controller.dart';
import 'package:todo_app/Data/Models/login_model.dart';
import 'package:todo_app/Data/Models/network_response.dart';
import 'package:todo_app/Data/Services/network_caller.dart';
import 'package:todo_app/Data/Utils/urls.dart';
import 'package:todo_app/screens/email_verification_screen.dart';
import 'package:todo_app/screens/main_bottom_nav_bar.dart';
import 'package:todo_app/screens/sign_up_screen.dart';
import 'package:todo_app/utils/appColor.dart';
import 'package:todo_app/widgets/screen_background.dart';
import 'package:todo_app/widgets/snackbar_message.dart';

class signInScreen extends StatefulWidget {
  const signInScreen({super.key});

  @override
  State<signInScreen> createState() => _signInScreenState();
}

class _signInScreenState extends State<signInScreen> {
  final TextEditingController _emailTEController=TextEditingController();
  final TextEditingController _passWordTEController=TextEditingController();
  final GlobalKey<FormState> _signInformKey=GlobalKey<FormState>();
  bool _inprogress=false;
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
            validator: (String? value){
              if(value?.isEmpty ?? true){
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
            validator: (String? value){
              if(value?.isEmpty ?? true){
                return 'Enter a valid Value';
              }
              if(value!.length<=6){
                return 'Enter a password more than 6 character';
              }
              return null;
            },
          ),
          SizedBox(height: 24),
          Visibility(
            visible: _inprogress==false,
            replacement: CircularProgressIndicator(),
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
   if(_signInformKey.currentState!.validate()){
     _signIn();
   }
  }
  Future<void> _signIn() async{
    _inprogress=true;
    setState(() {});
    Map<String,dynamic> requestBody={
      "email":_emailTEController.text.trim(),
      "password":_passWordTEController.text
    };
    NetworkResponse response=await NetworkCaller.postRequest(url:Urls.login,body: requestBody);
    _inprogress=false;
    setState(() {});
    if(response.isSuccessful){
      LoginModel loginModel=LoginModel.fromJson(response.responseData);
      await AuthController.saveAccessToken(loginModel.token!);
      await AuthController.saveUserData(loginModel.userModelData!);
      Navigator.pushAndRemoveUntil(
          context, MaterialPageRoute(builder: (context) => MainBottomNavBar(),),
              (_)=>false);
    }
    else{
      showSnackbarMessage(context, response.errorMessage,true);
    }
  }

  void _onTapForgotPassword() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EmailVerificationScreen()),
    );
  }

  void _onTapSignUpScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => signUpScreen()),
    );

  }
  void disposed(){
    super.dispose();
    _emailTEController.dispose();
    _passWordTEController.dispose();
  }
}

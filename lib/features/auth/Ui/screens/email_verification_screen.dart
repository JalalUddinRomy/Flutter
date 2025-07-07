import 'package:ecommerceapp/features/auth/Ui/screens/pin_verfication_screen.dart';
import 'package:ecommerceapp/features/auth/Ui/widgets/app_icon_widget.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  static const String name = '/email_verification_screen';

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final TextEditingController _emailTEController=TextEditingController();
  final GlobalKey<FormState> _formkey=GlobalKey<FormState>();
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
                Text('Welcome Back', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 10),
                Text(
                  'Please Enter Your Email Address',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(color: Colors.grey),
                ),
                const SizedBox(height: 24,),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailTEController,
                  validator: (String? value){
                    if(value?.isEmpty ?? true){
                      return 'Enter your email Address';
                    }
                    if(EmailValidator.validate(value!)==false){
                      return 'Enter a valid Email Address';
                    }
                    return null;
                  },
                  decoration: InputDecoration(hintText: "Email Address"),
                ),
                SizedBox(height: 16),
                ElevatedButton(onPressed: () {
                  if(_formkey.currentState!.validate()){
                    Navigator.pushNamed(context, PinVerificationScreen.name);
                  }
                }, child: Text('Next')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

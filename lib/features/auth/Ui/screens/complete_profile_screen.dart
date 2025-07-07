import 'package:ecommerceapp/features/auth/Ui/screens/pin_verfication_screen.dart';
import 'package:ecommerceapp/features/auth/Ui/widgets/app_icon_widget.dart';
import 'package:flutter/material.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({super.key});

  static const String name = '/complete_profile_screen';

  @override
  State<CompleteProfileScreen> createState() =>
      _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  final TextEditingController _firstNameTEController=TextEditingController();
  final TextEditingController _lastNameTEController=TextEditingController();
  final TextEditingController _mobileTEController=TextEditingController();
  final TextEditingController _cityTEController=TextEditingController();
  final TextEditingController _shippingAddressTEController=TextEditingController();
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
                Text('Complete Profile', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 10),
                Text(
                  'Get started with us with your details',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(color: Colors.grey),
                ),
                const SizedBox(height: 24,),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _firstNameTEController,
                  validator: (String? value){
                    if(value?.isEmpty ?? true){
                      return 'Enter Your First Name';
                    }
                    return null;
                  },
                  decoration: InputDecoration(hintText: "First Name"),
                ),
                SizedBox(height: 24,),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _lastNameTEController,
                  validator: (String? value){
                    if(value?.isEmpty ?? true){
                      return 'Enter Your last Name';
                    }
                    return null;
                  },
                  decoration: InputDecoration(hintText: "Last Name"),
                ),
                SizedBox(height: 24,),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.emailAddress,
                  controller: _mobileTEController,
                  maxLength: 11,
                  validator: (String? value){
                    if(value?.isEmpty ?? true){
                      return 'Enter your Mobile No';
                    }
                    if(RegExp(r'^(\+88)?01[3-9]\d{8}$').hasMatch(value!)==false){
                      return 'Enter a valid Mobile Number';
                    }
                    return null;
                  },
                  decoration: InputDecoration(hintText: "Mobile"),
                ),
                SizedBox(height: 24,),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _cityTEController,
                  validator: (String? value){
                    if(value?.isEmpty ?? true){
                      return 'Enter your City Name';
                    }
                    return null;
                  },
                  decoration: InputDecoration(hintText: "City"),
                ),
                SizedBox(height: 24,),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _shippingAddressTEController,
                  maxLines: 3,
                  validator: (String? value){
                    if(value?.isEmpty ?? true){
                      return 'Enter your Shipping Address';
                    }
                    return null;
                  },
                  decoration: InputDecoration(hintText: "Shipping Address"),
                ),
                SizedBox(height: 16),
                ElevatedButton(onPressed: () {
                  Navigator.pushNamed(context, PinVerificationScreen.name);
                }, child: Text('Complete')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

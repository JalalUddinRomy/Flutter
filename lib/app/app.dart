import 'package:ecommerceapp/app/app_theme_data.dart';
import 'package:ecommerceapp/app/controller_binders.dart';
import 'package:ecommerceapp/features/auth/Ui/screens/complete_profile_screen.dart';
import 'package:ecommerceapp/features/auth/Ui/screens/email_verification_screen.dart';
import 'package:ecommerceapp/features/auth/Ui/screens/pin_verfication_screen.dart';
import 'package:ecommerceapp/features/auth/Ui/screens/splesh_screen.dart';
import 'package:ecommerceapp/features/common/ui/screens/main_bottom_nav_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CraftyBay extends StatelessWidget {
  const CraftyBay({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: AppThemeData.lightThemeData,
      darkTheme: AppThemeData.darkThemeData,
      themeMode: ThemeMode.light,
      initialRoute: '/',
      initialBinding: ControllerBinders(),
      routes: {
        '/':(context)=>SpleshScreen(),
        EmailVerificationScreen.name:(context)=>const EmailVerificationScreen(),
        PinVerificationScreen.name:(context)=>const PinVerificationScreen(),
        CompleteProfileScreen.name:(context)=>const CompleteProfileScreen(),
        MainBottomNavScreen.name:(context)=>const MainBottomNavScreen()
      },
    );
  }
}

import 'package:ecommerceapp/app/app_theme_data.dart';
import 'package:ecommerceapp/app/controller_binders.dart';
import 'package:ecommerceapp/features/auth/Ui/screens/complete_profile_screen.dart';
import 'package:ecommerceapp/features/auth/Ui/screens/email_verification_screen.dart';
import 'package:ecommerceapp/features/auth/Ui/screens/pin_verfication_screen.dart';
import 'package:ecommerceapp/features/auth/Ui/screens/splesh_screen.dart';
import 'package:ecommerceapp/features/common/ui/screens/main_bottom_nav_screen.dart';
import 'package:ecommerceapp/features/products/ui/screens/products_item_screen.dart';
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
      onGenerateRoute: (RouteSettings setting){
        late Widget widget;
        if(setting.name==SpleshScreen.name){
          widget=SpleshScreen();
        }else if(setting.name==EmailVerificationScreen.name){
          widget =EmailVerificationScreen();
        }
        else if(setting.name==PinVerificationScreen.name){
          widget =PinVerificationScreen();
        }else if(setting.name==CompleteProfileScreen.name){
          widget =CompleteProfileScreen();
        }else if(setting.name==MainBottomNavScreen.name){
          widget =MainBottomNavScreen();
        }else if(setting.name==ProductsItemScreen.name){
          String name=setting.arguments as String;
          widget =ProductsItemScreen(CategoryTitle: name,);
        }
        return MaterialPageRoute(builder: (context){
          return widget;
        });
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_getx/controller_binders.dart';
import 'package:task_manager_getx/screens/add_new_task_screen.dart';
import 'package:task_manager_getx/screens/email_verification_screen.dart';
import 'package:task_manager_getx/screens/main_bottom_nav_bar.dart';
import 'package:task_manager_getx/screens/sign_in_screen.dart';
import 'package:task_manager_getx/screens/sign_up_screen.dart';
import 'package:task_manager_getx/screens/splesh_screen.dart';
import 'package:task_manager_getx/utils/appColor.dart';
class TodoApp extends StatefulWidget {
  const TodoApp({super.key});
  static final GlobalKey<NavigatorState> navigatorKey=GlobalKey<NavigatorState>();

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey:TodoApp.navigatorKey,
      theme:ThemeData(
        colorSchemeSeed: AppColor.themecolor,
        inputDecorationTheme:_inputDecorationTheme(),
        elevatedButtonTheme:_elevatedButtonThemeData()
      ),
      initialBinding: ControllerBinders(),
      initialRoute:'/',
      routes: {
        spleshScreen.name:(context)=>spleshScreen(),
        MainBottomNavBar.name:(context)=>MainBottomNavBar(),
        EmailVerificationScreen.name:(context)=>EmailVerificationScreen(),
        signUpScreen.name:(context)=>signUpScreen(),
        signInScreen.name:(context)=>signInScreen(),
        AddNewTaskScreen.name:(context)=>AddNewTaskScreen()

      },
    );
  }
}
ElevatedButtonThemeData _elevatedButtonThemeData(){
  return ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor:AppColor.themecolor,
      foregroundColor: Colors.white,
      padding:EdgeInsets.symmetric(horizontal: 16,vertical: 16),
      shape:RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8)
      ),
      fixedSize:Size.fromWidth(double.maxFinite)
    )
  );
}
InputDecorationTheme _inputDecorationTheme(){
  return InputDecorationTheme(
    fillColor: Colors.white,
    filled:true,
    hintStyle: TextStyle(
      fontWeight: FontWeight.w300
    ),
    border: _outlineBorder(),
    enabledBorder: _outlineBorder(),
    errorBorder: _outlineBorder(),
    focusedBorder: _outlineBorder(),
  );
}
OutlineInputBorder _outlineBorder(){
  return OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: BorderRadius.circular(8)
  );
}

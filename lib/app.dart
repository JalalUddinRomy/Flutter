import 'package:flutter/material.dart';
import 'package:todo_app/screens/splesh_screen.dart';
import 'package:todo_app/utils/appColor.dart';

class TodoApp extends StatefulWidget {
  const TodoApp({super.key});
  static final GlobalKey<NavigatorState> navigatorKey=GlobalKey<NavigatorState>();

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey:TodoApp.navigatorKey,
      theme:ThemeData(
        colorSchemeSeed: AppColor.themecolor,
        inputDecorationTheme:_inputDecorationTheme(),
        elevatedButtonTheme:_elevatedButtonThemeData()
      ),
      home: const spleshScreen(),
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

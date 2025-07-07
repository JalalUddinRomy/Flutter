import 'package:ecommerceapp/app/app_color.dart';
import 'package:flutter/material.dart';

class AppThemeData {
  static ThemeData get lightThemeData {
    return ThemeData(
      colorSchemeSeed: AppColor.themeColor,
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: AppColor.themeColor,
      ),
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: AppBarTheme(backgroundColor: Colors.white),
      textTheme: TextTheme(
        titleLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
      ),
      inputDecorationTheme: InputDecorationTheme(
        fillColor: Colors.white,
        filled: true,
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.themeColor, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.themeColor, width: 1),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.themeColor, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.themeColor, width: 1),
        ),
        hintStyle: TextStyle(color: Colors.grey),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          textStyle: TextStyle(
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
          backgroundColor: AppColor.themeColor,
          foregroundColor: Colors.white,
          fixedSize: Size.fromWidth(double.maxFinite),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: EdgeInsets.symmetric(horizontal: 12),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
        )
      )
    );
  }

  static ThemeData get darkThemeData {
    return ThemeData(
      colorSchemeSeed: AppColor.themeColor,
      scaffoldBackgroundColor: Colors.black,
      brightness: Brightness.dark,
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: AppColor.themeColor,
      ),
    );
  }
}

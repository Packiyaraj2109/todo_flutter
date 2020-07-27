import 'package:flutter/material.dart';
import 'package:todo_flutter/src/assets/app_colors.dart';

ThemeData lightTheme() {
  return ThemeData(
    fontFamily: 'NotoSansJP-Medium',
    scaffoldBackgroundColor: AppColors.scaffoldBackgroundColor,
    primaryTextTheme: TextTheme(
      headline1: TextStyle(
        fontSize: 25,
        color: AppColors.textColor,
        fontWeight: FontWeight.bold,
      ),
      headline2: TextStyle(
          fontSize: 20,
          color: AppColors.textColor,
          fontWeight: FontWeight.bold),
      headline3: TextStyle(
          fontSize: 16,
          color: AppColors.textColor,
          fontWeight: FontWeight.bold),
      headline4: TextStyle(
        color: AppColors.boldtextColor,
        fontSize: 13,
        fontWeight: FontWeight.bold,
      ),
      bodyText1: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.bold,
      ),
      bodyText2: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.bold,
      ),
    ),
    textTheme: TextTheme(
      headline1: TextStyle(
        fontSize: 25,
        color: AppColors.textColor,
        fontWeight: FontWeight.bold,
      ),
      headline2: TextStyle(
          fontSize: 20,
          color: AppColors.textColor,
          fontWeight: FontWeight.bold),
      headline3: TextStyle(
          fontSize: 16,
          color: AppColors.textColor,
          fontWeight: FontWeight.bold),
      headline4: TextStyle(
        color: AppColors.boldtextColor,
        fontSize: 13,
        fontWeight: FontWeight.bold,
      ),
      bodyText1: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.bold,
      ),
      bodyText2: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

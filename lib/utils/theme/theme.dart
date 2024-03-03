import 'package:flutter/material.dart';
import 'package:travel_app/utils/constants/colors.dart';
import 'package:travel_app/utils/theme/theme_widgets.dart/elevated_button.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Montserrat',
    brightness: Brightness.light,
    primaryColor: MyColors.primary,
    scaffoldBackgroundColor: MyColors.light,
    elevatedButtonTheme: MyElevatedButtonTheme.lightlevatedButtonThemeData,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Montserrat',
    brightness: Brightness.dark,
    primaryColor: MyColors.primary,
    elevatedButtonTheme: MyElevatedButtonTheme.darklevatedButtonThemeData,
  );
}

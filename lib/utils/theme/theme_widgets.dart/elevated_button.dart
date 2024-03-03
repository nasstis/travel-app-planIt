import 'package:flutter/material.dart';
import 'package:travel_app/utils/constants/colors.dart';

class MyElevatedButtonTheme {
  MyElevatedButtonTheme._();

  static ElevatedButtonThemeData lightlevatedButtonThemeData =
      ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: MyColors.primary,
      foregroundColor: MyColors.light,
      disabledBackgroundColor: MyColors.buttonDisabled,
      elevation: 0,
      textStyle: const TextStyle(
          fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
    ),
  );

  static ElevatedButtonThemeData darklevatedButtonThemeData =
      ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: MyColors.primary,
      foregroundColor: MyColors.light,
      disabledBackgroundColor: MyColors.buttonDisabled,
      elevation: 0,
      textStyle: const TextStyle(
          fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:travel_app/utils/constants/colors.dart';

class MySwitchTheme {
  MySwitchTheme._();

  static SwitchThemeData lightSwitchThemeData = SwitchThemeData(
    trackColor: MaterialStateProperty.resolveWith(
      (final Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return null;
        }
        return const Color(0xFFDBDADA);
      },
    ),
    trackOutlineColor: MaterialStateProperty.resolveWith(
      (final Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return MyColors.primary;
        }
        return const Color(0xFFDBDADA);
      },
    ),
  );
}

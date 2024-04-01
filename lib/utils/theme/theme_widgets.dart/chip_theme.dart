import 'package:flutter/material.dart';
import 'package:travel_app/utils/constants/colors.dart';

class MyChipTheme {
  MyChipTheme._();

  static ChipThemeData lightChipThemeData = ChipThemeData(
    backgroundColor: MyColors.primary.withOpacity(0.2),
    labelStyle:
        const TextStyle(color: MyColors.primary, fontWeight: FontWeight.w500),
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    side: BorderSide.none,
    elevation: 3,
    shadowColor: MyColors.darkPrimary,
  );

  static ChipThemeData darkChipThemeData = ChipThemeData(
    backgroundColor: MyColors.primary.withOpacity(0.2),
    labelStyle:
        const TextStyle(color: MyColors.primary, fontWeight: FontWeight.w500),
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    side: BorderSide.none,
    elevation: 3,
    shadowColor: MyColors.darkPrimary,
  );
}

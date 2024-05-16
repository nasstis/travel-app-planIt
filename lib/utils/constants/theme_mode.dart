import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyThemeMode {
  static Future<ThemeMode> getPrefsThemeMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    ThemeMode themeMode;
    if (prefs.getString('themeMode') != null) {
      themeMode = prefs.getString('themeMode') == 'dark'
          ? ThemeMode.dark
          : ThemeMode.light;
    } else {
      themeMode = ThemeMode.system;
    }
    return themeMode;
  }

  static late ThemeMode myThemeMode;

  static Future<void> initialize() async {
    myThemeMode = await getPrefsThemeMode();
  }

  static bool get isDark =>
      myThemeMode == ThemeMode.dark ||
      myThemeMode == ThemeMode.system &&
          SchedulerBinding.instance.platformDispatcher.platformBrightness ==
              Brightness.dark;
}

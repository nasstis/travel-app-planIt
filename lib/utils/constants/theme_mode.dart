import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class MyThemeMode {
  static final isDark =
      SchedulerBinding.instance.platformDispatcher.platformBrightness ==
          Brightness.dark;
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_app/utils/constants/theme_mode.dart';

part 'theme_event.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeMode> {
  SharedPreferences? prefs;
  ThemeBloc() : super(MyThemeMode.myThemeMode) {
    on<ChangeTheme>((event, emit) async {
      prefs = await SharedPreferences.getInstance();
      prefs!.setString('themeMode', event.isDark ? 'light' : 'dark');
      MyThemeMode.myThemeMode = event.isDark ? ThemeMode.light : ThemeMode.dark;
      emit(event.isDark ? ThemeMode.light : ThemeMode.dark);
    });
  }
}

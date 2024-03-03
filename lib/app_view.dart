import 'package:flutter/material.dart';
import 'package:travel_app/screens/auth/views/welcome_screen.dart';
import 'package:travel_app/screens/home/views/home_screen.dart';
import 'package:travel_app/utils/theme/theme.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: const WelcomeScreen(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/blocs/auth_bloc/auth_bloc.dart';
import 'package:travel_app/screens/auth/blocs/sign_in_bloc/sign_in_bloc.dart';
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
      home: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state.status == AuthStatus.authenticated) {
            return BlocProvider(
              create: (context) => SignInBloc(
                context.read<AuthBloc>().userRepository,
              ),
              child: const HomeScreen(),
            );
          } else if (state.status == AuthStatus.unknown) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return const WelcomeScreen();
          }
        },
      ),
    );
  }
}

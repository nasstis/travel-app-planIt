import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/blocs/auth_bloc/auth_bloc.dart';
import 'package:travel_app/screens/auth/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:travel_app/screens/auth/components/forgot_password_component.dart';
import 'package:travel_app/utils/constants/colors.dart';
import 'package:travel_app/utils/constants/theme_mode.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyThemeMode.isDark ? MyColors.dark : MyColors.white,
      appBar: AppBar(
        title: const Text('Reset password'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 120),
          Center(
            child: BlocProvider<SignInBloc>(
              create: (context) =>
                  SignInBloc(context.read<AuthBloc>().userRepository),
              child: const ForgotPasswordComponent(),
            ),
          ),
        ],
      ),
    );
  }
}

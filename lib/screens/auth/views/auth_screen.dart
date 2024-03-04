import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/blocs/auth_bloc/auth_bloc.dart';
import 'package:travel_app/screens/auth/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:travel_app/screens/auth/blocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:travel_app/screens/auth/components/forgot_password_component.dart';
import 'package:travel_app/screens/auth/components/sign_in_component.dart';
import 'package:travel_app/screens/auth/components/sign_up_component.dart';
import 'package:travel_app/utils/constants/text_strings.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key, required this.screen});

  final String screen;

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              Column(
                children: [
                  Container(
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/7.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height - 250,
                  )
                ],
              ),
              Positioned(
                top: 200,
                child: Container(
                  height: MediaQuery.of(context).size.height - 185,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.white),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 80,
                      ),
                      if (widget.screen == MyTexts.signIn)
                        BlocProvider<SignInBloc>(
                          create: (context) => SignInBloc(
                              context.read<AuthBloc>().userRepository),
                          child: const SignInComponent(),
                        ),
                      if (widget.screen == MyTexts.signUp)
                        BlocProvider<SignUpBloc>(
                          create: (context) => SignUpBloc(
                              context.read<AuthBloc>().userRepository),
                          child: const SignUpComponent(),
                        ),
                      if (widget.screen == MyTexts.forgotPassword)
                        BlocProvider<SignInBloc>(
                          create: (context) => SignInBloc(
                              context.read<AuthBloc>().userRepository),
                          child: const ForgotPasswordComponent(),
                        ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 70,
                right: 5,
                child: Image.asset(
                  'assets/images/8.png',
                  height: 200,
                ),
              ),
            ],
          )
        ],
      ),
    ));
  }
}

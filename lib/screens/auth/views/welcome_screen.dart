import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/blocs/auth_bloc/auth_bloc.dart';
import 'package:travel_app/screens/auth/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:travel_app/screens/auth/blocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:travel_app/screens/auth/views/sign_in_screen.dart';
import 'package:travel_app/screens/auth/views/sign_up_screen.dart';
import 'package:travel_app/utils/constants/colors.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            children: [
              SizedBox(height: 170),
              Text(
                'Let\'s enjoy',
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'your Vacation!',
                style: TextStyle(
                  fontSize: 31,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider(
                        create: (context) =>
                            SignInBloc(context.read<AuthBloc>().userRepository),
                        child: const SignInScreen(),
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(fixedSize: const Size(160, 45)),
                child: const Text('Sign In'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider(
                        create: (context) => SignUpBloc(
                          context.read<AuthBloc>().userRepository,
                        ),
                        child: const SignUpScreen(),
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: MyColors.secondary,
                    fixedSize: const Size(160, 45)),
                child: const Text('Sign Up'),
              ),
            ],
          ),
          Image.asset(
            'assets/images/6.png',
          ),
        ],
      ),
    );
  }
}

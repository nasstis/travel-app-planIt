import 'package:flutter/material.dart';
import 'package:travel_app/screens/auth/views/auth_screen.dart';
import 'package:travel_app/utils/constants/colors.dart';
import 'package:travel_app/utils/constants/text_strings.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void chooseScreen(String screen) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AuthScreen(
            screen: screen,
          ),
        ),
      );
    }

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
                  chooseScreen(MyTexts.signIn);
                },
                style: ElevatedButton.styleFrom(fixedSize: const Size(160, 45)),
                child: const Text(MyTexts.signIn),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  chooseScreen(MyTexts.signUp);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: MyColors.secondary,
                    fixedSize: const Size(160, 45)),
                child: const Text(MyTexts.signUp),
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

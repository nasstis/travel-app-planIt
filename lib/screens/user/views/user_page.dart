import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/blocs/auth_bloc/auth_bloc.dart';
import 'package:travel_app/screens/user/components/profile_button.dart';
import 'package:travel_app/screens/user/components/user_profile_top_part.dart';
import 'package:travel_app/utils/constants/colors.dart';
import 'package:travel_app/utils/constants/rank.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state.status == AuthStatus.authenticated) {
          return Column(
            children: [
              UserProfileTop(user: state.user!),
              Stack(
                children: [
                  const SizedBox(
                    width: 310,
                    height: 80,
                  ),
                  Positioned(
                    top: 47,
                    child: Container(
                      width: 280,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: const LinearGradient(
                          colors: [
                            MyColors.primary,
                            MyColors.lightPrimary,
                            Color(0xffD6D6D6),
                          ],
                          stops: [
                            0.55 / 2,
                            0.55,
                            0.55,
                          ],
                        ),
                      ),
                      child: const SizedBox(height: 15),
                    ),
                  ),
                  Positioned(
                    right: -5,
                    top: 30,
                    child: Image.asset(
                      Rank.ranks[1],
                      height: 50,
                    ),
                  ),
                  const Positioned(
                    top: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Your progress',
                          style: TextStyle(
                            color: Color(0xFFA4A0B1),
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '45% to next Rank',
                          style: TextStyle(
                            color: MyColors.primary,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const ProfileButton(
                icon: CupertinoIcons.heart,
                text: 'Your Favorites',
              ),
              const SizedBox(height: 5),
              const ProfileButton(
                icon: CupertinoIcons.profile_circled,
                text: 'Edit Profile',
              ),
              const SizedBox(height: 5),
              const ProfileButton(
                icon: Icons.sunny,
                text: 'Theme Mode',
              ),
              const SizedBox(height: 5),
              const Divider(),
              const ProfileButton(
                icon: Icons.info,
                text: 'Info',
                info: true,
              ),
              const SizedBox(height: 5),
              const ProfileButton(
                icon: Icons.logout,
                text: 'Log out',
                logout: true,
              ),
            ],
          );
        }
        return const SizedBox();
      },
    );
  }
}

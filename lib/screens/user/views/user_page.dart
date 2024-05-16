import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_app/blocs/auth_bloc/auth_bloc.dart';
import 'package:travel_app/blocs/theme_bloc/theme_bloc.dart';
import 'package:travel_app/screens/auth/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:travel_app/screens/user/components/profile_button.dart';
import 'package:travel_app/screens/user/components/user_profile_top_part.dart';
import 'package:travel_app/utils/constants/colors.dart';
import 'package:travel_app/utils/constants/rank.dart';
import 'package:travel_app/utils/constants/routes_names.dart';
import 'package:travel_app/utils/constants/theme_mode.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
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
                      Rank.ranks[3],
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
              ProfileButton(
                icon: CupertinoIcons.heart,
                text: 'Your Favorites',
                onPressed: () {},
              ),
              const SizedBox(height: 5),
              ProfileButton(
                icon: CupertinoIcons.profile_circled,
                text: 'Edit Profile',
                onPressed: () {
                  context.push(PageName.editProfileRoute, extra: state.user!);
                },
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: ProfileButton(
                      icon: Icons.dark_mode,
                      text: 'Dark theme',
                      onPressed: () {},
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: SizedBox(
                      height: MyThemeMode.isDark ? 30 : 35,
                      child: FittedBox(
                        fit: BoxFit.cover,
                        child: Switch(
                          value: MyThemeMode.isDark,
                          onChanged: (value) {
                            context
                                .read<ThemeBloc>()
                                .add(ChangeTheme(MyThemeMode.isDark));
                          },
                          inactiveThumbColor: const Color(0xFF7159C2),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              const Divider(),
              ProfileButton(
                icon: Icons.info,
                text: 'Info',
                info: true,
                onPressed: () {},
              ),
              const SizedBox(height: 5),
              ProfileButton(
                icon: Icons.logout,
                text: 'Log out',
                logout: true,
                onPressed: () {
                  context.read<SignInBloc>().add(SignOutRequired());
                  context.go(PageName.initRoute);
                },
              ),
            ],
          );
        }
        return const SizedBox();
      },
    );
  }
}

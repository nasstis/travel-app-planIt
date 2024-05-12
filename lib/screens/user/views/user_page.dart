import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/blocs/auth_bloc/auth_bloc.dart';
import 'package:travel_app/screens/user/components/profile_button.dart';
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
              const SizedBox(height: 80),
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.25,
                  ),
                  Positioned(
                    top: 23,
                    child: Container(
                      height: MediaQuery.of(context).size.width * 0.28,
                      width: MediaQuery.of(context).size.width * 0.28,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(state.user!.photo),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.width * 0.39,
                    width: MediaQuery.of(context).size.width * 0.39,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage(
                        Rank.frames[0],
                      ),
                      fit: BoxFit.cover,
                    )),
                  ),
                  Positioned(
                    top: 148,
                    child: Column(
                      children: [
                        Text(
                          state.user!.name,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          state.user!.email,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(),
              Stack(
                children: [
                  Material(
                    elevation: 8,
                    borderRadius: BorderRadius.circular(25),
                    child: Container(
                      height: 30,
                      width: MediaQuery.of(context).size.width * 0.43,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        gradient: const RadialGradient(
                          colors: [
                            Color(0xFFFFF5E8),
                            Color(0xFFFFEACD),
                          ],
                          radius: 4,
                          stops: [0.2, 0.9],
                        ),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 50),
                          Text(
                            Rank.rankNames[0],
                            style: const TextStyle(
                              color: Color(0xF23D3121),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Image.asset(
                    Rank.badges[0],
                    height: 53,
                  ),
                ],
              ),
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

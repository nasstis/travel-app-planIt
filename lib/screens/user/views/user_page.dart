import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/blocs/auth_bloc/auth_bloc.dart';
import 'package:travel_app/screens/user/components/profile_button.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state.status == AuthStatus.authenticated) {
          return Column(
            children: [
              const SizedBox(height: 100),
              Container(
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
              const SizedBox(height: 15),
              Text(
                state.user!.name,
                style: const TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                state.user!.email,
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 200),
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

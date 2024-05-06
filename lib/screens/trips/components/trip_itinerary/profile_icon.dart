import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app/utils/constants/colors.dart';

class ProfileIcon extends StatelessWidget {
  const ProfileIcon({
    super.key,
    required this.profile,
    required this.icon,
    required this.onPressed,
    required this.currentProfile,
  });

  final String profile;
  final String currentProfile;
  final void Function() onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: FaIcon(
        icon,
        color: currentProfile == profile ? MyColors.primary : null,
        size: currentProfile == profile ? 30 : null,
      ),
    );
  }
}

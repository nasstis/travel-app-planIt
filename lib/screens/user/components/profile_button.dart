import 'package:flutter/material.dart';
import 'package:travel_app/utils/constants/colors.dart';

class ProfileButton extends StatelessWidget {
  const ProfileButton({
    super.key,
    required this.icon,
    required this.text,
    this.logout = false,
    this.info = false,
    required this.onPressed,
  });

  final IconData icon;
  final String text;
  final bool logout;
  final bool info;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: logout
            ? MyColors.red
            : info
                ? MyColors.lightGrey
                : null,
      ),
      label: Text(
        text,
        style: TextStyle(
          color: logout
              ? MyColors.red
              : info
                  ? MyColors.lightGrey
                  : null,
          fontWeight: FontWeight.w600,
          fontSize: 15,
        ),
      ),
      style: TextButton.styleFrom(
          fixedSize: Size.fromWidth(MediaQuery.of(context).size.width),
          padding: const EdgeInsets.only(left: 30),
          alignment: Alignment.centerLeft),
    );
  }
}

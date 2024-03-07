import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app/utils/constants/colors.dart';

class InfoComponents extends StatelessWidget {
  const InfoComponents({super.key, required this.text, required this.icon});

  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 50,
          width: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: MyColors.grey.withOpacity(0.2),
          ),
          child: FaIcon(
            icon,
            size: 20,
            color: MyColors.primary,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.w500),
        )
      ],
    );
  }
}

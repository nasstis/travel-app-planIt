import 'package:flutter/material.dart';
import 'package:travel_app/utils/constants/colors.dart';

class StarDisplay extends StatelessWidget {
  const StarDisplay({super.key, required this.rating, required this.size});

  final double rating;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(5, (index) {
        return Icon(
          index < rating.floor()
              ? Icons.star
              : index == rating.floor() && rating - index >= 0.5
                  ? Icons.star_half
                  : Icons.star_border,
          color: MyColors.accent,
          size: size,
        );
      }),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travel_app/utils/constants/colors.dart';
import 'package:travel_app/utils/helpers/widget_to_map_icon.dart';

Future<BitmapDescriptor> getCustomIcon(int index) async {
  return Stack(children: [
    const FaIcon(
      FontAwesomeIcons.locationPin,
      size: 34,
      color: MyColors.primary,
    ),
    Positioned(
      left: index == 11
          ? 5
          : index > 9
              ? 4
              : index == 1
                  ? 8
                  : 7.8,
      top: 4,
      child: Text(
        '$index',
        style: const TextStyle(
          color: MyColors.light,
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
    )
  ]).toBitmapDescriptor();
}

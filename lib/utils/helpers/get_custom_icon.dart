import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travel_app/utils/constants/colors.dart';
import 'package:travel_app/utils/helpers/widget_to_map_icon.dart';

Future<BitmapDescriptor> getCustomIcon(int index, int length) async {
  const String assetNameLeftLocation =
      'assets/icons/left-half-location-pin-solid-svg.svg';
  const String assetNameRightLocation =
      'assets/icons/right-half-location-pin-solid-svg.svg';
  return Stack(children: [
    Stack(
      // mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          height: 35,
          width: 25,
        ),
        Positioned(
          left: 0,
          child: SvgPicture.asset(
            assetNameLeftLocation,
            colorFilter: ColorFilter.mode(
                index == 1
                    ? MyColors.primary
                    : MyColors.colorsForMap[index - 2],
                BlendMode.srcIn),
            height: 35,
          ),
        ),
        Positioned(
          right: 0,
          child: SvgPicture.asset(
            assetNameRightLocation,
            colorFilter: ColorFilter.mode(
                index == 1
                    ? MyColors.primary
                    : index == length
                        ? MyColors.colorsForMap[index - 2]
                        : MyColors.colorsForMap[index - 1],
                BlendMode.srcIn),
            height: 35,
          ),
        ),
      ],
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
          fontSize: 16,
          fontWeight: FontWeight.w800,
        ),
      ),
    )
  ]).toBitmapDescriptor();
}

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travel_app/utils/constants/colors.dart';
import 'package:travel_app/utils/constants/theme_mode.dart';

import '../../city/views/map_view.dart';

class TripMapScreen extends StatelessWidget {
  const TripMapScreen({super.key, required this.places});

  final List places;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: MyThemeMode.isDark
            ? MyColors.dark.withOpacity(0.5)
            : MyColors.light.withOpacity(0.5),
      ),
      body: Stack(
        children: [
          MapView(
            latLng: LatLng(places[0].latitude, places[0].longitude),
            zoomControlsEnabled: true,
            mapType: MapType.normal,
            places: places,
            isItinerary: false,
          ),
        ],
      ),
    );
  }
}

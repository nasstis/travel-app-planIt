import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travel_app/utils/constants/colors.dart';

import '../../city/views/map_view.dart';

class TripMapScreen extends StatelessWidget {
  const TripMapScreen({super.key, required this.extra});

  final Map<String, dynamic> extra;

  @override
  Widget build(BuildContext context) {
    final List places = extra['places'];
    final bool isItinerary = extra['isItinerary'];
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: MyColors.light.withOpacity(0.5),
      ),
      body: MapView(
        latLng: LatLng(places[0].latitude, places[0].longitude),
        zoomControlsEnabled: true,
        mapType: MapType.normal,
        places: places,
        isItinerary: isItinerary,
      ),
    );
  }
}

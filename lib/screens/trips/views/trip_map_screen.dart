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
    double? distance;
    double? duration;
    if (isItinerary) {
      distance = 2163.196;
      duration = 1521.802;
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: MyColors.light.withOpacity(0.5),
      ),
      body: Stack(
        children: [
          MapView(
            latLng: LatLng(places[0].latitude, places[0].longitude),
            zoomControlsEnabled: true,
            mapType: MapType.normal,
            places: places,
            isItinerary: isItinerary,
          ),
          if (isItinerary)
            Positioned(
              top: 120,
              left: 135,
              child: Material(
                borderRadius: BorderRadius.circular(15),
                elevation: 7,
                child: Container(
                  width: 140,
                  height: 32,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: MyColors.primary,
                  ),
                  child: Center(
                    child: Text(
                      '${(distance! / 1000).toStringAsFixed(1)} km, ${(duration! / 60).toStringAsFixed(0)} mins',
                      style: const TextStyle(
                        fontSize: 14,
                        color: MyColors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

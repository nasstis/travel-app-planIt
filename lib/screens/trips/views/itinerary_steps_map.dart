import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travel_app/screens/trips/blocs/route_bloc/route_bloc.dart';
import 'package:travel_app/screens/trips/components/trip_itinerary/profile_icon.dart';
import 'package:travel_app/utils/constants/colors.dart';

import '../../city/views/map_view.dart';

class ItineraryStepsMap extends StatefulWidget {
  const ItineraryStepsMap(
      {super.key,
      required this.places,
      required this.tripId,
      required this.day});

  final List places;
  final String tripId;
  final String day;

  @override
  State<ItineraryStepsMap> createState() => _ItineraryStepsMapState();
}

class _ItineraryStepsMapState extends State<ItineraryStepsMap> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    Set<Polyline> polylines = <Polyline>{};
    List polylineLegs = [];
    int polylineIdCounter = 1;

    void setPolyline(decodedPolyline) {
      final String polylineIdVal = 'polyline_$polylineIdCounter';
      polylineIdCounter++;

      polylines.add(
        Polyline(
          polylineId: PolylineId(polylineIdVal),
          width: 7,
          color: MyColors.primary,
          points: decodedPolyline!
              .map<LatLng>(
                (point) => LatLng(point.latitude, point.longitude),
              )
              .toList(),
        ),
      );
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: MyColors.light.withOpacity(0.5),
      ),
      body: BlocBuilder<RouteBloc, RouteState>(
        builder: (context, state) {
          if (state is GetRouteStepSuccess) {
            log('INDEX AAAAAAAAAAAAAAAAA $index');

            polylineLegs.add(state.leg.geometry
                .map(
                  (e) => PolylinePoints().decodePolyline(e),
                )
                .toList());
            for (var polylineLeg in polylineLegs) {
              for (var decodedPolyline in polylineLeg!) {
                setPolyline(decodedPolyline);
              }
            }
            return Stack(
              children: [
                MapView(
                  latLng: LatLng(widget.places[index].latitude,
                      widget.places[index].longitude),
                  zoomControlsEnabled: true,
                  mapType: MapType.normal,
                  places: widget.places,
                  isItinerary: true,
                  polylines: polylines,
                  zoom: 17,
                ),
                Positioned(
                  top: 110,
                  left: 140,
                  child: Material(
                    borderRadius: BorderRadius.circular(15),
                    elevation: 7,
                    child: Container(
                      width: 150,
                      height: 32,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: MyColors.primary,
                      ),
                      child: Center(
                        child: Text(
                          '${(state.leg.distance / 1000).toStringAsFixed(1)} km, ${(state.leg.duration / 60).toStringAsFixed(0)} mins',
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
                Positioned(
                  bottom: 80,
                  left: 160,
                  child: ElevatedButton(
                    onPressed: widget.places.length == index + 2
                        ? () {}
                        : () {
                            setState(() {});
                            context.read<RouteBloc>().add(
                                  GetRouteStep(widget.tripId, widget.day,
                                      state.leg.profile, ++index),
                                );
                          },
                    child: widget.places.length == (index + 2)
                        ? const Text('Done')
                        : const Text('Next place'),
                  ),
                ),
                Positioned(
                  top: 110,
                  right: 10,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: MyColors.light.withOpacity(0.6),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ProfileIcon(
                          profile: 'cycling',
                          currentProfile: state.leg.profile,
                          onPressed: () {
                            setState(() {});
                            context.read<RouteBloc>().add(
                                  GetRouteStep(widget.tripId, widget.day,
                                      'cycling', index),
                                );
                          },
                          icon: FontAwesomeIcons.personBiking,
                        ),
                        ProfileIcon(
                          profile: 'walking',
                          currentProfile: state.leg.profile,
                          onPressed: () {
                            setState(() {});
                            context.read<RouteBloc>().add(
                                  GetRouteStep(widget.tripId, widget.day,
                                      'walking', index),
                                );
                          },
                          icon: FontAwesomeIcons.personWalking,
                        ),
                        ProfileIcon(
                          profile: 'driving',
                          currentProfile: state.leg.profile,
                          onPressed: () {
                            setState(() {});
                            context.read<RouteBloc>().add(
                                  GetRouteStep(widget.tripId, widget.day,
                                      'driving', index),
                                );
                          },
                          icon: FontAwesomeIcons.car,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            );
          }
          if (state is GetRouteLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return const Center();
        },
      ),
    );
  }
}

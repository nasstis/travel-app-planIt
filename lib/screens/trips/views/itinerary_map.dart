import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travel_app/screens/trips/blocs/route_bloc/route_bloc.dart';
import 'package:travel_app/screens/trips/components/trip_itinerary/profile_icon.dart';
import 'package:travel_app/utils/constants/colors.dart';
import 'package:travel_app/utils/constants/routes_names.dart';

import '../../city/views/map_view.dart';

class ItineraryMap extends StatefulWidget {
  const ItineraryMap({
    super.key,
    required this.places,
    required this.hasOnePlace,
  });

  final List places;

  final bool hasOnePlace;

  @override
  State<ItineraryMap> createState() => _ItineraryMapState();
}

class _ItineraryMapState extends State<ItineraryMap> {
  @override
  Widget build(BuildContext context) {
    Set<Polyline> polylines = <Polyline>{};
    List polylineLegs = [];
    int polylineIdCounter = 1;
    int colorsCounter = 0;

    void setPolyline(decodedPolyline, color) {
      final String polylineIdVal = 'polyline_$polylineIdCounter';
      polylineIdCounter++;

      polylines.add(
        Polyline(
          polylineId: PolylineId(polylineIdVal),
          width: 7,
          color: color,
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
      body: widget.hasOnePlace
          ? MapView(
              latLng:
                  LatLng(widget.places[0].latitude, widget.places[0].longitude),
              zoomControlsEnabled: true,
              mapType: MapType.normal,
              places: widget.places,
              isItinerary: true,
              zoom: 14,
            )
          : BlocBuilder<RouteBloc, RouteState>(
              builder: (context, state) {
                if (state is GetRouteSuccess) {
                  for (var leg in state.route.legs) {
                    polylineLegs.add(leg.geometry
                        .map(
                          (e) => PolylinePoints().decodePolyline(e),
                        )
                        .toList());
                  }
                  for (var polylineLeg in polylineLegs) {
                    for (var decodedPolyline in polylineLeg!) {
                      setPolyline(decodedPolyline,
                          MyColors.colorsForMap[colorsCounter]);
                    }
                    colorsCounter++;
                  }

                  return Stack(
                    children: [
                      MapView(
                        latLng: LatLng(widget.places[0].latitude,
                            widget.places[0].longitude),
                        zoomControlsEnabled: true,
                        mapType: MapType.normal,
                        places: widget.places,
                        isItinerary: true,
                        polylines: polylines,
                        zoom: 13,
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
                                '${(state.route.distance / 1000).toStringAsFixed(1)} km, ${(state.route.duration / 60).toStringAsFixed(0)} mins',
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
                        left: 140,
                        child: ElevatedButton(
                          onPressed: () {
                            context.pushReplacement(PageName.itineraryStepsMap,
                                extra: {
                                  'places': widget.places,
                                  'tripId': state.route.tripId,
                                  'day': state.route.day,
                                  'profile': state.route.profile,
                                });
                          },
                          child: const Text('Start itinerary'),
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
                                currentProfile: state.route.profile,
                                onPressed: () {
                                  setState(() {});
                                  context.read<RouteBloc>().add(
                                        GetRoute(state.route.tripId,
                                            state.route.day, 'cycling'),
                                      );
                                },
                                icon: FontAwesomeIcons.personBiking,
                              ),
                              ProfileIcon(
                                profile: 'walking',
                                currentProfile: state.route.profile,
                                onPressed: () {
                                  setState(() {});
                                  context.read<RouteBloc>().add(
                                        GetRoute(state.route.tripId,
                                            state.route.day, 'walking'),
                                      );
                                },
                                icon: FontAwesomeIcons.personWalking,
                              ),
                              ProfileIcon(
                                profile: 'driving',
                                currentProfile: state.route.profile,
                                onPressed: () {
                                  setState(() {});
                                  context.read<RouteBloc>().add(
                                        GetRoute(state.route.tripId,
                                            state.route.day, 'driving'),
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

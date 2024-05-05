import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travel_app/screens/trips/blocs/route_bloc/route_bloc.dart';
import 'package:travel_app/utils/constants/colors.dart';

import '../../city/views/map_view.dart';

class ItineraryMap extends StatefulWidget {
  const ItineraryMap({super.key, required this.places});

  final List places;

  @override
  State<ItineraryMap> createState() => _ItineraryMapState();
}

class _ItineraryMapState extends State<ItineraryMap> {
  @override
  Widget build(BuildContext context) {
    Set<Polyline> polylines = <Polyline>{};
    List polylineLegs = [];
    int polylineIdCounter = 1;

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

    int colorsCounter = 0;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: MyColors.light.withOpacity(0.5),
      ),
      body: BlocBuilder<RouteBloc, RouteState>(
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
                setPolyline(
                    decodedPolyline, MyColors.colorsForMap[colorsCounter]);
              }
              colorsCounter++;
            }
            return Stack(
              children: [
                MapView(
                  latLng: LatLng(
                      widget.places[0].latitude, widget.places[0].longitude),
                  zoomControlsEnabled: true,
                  mapType: MapType.normal,
                  places: widget.places,
                  isItinerary: true,
                  // polyline: state.route.geometry,
                  // legs: state.route.legs,
                  polylines: polylines,
                ),
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
                        IconButton(
                          onPressed: () {
                            setState(() {
                              <Polyline>{};
                              polylineLegs = [];
                              polylineIdCounter = 1;
                            });
                            context.read<RouteBloc>().add(
                                  GetRoute(state.route.tripId, state.route.day,
                                      'cycling'),
                                );
                          },
                          icon: FaIcon(
                            FontAwesomeIcons.personBiking,
                            color: state.route.profile == 'cycling'
                                ? MyColors.primary
                                : null,
                            size: state.route.profile == 'cycling' ? 28 : null,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              <Polyline>{};
                              polylineLegs = [];
                              polylineIdCounter = 1;
                            });
                            context.read<RouteBloc>().add(
                                  GetRoute(state.route.tripId, state.route.day,
                                      'walking'),
                                );
                          },
                          icon: FaIcon(
                            FontAwesomeIcons.personWalking,
                            color: state.route.profile == 'walking'
                                ? MyColors.primary
                                : null,
                            size: state.route.profile == 'walking' ? 30 : null,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              <Polyline>{};
                              polylineLegs = [];
                              polylineIdCounter = 1;
                            });
                            context.read<RouteBloc>().add(
                                  GetRoute(state.route.tripId, state.route.day,
                                      'driving'),
                                );
                          },
                          icon: FaIcon(
                            FontAwesomeIcons.car,
                            color: state.route.profile == 'driving'
                                ? MyColors.primary
                                : null,
                            size: state.route.profile == 'driving' ? 28 : null,
                          ),
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
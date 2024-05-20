import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travel_app/blocs/auth_bloc/auth_bloc.dart';
import 'package:travel_app/screens/trips/blocs/route_bloc/route_bloc.dart';
import 'package:travel_app/screens/trips/blocs/trip_calendar_bloc.dart/trip_calendar_bloc.dart';
import 'package:travel_app/screens/trips/components/trip_itinerary/profile_icon.dart';
import 'package:travel_app/utils/constants/colors.dart';
import 'package:travel_app/utils/constants/theme_mode.dart';
import 'package:trip_repository/trip_repository.dart';

import '../../city/views/map_view.dart';

class ItineraryStepsMap extends StatefulWidget {
  const ItineraryStepsMap(
      {super.key,
      required this.places,
      required this.tripId,
      required this.day,
      required this.startingRoute,
      required this.startingLocation,
      required this.profile});

  final List places;
  final String tripId;
  final String day;
  final Map<String, RouteLeg> startingRoute;
  final LatLng startingLocation;
  final String profile;

  @override
  State<ItineraryStepsMap> createState() => _ItineraryStepsMapState();
}

class _ItineraryStepsMapState extends State<ItineraryStepsMap> {
  int index = -1;
  late RouteLeg leg;
  late LatLng mapCenter;

  @override
  void initState() {
    leg = widget.startingRoute[widget.profile]!;
    mapCenter = widget.startingLocation;
    super.initState();
  }

  void changeStepProfile(String profile) {
    if (index == -1) {
      setState(() {
        leg = widget.startingRoute[profile]!;
      });
    }
    setState(() {});
    context.read<RouteBloc>().add(
          GetRouteStep(widget.tripId, widget.day, profile, index),
        );
  }

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

    log('INDEX $index');

    polylineLegs.add(leg.geometry
        .map(
          (e) => PolylinePoints().decodePolyline(e),
        )
        .toList());
    for (var polylineLeg in polylineLegs) {
      for (var decodedPolyline in polylineLeg!) {
        setPolyline(decodedPolyline);
      }
    }

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: MyThemeMode.isDark
              ? MyColors.dark.withOpacity(0.5)
              : MyColors.light.withOpacity(0.5),
        ),
        body: MultiBlocListener(
          listeners: [
            BlocListener<RouteBloc, RouteState>(
              listener: (context, state) {
                if (state is GetRouteStepSuccess) {
                  setState(() {
                    leg = state.leg;
                    mapCenter = LatLng(widget.places[index].latitude,
                        widget.places[index].longitude);
                  });
                }
              },
            ),
            BlocListener<TripCalendarBloc, TripCalendarState>(
              listener: (context, state) {
                if (state is FinishDayItinerarySuccess) {
                  context.pop();
                }
              },
            ),
          ],
          child: Stack(
            children: [
              MapView(
                latLng: mapCenter,
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
                        '//${(leg.distance / 1000).toStringAsFixed(1)} km, ${(leg.duration / 60).toStringAsFixed(0)} mins',
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
                      ? () {
                          context.read<TripCalendarBloc>().add(
                                FinishDayItinerary(widget.tripId, widget.day,
                                    context.read<AuthBloc>().state.user!),
                              );
                        }
                      : () {
                          setState(() {});
                          context.read<RouteBloc>().add(
                                GetRouteStep(widget.tripId, widget.day,
                                    leg.profile, ++index),
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
                    color: MyThemeMode.isDark
                        ? MyColors.dark.withOpacity(0.6)
                        : MyColors.light.withOpacity(0.6),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ProfileIcon(
                        profile: 'cycling',
                        currentProfile: leg.profile,
                        onPressed: () => changeStepProfile('cycling'),
                        icon: FontAwesomeIcons.personBiking,
                      ),
                      ProfileIcon(
                        profile: 'walking',
                        currentProfile: leg.profile,
                        onPressed: () => changeStepProfile('walking'),
                        icon: FontAwesomeIcons.personWalking,
                      ),
                      ProfileIcon(
                        profile: 'driving',
                        currentProfile: leg.profile,
                        onPressed: () => changeStepProfile('driving'),
                        icon: FontAwesomeIcons.car,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}

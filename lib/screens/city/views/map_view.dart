import 'dart:async';

import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:place_repository/place_repository.dart';
import 'package:travel_app/screens/city/blocs/get_places_bloc/get_places_bloc.dart';
import 'package:travel_app/screens/city/components/info_window.dart';
import 'package:travel_app/utils/constants/theme_mode.dart';
import 'package:travel_app/utils/helpers/get_custom_icon.dart';
import 'package:travel_app/utils/helpers/get_json.dart';
import 'package:travel_app/utils/helpers/get_user_location.dart';

class MapView extends StatefulWidget {
  const MapView(
      {super.key,
      required this.mapType,
      required this.zoomControlsEnabled,
      required this.latLng,
      this.places,
      required this.isItinerary,
      this.polylines,
      this.zoom});

  final LatLng latLng;
  final MapType mapType;
  final bool zoomControlsEnabled;
  final List? places;
  final bool isItinerary;
  final Set<Polyline>? polylines;
  final double? zoom;

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  int index = 0;
  late GoogleMapController mapController;
  final CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();
  final Set<Marker> _markers = {};
  final Completer<GoogleMapController> _controller = Completer();

  void changeMapMode(GoogleMapController mapController) {
    if (MyThemeMode.isDark) {
      getJsonFile("assets/styles/dark_map_style.json").then(
        (value) => mapController.setMapStyle(value),
      );
    } else {
      getJsonFile("assets/styles/map_style.json").then(
        (value) => mapController.setMapStyle(value),
      );
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    _customInfoWindowController.googleMapController = controller;
    changeMapMode(_customInfoWindowController.googleMapController!);
    _controller.complete(controller);
  }

  Future<void> _upsertMarker(Place place, int? index, int? length) async {
    BitmapDescriptor? customIcon;
    if (index != null) {
      customIcon = await getCustomIcon(index, length!, widget.zoom != null);
    }
    _markers.add(Marker(
      markerId: MarkerId(place.id),
      position: LatLng(place.latitude, place.longitude),
      onTap: () {
        _customInfoWindowController.addInfoWindow!(
          MyInfoWindow(
            selectedPlace: place,
            routingToPlaceAllowed: widget.places == null,
          ),
          LatLng(place.latitude, place.longitude),
        );
      },
      icon: customIcon ?? BitmapDescriptor.defaultMarkerWithHue(280),
    ));
  }

  Future<void> _addMarkers() async {
    int counter = 1;
    if (widget.isItinerary) {
      for (final place in widget.places!) {
        await _upsertMarker(place, counter, widget.places!.length);
        counter++;
      }
    } else {
      for (final place in widget.places!) {
        _upsertMarker(place, null, null);
      }
    }
    if (_markers.length == widget.places!.length) {
      setState(() {});
    }
  }

  void changeCameraPosition(LatLng position) async {
    CameraPosition cameraPosition =
        CameraPosition(target: position, zoom: widget.zoom ?? 13);

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  @override
  Widget build(BuildContext context) {
    Widget mainWidget = Stack(
      children: [
        GoogleMap(
          onMapCreated: _onMapCreated,
          mapType: widget.mapType,
          zoomControlsEnabled: widget.zoomControlsEnabled,
          initialCameraPosition: CameraPosition(
            target: widget.latLng,
            zoom: widget.zoom ?? 13,
          ),
          myLocationEnabled: widget.zoom != null,
          myLocationButtonEnabled: false,
          markers: _markers,
          polylines: widget.polylines ?? {},
          onTap: (_) {
            _customInfoWindowController.hideInfoWindow!();
          },
          onCameraMove: (_) {
            _customInfoWindowController.onCameraMove!();
          },
        ),
        CustomInfoWindow(
          controller: _customInfoWindowController,
          height: 140,
          width: 250,
        ),
        if (widget.zoom != null)
          Positioned(
            right: 6.8,
            bottom: 110,
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: const Color(0xFFfcfafa).withOpacity(0.75)),
              child: IconButton(
                onPressed: () {
                  getUserCurrentLocation().then((value) {
                    changeCameraPosition(
                        LatLng(value.latitude, value.longitude));
                  });
                },
                icon: const FaIcon(
                  FontAwesomeIcons.locationCrosshairs,
                  color: Color(0xFF666666),
                ),
              ),
            ),
          ),
      ],
    );

    if (index > 0) {
      changeCameraPosition(widget.latLng);
    }

    if (widget.places != null) {
      return FutureBuilder(
        future: _addMarkers(),
        builder: (context, snapshot) {
          index++;
          return mainWidget;
        },
      );
    } else {
      return BlocListener<GetPlacesBloc, GetPlacesState>(
          listener: (context, state) {
            if (state is GetPlacesSuccess) {
              for (final place in state.places) {
                _upsertMarker(place, null, null);
              }
              setState(() {});
            }
          },
          child: mainWidget);
    }
  }
}

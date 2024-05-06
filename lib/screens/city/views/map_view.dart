import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:place_repository/place_repository.dart';
import 'package:travel_app/screens/city/blocs/get_places_bloc/get_places_bloc.dart';
import 'package:travel_app/screens/city/components/info_window.dart';
import 'package:travel_app/utils/helpers/get_custom_icon.dart';
import 'package:travel_app/utils/helpers/get_json.dart';

class MapView extends StatefulWidget {
  const MapView(
      {super.key,
      required this.mapType,
      required this.zoomControlsEnabled,
      required this.latLng,
      this.places,
      required this.isItinerary,
      this.polylines,
      required this.zoom});

  final LatLng latLng;
  final MapType mapType;
  final bool zoomControlsEnabled;
  final List? places;
  final bool isItinerary;
  final Set<Polyline>? polylines;
  final double zoom;

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  late GoogleMapController mapController;
  final CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();
  final Set<Marker> _markers = {};

  void changeMapMode(GoogleMapController mapController) {
    getJsonFile("assets/styles/map_style.json").then(
      (value) => mapController.setMapStyle(value),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    _customInfoWindowController.googleMapController = controller;
    changeMapMode(_customInfoWindowController.googleMapController!);
  }

  void _upsertMarker(Place place, int? index, int? length) async {
    BitmapDescriptor? customIcon;
    if (index != null) {
      customIcon = await getCustomIcon(index, length!);
    }
    setState(() {
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
    });
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
            zoom: widget.zoom,
          ),
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
      ],
    );

    if (widget.places != null) {
      if (widget.isItinerary) {
        int counter = 1;

        for (final place in widget.places!) {
          _upsertMarker(place, counter, widget.places!.length);
          counter++;
        }
      } else {
        for (final place in widget.places!) {
          _upsertMarker(place, null, null);
        }
      }
      return mainWidget;
    } else {
      return BlocListener<GetPlacesBloc, GetPlacesState>(
          listener: (context, state) {
            if (state is GetPlacesSuccess) {
              for (final place in state.places) {
                _upsertMarker(place, null, null);
              }
            }
          },
          child: mainWidget);
    }
  }
}

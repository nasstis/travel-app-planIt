// import 'package:city_repository/city_repository.dart';
// import 'package:custom_info_window/custom_info_window.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:place_repository/place_repository.dart';
// import 'package:travel_app/screens/city/blocs/get_places_bloc/get_places_bloc.dart';
// import 'package:travel_app/screens/city/components/info_window.dart';
// import 'package:travel_app/utils/helpers/get_json.dart';

import 'package:city_repository/city_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:travel_app/screens/city/blocs/get_places_bloc/get_places_bloc.dart';

class MapView extends StatefulWidget {
  const MapView(
      {super.key,
      required this.city,
      // required this.mapType,
      required this.zoomControlsEnabled});

  final City city;
  // final MapType mapType;
  final bool zoomControlsEnabled;

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  // late GoogleMapController mapController;
  // final CustomInfoWindowController _customInfoWindowController =
  //     CustomInfoWindowController();
  // final Set<Marker> _markers = {};

  // void changeMapMode(GoogleMapController mapController) {
  //   getJsonFile("assets/styles/map_style.json").then(
  //     (value) => mapController.setMapStyle(value),
  //   );
  // }

  // void _onMapCreated(GoogleMapController controller) {
  //   _customInfoWindowController.googleMapController = controller;
  //   changeMapMode(_customInfoWindowController.googleMapController!);
  // }

  // void _upsertMarker(Place place) {
  //   setState(() {
  //     _markers.add(Marker(
  //       markerId: MarkerId(place.id),
  //       position: LatLng(place.latitude, place.longitude),
  //       onTap: () {
  //         _customInfoWindowController.addInfoWindow!(
  //           MyInfoWindow(
  //             cityName: widget.city.name,
  //             selectedPlace: place,
  //           ),
  //           LatLng(place.latitude, place.longitude),
  //         );
  //       },
  //       icon: BitmapDescriptor.defaultMarkerWithHue(280),
  //     ));
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GetPlacesBloc, GetPlacesState>(
      listener: (context, state) {
        if (state is GetPlacesSuccess) {
          // for (final place in state.places) {
          //   // _upsertMarker(place);
          // }
        }
      },
      child: Stack(
        children: [
          MapboxMap(
            accessToken: FlutterConfig.get('MAPBOX_ACCESS_TOKEN'),
            initialCameraPosition: CameraPosition(
                target: LatLng(widget.city.latitude, widget.city.longitude),
                zoom: 13),
          ),
          // GoogleMap(
          //   onMapCreated: _onMapCreated,
          //   mapType: widget.mapType,
          //   zoomControlsEnabled: widget.zoomControlsEnabled,
          //   initialCameraPosition: CameraPosition(
          //     target: LatLng(widget.city.latitude, widget.city.longitude),
          //     zoom: 12.0,
          //   ),
          //   markers: _markers,
          //   onTap: (_) {
          //     _customInfoWindowController.hideInfoWindow!();
          //   },
          //   onCameraMove: (_) {
          //     _customInfoWindowController.onCameraMove!();
          //   },
          // ),
          // CustomInfoWindow(
          //   controller: _customInfoWindowController,
          //   height: 150,
          //   width: 200,
          // ),
        ],
      ),
    );
  }
}

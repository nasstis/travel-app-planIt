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
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:place_repository/place_repository.dart';
// import 'package:flutter_config/flutter_config.dart';
// import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:travel_app/screens/city/blocs/get_places_bloc/get_places_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:travel_app/screens/city/components/info_window.dart';

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
  final List<Marker> _markers = [];

  void _upsertMarker(Place place) {
    setState(() {
      _markers.add(
        Marker(
          point: LatLng(place.latitude, place.longitude),
          width: 80,
          height: 80,
          child: InkWell(
            onTap: () {},
            child: const FaIcon(FontAwesomeIcons.locationDot),
          ),
        ),
      );
      // Marker(
      // markerId: MarkerId(place.id),
      // position: LatLng(place.latitude, place.longitude),
      // onTap: () {
      // _customInfoWindowController.addInfoWindow!(
      //   MyInfoWindow(
      //     cityName: widget.city.name,
      //     selectedPlace: place,
      //   ),
      //   LatLng(place.latitude, place.longitude),
      // );
      // },
      // icon: BitmapDescriptor.defaultMarkerWithHue(280),
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GetPlacesBloc, GetPlacesState>(
      listener: (context, state) {
        if (state is GetPlacesSuccess) {
          for (final place in state.places) {
            _upsertMarker(place);
          }
        }
      },
      child: Stack(
        children: [
          FlutterMap(
            mapController: MapController(),
            options: MapOptions(
                initialCenter:
                    LatLng(widget.city.latitude, widget.city.longitude),
                initialZoom: 14),
            children: [
              TileLayer(
                urlTemplate:
                    'https://api.mapbox.com/styles/v1/nastis22/cluv4a8ka005y01qx0houavjk/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoibmFzdGlzMjIiLCJhIjoiY2x1dTJ5eDdqMDQ3dDJqcnlwdDNqenlibCJ9.pzOLxESzaPi0iUBd8oBJAA',
                additionalOptions: const {
                  'accessToken':
                      'pk.eyJ1IjoibmFzdGlzMjIiLCJhIjoiY2x1dTJ5eDdqMDQ3dDJqcnlwdDNqenlibCJ9.pzOLxESzaPi0iUBd8oBJAA',
                  'id': 'mapbox.mapbox-streets-v8',
                },
              ),
              MarkerLayer(
                markers: _markers,
              ),
            ],
          )

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

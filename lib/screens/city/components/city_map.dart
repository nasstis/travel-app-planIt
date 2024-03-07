import 'package:city_repository/city_repository.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travel_app/screens/city/views/map_screen.dart';

class CityMap extends StatefulWidget {
  const CityMap({super.key, required this.city});

  final City city;

  @override
  State<CityMap> createState() => _CityMapState();
}

class _CityMapState extends State<CityMap> {
  late GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MapScreen(
                cityLatLng: LatLng(widget.city.latitude, widget.city.longitude),
              ),
            ));
      },
      child: AbsorbPointer(
        absorbing: true,
        child: GoogleMap(
          onMapCreated: _onMapCreated,
          mapType: MapType.terrain,
          zoomControlsEnabled: false,
          initialCameraPosition: CameraPosition(
            target: LatLng(widget.city.latitude, widget.city.longitude),
            zoom: 11.0,
          ),
          markers: {
            Marker(
              markerId: MarkerId(widget.city.name),
              position: LatLng(widget.city.latitude, widget.city.longitude),
            )
          },
        ),
      ),
    );
  }
}

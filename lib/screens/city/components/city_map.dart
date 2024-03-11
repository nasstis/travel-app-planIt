import 'package:city_repository/city_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:place_repository/place_repository.dart';
import 'package:travel_app/screens/city/blocs/get_places_bloc/get_places_bloc.dart';
import 'package:travel_app/screens/city/views/map_screen.dart';
import 'package:travel_app/screens/place/views/place_screen.dart';

class CityMap extends StatefulWidget {
  const CityMap({super.key, required this.city});

  final City city;

  @override
  State<CityMap> createState() => _CityMapState();
}

class _CityMapState extends State<CityMap> {
  late GoogleMapController mapController;
  final Set<Marker> _markers = {};

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _upsertMarker(Place place) {
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId(place.id),
        position: LatLng(place.latitude, place.longitude),
        infoWindow: InfoWindow(
          title: place.name,
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      PlaceScreen(place: place, cityName: widget.city.name),
                ));
          },
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
      ));
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
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MapScreen(
                  cityLatLng:
                      LatLng(widget.city.latitude, widget.city.longitude),
                  markers: _markers,
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
            markers: _markers,
          ),
        ),
      ),
    );
  }
}

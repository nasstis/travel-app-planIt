import 'package:city_repository/city_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:place_repository/place_repository.dart';
import 'package:travel_app/screens/city/blocs/get_places_bloc/get_places_bloc.dart';
import 'package:travel_app/screens/city/views/map_view.dart';
import 'package:travel_app/utils/constants/routes_names.dart';

class CityMap extends StatelessWidget {
  const CityMap({super.key, required this.city});

  final City city;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.push(PageName.mapRoute, extra: city);
      },
      child: AbsorbPointer(
          absorbing: true,
          child: BlocProvider(
            create: (context) =>
                GetPlacesBloc(FirebasePlaceRepo())..add(GetPlaces(city.cityId)),
            child: MapView(
              latLng: LatLng(city.latitude, city.longitude),
              zoomControlsEnabled: false,
              mapType: MapType.normal,
              isItinerary: false,
            ),
          )),
    );
  }
}

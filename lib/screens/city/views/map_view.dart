import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:place_repository/place_repository.dart';
import 'package:travel_app/screens/city/blocs/get_places_bloc/get_places_bloc.dart';
import 'package:travel_app/screens/city/components/info_window.dart';
import 'package:travel_app/utils/constants/colors.dart';
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
      this.polyline,
      this.polylines});

  final LatLng latLng;
  final MapType mapType;
  final bool zoomControlsEnabled;
  final List? places;
  final bool isItinerary;
  final List? polylines;
  final String? polyline;

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  late GoogleMapController mapController;
  final CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();
  final Set<Marker> _markers = {};
  List<List<PointLatLng>>? decodedPolylines;
  Set<Polyline>? _polylines;
  int? _polylineIdCounter;

  @override
  void initState() {
    if (widget.isItinerary) {
      decodedPolylines = widget.polylines!
          .map(
            (e) => PolylinePoints().decodePolyline(e),
          )
          .toList();
      _polylines = <Polyline>{};
      _polylineIdCounter = 1;
    }
    super.initState();
  }

  void changeMapMode(GoogleMapController mapController) {
    getJsonFile("assets/styles/map_style.json").then(
      (value) => mapController.setMapStyle(value),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    _customInfoWindowController.googleMapController = controller;
    changeMapMode(_customInfoWindowController.googleMapController!);
  }

  void _upsertMarker(Place place, int? index) async {
    BitmapDescriptor? customIcon;
    if (index != null) {
      customIcon = await getCustomIcon(index);
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

  void _setPolyline(decodedPolyline) {
    final String polylineIdVal = 'polyline_$_polylineIdCounter';
    _polylineIdCounter = _polylineIdCounter! + 1;

    _polylines!.add(
      Polyline(
        polylineId: PolylineId(polylineIdVal),
        width: 4,
        color: MyColors.primary,
        points: decodedPolyline!
            .map<LatLng>(
              (point) => LatLng(point.latitude, point.longitude),
            )
            .toList(),
      ),
    );
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
            zoom: 13.0,
          ),
          markers: _markers,
          polylines: _polylines ?? {},
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

        for (var decodedPolyline in decodedPolylines!) {
          _setPolyline(decodedPolyline);
        }
        for (final place in widget.places!) {
          _upsertMarker(place, counter);
          counter++;
        }
      } else {
        for (final place in widget.places!) {
          _upsertMarker(place, null);
        }
      }
      return mainWidget;
    } else {
      return BlocListener<GetPlacesBloc, GetPlacesState>(
          listener: (context, state) {
            if (state is GetPlacesSuccess) {
              for (final place in state.places) {
                _upsertMarker(place, null);
              }
            }
          },
          child: mainWidget);
    }
  }
}

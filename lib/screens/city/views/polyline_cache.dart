import 'package:google_maps_flutter/google_maps_flutter.dart';

class PolylineCache {
  static final PolylineCache _instance = PolylineCache._internal();

  factory PolylineCache() {
    return _instance;
  }

  PolylineCache._internal();

  final Map<String, List<LatLng>> _polylineMap = {};

  void addPolyline(String key, List<LatLng> polyline) {
    _polylineMap[key] = polyline;
  }

  List<LatLng>? getPolyline(String key) {
    return _polylineMap[key];
  }
}

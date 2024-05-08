import 'package:geolocator/geolocator.dart';

Future<Position> getUserCurrentLocation() async {
  await Geolocator.requestPermission()
      .then((value) {})
      .onError((error, stackTrace) async {
    await Geolocator.requestPermission();
  });
  return await Geolocator.getCurrentPosition();
}

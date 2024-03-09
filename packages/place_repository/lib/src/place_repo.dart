import 'package:place_repository/place_repository.dart';

abstract class PlaceRepo {
  Future<List<Place>> getPlaces(String cityId);
}

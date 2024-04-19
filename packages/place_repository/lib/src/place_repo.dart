import '../place_repository.dart';

abstract class PlaceRepo {
  Future<List<Place>> getPlaces(String cityId);

  Future<List<Place>?> getSearchResult({required String qSearch});
}

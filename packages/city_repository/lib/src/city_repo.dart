import 'package:city_repository/city_repository.dart';

abstract class CityRepo {
  Future<List<City>> getCities();

  Future<List<City>> getCitiesById(List<String> id);

  Future<List<City>?> getSearchResult({required String qSearch});

  Future<String> getCityName(String cityId);
}

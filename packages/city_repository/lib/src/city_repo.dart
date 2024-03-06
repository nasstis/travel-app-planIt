import 'package:city_repository/city_repository.dart';

abstract class CityRepo {
  Future<List<City>> getCities();
}

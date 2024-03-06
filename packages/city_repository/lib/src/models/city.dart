import 'package:city_repository/city_repository.dart';

class City {
  String cityId;
  String name;
  String description;
  String continent;
  String country;
  List<dynamic> pictures;
  double latitude;
  double longitude;

  City({
    required this.cityId,
    required this.name,
    required this.description,
    required this.continent,
    required this.country,
    required this.pictures,
    required this.latitude,
    required this.longitude,
  });

  CityEntity toEntity() {
    return CityEntity(
      cityId: cityId,
      name: name,
      description: description,
      continent: continent,
      country: country,
      pictures: pictures,
      latitude: latitude,
      longitude: longitude,
    );
  }

  static City fromEntity(CityEntity entity) {
    return City(
      cityId: entity.cityId,
      name: entity.name,
      description: entity.description,
      continent: entity.continent,
      country: entity.country,
      pictures: entity.pictures,
      latitude: entity.latitude,
      longitude: entity.longitude,
    );
  }
}

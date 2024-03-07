import 'package:city_repository/city_repository.dart';

class City {
  String cityId;
  String name;
  String description;
  String continent;
  String country;
  String picture;
  double latitude;
  double longitude;
  String officialLanguage;
  String timeZone;
  String climate;
  String currency;

  City(
      {required this.cityId,
      required this.name,
      required this.description,
      required this.continent,
      required this.country,
      required this.picture,
      required this.latitude,
      required this.longitude,
      required this.officialLanguage,
      required this.timeZone,
      required this.climate,
      required this.currency});

  CityEntity toEntity() {
    return CityEntity(
      cityId: cityId,
      name: name,
      description: description,
      continent: continent,
      country: country,
      picture: picture,
      latitude: latitude,
      longitude: longitude,
      officialLanguage: officialLanguage,
      timeZone: timeZone,
      climate: climate,
      currency: currency,
    );
  }

  static City fromEntity(CityEntity entity) {
    return City(
      cityId: entity.cityId,
      name: entity.name,
      description: entity.description,
      continent: entity.continent,
      country: entity.country,
      picture: entity.picture,
      latitude: entity.latitude,
      longitude: entity.longitude,
      officialLanguage: entity.officialLanguage,
      timeZone: entity.timeZone,
      climate: entity.climate,
      currency: entity.currency,
    );
  }
}

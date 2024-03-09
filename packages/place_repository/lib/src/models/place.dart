import 'package:place_repository/place_repository.dart';

class Place {
  String id;
  String name;
  String description;
  List<dynamic> pictures;
  double latitude;
  double longitude;
  String cityId;

  Place({
    required this.id,
    required this.name,
    required this.description,
    required this.pictures,
    required this.latitude,
    required this.longitude,
    required this.cityId,
  });

  PlaceEntity toEntity() {
    return PlaceEntity(
      id: id,
      name: name,
      description: description,
      pictures: pictures,
      latitude: latitude,
      longitude: longitude,
      cityId: cityId,
    );
  }

  static Place fromEntity(PlaceEntity entity) {
    return Place(
      id: entity.id,
      name: entity.name,
      description: entity.description,
      pictures: entity.pictures,
      latitude: entity.latitude,
      longitude: entity.longitude,
      cityId: entity.cityId,
    );
  }
}

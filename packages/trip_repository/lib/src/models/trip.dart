import 'package:trip_repository/trip_repository.dart';

class Trip {
  String id;
  String userId;
  String cityId;
  List<String> placesId;
  DateTime startDate;
  DateTime endDate;
  String name;
  String? description;

  Trip({
    required this.id,
    required this.userId,
    required this.cityId,
    required this.placesId,
    required this.startDate,
    required this.endDate,
    required this.name,
    this.description,
  });

  TripEntity toEntity() {
    return TripEntity(
      id: id,
      userId: userId,
      cityId: cityId,
      placesId: placesId,
      startDate: startDate,
      endDate: endDate,
      name: name,
      description: description,
    );
  }

  static Trip fromEntity(TripEntity entity) {
    return Trip(
      id: entity.id,
      userId: entity.userId,
      cityId: entity.cityId,
      placesId: entity.placesId,
      startDate: entity.startDate,
      endDate: entity.endDate,
      name: entity.name,
      description: entity.description,
    );
  }
}

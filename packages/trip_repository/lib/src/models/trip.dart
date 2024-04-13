import 'package:trip_repository/trip_repository.dart';

class Trip {
  String id;
  String userId;
  String cityId;
  DateTime startDate;
  DateTime endDate;
  String name;
  String? description;
  List<String>? placesId;

  Trip({
    required this.id,
    required this.userId,
    required this.cityId,
    required this.startDate,
    required this.endDate,
    required this.name,
    this.description,
    this.placesId,
  });

  TripEntity toEntity() {
    return TripEntity(
      id: id,
      userId: userId,
      startDate: startDate,
      endDate: endDate,
      name: name,
      description: description,
      cityId: cityId,
      placesId: placesId,
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

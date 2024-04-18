import 'package:trip_repository/trip_repository.dart';

class Trip {
  String id;
  String userId;
  String cityId;
  DateTime startDate;
  DateTime endDate;
  String name;
  String photoUrl;
  String? description;
  List places;

  Trip({
    required this.id,
    required this.userId,
    required this.cityId,
    required this.startDate,
    required this.endDate,
    required this.name,
    required this.photoUrl,
    this.description,
    required this.places,
  });

  TripEntity toEntity() {
    return TripEntity(
      id: id,
      userId: userId,
      startDate: startDate,
      endDate: endDate,
      name: name,
      photoUrl: photoUrl,
      description: description,
      cityId: cityId,
      placesId: places,
    );
  }

  static Future<Trip> fromEntity(TripEntity entity) async {
    return Trip(
      id: entity.id,
      userId: entity.userId,
      cityId: entity.cityId,
      places: await FirebaseTripRepo().getPlaces(entity.placesId),
      startDate: entity.startDate,
      endDate: entity.endDate,
      name: entity.name,
      photoUrl: entity.photoUrl,
      description: entity.description,
    );
  }
}

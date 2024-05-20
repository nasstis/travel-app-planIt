import 'package:trip_repository/trip_repository.dart';

class TripCalendar {
  final String id;
  final String tripId;
  final Map<String, List> places;
  final Map<String, dynamic> isDayFinished;

  TripCalendar({
    required this.id,
    required this.tripId,
    required this.places,
    required this.isDayFinished,
  });

  TripCalendarEntity toEntity() {
    return TripCalendarEntity(
      id: id,
      tripId: tripId,
      places: places,
      isDayFinished: isDayFinished,
    );
  }

  static Future<Map<String, List>> getPlaces(
      Map<String, dynamic> placesMap) async {
    final futures = placesMap.values.map((placesId) async {
      return await FirebaseTripRepo().getPlaces(placesId);
    }).toList();

    final places = await Future.wait(futures);

    Map<String, List> map = Map.fromIterables(placesMap.keys, places);
    return map;
  }

  static Future<TripCalendar> fromEntity(TripCalendarEntity entity) async {
    return TripCalendar(
      id: entity.id,
      tripId: entity.tripId,
      places: await getPlaces(entity.places),
      isDayFinished: entity.isDayFinished,
    );
  }
}

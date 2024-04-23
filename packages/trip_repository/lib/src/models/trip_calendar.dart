import 'package:trip_repository/trip_repository.dart';

class TripCalendar {
  final String id;
  final String tripId;
  final Map<String, List> places;

  TripCalendar({
    required this.id,
    required this.tripId,
    required this.places,
  });

  TripCalendarEntity toEntity() {
    return TripCalendarEntity(
      id: id,
      tripId: tripId,
      places: places,
    );
  }

  static Future<Map<String, List>> getPlaces(
      Map<String, dynamic> placesMap) async {
    final List<List> places = [];
    for (var placesId in placesMap.values) {
      places.add(await FirebaseTripRepo().getPlaces(placesId));
    }
    Map<String, List> map = Map.fromIterables(placesMap.keys, places);
    return map;
  }

  static Future<TripCalendar> fromEntity(TripCalendarEntity entity) async {
    return TripCalendar(
      id: entity.id,
      tripId: entity.tripId,
      places: await getPlaces(entity.places),
    );
  }
}

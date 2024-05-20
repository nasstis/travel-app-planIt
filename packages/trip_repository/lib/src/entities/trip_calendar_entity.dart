class TripCalendarEntity {
  final String id;
  final String tripId;
  final Map<String, dynamic> places;
  final Map<String, dynamic> isDayFinished;

  TripCalendarEntity({
    required this.id,
    required this.tripId,
    required this.places,
    required this.isDayFinished,
  });

  Map<String, Object?> toDocument() {
    return {
      'id': id,
      'tripId': tripId,
      'places': places,
      'isDayFinished': isDayFinished,
    };
  }

  static TripCalendarEntity fromDocument(Map<String, dynamic> doc) {
    return TripCalendarEntity(
      id: doc['id'],
      tripId: doc['tripId'],
      places: doc['places'],
      isDayFinished: doc['isDayFinished'],
    );
  }
}

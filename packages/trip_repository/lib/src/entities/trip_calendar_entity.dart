class TripCalendarEntity {
  final String id;
  final String tripId;
  final Map<String, dynamic> places;

  TripCalendarEntity({
    required this.id,
    required this.tripId,
    required this.places,
  });

  Map<String, Object?> toDocument() {
    return {
      'id': id,
      'tripId': tripId,
      'places': places,
    };
  }

  static TripCalendarEntity fromDocument(Map<String, dynamic> doc) {
    return TripCalendarEntity(
      id: doc['id'],
      tripId: doc['tripId'],
      places: doc['places'],
    );
  }
}

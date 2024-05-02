class TripRouteEntity {
  final String id;
  final String tripId;
  final String day;
  final double duration;
  final double distance;
  final String geometry;
  final String profile;

  TripRouteEntity({
    required this.id,
    required this.tripId,
    required this.day,
    required this.duration,
    required this.distance,
    required this.geometry,
    required this.profile,
  });

  Map<String, Object> toDocument() {
    return {
      'id': id,
      'tripId': tripId,
      'day': day,
      'duration': duration,
      'distance': distance,
      'geometry': geometry,
      'profile': profile,
    };
  }

  static TripRouteEntity fromDocument(Map<String, dynamic> doc) {
    return TripRouteEntity(
      id: doc['id'],
      tripId: doc['tripId'],
      day: doc['day'],
      duration: doc['duration'],
      distance: doc['distance'],
      geometry: doc['geometry'],
      profile: doc['profile'],
    );
  }
}

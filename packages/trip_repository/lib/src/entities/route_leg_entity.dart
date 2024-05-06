class RouteLegEntity {
  final double duration;
  final double distance;
  final List geometry;
  final String profile;

  RouteLegEntity({
    required this.duration,
    required this.distance,
    required this.geometry,
    required this.profile,
  });

  Map<String, dynamic> toDocument() {
    return {
      'duration': duration,
      'distance': distance,
      'geometry': geometry,
      'profile': profile,
    };
  }

  static RouteLegEntity fromDocument(Map<String, dynamic> doc) {
    return RouteLegEntity(
      duration: doc['duration'],
      distance: doc['distance'],
      geometry: doc['geometry'],
      profile: doc['profile'],
    );
  }
}

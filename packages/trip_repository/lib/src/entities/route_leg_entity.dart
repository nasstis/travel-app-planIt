class RouteLegEntity {
  final double duration;
  final double distance;
  final List geometry;

  RouteLegEntity({
    required this.duration,
    required this.distance,
    required this.geometry,
  });

  Map<String, dynamic> toDocument() {
    return {
      'duration': duration,
      'distance': distance,
      'geometry': geometry,
    };
  }

  static RouteLegEntity fromDocument(Map<String, dynamic> doc) {
    return RouteLegEntity(
      duration: doc['duration'],
      distance: doc['distance'],
      geometry: doc['geometry'],
    );
  }
}

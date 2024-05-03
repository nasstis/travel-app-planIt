import 'package:trip_repository/src/entities/route_leg_entity.dart';

class RouteLeg {
  final double duration;
  final double distance;
  final List geometry;

  RouteLeg({
    required this.duration,
    required this.distance,
    required this.geometry,
  });

  static RouteLeg fromEntity(RouteLegEntity entity) {
    return RouteLeg(
      duration: entity.duration,
      distance: entity.distance,
      geometry: entity.geometry,
    );
  }

  RouteLegEntity toEntity() {
    return RouteLegEntity(
      duration: duration,
      distance: distance,
      geometry: geometry,
    );
  }
}

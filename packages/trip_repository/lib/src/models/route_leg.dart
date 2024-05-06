import 'package:trip_repository/src/entities/route_leg_entity.dart';

class RouteLeg {
  final double duration;
  final double distance;
  final List geometry;
  final String profile;

  RouteLeg({
    required this.duration,
    required this.distance,
    required this.geometry,
    required this.profile,
  });

  static RouteLeg fromEntity(RouteLegEntity entity) {
    return RouteLeg(
      duration: entity.duration,
      distance: entity.distance,
      geometry: entity.geometry,
      profile: entity.profile,
    );
  }

  RouteLegEntity toEntity() {
    return RouteLegEntity(
      duration: duration,
      distance: distance,
      geometry: geometry,
      profile: profile,
    );
  }
}

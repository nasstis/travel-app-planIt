import 'package:trip_repository/src/entities/entities.dart';
import 'package:trip_repository/src/models/route_leg.dart';

class TripRoute {
  final String id;
  final String tripId;
  final String day;
  final double duration;
  final double distance;
  final String geometry;
  final String profile;
  final List<RouteLeg> legs;

  TripRoute({
    required this.id,
    required this.tripId,
    required this.day,
    required this.duration,
    required this.distance,
    required this.geometry,
    required this.profile,
    required this.legs,
  });

  static TripRoute fromEntity(TripRouteEntity entity) {
    return TripRoute(
      id: entity.id,
      tripId: entity.tripId,
      day: entity.day,
      duration: entity.duration,
      distance: entity.distance,
      geometry: entity.geometry,
      profile: entity.profile,
      legs: entity.legs,
    );
  }

  TripRouteEntity toEntity() {
    return TripRouteEntity(
      id: id,
      tripId: tripId,
      day: day,
      duration: duration,
      distance: distance,
      geometry: geometry,
      profile: profile,
      legs: legs,
    );
  }

  @override
  String toString() {
    return 'id: $id, duration: $duration, distance: $distance, geometry: $geometry';
  }
}

import 'package:trip_repository/src/entities/route_leg_entity.dart';
import 'package:trip_repository/src/models/route_leg.dart';

class TripRouteEntity {
  final String id;
  final String tripId;
  final String day;
  final double duration;
  final double distance;
  final String geometry;
  final String profile;
  final List<RouteLeg> legs;

  TripRouteEntity({
    required this.id,
    required this.tripId,
    required this.day,
    required this.duration,
    required this.distance,
    required this.geometry,
    required this.profile,
    required this.legs,
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
      'legs': legs.map((leg) => leg.toEntity().toDocument()),
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
      legs: doc['legs']
          .map<RouteLeg>(
              (leg) => RouteLeg.fromEntity(RouteLegEntity.fromDocument(leg)))
          .toList(),
    );
  }
}

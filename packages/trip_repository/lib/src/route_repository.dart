import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:trip_repository/src/entities/entities.dart';
import 'package:trip_repository/src/entities/route_leg_entity.dart';
import 'package:trip_repository/src/models/route_leg.dart';
import 'package:trip_repository/src/models/trip_route.dart';

final dio = Dio(
  BaseOptions(
    baseUrl: 'https://api.mapbox.com',
    connectTimeout: const Duration(milliseconds: 5000),
    receiveTimeout: const Duration(milliseconds: 15000),
    sendTimeout: const Duration(milliseconds: 15000),
    queryParameters: {
      'annotations': 'distance,duration',
      'continue_straight': true,
      'geometries': 'polyline',
      'steps': true,
      'overview': 'full',
      'access_token': FlutterConfig.get('MAPBOX_ACCESS_TOKEN'),
    },
  ),
);

class RouteRepository {
  final routeCollection = FirebaseFirestore.instance.collection('tripsRoutes');

  Future<void> createRoute(
      String tripId, List<String> coordinates, String day) async {
    String coordinatesString = coordinates.join(';');
    List<String> profiles = ['walking', 'cycling', 'driving'];

    for (var profile in profiles) {
      final response = await dio.get(
        '/directions/v5/mapbox/$profile/$coordinatesString',
      );

      List<RouteLeg> legs = [];

      for (var leg in response.data['routes'][0]['legs']) {
        legs.add(
          RouteLeg(
            duration: leg['duration'].toDouble(),
            distance: leg['distance'].toDouble(),
            geometry: leg['steps'].map((step) => step['geometry']).toList(),
            profile: profile,
          ),
        );
      }

      final doc = TripRoute(
              id: '$day, $profile',
              tripId: tripId,
              day: day,
              duration: response.data['routes'][0]['duration'].toDouble(),
              distance: response.data['routes'][0]['distance'].toDouble(),
              geometry: response.data['routes'][0]['geometry'],
              profile: profile,
              legs: legs)
          .toEntity()
          .toDocument();

      await routeCollection.doc('$day, $profile').set(doc);
    }
  }

  Future<TripRoute> getRoute(String tripId, String day, String profile) async {
    final route = await routeCollection
        .where('tripId', isEqualTo: tripId)
        .where('id', isEqualTo: '$day, $profile')
        .get()
        .then(
          (doc) => TripRoute.fromEntity(
            TripRouteEntity.fromDocument(
              doc.docs.first.data(),
            ),
          ),
        );

    return route;
  }

  Future<RouteLeg> getRouteStep(
      String tripId, String day, String profile, int index) async {
    final RouteLeg routeLeg = await routeCollection
        .where('tripId', isEqualTo: tripId)
        .where('id', isEqualTo: '$day, $profile')
        .get()
        .then((doc) => RouteLeg.fromEntity(
            RouteLegEntity.fromDocument(doc.docs.first.data()['legs'][index])));

    return routeLeg;
  }

  Future<void> editRoute(
      String tripId, String day, List<String> coordinates) async {
    String coordinatesString = coordinates.join(';');
    await routeCollection
        .where('tripId', isEqualTo: tripId)
        .where('day', isEqualTo: day)
        .get()
        .then((doc) async {
      for (var doc in doc.docs) {
        String profile = doc.data()['profile'];

        final response = await dio.get(
          '/directions/v5/mapbox/$profile/$coordinatesString',
        );

        List<Map<String, dynamic>> legs = [];

        for (var leg in response.data['routes'][0]['legs']) {
          legs.add(
            RouteLeg(
              duration: leg['duration'].toDouble(),
              distance: leg['distance'].toDouble(),
              geometry: leg['steps'].map((step) => step['geometry']).toList(),
              profile: profile,
            ).toEntity().toDocument(),
          );
        }

        await routeCollection.doc('$day, $profile').update({
          'duration': response.data['routes'][0]['duration'].toDouble(),
          'distance': response.data['routes'][0]['distance'].toDouble(),
          'geometry': response.data['routes'][0]['geometry'],
          'legs': legs,
        });
      }
    });
  }

  Future<void> deleteTripRoutes(String tripId) async {
    final querySnapshot =
        await routeCollection.where('tripId', isEqualTo: tripId).get();

    for (final doc in querySnapshot.docs) {
      await doc.reference.delete();
    }
  }

  Future<void> deleteRoute(String tripId, String day) async {
    List<String> profiles = ['walking', 'cycling', 'driving'];
    for (var profile in profiles) {
      final querySnapshot = await routeCollection
          .where('tripId', isEqualTo: tripId)
          .where('id', isEqualTo: '$day, $profile')
          .get();
      for (final doc in querySnapshot.docs) {
        await doc.reference.delete();
      }
    }
  }
}

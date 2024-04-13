import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trip_repository/trip_repository.dart';

class FirebaseTripRepo extends TripRepo {
  final tripColection = FirebaseFirestore.instance.collection('trips');

  @override
  Future<List<Trip>> getTrips(String userId) async {
    final tripQuery =
        await tripColection.where('userId', isEqualTo: userId).get();
    List<Trip> trips = tripQuery.docs
        .map(
          (e) => Trip.fromEntity(
            TripEntity.fromDocument(e.data()),
          ),
        )
        .toList();

    return trips;
  }

  @override
  Future<void> addTrip(Trip newTrip) async {
    try {
      await tripColection.doc(newTrip.id).set(
            newTrip.toEntity().toDocument(),
          );
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}

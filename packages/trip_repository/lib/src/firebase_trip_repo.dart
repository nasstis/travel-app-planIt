import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trip_repository/trip_repository.dart';

class FirebaseTripRepo extends TripRepo {
  final FirebaseAuth _firebaseAuth;
  final tripColection = FirebaseFirestore.instance.collection('trips');

  FirebaseTripRepo({
    FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  @override
  Future<List<Trip>> getTrips() async {
    final tripQuery = await tripColection
        .where('userId', isEqualTo: _firebaseAuth.currentUser!.uid)
        .get();
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
      newTrip.userId = _firebaseAuth.currentUser!.uid;
      await tripColection.doc(newTrip.id).set(
            newTrip.toEntity().toDocument(),
          );
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}

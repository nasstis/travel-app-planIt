import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trip_repository/trip_repository.dart';

class FirebaseTripRepo extends TripRepo {
  final FirebaseAuth _firebaseAuth;
  final tripCollection = FirebaseFirestore.instance.collection('trips');

  FirebaseTripRepo({
    FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  @override
  Stream<List<Trip>> get trips {
    return tripCollection
        .where('userId', isEqualTo: _firebaseAuth.currentUser!.uid)
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return Trip.fromEntity(TripEntity.fromDocument(doc.data()));
      }).toList();
    });
  }

  @override
  Future<void> addTrip(Trip newTrip) async {
    try {
      newTrip.userId = _firebaseAuth.currentUser!.uid;
      await tripCollection.doc(newTrip.id).set(
            newTrip.toEntity().toDocument(),
          );
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<Trip> getTrip(String tripId) async {
    Trip trip = await tripCollection.doc(tripId).get().then(
          (doc) => Trip.fromEntity(
            TripEntity.fromDocument(
              doc.data() as Map<String, dynamic>,
            ),
          ),
        );
    return trip;
  }

  @override
  Future<void> deleteTrip(String tripId) async {
    await tripCollection.doc(tripId).delete();
  }
}

import 'dart:developer';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:place_repository/place_repository.dart';
import 'package:trip_repository/src/models/trip_calendar.dart';
import 'package:trip_repository/trip_repository.dart';

class FirebaseTripRepo extends TripRepo {
  final FirebaseAuth _firebaseAuth;
  final tripCollection = FirebaseFirestore.instance.collection('trips');
  final tripCalendarCollection =
      FirebaseFirestore.instance.collection('tripsCalendars');
  final placeCollection = FirebaseFirestore.instance.collection('places');
  final FirebaseStorage storage = FirebaseStorage.instance;

  FirebaseTripRepo({
    FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  @override
  Stream<List<Trip>> get trips {
    return tripCollection
        .where('userId', isEqualTo: _firebaseAuth.currentUser!.uid)
        .snapshots()
        .asyncMap((querySnapshot) async {
      List<Trip> trips = [];
      for (var doc in querySnapshot.docs) {
        var trip = await Trip.fromEntity(TripEntity.fromDocument(doc.data()));
        trips.add(trip);
      }
      return trips;
    });
  }

  @override
  Future<void> addTrip(Trip newTrip, TripCalendar tripCalendar) async {
    try {
      newTrip.userId = _firebaseAuth.currentUser!.uid;
      await tripCollection.doc(newTrip.id).set(
            newTrip.toEntity().toDocument(),
          );
      await tripCalendarCollection.doc(tripCalendar.id).set(
            tripCalendar.toEntity().toDocument(),
          );
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<List> getPlaces(List placesId) async {
    List places = [];

    for (var placeId in placesId) {
      await placeCollection.doc(placeId).get().then((doc) async {
        places.add(
          await Place.fromEntity(
            PlaceEntity.fromDocument(doc.data()!),
          ),
        );
      });
    }
    return places;
  }

  @override
  Future<Trip> getTrip(String tripId) async {
    Trip trip = await tripCollection
        .doc(tripId)
        .get()
        .then((doc) => Trip.fromEntity(TripEntity.fromDocument(doc.data()!)));
    return trip;
  }

  @override
  Future<void> deleteTrip(String tripId) async {
    await tripCollection.doc(tripId).delete();
  }

  @override
  Future<void> editPhoto(String tripId, File photo) async {
    String? imageUrl;

    String fileName = path.basename(photo.path);
    Reference ref = storage
        .ref()
        .child("${_firebaseAuth.currentUser!.uid}/$tripId/Image-$fileName");

    UploadTask uploadTask = ref.putFile(photo);

    await uploadTask.whenComplete(() async {
      var url = await ref.getDownloadURL();
      imageUrl = url.toString();
    }).then((value) async {
      if (imageUrl != null) {
        await tripCollection.doc(tripId).update({'photoUrl': imageUrl!});
      }
    });
  }

  @override
  Future<void> editTrip({
    required String tripId,
    required String name,
    String? description,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    Map<String, dynamic> updates = {
      'name': name,
      'description': description,
      'startDate': startDate,
      'endDate': endDate,
    };

    await tripCollection.doc(tripId).update(updates);
  }

  @override
  Future<void> removePlaceFromTrip(
      String tripId, List tripPlaces, String placeId) async {
    tripPlaces = tripPlaces.map((place) => place.id).toList();
    tripPlaces.remove(placeId);
    await tripCollection.doc(tripId).update({'placesId': tripPlaces});
  }

  @override
  Future<Trip> addPlaceToTrip(
      String tripId, String placeId, List tripPlaces) async {
    tripPlaces = tripPlaces.map((place) => place.id).toList();
    tripPlaces.add(placeId);
    await tripCollection.doc(tripId).update({'placesId': tripPlaces});
    final trip = await getTrip(tripId);
    return trip;
  }

  @override
  Future<TripCalendar> getTripCalendar(String tripId) async {
    TripCalendar tripCalendar = await tripCalendarCollection
        .where('tripId', isEqualTo: tripId)
        .get()
        .then((doc) async => await TripCalendar.fromEntity(
            TripCalendarEntity.fromDocument(doc.docs.first.data())));
    return tripCalendar;
  }

  @override
  Future<void> deleteTripCalendar(String tripId) async {
    final querySnapshot =
        await tripCalendarCollection.where('tripId', isEqualTo: tripId).get();
    await querySnapshot.docs[0].reference.delete();
  }
}

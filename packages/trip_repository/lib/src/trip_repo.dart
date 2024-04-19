import 'dart:io';

import '../trip_repository.dart';

abstract class TripRepo {
  Stream<List<Trip>> get trips;

  Future<Trip> getTrip(String tripId);

  Future<void> addTrip(Trip newTrip);

  Future<void> deleteTrip(String tripId);

  Future<void> editPhoto(String tripId, File photo);

  Future<void> editTrip({
    required String tripId,
    required String name,
    String? description,
    required DateTime startDate,
    required DateTime endDate,
  });

  Future<List> getPlaces(List placesId);

  Future<void> removePlaceFromTrip(
      String tripId, List tripPlaces, String placeId);
}

import 'dart:io';

import '../trip_repository.dart';

abstract class TripRepo {
  Stream<List<Trip>> get trips;

  Future<Trip> getTrip(String tripId);

  Future<void> addTrip(Trip newTrip, TripCalendar tripCalendar);

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

  Future<Trip> addPlaceToTrip(String tripId, String placeId, List tripPlaces);

  Future<TripCalendar> getTripCalendar(String tripId);

  // Stream<TripCalendar> getTripCalendarStream(String tripId);

  Future<void> deleteTripCalendar(String tripId);

  Future<void> addPlaceToItinerary(String tripId, String date, List places);

  Future<void> editItinerary(String tripId, String date, List places);
}

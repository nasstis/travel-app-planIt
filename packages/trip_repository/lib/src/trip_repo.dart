import '../trip_repository.dart';

abstract class TripRepo {
  Stream<List<Trip>> get trips;

  Future<Trip> getTrip(String tripId);

  Future<void> addTrip(Trip newTrip);

  Future<void> deleteTrip(String tripId);
}

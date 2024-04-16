import '../trip_repository.dart';

abstract class TripRepo {
  Stream<List<Trip>> get trips;

  // Stream<List<Trip>> getTrips();

  Future<Trip> getTrip(String tripId);

  Future<void> addTrip(Trip newTrip);
}

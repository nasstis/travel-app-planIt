import '../trip_repository.dart';

abstract class TripRepo {
  Future<List<Trip>> getTrips();

  Future<Trip> getTrip(String tripId);

  Future<void> addTrip(Trip newTrip);
}

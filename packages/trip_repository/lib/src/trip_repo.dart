import '../trip_repository.dart';

abstract class TripRepo {
  Future<List<Trip>> getTrips();

  Future<void> addTrip(Trip newTrip);
}

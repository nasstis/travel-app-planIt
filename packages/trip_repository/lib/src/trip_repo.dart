import '../trip_repository.dart';

abstract class TripRepo {
  Future<List<Trip>> getTrips(String userId);

  Future<void> addTrip(Trip newTrip);
}

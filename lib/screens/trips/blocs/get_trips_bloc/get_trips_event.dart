part of 'get_trips_bloc.dart';

sealed class GetTripsEvent extends Equatable {
  const GetTripsEvent();

  @override
  List<Object> get props => [];
}

class GetTripsRequired extends GetTripsEvent {}

class GetTripByIdRequired extends GetTripsEvent {
  final String tripId;

  const GetTripByIdRequired(this.tripId);
}

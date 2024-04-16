part of 'trip_bloc.dart';

sealed class TripEvent extends Equatable {
  const TripEvent();

  @override
  List<Object> get props => [];
}

class CreateTrip extends TripEvent {
  final Trip trip;

  const CreateTrip(this.trip);
}

class DeleteTrip extends TripEvent {
  final String tripId;

  const DeleteTrip(this.tripId);
}

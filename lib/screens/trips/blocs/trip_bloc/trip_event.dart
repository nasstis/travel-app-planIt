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

class EditTripEvent extends TripEvent {
  final String tripId;
  final String name;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final File? photo;

  const EditTripEvent(
    this.photo, {
    required this.tripId,
    required this.name,
    required this.description,
    required this.startDate,
    required this.endDate,
  });
}

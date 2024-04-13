part of 'create_trip_bloc.dart';

sealed class CreateTripEvent extends Equatable {
  const CreateTripEvent();

  @override
  List<Object> get props => [];
}

class CreateTripRequired extends CreateTripEvent {
  final Trip trip;

  const CreateTripRequired(this.trip);
}

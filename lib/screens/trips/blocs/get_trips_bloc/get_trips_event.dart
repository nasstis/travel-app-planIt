part of 'get_trips_bloc.dart';

sealed class GetTripsEvent extends Equatable {
  const GetTripsEvent();

  @override
  List<Object> get props => [];
}

class GetTripsRequired extends GetTripsEvent {
  final String userId;

  const GetTripsRequired(this.userId);
}

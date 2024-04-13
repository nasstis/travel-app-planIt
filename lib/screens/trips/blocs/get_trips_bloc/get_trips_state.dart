part of 'get_trips_bloc.dart';

sealed class GetTripsState extends Equatable {
  const GetTripsState();

  @override
  List<Object> get props => [];
}

final class GetTripsInitial extends GetTripsState {}

final class GetTripsLoading extends GetTripsState {}

final class GetTripsSuccess extends GetTripsState {
  final List<Trip> trips;

  const GetTripsSuccess(this.trips);
}

final class GetTripsFailure extends GetTripsState {}

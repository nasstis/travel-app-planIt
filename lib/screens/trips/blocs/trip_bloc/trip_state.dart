part of 'trip_bloc.dart';

sealed class TripState extends Equatable {
  const TripState();

  @override
  List<Object> get props => [];
}

final class TripInitial extends TripState {}

final class CreateTripLoading extends TripState {}

final class CreateTripSuccess extends TripState {}

final class CreateTripFailure extends TripState {}

final class DeleteTripLoading extends TripState {}

final class DeleteTripSuccess extends TripState {}

final class DeleteTripFailure extends TripState {}

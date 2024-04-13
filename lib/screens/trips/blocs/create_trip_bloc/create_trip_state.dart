part of 'create_trip_bloc.dart';

sealed class CreateTripState extends Equatable {
  const CreateTripState();

  @override
  List<Object> get props => [];
}

final class CreateTripInitial extends CreateTripState {}

final class CreateTripLoading extends CreateTripState {}

final class CreateTripSuccess extends CreateTripState {}

final class CreateTripFailure extends CreateTripState {}

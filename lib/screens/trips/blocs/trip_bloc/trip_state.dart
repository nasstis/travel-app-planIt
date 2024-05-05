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

final class EditTripSuccess extends TripState {}

final class EditTripLoading extends TripState {}

final class EditTripFailure extends TripState {}

final class RemovePlaceFromTripSuccess extends TripState {}

final class RemovePlaceFromTripLoading extends TripState {}

final class RemovePlaceFromTripFailure extends TripState {}

final class AddPlaceToTripSuccess extends TripState {
  final Trip trip;

  const AddPlaceToTripSuccess(this.trip);
}

final class AddPlaceToTripLoading extends TripState {}

final class PlaceAlreadyInTrip extends TripState {}

final class AddPlaceToTripFailure extends TripState {}

final class GetCityPlacesSuccess extends TripState {
  final List<Place> places;

  const GetCityPlacesSuccess(this.places);
}

final class GetCityPlacesLoading extends TripState {}

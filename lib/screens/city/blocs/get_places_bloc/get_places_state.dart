part of 'get_places_bloc.dart';

sealed class GetPlacesState extends Equatable {
  const GetPlacesState();

  @override
  List<Object> get props => [];
}

final class GetPlacesInitial extends GetPlacesState {}

final class GetPlacesLoading extends GetPlacesState {}

final class GetPlacesSuccess extends GetPlacesState {
  final List<Place> places;

  const GetPlacesSuccess(this.places);
}

final class GetPlacesFailure extends GetPlacesState {
  final String error;

  GetPlacesFailure({required this.error});
}

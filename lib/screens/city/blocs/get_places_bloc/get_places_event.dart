part of 'get_places_bloc.dart';

sealed class GetPlacesEvent extends Equatable {
  const GetPlacesEvent();

  @override
  List<Object> get props => [];
}

class GetPlaces extends GetPlacesEvent {
  final String cityId;

  const GetPlaces(this.cityId);
}

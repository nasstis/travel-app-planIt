part of 'get_cities_bloc.dart';

sealed class GetCitiesEvent extends Equatable {
  const GetCitiesEvent();

  @override
  List<Object> get props => [];
}

class GetCities extends GetCitiesEvent {}

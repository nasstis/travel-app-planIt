part of 'get_cities_bloc.dart';

sealed class GetCitiesState extends Equatable {
  const GetCitiesState();

  @override
  List<Object> get props => [];
}

final class GetCitiesInitial extends GetCitiesState {}

final class GetCitiesLoading extends GetCitiesState {}

final class GetCitiesFailure extends GetCitiesState {
  final String errorMessage;

  const GetCitiesFailure(this.errorMessage);
}

final class GetCitiesSuccess extends GetCitiesState {
  final List<City> cities;

  const GetCitiesSuccess(this.cities);

  @override
  List<Object> get props => [cities];
}

final class GetAllCitiesState extends GetCitiesState {
  final Query<City> cityQuery;

  const GetAllCitiesState(this.cityQuery);
}

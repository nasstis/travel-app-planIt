import 'package:bloc/bloc.dart';
import 'package:city_repository/city_repository.dart';
import 'package:equatable/equatable.dart';

part 'get_cities_event.dart';
part 'get_cities_state.dart';

class GetCitiesBloc extends Bloc<GetCitiesEvent, GetCitiesState> {
  final CityRepo _cityRepo;
  GetCitiesBloc(this._cityRepo) : super(GetCitiesInitial()) {
    on<GetCities>((event, emit) async {
      emit(GetCitiesLoading());
      try {
        List<City> cities = await _cityRepo.getCities();
        emit(GetCitiesSuccess(cities));
      } catch (e) {
        emit(GetCitiesFailure(e.toString()));
      }
    });
  }
}

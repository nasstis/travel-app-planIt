import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:place_repository/place_repository.dart';

part 'get_places_event.dart';
part 'get_places_state.dart';

class GetPlacesBloc extends Bloc<GetPlacesEvent, GetPlacesState> {
  final PlaceRepo _placeRepo;
  GetPlacesBloc(this._placeRepo) : super(GetPlacesInitial()) {
    on<GetPlaces>((event, emit) async {
      emit(GetPlacesLoading());
      try {
        final places = await _placeRepo.getPlaces(event.cityId);
        emit(GetPlacesSuccess(places));
      } catch (e) {
        emit(GetPlacesFailure(error: e.toString()));
      }
    });
  }
}

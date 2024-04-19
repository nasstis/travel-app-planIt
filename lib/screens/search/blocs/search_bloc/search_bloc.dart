import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:city_repository/city_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:place_repository/place_repository.dart';
import 'package:stream_transform/stream_transform.dart';

part 'search_event.dart';
part 'search_state.dart';

EventTransformer<E> debounceDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.debounce(duration), mapper);
  };
}

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final CityRepo _cityRepo;
  final PlaceRepo _placeRepo;
  SearchBloc(this._cityRepo, this._placeRepo) : super(SearchState()) {
    on<SearchWordRequired>(
      _onSearch,
      transformer: debounceDroppable(
        const Duration(milliseconds: 500),
      ),
    );

    on<ClearSearchResults>((event, emit) {
      emit(SearchState(cities: null, places: null));
    });

    on<SearchWordPlace>(
      _onSearchPlace,
      transformer: debounceDroppable(
        const Duration(milliseconds: 500),
      ),
    );
  }

  _onSearch(SearchWordRequired event, Emitter<SearchState> emit) async {
    final cities = await _cityRepo.getSearchResult(qSearch: event.word);
    emit(SearchState(cities: cities));
  }

  _onSearchPlace(SearchWordPlace event, Emitter<SearchState> emit) async {
    final places = await _placeRepo.getSearchResult(qSearch: event.word);
    emit(SearchState(places: places));
  }
}

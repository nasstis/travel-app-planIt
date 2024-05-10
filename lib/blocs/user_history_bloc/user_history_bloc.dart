import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:city_repository/city_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'user_history_event.dart';
part 'user_history_state.dart';

class UserHistoryBloc extends Bloc<UserHistoryEvent, UserHistoryState> {
  final UserRepository _userRepository;
  final CityRepo _cityRepository;
  UserHistoryBloc(this._userRepository, this._cityRepository)
      : super(UserHistoryInitial()) {
    on<GetUserHistory>((event, emit) async {
      emit(GetUserHistoryLoading());
      try {
        final history = await _userRepository.getHistory();
        final recentlyViewed = await _cityRepository.getCitiesById(history);

        emit(GetUserHistorySuccess(recentlyViewed.reversed.toList()));
      } catch (e) {
        log(e.toString());
        emit(GetUserHistoryFailure());
      }
    });

    on<AddToHistory>((event, emit) async {
      final recentlyViewed = await _userRepository.getHistory();
      if (!recentlyViewed.contains(event.id)) {
        await _userRepository.addToHistory(event.id);
        emit(AddToHistorySuccess());
      }
    });
  }
}

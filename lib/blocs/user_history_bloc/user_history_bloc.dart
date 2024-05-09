import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'user_history_event.dart';
part 'user_history_state.dart';

class UserHistoryBloc extends Bloc<UserHistoryEvent, UserHistoryState> {
  final UserRepository _userRepository;
  UserHistoryBloc(this._userRepository) : super(UserHistoryInitial()) {
    on<GetUserHistory>((event, emit) async {
      emit(GetUserHistoryLoading());
      try {
        final recentlyViewed = await _userRepository.getHistory();
        emit(GetUserHistorySuccess(recentlyViewed));
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

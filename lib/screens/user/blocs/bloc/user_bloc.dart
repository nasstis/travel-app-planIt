import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;
  UserBloc(this._userRepository) : super(UserInitial()) {
    on<EditProfile>((event, emit) async {
      emit(EditProfileLoading());
      try {
        MyUser user = MyUser.empty;
        if (event.photo != null) {
          user = await _userRepository.editPhoto(event.photo!);
        }
        if (event.name != null && event.email != null) {
          user = await _userRepository.editProfile(
              name: event.name!, email: event.email!);
        }
        emit(EditProfileSuccess(user));
      } catch (e) {
        emit(EditProfileFailure());
      }
    });

    on<DeleteAccount>((event, emit) async {
      emit(DeleteAccountLoading());
      try {
        await _userRepository.deleteAccount();
        emit(DeleteAccountSuccess());
      } catch (e) {
        emit(DeleteAccountFailure());
      }
    });
  }
}

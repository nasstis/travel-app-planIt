import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:user_repository/user_repository.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final UserRepository _userRepository;
  SignInBloc(this._userRepository) : super(SignInInitial()) {
    on<SignInRequired>((event, emit) async {
      emit(SignInLoading());
      try {
        await _userRepository.signIn(event.email, event.password);
        emit(SignInSuccess());
      } catch (e) {
        emit(SignInFailure());
      }
    });

    on<SignOutRequired>((event, emit) async {
      await _userRepository.logOut();
    });

    on<ResetPasswordRequired>((event, emit) async {
      emit(ResetPasswordLoading());
      try {
        await _userRepository.resetPassword(event.email);
        emit(ResetPasswordSuccess());
      } catch (e) {
        emit(ResetPasswordFailure(e.toString()));
      }
    });

    on<SignInWithGoogleRequired>((event, emit) async {
      emit(SignInWithGoogleLoading());
      try {
        await _userRepository.signInWithGoogle();
        emit(SignInWithGoogleSuccess());
      } catch (e) {
        log(e.toString());
        emit(SignInWithGoogleFailure(e.toString()));
      }
    });
  }
}

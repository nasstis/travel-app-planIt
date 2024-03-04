part of 'sign_in_bloc.dart';

@immutable
sealed class SignInState extends Equatable {
  @override
  List<Object> get props => [];
}

final class SignInInitial extends SignInState {}

final class SignInLoading extends SignInState {}

final class SignInSuccess extends SignInState {}

final class SignInFailure extends SignInState {}

final class ResetPasswordLoading extends SignInState {}

final class ResetPasswordSuccess extends SignInState {}

final class ResetPasswordFailure extends SignInState {
  final String errorMsg;

  ResetPasswordFailure(this.errorMsg);
}

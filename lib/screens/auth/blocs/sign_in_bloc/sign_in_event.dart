part of 'sign_in_bloc.dart';

@immutable
sealed class SignInEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SignInRequired extends SignInEvent {
  final String email;
  final String password;

  SignInRequired(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

class SignOutRequired extends SignInEvent {}

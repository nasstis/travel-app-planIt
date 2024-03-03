part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class AuthUserChanged extends AuthEvent {
  final MyUser? user;

  AuthUserChanged(this.user);
}

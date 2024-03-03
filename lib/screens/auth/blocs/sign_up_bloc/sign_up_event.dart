part of 'sign_up_bloc.dart';

@immutable
sealed class SignUpEvent {}

class SignUpRequired extends SignUpEvent {
  final MyUser user;
  final String password;

  SignUpRequired({
    required this.user,
    required this.password,
  });
}

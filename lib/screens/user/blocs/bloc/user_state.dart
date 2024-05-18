part of 'user_bloc.dart';

sealed class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

final class UserInitial extends UserState {}

final class EditProfileSuccess extends UserState {
  final MyUser user;

  const EditProfileSuccess(this.user);
}

final class EditProfileFailure extends UserState {}

final class EditProfileLoading extends UserState {}

final class DeleteAccountSuccess extends UserState {}

final class DeleteAccountFailure extends UserState {}

final class DeleteAccountLoading extends UserState {}

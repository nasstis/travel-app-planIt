part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class EditProfile extends UserEvent {
  final String? name;
  final String? email;
  final File? photo;

  const EditProfile(this.name, this.email, this.photo);
}

class DeleteAccount extends UserEvent {}

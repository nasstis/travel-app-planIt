part of 'get_user_id_bloc.dart';

sealed class GetUserIdEvent extends Equatable {
  const GetUserIdEvent();

  @override
  List<Object> get props => [];
}

class GetUserIdRequired extends GetUserIdEvent {}

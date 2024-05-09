part of 'user_history_bloc.dart';

sealed class UserHistoryEvent extends Equatable {
  const UserHistoryEvent();

  @override
  List<Object> get props => [];
}

class GetUserHistory extends UserHistoryEvent {}

class AddToHistory extends UserHistoryEvent {
  final String id;

  const AddToHistory(this.id);
}

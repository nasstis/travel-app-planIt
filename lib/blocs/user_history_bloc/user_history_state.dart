part of 'user_history_bloc.dart';

sealed class UserHistoryState extends Equatable {
  const UserHistoryState();

  @override
  List<Object> get props => [];
}

final class UserHistoryInitial extends UserHistoryState {}

class GetUserHistorySuccess extends UserHistoryState {
  final List<String> recentlyViewed;

  const GetUserHistorySuccess(this.recentlyViewed);
}

class GetUserHistoryFailure extends UserHistoryState {}

class GetUserHistoryLoading extends UserHistoryState {}

class AddToHistorySuccess extends UserHistoryState {}

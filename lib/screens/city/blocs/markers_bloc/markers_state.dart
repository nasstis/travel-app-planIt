part of 'markers_bloc.dart';

sealed class MarkersState extends Equatable {
  const MarkersState();
  
  @override
  List<Object> get props => [];
}

final class MarkersInitial extends MarkersState {}

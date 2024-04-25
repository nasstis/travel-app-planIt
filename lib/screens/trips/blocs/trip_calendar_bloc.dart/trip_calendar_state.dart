part of 'trip_calendar_bloc.dart';

sealed class TripCalendarState extends Equatable {
  const TripCalendarState();

  @override
  List<Object> get props => [];
}

final class TripCalendarInitial extends TripCalendarState {}

final class GetTripCalendarSuccess extends TripCalendarState {
  final TripCalendar tripCalendar;

  const GetTripCalendarSuccess(this.tripCalendar);
}

final class GetTripCalendarLoading extends TripCalendarState {}

final class GetTripCalendarFailure extends TripCalendarState {}

final class AddPlacesToItineraryFailure extends TripCalendarState {
  final String errorMessage;

  const AddPlacesToItineraryFailure(this.errorMessage);
}

final class AddPlacesToItinerarySuccess extends TripCalendarState {}

final class AddPlacesToItineraryLoading extends TripCalendarState {}

final class EditItineraryFailure extends TripCalendarState {
  final String errorMessage;

  const EditItineraryFailure(this.errorMessage);
}

final class EditItinerarySuccess extends TripCalendarState {}

final class EditItineraryLoading extends TripCalendarState {}

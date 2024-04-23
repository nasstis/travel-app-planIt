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

final class AddPlacesToItineraryFailure extends TripCalendarState {}

final class AddPlacesToItinerarySuccess extends TripCalendarState {}

final class AddPlacesToItineraryLoading extends TripCalendarState {}

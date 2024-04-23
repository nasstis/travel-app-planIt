part of 'trip_calendar_bloc.dart';

sealed class TripCalendarEvent extends Equatable {
  const TripCalendarEvent();

  @override
  List<Object> get props => [];
}

class GetTripCalendar extends TripCalendarEvent {
  final String tripId;

  const GetTripCalendar(this.tripId);
}

class AddPlacesToItinerary extends TripCalendarEvent {
  final List<bool> selectedCheckboxes;
  final List places;

  const AddPlacesToItinerary(
      {required this.selectedCheckboxes, required this.places});
}

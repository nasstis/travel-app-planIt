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
  final String date;
  final List places;
  final String tripId;

  const AddPlacesToItinerary(
      {required this.selectedCheckboxes,
      required this.date,
      required this.places,
      required this.tripId});
}

class EditItinerary extends TripCalendarEvent {
  final String tripId;
  final String date;
  final List places;

  const EditItinerary({
    required this.tripId,
    required this.date,
    required this.places,
  });
}

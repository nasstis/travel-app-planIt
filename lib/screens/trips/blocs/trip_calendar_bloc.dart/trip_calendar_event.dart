part of 'trip_calendar_bloc.dart';

sealed class TripCalendarEvent extends Equatable {
  const TripCalendarEvent();

  @override
  List<Object> get props => [];
}

class GetTripCalendar extends TripCalendarEvent {
  final String tripId;
  final int index;

  const GetTripCalendar(this.tripId, {this.index = 0});
}

class AddPlacesToItinerary extends TripCalendarEvent {
  final List selectedPlaces;
  final String date;
  final String tripId;

  const AddPlacesToItinerary(
      {required this.selectedPlaces, required this.date, required this.tripId});
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

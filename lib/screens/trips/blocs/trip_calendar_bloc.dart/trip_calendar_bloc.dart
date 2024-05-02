import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:trip_repository/trip_repository.dart';

part 'trip_calendar_event.dart';
part 'trip_calendar_state.dart';

class TripCalendarBloc extends Bloc<TripCalendarEvent, TripCalendarState> {
  final TripRepo _tripRepository;
  TripCalendarBloc(
    this._tripRepository,
  ) : super(TripCalendarInitial()) {
    on<GetTripCalendar>(
      (event, emit) async {
        emit(GetTripCalendarLoading());
        try {
          final tripCalendar =
              await _tripRepository.getTripCalendar(event.tripId);
          emit(GetTripCalendarSuccess(tripCalendar, event.index));
        } catch (e) {
          log(e.toString());
          emit(GetTripCalendarFailure());
        }
      },
    );

    on<AddPlacesToItinerary>(
      (event, emit) async {
        emit(AddPlacesToItineraryLoading());
        try {
          final List selectedPlaces = [];
          int index = 0;
          for (var checkbox in event.selectedCheckboxes) {
            if (checkbox) {
              selectedPlaces.add(event.places[index].id);
            }
            index++;
          }
          if (selectedPlaces.isEmpty) {
            emit(const AddPlacesToItineraryFailure(
                'You haven\'t selected any place'));
          } else {
            await _tripRepository.addPlaceToItinerary(
                event.tripId, event.date, selectedPlaces);
          }
          emit(AddPlacesToItinerarySuccess());
        } catch (e) {
          log(e.toString());
          emit(AddPlacesToItineraryFailure(e.toString()));
        }
      },
    );

    on<EditItinerary>(
      (event, emit) async {
        emit(EditItineraryLoading());
        try {
          final places = event.places.map((e) => e.id).toList();
          await _tripRepository.editItinerary(event.tripId, event.date, places);
          emit(EditItinerarySuccess());
        } catch (e) {
          log(e.toString());
          emit(EditItineraryFailure(e.toString()));
        }
      },
    );
  }
}

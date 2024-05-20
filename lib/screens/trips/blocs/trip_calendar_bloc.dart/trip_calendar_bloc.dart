import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:trip_repository/trip_repository.dart';
import 'package:user_repository/user_repository.dart';

part 'trip_calendar_event.dart';
part 'trip_calendar_state.dart';

class TripCalendarBloc extends Bloc<TripCalendarEvent, TripCalendarState> {
  final TripRepo _tripRepository;
  final UserRepository _userRepository;
  TripCalendarBloc(this._tripRepository, this._userRepository)
      : super(TripCalendarInitial()) {
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
          if (event.selectedPlaces.isEmpty) {
            emit(const AddPlacesToItineraryFailure(
                'You haven\'t selected any place'));
          } else {
            await _tripRepository.addPlaceToItinerary(
                event.tripId, event.date, event.selectedPlaces);
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

    on<FinishDayItinerary>(
      (event, emit) async {
        emit(FinishDayItineraryLoading());
        try {
          await _tripRepository.finishDayItinerary(event.tripId, event.date);
          await _userRepository.updateScore(event.user, 3);
          emit(FinishDayItinerarySuccess());
        } catch (e) {
          log(e.toString());
          emit(FinishDayItineraryFailure());
        }
      },
    );
  }
}

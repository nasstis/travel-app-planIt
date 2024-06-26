import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:place_repository/place_repository.dart';
import 'package:trip_repository/trip_repository.dart';
import 'package:user_repository/user_repository.dart';

part 'trip_event.dart';
part 'trip_state.dart';

class TripBloc extends Bloc<TripEvent, TripState> {
  final TripRepo _tripRepository;
  final UserRepository _userRepository;

  TripBloc(this._tripRepository, this._userRepository) : super(TripInitial()) {
    on<CreateTrip>((event, emit) async {
      emit(CreateTripLoading());
      try {
        await _tripRepository.addTrip(event.trip, event.tripCalendar);
        await _userRepository.updateScore(event.user, 2);
        emit(CreateTripSuccess());
      } catch (e) {
        log(e.toString());
        emit(CreateTripFailure());
      }
    });

    on<DeleteTrip>((event, emit) async {
      emit(DeleteTripLoading());
      try {
        await _tripRepository.deleteTrip(event.tripId);
        await _tripRepository.deleteTripCalendar(event.tripId);
        await RouteRepository().deleteTripRoutes(event.tripId);
        emit(DeleteTripSuccess());
      } catch (e) {
        emit(DeleteTripFailure());
      }
    });

    on<EditTripEvent>((event, emit) async {
      emit(EditTripLoading());
      try {
        if (event.photo != null) {
          await _tripRepository.editPhoto(event.tripId, event.photo!);
        }
        await _tripRepository.editTrip(
          tripId: event.tripId,
          name: event.name,
          startDate: event.startDate,
          endDate: event.endDate,
          description: event.description,
        );
        emit(EditTripSuccess());
      } catch (e) {
        emit(EditTripFailure());
      }
    });

    on<RemovePlaceFromTrip>((event, emit) async {
      emit(RemovePlaceFromTripLoading());
      try {
        await _tripRepository.removePlaceFromTrip(
            event.tripId, event.places, event.placeId);
        emit(RemovePlaceFromTripSuccess());
      } catch (e) {
        emit(RemovePlaceFromTripFailure());
      }
    });

    on<AddPlaceToTrip>((event, emit) async {
      emit(AddPlaceToTripLoading());
      try {
        final placesId = event.places.map((e) => e.id).toList();
        if (placesId.contains(event.placeId)) {
          emit(PlaceAlreadyInTrip());
        } else {
          final trip = await _tripRepository.addPlaceToTrip(
              event.tripId, event.placeId, event.places);
          emit(AddPlaceToTripSuccess(trip));
        }
      } catch (e) {
        emit(AddPlaceToTripFailure());
      }
    });

    on<GetCityPlaces>((event, emit) async {
      emit(GetCityPlacesLoading());
      final List<Place> places =
          await _tripRepository.getCityPlaces(event.cityId);
      emit(GetCityPlacesSuccess(places));
    });
  }
}

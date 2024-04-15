import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:trip_repository/trip_repository.dart';

part 'get_trips_event.dart';
part 'get_trips_state.dart';

class GetTripsBloc extends Bloc<GetTripsEvent, GetTripsState> {
  final TripRepo _tripRepository;
  GetTripsBloc(this._tripRepository) : super(GetTripsInitial()) {
    on<GetTripsRequired>(
      (event, emit) async {
        emit(GetTripsLoading());
        try {
          final trips = await _tripRepository.getTrips();
          emit(GetTripsSuccess(trips));
        } catch (e) {
          log(e.toString());
          emit(GetTripsFailure());
        }
      },
    );

    on<GetTripByIdRequired>(
      (event, emit) async {
        emit(GetTripByIdLoading());
        try {
          final trip = await _tripRepository.getTrip(event.tripId);
          emit(GetTripByIdSuccess(trip));
        } catch (e) {
          log(e.toString());
          emit(GetTripByIdFailure());
        }
      },
    );
  }
}

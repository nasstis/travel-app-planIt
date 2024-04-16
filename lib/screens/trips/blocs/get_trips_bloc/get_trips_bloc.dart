import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:trip_repository/trip_repository.dart';

part 'get_trips_event.dart';
part 'get_trips_state.dart';

class GetTripsBloc extends Bloc<GetTripsEvent, GetTripsState> {
  final TripRepo _tripRepository;
  late final StreamSubscription<List<Trip>> _tripsSubscription;
  GetTripsBloc(this._tripRepository) : super(GetTripsInitial()) {
    _tripsSubscription = _tripRepository.trips.listen(
      (trips) {
        add(GetTripsRequired(trips));
      },
    );

    on<GetTripsRequired>(
      (event, emit) {
        emit(GetTripsLoading());
        try {
          // final trips = _tripRepository.getTrips();
          emit(GetTripsSuccess(event.trips!));
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

  @override
  Future<void> close() {
    _tripsSubscription.cancel();
    return super.close();
  }
}

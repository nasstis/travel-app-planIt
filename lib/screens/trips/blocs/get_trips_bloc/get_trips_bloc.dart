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
          if (event.trips != null) {
            List<Trip> trips = event.trips!;
            trips.sort(
              (a, b) => a.startDate.compareTo(b.startDate),
            );
            emit(GetTripsSuccess(trips));
          } else {
            emit(GetTripsLoading());
          }
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

    on<GetTripCalendar>(
      (event, emit) async {
        emit(GetTripCalendarLoading());
        try {
          final tripCalendar =
              await _tripRepository.getTripCalendar(event.tripId);
          emit(GetTripCalendarSuccess(tripCalendar));
        } catch (e) {
          log(e.toString());
          emit(GetTripCalendarFailure());
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

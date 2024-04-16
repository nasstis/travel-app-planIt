import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:trip_repository/trip_repository.dart';

part 'trip_event.dart';
part 'trip_state.dart';

class TripBloc extends Bloc<TripEvent, TripState> {
  final TripRepo _tripRepository;
  TripBloc(this._tripRepository) : super(TripInitial()) {
    on<CreateTrip>((event, emit) async {
      emit(CreateTripLoading());
      try {
        await _tripRepository.addTrip(event.trip);
        emit(CreateTripSuccess());
      } catch (e) {
        emit(CreateTripFailure());
      }
    });

    on<DeleteTrip>((event, emit) async {
      emit(DeleteTripLoading());
      try {
        await _tripRepository.deleteTrip(event.tripId);
        emit(DeleteTripSuccess());
      } catch (e) {
        emit(DeleteTripFailure());
      }
    });
  }
}

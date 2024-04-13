import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:trip_repository/trip_repository.dart';

part 'create_trip_event.dart';
part 'create_trip_state.dart';

class CreateTripBloc extends Bloc<CreateTripEvent, CreateTripState> {
  final TripRepo _tripRepository;
  CreateTripBloc(this._tripRepository) : super(CreateTripInitial()) {
    on<CreateTripRequired>((event, emit) {
      emit(CreateTripLoading());
      try {
        _tripRepository.addTrip(event.trip);
        emit(CreateTripSuccess());
      } catch (e) {
        emit(CreateTripFailure());
      }
    });
  }
}

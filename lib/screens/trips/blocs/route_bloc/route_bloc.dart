import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:trip_repository/trip_repository.dart';

part 'route_event.dart';
part 'route_state.dart';

class RouteBloc extends Bloc<RouteEvent, RouteState> {
  final RouteRepository _routeRepository;
  RouteBloc(this._routeRepository) : super(RouteInitial()) {
    on<CreateRoute>((event, emit) async {
      await _routeRepository.createRoute(
          event.tripId, event.coordinates, event.day);
      emit(CreateRouteSuccess());
    });

    on<GetRoute>((event, emit) async {
      emit(GetRouteLoading());
      try {
        final TripRoute route = await _routeRepository.getRoute(
            event.tripId, event.day, event.profile);
        emit(GetRouteSuccess(route));
      } catch (e) {
        log(e.toString());
        emit(GetRouteFailure());
      }
    });

    on<GetRouteStep>((event, emit) async {
      emit(GetRouteStepLoading());
      try {
        final RouteLeg routeLeg = await _routeRepository.getRouteStep(
            event.tripId, event.day, event.profile, event.index);
        emit(GetRouteStepSuccess(routeLeg));
      } catch (e) {
        log(e.toString());
        emit(GetRouteStepFailure());
      }
    });

    on<EditRoute>((event, emit) async {
      emit(EditRouteLoading());
      try {
        await _routeRepository.editRoute(
            event.tripId, event.day, event.coordinates);
        emit(EditRouteSuccess());
      } catch (e) {
        log(e.toString());
        emit(EditRouteFailure());
      }
    });

    on<GetRouteFromCurrentLocation>((event, emit) async {
      emit(GetRouteFromCurrentLocationLoading());
      try {
        final Map<String, RouteLeg> mapProfileRoute = await _routeRepository
            .getRouteFromCurrentLocation(event.coordinates);
        emit(GetRouteFromCurrentLocationSuccess(mapProfileRoute, event.route));
      } catch (e) {
        log(e.toString());
        emit(GetRouteFromCurrentLocationFailure());
      }
    });
  }
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'route_event.dart';
part 'route_state.dart';

class RouteBloc extends Bloc<RouteEvent, RouteState> {
  RouteBloc() : super(RouteInitial()) {
    on<RouteEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}

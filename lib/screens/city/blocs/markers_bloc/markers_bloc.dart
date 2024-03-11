import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'markers_event.dart';
part 'markers_state.dart';

class MarkersBloc extends Bloc<MarkersEvent, MarkersState> {
  MarkersBloc() : super(MarkersInitial()) {
    on<MarkersEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}

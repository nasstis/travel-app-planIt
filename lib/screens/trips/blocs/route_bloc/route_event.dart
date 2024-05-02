part of 'route_bloc.dart';

sealed class RouteEvent extends Equatable {
  const RouteEvent();

  @override
  List<Object> get props => [];
}

class CreateRoute extends RouteEvent {
  final String tripId;
  final List<String> coordinates;
  final String day;
  final String profile;

  const CreateRoute(this.tripId, this.coordinates, this.day, this.profile);
}

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

  const CreateRoute(this.tripId, this.coordinates, this.day);
}

class GetRoute extends RouteEvent {
  final String tripId;
  final String day;
  final String profile;

  const GetRoute(this.tripId, this.day, this.profile);
}

class GetRouteStep extends RouteEvent {
  final String tripId;
  final String day;
  final String profile;
  final int index;

  const GetRouteStep(this.tripId, this.day, this.profile, this.index);
}

class EditRoute extends RouteEvent {
  final String tripId;
  final List<String> coordinates;
  final String day;

  const EditRoute(this.tripId, this.coordinates, this.day);
}

class GetRouteFromCurrentLocation extends RouteEvent {
  final List<String> coordinates;
  final TripRoute route;

  const GetRouteFromCurrentLocation(this.coordinates, this.route);
}

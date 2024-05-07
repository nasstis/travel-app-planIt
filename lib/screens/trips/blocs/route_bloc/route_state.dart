part of 'route_bloc.dart';

sealed class RouteState extends Equatable {
  const RouteState();

  @override
  List<Object> get props => [];
}

final class RouteInitial extends RouteState {}

final class CreateRouteSuccess extends RouteState {}

final class CreateRouteLoading extends RouteState {}

final class CreateRouteFailure extends RouteState {}

final class GetRouteSuccess extends RouteState {
  final TripRoute route;

  const GetRouteSuccess(this.route);
}

final class GetRouteLoading extends RouteState {}

final class GetRouteFailure extends RouteState {}

final class GetRouteStepSuccess extends RouteState {
  final RouteLeg leg;

  const GetRouteStepSuccess(this.leg);
}

final class GetRouteStepLoading extends RouteState {}

final class GetRouteStepFailure extends RouteState {}

final class EditRouteSuccess extends RouteState {}

final class EditRouteLoading extends RouteState {}

final class EditRouteFailure extends RouteState {}

final class GetRouteFromCurrentLocationSuccess extends RouteState {
  final Map<String, RouteLeg> mapProfileRoute;
  final TripRoute route;

  const GetRouteFromCurrentLocationSuccess(this.mapProfileRoute, this.route);
}

final class GetRouteFromCurrentLocationLoading extends RouteState {}

final class GetRouteFromCurrentLocationFailure extends RouteState {}

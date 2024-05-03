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

part of 'get_working_hours_bloc.dart';

sealed class GetWorkingHoursEvent extends Equatable {
  const GetWorkingHoursEvent();

  @override
  List<Object> get props => [];
}

final class GetWotkingHoursRequired extends GetWorkingHoursEvent {
  final List<dynamic> openingHours;

  const GetWotkingHoursRequired({required this.openingHours});
}

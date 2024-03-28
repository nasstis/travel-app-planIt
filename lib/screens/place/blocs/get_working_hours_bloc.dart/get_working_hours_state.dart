part of 'get_working_hours_bloc.dart';

sealed class GetWorkingHoursState extends Equatable {
  const GetWorkingHoursState();

  @override
  List<Object> get props => [];
}

final class GetWorkingHoursInitial extends GetWorkingHoursState {}

final class GetWorkingHoursSucces extends GetWorkingHoursState {
  final bool isOpen;
  final Map<String, String> workingHours;
  final String currentDay;

  const GetWorkingHoursSucces(
      {required this.workingHours,
      required this.currentDay,
      required this.isOpen});
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:travel_app/utils/helpers/check_time.dart';

part 'get_working_hours_event.dart';
part 'get_working_hours_state.dart';

class GetWorkingHoursBloc
    extends Bloc<GetWorkingHoursEvent, GetWorkingHoursState> {
  GetWorkingHoursBloc() : super(GetWorkingHoursInitial()) {
    on<GetWotkingHoursRequired>((event, emit) {
      Map<String, String> workingHours = {};
      bool isOpen = false;
      DateTime date = DateTime.now();
      String currentDay = DateFormat('EEEE').format(date);
      for (var day in event.openingHours) {
        List<String> openingHoursSplit = day.split(': ');
        workingHours.addAll({openingHoursSplit[0]: openingHoursSplit[1]});
        if (day.contains(currentDay)) {
          isOpen = isValidTimeRange(openingHoursSplit[1]);
        }
      }
      emit(GetWorkingHoursSucces(
          workingHours: workingHours, currentDay: currentDay, isOpen: isOpen));
    });
  }
}

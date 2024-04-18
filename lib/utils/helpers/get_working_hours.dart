import 'package:intl/intl.dart';
import 'package:travel_app/utils/helpers/check_time.dart';

Map<String, dynamic> getPlaceWorkingHoursInfo(List openingHours) {
  Map<String, String> workingHours = {};
  bool isOpen = false;
  DateTime date = DateTime.now();
  String currentDay = DateFormat('EEEE').format(date);
  for (var day in openingHours) {
    List<String> openingHoursSplit = day.split(': ');
    workingHours.addAll({openingHoursSplit[0]: openingHoursSplit[1]});
    if (day.contains(currentDay)) {
      isOpen = isValidTimeRange(openingHoursSplit[1]);
    }
  }

  return {
    'workingHours': workingHours,
    'currentDay': currentDay,
    'isOpen': isOpen,
  };
}

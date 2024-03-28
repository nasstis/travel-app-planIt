import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

bool isValidTimeRange(String time) {
  if (time == 'Open 24 hours') {
    return true;
  } else if (time == 'Closed') {
    return false;
  }
  TimeOfDay now = TimeOfDay.now();
  List<String> hoursSplit = time.split(' – ');
  DateTime startTime = DateFormat.jm().parse(hoursSplit[0]);
  DateTime endTime = DateFormat.jm().parse(hoursSplit[1]);
  if (endTime.hour > startTime.hour) {
    return ((now.hour > startTime.hour) ||
            (now.hour == startTime.hour && now.minute >= startTime.minute)) &&
        ((now.hour < endTime.hour) ||
            (now.hour == endTime.hour && now.minute <= endTime.minute));
  } else {
    return ((now.hour > startTime.hour) ||
        (now.hour == startTime.hour && now.minute >= startTime.minute));
  }
}

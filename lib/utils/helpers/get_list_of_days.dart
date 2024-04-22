List<DateTime> getListOfDaysInDateRange(startDate, endDate) {
  final int daysToGenerate = endDate.difference(startDate).inDays + 1;
  final List<DateTime> days = List.generate(
    daysToGenerate,
    (i) => DateTime(
      startDate.year,
      startDate.month,
      startDate.day + (i),
    ),
  );
  return days;
}

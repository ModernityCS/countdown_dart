import 'dart:typed_data';

class TimeInfo {
  // This implements the Gregorian calendar leap year rules wherein a year is considered to
  // be a leap year if it is divisible by 4, excepting years divisible by 100, but including years divisible by 400.

  /// This function assumes the use of the [Gregorian calendar] or the [proleptic Gregorian calendar].
  bool isLeapYear(int year) =>
      (year % 4 == 0) && ((year % 100 != 0) || (year % 400 == 0));

  /// The 12 Months of the Year in days
  Uint8List monthsLength =
      Uint8List.fromList([31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]);

  /// The 12 Months of the Year name
  List<String> monthsName = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  /// Return the amount of seconds in one minute
  int get secondsInOneMinute => 60;

  /// Return the amount of seconds in one hour
  int get secondsInOneHour => 3600;

  /// Return the amount of seconds in one day
  int get secondsInOneDay => 86400;

  /// @startDate if left empty is set as [DateTime.now()]
  ///
  /// Return the length of the months from the startDate to EndDate
  List<int> getMonthsLength(DateTime endDate, {DateTime? startDate}) {
    /// Initialize an empty list that will contain the monthsLength between the two dates
    List<int> monthsLengthBetweenDates = [];

    /// Check if the  [@startDate] is null
    startDate = startDate ?? DateTime.now();

    /// Get the [@startDate month] and the [@endDate month]
    int fromMonth = startDate.month;
    int toMonth = endDate.month;

    /// How many months between [@startDate] and [@endDate]
    int differenceBetweenMonths = 0;

    // Cases
    if (fromMonth == toMonth && DateTime.now().year != endDate.year) {
      differenceBetweenMonths = 12;
    } else if (fromMonth > toMonth) {
      differenceBetweenMonths = (fromMonth + toMonth) % 12;
    } else {
      differenceBetweenMonths = (toMonth + fromMonth) % 12;
    }

    /// For [@DisplaySettings] -> Add 12 months for each extra year between [@startDate] and [@endDate]
    int years = (endDate.year - startDate.year) - 1;
    differenceBetweenMonths += (years * 12);

    if (DateTime.now().year == endDate.year && fromMonth == toMonth) {
      monthsLengthBetweenDates.add(monthsLength[fromMonth - 1]);
    } else {
      for (int i = 0; i < differenceBetweenMonths + 1; i++) {
        monthsLengthBetweenDates.add(monthsLength[((fromMonth - 1) + i) % 12]);
      }
    }

    return monthsLengthBetweenDates;
  }
}

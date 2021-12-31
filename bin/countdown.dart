class CountDown {
  ///Seconds in a minute
  static const int _minuteSecond = 60;

  ///Seconds in an hour
  static const int _hourSecond = 3600;

  ///days in seconds
  static const int _daySecond = 86400;

  /// Months days
  List<int> monthDays = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

  /// Months name
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

  /// Get list of needed months
  List<int> getNeededMonthDays(DateTime end) {
    List<int> neededMonthDays = [];

    int fromMonth = DateTime.now().month;
    int toMonth = end.month;

    /// Monthsù
    int differenceBetweenMonths = 0;
    if (fromMonth == toMonth && DateTime.now().year != end.year) {
      differenceBetweenMonths = 12;
    } else if (fromMonth > toMonth) {
      differenceBetweenMonths = (fromMonth + toMonth) % 12;
    } else {
      differenceBetweenMonths = (toMonth + fromMonth) % 12;
    }

    // CountDown years
    int years = (end.year - DateTime.now().year) - 1;

    differenceBetweenMonths += (years * 12);

    if (DateTime.now().year == end.year && fromMonth == toMonth) {
      neededMonthDays.add(monthDays[fromMonth - 1]);
    } else {
      for (int i = 0; i < differenceBetweenMonths + 1; i++) {
        neededMonthDays.add(monthDays[((fromMonth - 1) + i) % 12]);
      }
    }

    return neededMonthDays;
  }

  int monthsUntil(DateTime end) {
    List<int> months = getNeededMonthDays(end);

    return months.length - 1 > 0 ? months.length - 2 : 0;
  }

  int yearsUntil(DateTime end) {
    int years = ((end.year - DateTime.now().year) - 1);

    return years > 0 ? years : 0;
  }

  int countMounth(List<int> months, DateTime end) {
    int days = end.difference(DateTime.now()).inDays;
    int count = 0;

    for (int i = 0; i < months.length; i++) {
      if (months[i] >= days) {
        days -= months[i];
        count++;
      }
    }

    return count;
  }

  bool isLeapYear(int year) =>
      (year % 4 == 0) && ((year % 100 != 0) || (year % 400 == 0));

  List<int> countYears(DateTime end, int days, int seconds) {
    int currYear = DateTime.now().year;
    int diffYears = end.year - currYear;

    int years = 0;
    for (int i = 0; i < diffYears; i++) {
      int leap = isLeapYear(currYear + i) ? 1 : 0;
      if (days >= 365 + leap) {
        seconds = seconds - ((365 + leap) * _daySecond);
        days -= 365 + leap;
        years++;
      }
    }

    // Return a list of needed
    return [years, days, seconds];
  }

  List<int> countWeeks(int days, int seconds) {
    /// Calculate weeks
    int weeks = days ~/ 7;
    days %= 7;

    /// Recalculate the remaining seconds by removing the days used for counting weeks
    int daysWeek = weeks * 7;
    seconds = seconds - (daysWeek * _daySecond);

    // Return a list of needed
    return [weeks, days, seconds];
  }

  void calculateTime(DateTime end) {
    // Total seconds until end Date
    int seconds = end.difference(DateTime.now()).inSeconds;
    if (seconds < 0) seconds = 0;

    // Total days until endDate
    int inDays = end.difference(DateTime.now()).inDays;
    if (inDays < 0) inDays = 0;

    /// Check years
    List<int> processYears = countYears(end, inDays, seconds);
    int years = processYears[0];
    inDays = processYears[1];
    seconds = processYears[2];

    /// Check months
    List<int> monthsList = getNeededMonthDays(end);
    int months = 0;
    for (int i = 0; i < monthsList.length; i++) {
      if (inDays > monthsList[i]) {
        seconds = seconds - (monthsList[i] * _daySecond);
        inDays -= monthsList[i];
        months++;
      }
    }

    ///  Weeks
    int weeks = 0;
    if (inDays >= 7) {
      List<int> processWeeks = countWeeks(inDays, seconds);
      weeks = processWeeks[0];
      inDays = processWeeks[1];
      seconds = processWeeks[2];
    }

    // Calculate hours, minutes and seconds
    int secondsAfterProcessing = seconds - (inDays * _daySecond);

    int nowHours = secondsAfterProcessing ~/ _hourSecond;
    secondsAfterProcessing %= _hourSecond;

    int nowMinutes = secondsAfterProcessing ~/ _minuteSecond;
    secondsAfterProcessing %= _minuteSecond;

    print(
        "Years: $years, Months: $months, Weeks: $weeks, Days: $inDays, Hours: $nowHours, Minutes: $nowMinutes, Seconds: $secondsAfterProcessing");
  }
}

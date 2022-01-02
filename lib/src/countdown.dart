import 'package:countdown_dart/src/countdown_results.dart';
import 'package:countdown_dart/src/display_settings.dart';
import 'package:countdown_dart/src/time_info.dart';

class Countdown {
  final TimeInfo _timeInfo = TimeInfo();

  DisplaySettings displaySettings = DisplaySettings();

  int monthsLeft(DateTime end) {
    List<int> monthsLeft = _timeInfo.getMonthsLength(end);

    return monthsLeft.length - 1 > 0 ? monthsLeft.length - 2 : 0;
  }

  int yearsLeft(DateTime end) {
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

  List<int> countYears(DateTime end, int days, int seconds) {
    int currYear = DateTime.now().year;
    int diffYears = end.year - currYear;

    int years = 0;
    for (int i = 0; i < diffYears; i++) {
      int leap = _timeInfo.isLeapYear(currYear + i) ? 1 : 0;
      if (days >= 365 + leap) {
        seconds = seconds - ((365 + leap) * _timeInfo.secondsInOneDay);
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
    seconds = seconds - (daysWeek * _timeInfo.secondsInOneDay);

    // Return a list of needed
    return [weeks, days, seconds];
  }

  CountdownResults calculateTime(DateTime end) {
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
    List<int> monthsList = _timeInfo.getMonthsLength(end);
    int months = 0;
    // for (int i = 0; i < monthsList.length; i++) {
    //   if (inDays > monthsList[i]) {
    //     seconds = seconds - (monthsList[i] * _timeInfo.secondsInOneDay);
    //     inDays -= monthsList[i];
    //     months++;
    //   }
    // }

    ///  Weeks
    int weeks = 0;
    // if (inDays >= 7) {
    //   List<int> processWeeks = countWeeks(inDays, seconds);
    //   weeks = processWeeks[0];
    //   inDays = processWeeks[1];
    //   seconds = processWeeks[2];
    // }

    // Calculate hours, minutes and seconds
    int secondsAfterProcessing = seconds - (inDays * _timeInfo.secondsInOneDay);

    int nowHours = secondsAfterProcessing ~/ _timeInfo.secondsInOneHour;
    secondsAfterProcessing %= _timeInfo.secondsInOneHour;

    int nowMinutes = secondsAfterProcessing ~/ _timeInfo.secondsInOneMinute;
    secondsAfterProcessing %= _timeInfo.secondsInOneMinute;

    print(
        "Years: $years, Months: $months, Weeks: $weeks, Days: $inDays, Hours: $nowHours, Minutes: $nowMinutes, Seconds: $secondsAfterProcessing");

    return CountdownResults(
        years: years,
        months: months,
        weeks: weeks,
        days: inDays,
        hours: nowHours,
        minutes: nowMinutes,
        seconds: secondsAfterProcessing);
  }
}

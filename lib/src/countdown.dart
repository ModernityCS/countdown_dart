import 'package:countdown_dart/src/countdown_results.dart';
import 'package:countdown_dart/src/display_settings.dart';
import 'package:countdown_dart/src/time_info.dart';

class Countdown {
  /// Object Parameters
  final DateTime endDate;
  DateTime? startDate = DateTime.now();
  DisplaySettings? displaySettings;

  /// @startDate if left empty is set as [DateTime.now()]
  Countdown({required this.endDate, this.displaySettings}) {
    displaySettings = displaySettings ?? DisplaySettings();
  }

  /// Private/Local object call to compute the countdown
  final TimeInfo _timeInfo = TimeInfo();

  /// Compute years based on the current days left
  ///
  /// The logic behind this is simple: if there are > 365 or 366 increase years left and subtract these days from all the days left until the endDate
  List<int> _computeYears(DateTime end, int days, int seconds) {
    /// From @StartDate to @EndDate check each year to see if it's a leap year
    /// For-loop exec

    /// Check how many years there are between the startDate and EndDate
    int diffYears = end.year - startDate!.year;

    /// Self-explanatory
    int yearsLeft = 0;

    for (int i = 0; i < diffYears; i++) {
      int leap = _timeInfo.isLeapYear(startDate!.year + i) ? 1 : 0;

      // If there are >365 + leap (leap == 1 if is a leapYear and 0 if not) increment yearsLeft
      if (days >= 365 + leap) {
        /// Compute the remaining seconds by removing the days subtracted for counting years
        seconds = seconds - ((365 + leap) * _timeInfo.secondsInOneDay);

        /// Compute the remaining days by removing the days subtracted for counting years
        days -= 365 + leap;

        /// Increase yearsLeft
        yearsLeft++;
      }
    }

    // Return updated data
    // Usage of list:
    // * there are not tuples in DART
    // * Creating an object that stores the new data might be a solution, but lists do the work too.
    return [yearsLeft, days, seconds];
  }

  /// Compute weeks based on the current days left
  ///
  /// The logic, similar to years, is simple: if there are more than 7 days left, than that's a week
  List<int> _computeWeeks(int days, int seconds) {
    /// Total weeks left
    int weeks = days ~/ 7;

    /// Compute the remaining days by removing the days subtracted for counting weeks
    days %= 7;

    /// Compute the remaining seconds by removing the days subtracted for counting weeks
    int daysWeek = weeks * 7;
    seconds = seconds - (daysWeek * _timeInfo.secondsInOneDay);

    // Return updated data
    // Usage of list:
    // * there are not tuples in DART
    // * Creating an object that stores the new data might be a solution, but lists do the work too.
    return [weeks, days, seconds];
  }

  /// Seconds left between @startDate and @endDate
  int get _seconds => endDate.difference(DateTime.now()).inSeconds;

  /// Days left between @startDate and @endDate
  int get _days => endDate.difference(DateTime.now()).inDays;

  /// [Countdown] method returns the countdown with the [@displaySettings] you setted in the constructor
  ///
  /// Returns [CountDownResults] object
  CountdownResults countdown() {
    /// Prevention:: StartDate or EndDate can't be in the past.
    assert(startDate!.year < DateTime.now().year ||
        endDate.year < startDate!.year);

    /// Initialize [@CountdownResults] object
    CountdownResults countdownResults = CountdownResults();

    /// Total seconds left between @startDate and @endDate
    /// Double Prevention:: If seconds left is computes as negative number(in the past) then set on 0
    int seconds = _seconds;
    seconds = seconds > 0 ? seconds : 0;

    /// Total days left between @startDate and @endDate
    /// Double Prevention:: If days left is computes as negative number(in the past) then set on 0
    int days = _days;
    days = days > 0 ? days : 0;

    /// Compute [years] & re-calculate the remaining days and seconds left
    if (displaySettings!.years) {
      List<int> computeYearsData = _computeYears(endDate, days, seconds);
      countdownResults.years = computeYearsData[0];
      days = computeYearsData[1];
      seconds = computeYearsData[2];
    }

    /// Compute [months] & re-calculate the remaining days and seconds left
    if (displaySettings!.months) {
      List<int> computedMonths = _timeInfo.getMonthsLength(endDate);
      for (int i = 0; i < computedMonths.length; i++) {
        if (days > computedMonths[i]) {
          seconds = seconds - (computedMonths[i] * _timeInfo.secondsInOneDay);
          days -= computedMonths[i];
          countdownResults.months++;
        }
      }
    }

    /// Compute [weeks] & re-calculate the remaining days and seconds left
    if (days >= 7 && displaySettings!.weeks) {
      List<int> computeWeeksData = _computeWeeks(days, seconds);
      countdownResults.weeks = computeWeeksData[0];
      days = computeWeeksData[1];
      seconds = computeWeeksData[2];
    }

    /// If displaySettings has days setted: return the [days] left...
    if (displaySettings!.days) {
      countdownResults.days = days;
      seconds = seconds - (days * _timeInfo.secondsInOneDay);
    }

    /// If displaySettings has hours setted: Compute [hours]
    if (displaySettings!.hours) {
      int hours = seconds ~/ _timeInfo.secondsInOneHour;
      seconds %= _timeInfo.secondsInOneHour;
      countdownResults.hours = hours;
    }

    /// If displaySettings has minutes setted: Compute [minutes]
    if (displaySettings!.minutes) {
      int minutes = seconds ~/ _timeInfo.secondsInOneMinute;
      seconds %= _timeInfo.secondsInOneMinute;
      countdownResults.minutes = minutes;
    }

    /// If displaySettings has seconds setted: Compute [seconds]
    if (displaySettings!.seconds) {
      countdownResults.seconds = seconds;
    }

    // Return countdownResults object
    return countdownResults;
  }
}

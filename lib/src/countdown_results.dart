///
/// CountdownResults - Object to store the value of the current countdown
class CountdownResults {
  int years = 0;

  int months = 0;

  int weeks = 0;

  int days = 0;

  int hours = 0;

  int minutes = 0;

  int seconds = 0;

  CountdownResults({
    this.years = 0,
    this.months = 0,
    this.weeks = 0,
    this.days = 0,
    this.hours = 0,
    this.minutes = 0,
    this.seconds = 0,
  });

  @override
  String toString() {
    return "$years, $months, $weeks, $days, $hours, $minutes, $seconds";
  }
}

/// [@DisplaySettings] allows you to change how the countdown is going to be displayed on screen
///
/// The class will allow to display only the options setted on [true] -
/// by deactivating an option its value will be passed to the previous option
///
/// ### [Example - 1 month Left]
/// 1. Months option setted on true: [0 years, 1 month, 0 weeks....]
/// 2. Months option setted on false: [0 years, 1 month, 0 weeks....]

class DisplaySettings {
  /// Display how many [**years**] are left until the end of the countdown
  bool years;

  /// Display how many [**months**] are left until the end of the countdown
  bool months;

  /// Display how many [**weeks**] are left until the end of the countdown
  bool weeks;

  /// Display how many [**days**] are left until the end of the countdown
  bool days;

  /// Display how many [**hours**] are left until the end of the countdown
  bool hours;

  /// Display how many [**minutes**] are left until the end of the countdown
  bool minutes;

  /// Display how many [**seconds**] are left until the end of the countdown
  bool seconds;

  /// [DisplaySettings] Constructor
  ///
  /// Change how the countdown is going to be displayed on screen
  DisplaySettings(
      {this.years = true,
      this.months = true,
      this.weeks = true,
      this.days = true,
      this.hours = true,
      this.minutes = true,
      this.seconds = true});

  /// Setters for the after-math
  void setDisplayYears(bool value) => years = value;

  void setDisplayMonths(bool value) => months = value;

  void setDisplayWeeks(bool value) => weeks = value;

  void setDisplayDays(bool value) => days = value;

  void setDisplayHours(bool value) => hours = value;

  void setDisplayMinutes(bool value) => minutes = value;

  void setDisplaySeconds(bool value) => seconds = value;
}

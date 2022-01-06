import 'dart:async';

import 'package:countdown_dart/countdown_dart.dart';
import 'package:countdown_dart/src/countdown_results.dart';
import 'package:countdown_dart/src/display_settings.dart';

// update the state of the build every second
void periodicProcess(Countdown countdown) {
  /// CountdownResults: Where the countdown values are being store
  CountdownResults results = CountdownResults();

  /// Update each second
  Timer.periodic(const Duration(seconds: 1), (timer) async {
    results = countdown.countdown();
    print(results.toString());
  });
}

void main() {
  /// DisplaySettings
  DisplaySettings displaySettings = DisplaySettings(
      years: false,
      months: false,
      weeks: false,
      days: false,
      hours: false,
      minutes: false);

  /// Call countdown
  Countdown countDown = Countdown(
      endDate: DateTime(2022, 03, 14, 11, 00),
      displaySettings: displaySettings);

  // Update the countdown values each second
  periodicProcess(countDown);
}

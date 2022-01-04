import 'dart:async';

import 'package:countdown_dart/countdown_dart.dart';
import 'package:countdown_dart/src/countdown_results.dart';
import 'package:countdown_dart/src/display_settings.dart';

CountdownResults results = CountdownResults();

// update the state of the build every second
void periodicProcess(Countdown countdown) {
  Timer.periodic(const Duration(seconds: 1), (timer) async {
    results = countdown.countdown();
    print(results.toString());
  });
}

void main() {
  DisplaySettings displaySettings = DisplaySettings(
      years: false,
      months: false,
      weeks: false,
      days: false,
      hours: false,
      minutes: false);
  Countdown countDown = Countdown(
      endDate: DateTime(2022, 03, 14, 11, 00),
      displaySettings: displaySettings);

  periodicProcess(countDown);
}

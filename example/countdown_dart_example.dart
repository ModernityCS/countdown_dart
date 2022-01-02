import 'dart:async';

import 'package:countdown_dart/countdown_dart.dart';
import 'package:countdown_dart/src/countdown_results.dart';

CountdownResults results = CountdownResults();

// update the state of the build every second
void periodicProcess(DateTime end) {
  Timer.periodic(const Duration(seconds: 1), (timer) async {
    results = Countdown().calculateTime(end);
    print(results.toString());
  });
}

void main() {
  DateTime end = DateTime(2023);
  periodicProcess(end);
}

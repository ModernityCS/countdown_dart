import 'dart:async';

import 'countdown.dart';

// update the state of the build every second
void periodicProcess(DateTime end) {
  Timer.periodic(const Duration(seconds: 1), (timer) async {
    CountDown().calculateTime(end);
  });
}

void main() {
  DateTime end = DateTime(2022);
  periodicProcess(end);
}

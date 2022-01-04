import 'package:countdown_dart/countdown_dart.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {
    Countdown countDown = Countdown(endDate: DateTime(2021));

    setUp(() {
      // Additional setup goes here.
    });

    test('First Test', () {
      // expect(countDown.(), 7);
    });
  });
}

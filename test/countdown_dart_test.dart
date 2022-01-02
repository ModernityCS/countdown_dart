import 'package:countdown_dart/countdown_dart.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {
    Countdown countDown = Countdown();

    setUp(() {
      // Additional setup goes here.
    });

    test('First Test', () {
      expect(countDown.yearsLeft(DateTime(2029)), 7);
    });
  });
}

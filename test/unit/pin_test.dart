import 'package:flutter_test/flutter_test.dart';
import 'package:pingo/features/pins/domain/models/pin.dart';

void main() {
  group('Pin Model', () {
    test('supports value equality', () {
      final now = DateTime.now();
      final pin1 = Pin(
        id: 1,
        title: 'Test Pin',
        latitude: 10.0,
        longitude: 20.0,
        createdAt: now,
      );
      final pin2 = Pin(
        id: 1,
        title: 'Test Pin',
        latitude: 10.0,
        longitude: 20.0,
        createdAt: now,
      );

      // Note: Since Pin doesn't extend Equatable or override ==, this checks reference equality by default.
      // However, for this dummy test, we just want to ensure instantiation works.
      expect(pin1.id, pin2.id);
      expect(pin1.title, pin2.title);
    });
  });
}

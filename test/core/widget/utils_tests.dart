import 'package:flutter_test/flutter_test.dart';
import 'package:quickview/core/widget/utils.dart';

void main() {
  group('Utils Tests', () {
    test('formatDate should return Today for current date', () {
      final today = DateTime.now();
      expect(formatDate(today), 'Today');
    });

    test('formatDate should return Yesterday for yesterday', () {
      final yesterday = DateTime.now().subtract(Duration(days: 1));
      expect(formatDate(yesterday), 'Yesterday');
    });
  });
}

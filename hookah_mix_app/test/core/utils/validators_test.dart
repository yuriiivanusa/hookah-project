import 'package:flutter_test/flutter_test.dart';
import 'package:hookah_mix_master/core/utils/validators.dart';

void main() {
  group('Validators.email', () {
    test('returns null for valid email', () {
      expect(Validators.email('user@example.com'), isNull);
    });
    test('returns error for empty', () {
      expect(Validators.email(''), isNotNull);
    });
    test('returns error for missing @', () {
      expect(Validators.email('notanemail'), isNotNull);
    });
    test('returns error for null', () {
      expect(Validators.email(null), isNotNull);
    });
  });

  group('Validators.password', () {
    test('returns null for valid password', () {
      expect(Validators.password('securePass1'), isNull);
    });
    test('returns error for too short', () {
      expect(Validators.password('short'), isNotNull);
    });
    test('returns error for empty', () {
      expect(Validators.password(''), isNotNull);
    });
  });

  group('Validators.mixPercentage', () {
    test('returns null for valid percentage', () {
      expect(Validators.mixPercentage('50'), isNull);
    });
    test('returns error for 0', () {
      expect(Validators.mixPercentage('0'), isNotNull);
    });
    test('returns error for >100', () {
      expect(Validators.mixPercentage('101'), isNotNull);
    });
    test('returns error for non-number', () {
      expect(Validators.mixPercentage('abc'), isNotNull);
    });
  });

  group('Validators.mixName', () {
    test('returns null for valid name', () {
      expect(Validators.mixName('Summer Mix'), isNull);
    });
    test('returns error for empty', () {
      expect(Validators.mixName(''), isNotNull);
    });
    test('returns error for >50 chars', () {
      expect(Validators.mixName('a' * 51), isNotNull);
    });
  });
}

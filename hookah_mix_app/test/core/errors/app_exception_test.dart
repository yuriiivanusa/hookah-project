import 'package:flutter_test/flutter_test.dart';
import 'package:hookah_mix_master/core/errors/auth_exception.dart';
import 'package:hookah_mix_master/core/errors/failure.dart';
import 'package:hookah_mix_master/core/errors/network_exception.dart';

void main() {
  group('AuthException factories', () {
    test('invalidEmail has correct code', () {
      final e = AuthException.invalidEmail();
      expect(e.code, 'invalid-email');
      expect(e.message, isNotEmpty);
    });

    test('weakPassword has correct code', () {
      final e = AuthException.weakPassword();
      expect(e.code, 'weak-password');
    });

    test('unknown uses provided detail', () {
      final e = AuthException.unknown('custom error');
      expect(e.message, 'custom error');
    });
  });

  group('NetworkException factories', () {
    test('noConnection has correct code', () {
      final e = NetworkException.noConnection();
      expect(e.code, 'no-connection');
    });

    test('timeout has correct code', () {
      final e = NetworkException.timeout();
      expect(e.code, 'timeout');
    });
  });

  group('Result', () {
    test('Success.dataOrNull returns data', () {
      const result = Success<int>(42);
      expect(result.dataOrNull, 42);
      expect(result.isSuccess, isTrue);
    });

    test('Failure.dataOrNull returns null', () {
      final result = Failure<int>(NetworkException.noConnection());
      expect(result.dataOrNull, isNull);
      expect(result.isFailure, isTrue);
    });

    test('Result.when routes correctly', () {
      const success = Success<String>('ok');
      final value = success.when(success: (data) => data, failure: (_) => 'error');
      expect(value, 'ok');
    });
  });
}

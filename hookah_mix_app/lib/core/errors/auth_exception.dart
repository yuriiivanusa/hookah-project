import 'app_exception.dart';

final class AuthException extends AppException {
  const AuthException({required super.message, super.code, super.stackTrace});

  factory AuthException.invalidEmail() => const AuthException(
    message: 'Invalid email address',
    code: 'invalid-email',
  );

  factory AuthException.weakPassword() => const AuthException(
    message: 'Password is too weak',
    code: 'weak-password',
  );

  factory AuthException.emailAlreadyInUse() => const AuthException(
    message: 'Email is already in use',
    code: 'email-already-in-use',
  );

  factory AuthException.userNotFound() =>
      const AuthException(message: 'User not found', code: 'user-not-found');

  factory AuthException.wrongPassword() => const AuthException(
    message: 'Incorrect password',
    code: 'wrong-password',
  );

  factory AuthException.tooManyRequests() => const AuthException(
    message: 'Too many attempts. Try again later',
    code: 'too-many-requests',
  );

  factory AuthException.unknown([String? detail]) =>
      AuthException(message: detail ?? 'Authentication error', code: 'unknown');
}

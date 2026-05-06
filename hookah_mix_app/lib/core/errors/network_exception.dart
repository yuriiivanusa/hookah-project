import 'app_exception.dart';

final class NetworkException extends AppException {
  const NetworkException({
    required super.message,
    super.code,
    super.stackTrace,
  });

  factory NetworkException.noConnection() => const NetworkException(
    message: 'No internet connection',
    code: 'no-connection',
  );

  factory NetworkException.timeout() =>
      const NetworkException(message: 'Request timed out', code: 'timeout');

  factory NetworkException.notFound() =>
      const NetworkException(message: 'Resource not found', code: 'not-found');

  factory NetworkException.permissionDenied() => const NetworkException(
    message: 'Permission denied',
    code: 'permission-denied',
  );

  factory NetworkException.unknown([String? detail]) =>
      NetworkException(message: detail ?? 'Network error', code: 'unknown');
}

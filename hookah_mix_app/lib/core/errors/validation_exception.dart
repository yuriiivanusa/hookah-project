import 'app_exception.dart';

final class ValidationException extends AppException {
  const ValidationException({required super.message, super.code, this.field});

  final String? field;

  factory ValidationException.field(String field, String message) =>
      ValidationException(message: message, code: 'validation-error', field: field);

  factory ValidationException.mixPercentageExceeds100() => const ValidationException(
        message: 'Total mix percentage cannot exceed 100%',
        code: 'mix-percentage-exceeded',
      );

  factory ValidationException.maxComponentsReached() => const ValidationException(
        message: 'Maximum 5 components per mix',
        code: 'max-components-reached',
      );
}

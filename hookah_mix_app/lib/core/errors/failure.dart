import 'app_exception.dart';

sealed class Result<T> {
  const Result();
}

final class Success<T> extends Result<T> {
  const Success(this.data);
  final T data;
}

final class Failure<T> extends Result<T> {
  const Failure(this.exception);
  final AppException exception;

  String get message => exception.message;
}

extension ResultExtensions<T> on Result<T> {
  bool get isSuccess => this is Success<T>;
  bool get isFailure => this is Failure<T>;

  T? get dataOrNull => switch (this) {
        Success<T>(:final data) => data,
        Failure<T>() => null,
      };

  R when<R>({
    required R Function(T data) success,
    required R Function(AppException exception) failure,
  }) =>
      switch (this) {
        Success<T>(:final data) => success(data),
        Failure<T>(:final exception) => failure(exception),
      };
}

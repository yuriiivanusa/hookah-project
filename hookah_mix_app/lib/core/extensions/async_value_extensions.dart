import 'package:flutter_riverpod/flutter_riverpod.dart';

extension AsyncValueExtensions<T> on AsyncValue<T> {
  T? get valueOrNull => whenOrNull(data: (v) => v);
  bool get isLoading => this is AsyncLoading;
  bool get hasError => this is AsyncError;
}

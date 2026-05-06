import 'package:freezed_annotation/freezed_annotation.dart';

part 'tobacco_filter.freezed.dart';

enum TobaccoSortOrder { popularityDesc, nameAsc, nameDesc, strengthAsc, strengthDesc }

@freezed
abstract class TobaccoFilter with _$TobaccoFilter {
  const factory TobaccoFilter({
    @Default('') String query,
    String? brandId,
    String? leafType,
    String? flavorCategory,
    @Default(1) int minStrength,
    @Default(5) int maxStrength,
    @Default(TobaccoSortOrder.popularityDesc) TobaccoSortOrder sortOrder,
  }) = _TobaccoFilter;

  const TobaccoFilter._();

  bool get hasActiveFilters =>
      brandId != null ||
      leafType != null ||
      flavorCategory != null ||
      minStrength != 1 ||
      maxStrength != 5;

  TobaccoFilter clear() => const TobaccoFilter();
}

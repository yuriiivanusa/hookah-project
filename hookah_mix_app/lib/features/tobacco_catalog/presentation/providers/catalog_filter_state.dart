import 'package:hookah_mix_master/features/tobacco_catalog/domain/entities/tobacco_filter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'catalog_filter_state.g.dart';

@riverpod
class CatalogFilter extends _$CatalogFilter {
  @override
  TobaccoFilter build() => const TobaccoFilter();

  void setQuery(String query) => state = state.copyWith(query: query);

  void setBrand(String? brandId) => state = state.copyWith(brandId: brandId);

  void setLeafType(String? leafType) => state = state.copyWith(leafType: leafType);

  void setFlavorCategory(String? category) => state = state.copyWith(flavorCategory: category);

  void setStrengthRange(int min, int max) =>
      state = state.copyWith(minStrength: min, maxStrength: max);

  void setSortOrder(TobaccoSortOrder order) => state = state.copyWith(sortOrder: order);

  void clearFilters() => state = state.clear();
}

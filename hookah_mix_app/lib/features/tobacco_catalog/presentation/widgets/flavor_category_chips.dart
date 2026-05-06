import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hookah_mix_master/features/tobacco_catalog/presentation/providers/catalog_filter_state.dart';

const _categories = ['fruity', 'sweet', 'fresh', 'spice', 'earthy', 'floral', 'citrus', 'mint'];

class FlavorCategoryChips extends ConsumerWidget {
  const FlavorCategoryChips({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(catalogFilterProvider.select((f) => f.flavorCategory));

    return Wrap(
      spacing: 8,
      children: _categories.map((cat) {
        final isSelected = selected == cat;
        return FilterChip(
          label: Text(cat),
          selected: isSelected,
          onSelected: (_) =>
              ref.read(catalogFilterProvider.notifier).setFlavorCategory(isSelected ? null : cat),
        );
      }).toList(),
    );
  }
}

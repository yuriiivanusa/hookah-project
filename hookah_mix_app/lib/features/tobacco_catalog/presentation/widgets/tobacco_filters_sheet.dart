import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hookah_mix_master/core/extensions/context_extensions.dart';
import 'package:hookah_mix_master/features/tobacco_catalog/domain/entities/tobacco_filter.dart';
import 'package:hookah_mix_master/features/tobacco_catalog/presentation/providers/catalog_filter_state.dart';
import 'package:hookah_mix_master/features/tobacco_catalog/presentation/providers/tobacco_providers.dart';

const _leafTypes = ['virginia', 'burley', 'oriental', 'mixed'];

const _leafTypeLabels = {
  'virginia': 'Virginia',
  'burley': 'Burley',
  'oriental': 'Oriental',
  'mixed': 'Mixed',
};

const _flavorCategories = [
  'fruity',
  'sweet',
  'fresh',
  'spice',
  'earthy',
  'floral',
  'citrus',
  'mint',
];

class TobaccoFiltersSheet extends ConsumerWidget {
  const TobaccoFiltersSheet({super.key});

  static Future<void> show(BuildContext context) => showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useRootNavigator: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) => const TobaccoFiltersSheet(),
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(catalogFilterProvider);
    final brandsAsync = ref.watch(brandListProvider);
    final l10n = context.l10n;

    return DraggableScrollableSheet(
      initialChildSize: 0.75,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      expand: false,
      builder: (_, controller) => Column(
        children: [
          const SizedBox(height: 8),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.outlineVariant,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Expanded(
            child: ListView(
              controller: controller,
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
              children: [
                _SortSection(filter: filter, ref: ref),
                const Divider(height: 32),
                brandsAsync.when(
                  data: (brands) => _BrandSection(
                    brands: brands
                        .map((b) => (id: b.id, name: b.name))
                        .toList(),
                    selectedBrandId: filter.brandId,
                    onChanged: (id) =>
                        ref.read(catalogFilterProvider.notifier).setBrand(id),
                  ),
                  loading: () => const SizedBox.shrink(),
                  error: (_, _) => const SizedBox.shrink(),
                ),
                const Divider(height: 32),
                Text(
                  l10n.catalogFilterLeafType,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: _leafTypes.map((lt) {
                    final selected = filter.leafType == lt;
                    return FilterChip(
                      label: Text(_leafTypeLabels[lt] ?? lt),
                      selected: selected,
                      onSelected: (_) => ref
                          .read(catalogFilterProvider.notifier)
                          .setLeafType(selected ? null : lt),
                    );
                  }).toList(),
                ),
                const Divider(height: 32),
                Text(
                  l10n.catalogFilterFlavor,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: _flavorCategories.map((cat) {
                    final selected = filter.flavorCategory == cat;
                    return FilterChip(
                      label: Text(cat),
                      selected: selected,
                      onSelected: (_) => ref
                          .read(catalogFilterProvider.notifier)
                          .setFlavorCategory(selected ? null : cat),
                    );
                  }).toList(),
                ),
                const Divider(height: 32),
                Text(
                  l10n.catalogFilterStrength,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: 8),
                _StrengthRangeSlider(filter: filter, ref: ref),
                const SizedBox(height: 24),
                if (filter.hasActiveFilters)
                  OutlinedButton(
                    onPressed: () =>
                        ref.read(catalogFilterProvider.notifier).clearFilters(),
                    child: Text(l10n.catalogFilterReset),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SortSection extends StatelessWidget {
  const _SortSection({required this.filter, required this.ref});

  final TobaccoFilter filter;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final sortLabels = {
      TobaccoSortOrder.popularityDesc: l10n.catalogSortPopularityDesc,
      TobaccoSortOrder.nameAsc: l10n.catalogSortNameAsc,
      TobaccoSortOrder.nameDesc: l10n.catalogSortNameDesc,
      TobaccoSortOrder.strengthAsc: l10n.catalogSortStrengthAsc,
      TobaccoSortOrder.strengthDesc: l10n.catalogSortStrengthDesc,
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.catalogSortBy, style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(height: 8),
        DropdownButtonFormField<TobaccoSortOrder>(
          initialValue: filter.sortOrder,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
          items: TobaccoSortOrder.values.map((order) {
            return DropdownMenuItem(
              value: order,
              child: Text(sortLabels[order] ?? order.name),
            );
          }).toList(),
          onChanged: (order) {
            if (order != null) {
              ref.read(catalogFilterProvider.notifier).setSortOrder(order);
            }
          },
        ),
      ],
    );
  }
}

class _BrandSection extends StatelessWidget {
  const _BrandSection({
    required this.brands,
    required this.selectedBrandId,
    required this.onChanged,
  });

  final List<({String id, String name})> brands;
  final String? selectedBrandId;
  final void Function(String?) onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.catalogFilterBrand,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String?>(
          initialValue: selectedBrandId,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
          items: [
            DropdownMenuItem(
              value: null,
              child: Text('— ${l10n.catalogFilterBrand} —'),
            ),
            ...brands.map(
              (b) => DropdownMenuItem(value: b.id, child: Text(b.name)),
            ),
          ],
          onChanged: onChanged,
        ),
      ],
    );
  }
}

class _StrengthRangeSlider extends StatelessWidget {
  const _StrengthRangeSlider({required this.filter, required this.ref});

  final TobaccoFilter filter;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              l10n.catalogStrengthLight,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Text(
              l10n.catalogStrengthStrong,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
        RangeSlider(
          values: RangeValues(
            filter.minStrength.toDouble(),
            filter.maxStrength.toDouble(),
          ),
          min: 1,
          max: 5,
          divisions: 4,
          labels: RangeLabels(
            filter.minStrength.toString(),
            filter.maxStrength.toString(),
          ),
          onChanged: (range) => ref
              .read(catalogFilterProvider.notifier)
              .setStrengthRange(range.start.round(), range.end.round()),
        ),
      ],
    );
  }
}

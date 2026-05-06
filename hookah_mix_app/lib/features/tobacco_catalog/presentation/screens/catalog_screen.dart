import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hookah_mix_master/core/extensions/context_extensions.dart';
import 'package:hookah_mix_master/core/widgets/error_view.dart';
import 'package:hookah_mix_master/features/tobacco_catalog/presentation/providers/catalog_filter_state.dart';
import 'package:hookah_mix_master/features/tobacco_catalog/presentation/providers/tobacco_providers.dart';
import 'package:hookah_mix_master/features/tobacco_catalog/presentation/widgets/catalog_search_bar.dart';
import 'package:hookah_mix_master/features/tobacco_catalog/presentation/widgets/flavor_category_chips.dart';
import 'package:hookah_mix_master/features/tobacco_catalog/presentation/widgets/tobacco_card.dart';
import 'package:hookah_mix_master/features/tobacco_catalog/presentation/widgets/tobacco_filters_sheet.dart';

class CatalogScreen extends ConsumerWidget {
  const CatalogScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final filter = ref.watch(catalogFilterProvider);
    final tobaccosAsync = ref.watch(filteredTobaccoListProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.catalogTitle),
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.tune_outlined),
                onPressed: () => TobaccoFiltersSheet.show(context),
              ),
              if (filter.hasActiveFilters)
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: const CatalogSearchBar(),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: FlavorCategoryChips(),
          ),
          Expanded(
            child: tobaccosAsync.when(
              data: (tobaccos) {
                if (tobaccos.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: Text(
                        filter.hasActiveFilters
                            ? l10n.catalogEmptyStateFiltered
                            : l10n.catalogEmptyState,
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.only(bottom: 16),
                  itemCount: tobaccos.length,
                  itemBuilder: (_, i) => TobaccoCard(tobacco: tobaccos[i]),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => ErrorView(
                message: l10n.generalError,
                onRetry: () => ref.invalidate(filteredTobaccoListProvider),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

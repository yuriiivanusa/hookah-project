import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hookah_mix_master/core/extensions/context_extensions.dart';
import 'package:hookah_mix_master/features/tobacco_catalog/presentation/providers/catalog_filter_state.dart';

class CatalogSearchBar extends ConsumerStatefulWidget {
  const CatalogSearchBar({super.key});

  @override
  ConsumerState<CatalogSearchBar> createState() => _CatalogSearchBarState();
}

class _CatalogSearchBarState extends ConsumerState<CatalogSearchBar> {
  final _ctrl = TextEditingController();

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _ctrl,
      onChanged: (v) => ref.read(catalogFilterProvider.notifier).setQuery(v),
      decoration: InputDecoration(
        hintText: context.l10n.catalogSearchHint,
        prefixIcon: const Icon(Icons.search),
        suffixIcon: _ctrl.text.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  _ctrl.clear();
                  ref.read(catalogFilterProvider.notifier).setQuery('');
                },
              )
            : null,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: const EdgeInsets.symmetric(vertical: 0),
      ),
    );
  }
}

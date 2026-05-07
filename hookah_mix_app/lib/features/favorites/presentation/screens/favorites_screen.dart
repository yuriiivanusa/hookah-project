import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hookah_mix_master/core/extensions/context_extensions.dart';
import 'package:hookah_mix_master/core/router/routes.dart';
import 'package:hookah_mix_master/features/favorites/domain/entities/favorite_entry.dart';
import 'package:hookah_mix_master/features/favorites/presentation/providers/favorites_notifier.dart';
import 'package:hookah_mix_master/features/favorites/presentation/widgets/favorites_empty_state.dart';
import 'package:hookah_mix_master/features/smart_recommender/presentation/providers/recommendations_provider.dart';

class FavoritesScreen extends ConsumerStatefulWidget {
  const FavoritesScreen({super.key});

  @override
  ConsumerState<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends ConsumerState<FavoritesScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final favorites = ref.watch(favoritesProvider);
    final tobaccos = favorites
        .where((e) => e.type == FavoriteType.tobacco)
        .toList();
    final mixes = favorites.where((e) => e.type == FavoriteType.mix).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.favoritesTitle),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: l10n.favoritesTabTobaccos),
            Tab(text: l10n.favoritesTabMixes),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _FavoritesList(
            items: tobaccos,
            emptyLabel: l10n.favoritesEmptyTobaccos,
            onTap: (e) => context.push('${Routes.catalog}/${e.refId}'),
          ),
          _FavoritesList(
            items: mixes,
            emptyLabel: l10n.favoritesEmptyMixes,
            onTap: (e) => _showMixInfo(context, e),
          ),
        ],
      ),
    );
  }

  void _showMixInfo(BuildContext context, FavoriteEntry entry) {
    showModalBottomSheet<void>(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) =>
          SafeArea(bottom: true, child: _CuratedMixDetailSheet(entry: entry)),
    );
  }
}

class _FavoritesList extends ConsumerWidget {
  const _FavoritesList({
    required this.items,
    required this.emptyLabel,
    required this.onTap,
  });

  final List<FavoriteEntry> items;
  final String emptyLabel;
  final void Function(FavoriteEntry) onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (items.isEmpty) return FavoritesEmptyState(label: emptyLabel);

    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: items.length,
      separatorBuilder: (_, _) => const Divider(height: 1),
      itemBuilder: (context, i) {
        final entry = items[i];
        return ListTile(
          leading: Icon(
            entry.type == FavoriteType.tobacco
                ? Icons.local_fire_department_outlined
                : Icons.science_outlined,
            color: Theme.of(context).colorScheme.primary,
          ),
          title: Text(entry.displayName),
          subtitle: Text(
            entry.addedAt.toLocal().toString().substring(0, 10),
            style: Theme.of(context).textTheme.bodySmall,
          ),
          trailing: IconButton(
            icon: const Icon(Icons.favorite, color: Colors.red),
            onPressed: () => ref
                .read(favoritesProvider.notifier)
                .toggle(entry.type, entry.refId, entry.displayName),
          ),
          onTap: () => onTap(entry),
        );
      },
    );
  }
}

class _CuratedMixDetailSheet extends ConsumerWidget {
  const _CuratedMixDetailSheet({required this.entry});
  final FavoriteEntry entry;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mixAsync = ref.watch(curatedMixByIdProvider(entry.refId));
    final locale = Localizations.localeOf(context).languageCode;
    final cs = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
      child: mixAsync.when(
        data: (mix) {
          if (mix == null) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry.displayName,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  entry.addedAt.toLocal().toString().substring(0, 10),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            );
          }
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                mix.localName(locale),
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 4),
              Text(
                mix.localDescription(locale),
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: cs.onSurfaceVariant),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 16),
              Text(
                context.l10n.mixBuilderComponentsLabel,
                style: Theme.of(
                  context,
                ).textTheme.labelMedium?.copyWith(color: cs.primary),
              ),
              const SizedBox(height: 8),
              ...mix.components.map(
                (c) => Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Row(
                    children: [
                      Text(
                        '${c.percentage}%',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: cs.primary,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          c.displayName,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
        loading: () =>
            const Center(heightFactor: 2, child: CircularProgressIndicator()),
        error: (e, st) => Text(
          entry.displayName,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}

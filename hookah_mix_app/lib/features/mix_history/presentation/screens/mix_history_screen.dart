import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hookah_mix_master/core/extensions/context_extensions.dart';
import 'package:hookah_mix_master/core/router/routes.dart';
import 'package:hookah_mix_master/features/mix_builder/domain/entities/user_mix.dart';
import 'package:hookah_mix_master/features/mix_builder/presentation/providers/mix_builder_notifier.dart';
import 'package:hookah_mix_master/features/mix_history/presentation/providers/user_mixes_provider.dart';

class MixHistoryScreen extends ConsumerWidget {
  const MixHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final mixes = ref.watch(userMixesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.mixBuilderMyMixes),
        actions: [
          PopupMenuButton<MixSortOrder>(
            icon: const Icon(Icons.sort),
            onSelected: (o) => ref.read(userMixesProvider.notifier).sort(o),
            itemBuilder: (_) => [
              PopupMenuItem(
                value: MixSortOrder.dateDesc,
                child: Text(l10n.mixHistorySortDate),
              ),
              PopupMenuItem(
                value: MixSortOrder.ratingDesc,
                child: Text(l10n.mixHistorySortRating),
              ),
              PopupMenuItem(
                value: MixSortOrder.nameAsc,
                child: Text(l10n.mixHistorySortName),
              ),
            ],
          ),
        ],
      ),
      body: mixes.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.science_outlined,
                    size: 64,
                    color: Theme.of(context).colorScheme.outlineVariant,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    l10n.mixBuilderEmptyMixes,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    l10n.mixBuilderCreateFirst,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: mixes.length,
              separatorBuilder: (_, _) => const Divider(height: 1),
              itemBuilder: (context, i) => _MixTile(mix: mixes[i]),
            ),
    );
  }
}

class _MixTile extends ConsumerWidget {
  const _MixTile({required this.mix});
  final UserMix mix;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final cs = Theme.of(context).colorScheme;

    return ListTile(
      onTap: () => _showDetails(context),
      title: Text(mix.name),
      subtitle: Text(
        '${mix.components.length} ${l10n.mixBuilderComponentsLabel.toLowerCase()} · '
        '${mix.updatedAt.toLocal().toString().substring(0, 10)}',
        style: Theme.of(context).textTheme.bodySmall,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (mix.rating > 0) ...[
            Icon(Icons.star, size: 16, color: cs.primary),
            Text('${mix.rating}', style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(width: 4),
          ],
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: () {
              ref.read(mixBuilderProvider.notifier).loadMix(mix);
              context.go(Routes.builder);
            },
          ),
          IconButton(
            icon: Icon(Icons.delete_outline, color: cs.error),
            onPressed: () => _confirmDelete(context, ref),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmDelete(BuildContext context, WidgetRef ref) async {
    final l10n = context.l10n;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.mixBuilderDeleteConfirmTitle),
        content: Text(l10n.mixBuilderDeleteConfirmBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(l10n.mixBuilderCancel),
          ),
          FilledButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text(l10n.mixBuilderDelete),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      await ref.read(userMixesProvider.notifier).deleteMix(mix.id);
    }
  }

  void _showDetails(BuildContext context) {
    final l10n = context.l10n;
    final cs = Theme.of(context).colorScheme;
    showModalBottomSheet<void>(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) => SafeArea(
        bottom:true,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      mix.name,
                      style: Theme.of(ctx).textTheme.titleLarge,
                    ),
                  ),
                  if (mix.rating > 0) ...[
                    Icon(Icons.star, size: 18, color: cs.primary),
                    const SizedBox(width: 4),
                    Text(
                      '${mix.rating}',
                      style: Theme.of(ctx).textTheme.bodyMedium,
                    ),
                  ],
                ],
              ),
              if (mix.description.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(mix.description, style: Theme.of(ctx).textTheme.bodySmall),
              ],
              const SizedBox(height: 16),
              Text(
                l10n.mixBuilderComponentsLabel,
                style: Theme.of(
                  ctx,
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
                        style: Theme.of(ctx).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: cs.primary,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          c.tobaccoName,
                          style: Theme.of(ctx).textTheme.bodySmall,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

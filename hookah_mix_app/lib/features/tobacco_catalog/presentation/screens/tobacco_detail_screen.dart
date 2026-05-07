import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hookah_mix_master/core/extensions/context_extensions.dart';
import 'package:hookah_mix_master/core/router/routes.dart';
import 'package:hookah_mix_master/core/theme/app_tokens.dart';
import 'package:hookah_mix_master/core/widgets/error_view.dart';
import 'package:hookah_mix_master/features/favorites/domain/entities/favorite_entry.dart';
import 'package:hookah_mix_master/features/favorites/presentation/providers/favorites_notifier.dart';
import 'package:hookah_mix_master/features/mix_builder/presentation/providers/mix_builder_notifier.dart';
import 'package:hookah_mix_master/features/tobacco_catalog/domain/entities/tobacco.dart';
import 'package:hookah_mix_master/features/tobacco_catalog/presentation/providers/tobacco_providers.dart';
import 'package:hookah_mix_master/features/tobacco_catalog/presentation/widgets/taste_profile_radar.dart';
import 'package:hookah_mix_master/features/tobacco_catalog/presentation/widgets/tobacco_image_placeholder.dart';

class TobaccoDetailScreen extends ConsumerWidget {
  const TobaccoDetailScreen({super.key, required this.tobaccoId});

  final String tobaccoId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final tobaccoAsync = ref.watch(tobaccoDetailProvider(tobaccoId));

    return Scaffold(
      appBar: AppBar(title: Text(l10n.catalogTobaccoDetailTitle)),
      body: tobaccoAsync.when(
        data: (tobacco) {
          if (tobacco == null) {
            return ErrorView(message: l10n.generalError);
          }
          return _TobaccoDetailBody(tobacco: tobacco);
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => ErrorView(
          message: l10n.generalError,
          onRetry: () => ref.invalidate(tobaccoDetailProvider(tobaccoId)),
        ),
      ),
    );
  }
}

class _TobaccoDetailBody extends ConsumerWidget {
  const _TobaccoDetailBody({required this.tobacco});

  final Tobacco tobacco;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = context.l10n;
    final locale = Localizations.localeOf(context).languageCode;
    final isFav = ref
        .watch(favoritesProvider)
        .any((e) => e.type == FavoriteType.tobacco && e.refId == tobacco.id);
    final isInMix = ref
        .watch(mixBuilderProvider)
        .components
        .any((c) => c.tobaccoId == tobacco.id);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TobaccoImagePlaceholder(
            imageUrl: tobacco.imageUrl,
            width: double.infinity,
            height: 220,
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tobacco.localName(locale),
                  style: theme.textTheme.headlineSmall,
                ),
                const SizedBox(height: 4),
                Text(
                  tobacco.brandName,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 12),
                _InfoRow(
                  label: l10n.catalogBrandLabel,
                  value: '${tobacco.brandName} · ${tobacco.brandCountry}',
                ),
                const SizedBox(height: 4),
                _InfoRow(
                  label: l10n.catalogFilterStrength,
                  value: '${tobacco.strength} / 5',
                ),
                const SizedBox(height: 16),
                Text(
                  tobacco.localDescription(locale),
                  style: theme.textTheme.bodyMedium,
                ),
                const SizedBox(height: 24),
                if (tobacco.tasteNotes.isNotEmpty) ...[
                  Text(
                    l10n.catalogFlavorNotes,
                    style: theme.textTheme.titleSmall,
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    children: tobacco.tasteNotes
                        .map(
                          (note) => Chip(
                            label: Text(note),
                            visualDensity: VisualDensity.compact,
                            shape: const StadiumBorder(),
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 24),
                ],
                Center(
                  child: TasteProfileRadar(
                    profile: tobacco.tasteProfile,
                    size: 220,
                  ),
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    icon: Icon(
                      isInMix
                          ? Icons.remove_circle_outline
                          : Icons.science_outlined,
                    ),
                    label: Text(
                      isInMix
                          ? l10n.catalogRemoveFromMix
                          : l10n.catalogAddToMix,
                    ),
                    onPressed: () {
                      if (isInMix) {
                        final idx = ref
                            .read(mixBuilderProvider)
                            .components
                            .indexWhere((c) => c.tobaccoId == tobacco.id);
                        if (idx != -1) {
                          ref
                              .read(mixBuilderProvider.notifier)
                              .removeComponent(idx);
                        }
                      } else {
                        ref
                            .read(mixBuilderProvider.notifier)
                            .addComponent(tobacco);
                        context.go(Routes.builder);
                      }
                    },
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    icon: Icon(isFav ? Icons.favorite : Icons.favorite_outline),
                    label: Text(
                      isFav
                          ? l10n.catalogRemoveFromFavorites
                          : l10n.catalogAddToFavorites,
                    ),
                    onPressed: () => ref
                        .read(favoritesProvider.notifier)
                        .toggle(
                          FavoriteType.tobacco,
                          tobacco.id,
                          tobacco.localName(locale),
                        ),
                    style: OutlinedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                        borderRadius: AppTokens.borderRadiusMd,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Text(
          '$label: ',
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        Text(value, style: theme.textTheme.bodySmall),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hookah_mix_master/core/extensions/context_extensions.dart';
import 'package:hookah_mix_master/core/theme/app_tokens.dart';
import 'package:hookah_mix_master/features/favorites/domain/entities/favorite_entry.dart';
import 'package:hookah_mix_master/features/favorites/presentation/providers/favorites_notifier.dart';
import 'package:hookah_mix_master/features/smart_recommender/domain/services/recommendation_algorithm.dart';

class RecommendationCard extends ConsumerWidget {
  const RecommendationCard({super.key, required this.result});

  final RecommendationResult result;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = context.l10n;
    final locale = Localizations.localeOf(context).languageCode;
    final mix = result.mix;
    final isFav = ref
        .watch(favoritesProvider)
        .any((e) => e.type == FavoriteType.mix && e.refId == mix.id);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: const RoundedRectangleBorder(
        borderRadius: AppTokens.borderRadiusMd,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    mix.localName(locale),
                    style: theme.textTheme.titleMedium,
                  ),
                ),
                _MatchBadge(label: result.matchLabel, l10n: l10n),
                const SizedBox(width: 4),
                IconButton(
                  visualDensity: VisualDensity.compact,
                  icon: Icon(
                    isFav ? Icons.favorite : Icons.favorite_border,
                    color: isFav
                        ? Colors.red
                        : theme.colorScheme.onSurfaceVariant,
                  ),
                  onPressed: () => ref
                      .read(favoritesProvider.notifier)
                      .toggle(FavoriteType.mix, mix.id, mix.localName(locale)),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                _DifficultyChip(difficulty: mix.difficulty, l10n: l10n),
                const SizedBox(width: 8),
                _StrengthDots(strength: mix.strengthLevel),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              mix.localDescription(locale),
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 10),
            Text(
              l10n.recommenderComponentsLabel,
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 4),
            ...mix.components.map(
              (c) => Padding(
                padding: const EdgeInsets.only(bottom: 2),
                child: Row(
                  children: [
                    Text(
                      '${c.percentage}%',
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        c.displayName,
                        style: theme.textTheme.bodySmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (mix.tags.isNotEmpty) ...[
              const SizedBox(height: 10),
              Wrap(
                spacing: 6,
                children: mix.tags
                    .take(4)
                    .map(
                      (t) => Chip(
                        label: Text(t),
                        visualDensity: VisualDensity.compact,
                        shape: const StadiumBorder(),
                        padding: EdgeInsets.zero,
                      ),
                    )
                    .toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _MatchBadge extends StatelessWidget {
  const _MatchBadge({required this.label, required this.l10n});

  final MatchLabel label;
  final dynamic l10n;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final (text, color) = switch (label) {
      MatchLabel.excellent => (l10n.recommenderMatchExcellent, cs.primary),
      MatchLabel.good => (l10n.recommenderMatchGood, cs.secondary),
      MatchLabel.fair => (l10n.recommenderMatchFair, cs.outline),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppTokens.radiusFull),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Text(
        text as String,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(color: color),
      ),
    );
  }
}

class _DifficultyChip extends StatelessWidget {
  const _DifficultyChip({required this.difficulty, required this.l10n});

  final String difficulty;
  final dynamic l10n;

  @override
  Widget build(BuildContext context) {
    final label = switch (difficulty) {
      'easy' => l10n.recommenderDifficultyEasy as String,
      'medium' => l10n.recommenderDifficultyMedium as String,
      _ => l10n.recommenderDifficultyHard as String,
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(AppTokens.radiusSm),
      ),
      child: Text(label, style: Theme.of(context).textTheme.labelSmall),
    );
  }
}

class _StrengthDots extends StatelessWidget {
  const _StrengthDots({required this.strength});

  final int strength;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (i) {
        return Padding(
          padding: const EdgeInsets.only(right: 2),
          child: Container(
            width: 8,
            height: 5,
            decoration: BoxDecoration(
              color: i < strength ? color : color.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        );
      }),
    );
  }
}

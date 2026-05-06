import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hookah_mix_master/core/theme/app_tokens.dart';
import 'package:hookah_mix_master/features/tobacco_catalog/domain/entities/tobacco.dart';
import 'package:hookah_mix_master/features/tobacco_catalog/presentation/widgets/tobacco_image_placeholder.dart';

class TobaccoCard extends StatelessWidget {
  const TobaccoCard({super.key, required this.tobacco});

  final Tobacco tobacco;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final locale = Localizations.localeOf(context).languageCode;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      shape: const RoundedRectangleBorder(borderRadius: AppTokens.borderRadiusMd),
      child: InkWell(
        borderRadius: AppTokens.borderRadiusMd,
        onTap: () => context.push('/catalog/${tobacco.id}'),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(AppTokens.radiusMd),
                bottomLeft: Radius.circular(AppTokens.radiusMd),
              ),
              child: TobaccoImagePlaceholder(
                imageUrl: tobacco.imageUrl,
                width: 88,
                height: 88,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tobacco.localName(locale),
                      style: theme.textTheme.titleSmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      tobacco.brandName,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 6),
                    _StrengthDots(strength: tobacco.strength),
                    if (tobacco.tasteNotes.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        tobacco.tasteNotes.take(3).join(' · '),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.primary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Icon(
                Icons.chevron_right,
                size: 20,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
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
          padding: const EdgeInsets.only(right: 3),
          child: Container(
            width: 10,
            height: 6,
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

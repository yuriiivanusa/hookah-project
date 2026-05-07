import 'package:flutter/material.dart';
import 'package:hookah_mix_master/features/mix_builder/domain/entities/mix_component.dart';

class ComponentPercentageSlider extends StatelessWidget {
  const ComponentPercentageSlider({
    super.key,
    required this.component,
    required this.onPercentageChanged,
    required this.onRemove,
  });

  final MixComponent component;
  final void Function(int) onPercentageChanged;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 8, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    component.tobaccoName,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  '${component.percentage}%',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: cs.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, size: 18),
                  onPressed: onRemove,
                  color: cs.onSurfaceVariant,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(
                    minWidth: 36,
                    minHeight: 36,
                  ),
                ),
              ],
            ),
            Slider(
              value: component.percentage.clamp(1, 99).toDouble(),
              min: 1,
              max: 99,
              divisions: 98,
              onChanged: (v) => onPercentageChanged(v.round()),
            ),
          ],
        ),
      ),
    );
  }
}

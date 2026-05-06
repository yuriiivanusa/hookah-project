import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hookah_mix_master/core/extensions/async_value_extensions.dart';
import 'package:hookah_mix_master/core/extensions/context_extensions.dart';
import 'package:hookah_mix_master/features/mix_builder/presentation/providers/current_mix_state.dart';
import 'package:hookah_mix_master/features/mix_builder/presentation/providers/mix_builder_notifier.dart';
import 'package:hookah_mix_master/features/mix_builder/presentation/screens/save_mix_dialog.dart';
import 'package:hookah_mix_master/features/mix_builder/presentation/widgets/component_percentage_slider.dart';
import 'package:hookah_mix_master/features/mix_builder/presentation/widgets/taste_preview_card.dart';
import 'package:hookah_mix_master/features/mix_builder/presentation/widgets/tobacco_picker.dart';
import 'package:hookah_mix_master/features/tobacco_catalog/presentation/providers/tobacco_providers.dart';

class MixBuilderScreen extends ConsumerWidget {
  const MixBuilderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final mixState = ref.watch(mixBuilderProvider);
    final notifier = ref.read(mixBuilderProvider.notifier);
    final tobaccosAsync = ref.watch(tobaccoListProvider);
    final tobaccos = tobaccosAsync.valueOrNull ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text(mixState.isEditing ? l10n.mixBuilderEditTitle : l10n.mixBuilderTitle),
        actions: [
          if (mixState.isEditing)
            IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: () => _confirmDelete(context, ref),
            ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                if (mixState.components.isEmpty)
                  Padding(
                    padding: const EdgeInsets.all(32),
                    child: Center(
                      child: Text(
                        l10n.mixBuilderNoComponents,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  )
                else ...[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
                    child: Row(
                      children: [
                        Text(
                          l10n.mixBuilderComponentsLabel,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const Spacer(),
                        _PercentageBadge(total: mixState.totalPercentage),
                      ],
                    ),
                  ),
                  ...mixState.components.asMap().entries.map(
                    (e) => ComponentPercentageSlider(
                      component: e.value,
                      onPercentageChanged: (v) =>
                          notifier.updateComponentPercentage(e.key, v, tobaccos),
                      onRemove: () => notifier.removeComponent(e.key),
                    ),
                  ),
                  if (!mixState.isPercentageValid)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      child: Text(
                        l10n.mixBuilderPercentageWarning,
                        style: TextStyle(color: Theme.of(context).colorScheme.error, fontSize: 12),
                      ),
                    ),
                ],
                if (mixState.tasteProfile != null)
                  TastePreviewCard(
                    profile: mixState.tasteProfile!,
                    title: l10n.mixBuilderTastePreview,
                  ),
                const SizedBox(height: 16),
              ],
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: Row(
                children: [
                  if (mixState.components.length < 5)
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => _openPicker(context, mixState),
                        icon: const Icon(Icons.add),
                        label: Text(l10n.mixBuilderAddTobacco),
                      ),
                    ),
                  if (mixState.components.length < 5 && mixState.components.isNotEmpty)
                    const SizedBox(width: 12),
                  if (mixState.components.isNotEmpty)
                    Expanded(
                      flex: 2,
                      child: FilledButton(
                        onPressed: mixState.canSave ? () => _openSaveDialog(context, ref) : null,
                        child: Text(
                          mixState.isEditing ? l10n.mixBuilderUpdate : l10n.mixBuilderSave,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _openPicker(BuildContext context, CurrentMixState mixState) {
    final alreadyAdded = mixState.components.map((c) => c.tobaccoId).toSet();
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.75,
        maxChildSize: 0.95,
        builder: (ctx, ctrl) => TobaccoPicker(alreadyAdded: alreadyAdded),
      ),
    );
  }

  Future<void> _openSaveDialog(BuildContext context, WidgetRef ref) async {
    await showDialog<void>(context: context, builder: (_) => const SaveMixDialog());
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
    if (confirmed == true && context.mounted) {
      ref.read(mixBuilderProvider.notifier).reset();
      Navigator.of(context).pop();
    }
  }
}

class _PercentageBadge extends StatelessWidget {
  const _PercentageBadge({required this.total});

  final int total;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isValid = total == 100;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: isValid ? cs.primaryContainer : cs.errorContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        context.l10n.mixBuilderPercentageTotal(total),
        style: TextStyle(
          color: isValid ? cs.onPrimaryContainer : cs.onErrorContainer,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }
}

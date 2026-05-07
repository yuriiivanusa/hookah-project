import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hookah_mix_master/core/extensions/context_extensions.dart';
import 'package:hookah_mix_master/core/widgets/error_view.dart';
import 'package:hookah_mix_master/features/smart_recommender/presentation/providers/recommendations_provider.dart';
import 'package:hookah_mix_master/features/smart_recommender/presentation/providers/wizard_notifier.dart';
import 'package:hookah_mix_master/features/smart_recommender/presentation/widgets/recommendation_card.dart';

class RecommenderScreen extends ConsumerWidget {
  const RecommenderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final wizard = ref.watch(wizardProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.recommenderTitle),
        actions: [
          if (wizard.submitted)
            TextButton(
              onPressed: () => ref.read(wizardProvider.notifier).reset(),
              child: Text(l10n.recommenderTryAgain),
            ),
        ],
      ),
      body: wizard.submitted ? _ResultsView() : _WizardView(),
    );
  }
}

class _WizardView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wizard = ref.watch(wizardProvider);
    final notifier = ref.read(wizardProvider.notifier);
    final l10n = context.l10n;

    return Column(
      children: [
        LinearProgressIndicator(value: (wizard.step + 1) / 3),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: switch (wizard.step) {
              0 => _FlavorStep(
                selected: wizard.selectedFlavors,
                onToggle: notifier.toggleFlavor,
              ),
              1 => _StrengthStep(
                value: wizard.strengthPreference,
                onChanged: notifier.setStrength,
              ),
              _ => _MoodStep(
                selected: wizard.persona,
                onSelected: notifier.setPersona,
              ),
            },
          ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
            child: Row(
              children: [
                if (wizard.step > 0)
                  Expanded(
                    child: OutlinedButton(
                      onPressed: notifier.previousStep,
                      child: Text(l10n.generalBack),
                    ),
                  ),
                if (wizard.step > 0) const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: FilledButton(
                    onPressed: wizard.isLastStep
                        ? (wizard.canSubmit ? notifier.submit : null)
                        : notifier.nextStep,
                    child: Text(
                      wizard.isLastStep
                          ? l10n.recommenderGetMixes
                          : l10n.recommenderNext,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ResultsView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final resultsAsync = ref.watch(recommendationsProvider);

    return resultsAsync.when(
      data: (results) {
        if (results.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  l10n.recommenderResultEmpty,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 16),
                OutlinedButton(
                  onPressed: () => ref.read(wizardProvider.notifier).reset(),
                  child: Text(l10n.recommenderTryAgain),
                ),
              ],
            ),
          );
        }
        return ListView(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Text(
                l10n.recommenderResultTitle,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            ...results.map((r) => RecommendationCard(result: r)),
            const SizedBox(height: 16),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => ErrorView(
        message: l10n.generalError,
        onRetry: () => ref.invalidate(recommendationsProvider),
      ),
    );
  }
}

// ── Wizard steps ──────────────────────────────────────────────────────────────

const _flavorAxes = [
  ('sweet', 'sweet'),
  ('sour', 'sour'),
  ('fresh', 'fresh'),
  ('spicy', 'spicy'),
  ('bitter', 'bitter'),
  ('floral', 'floral'),
];

class _FlavorStep extends StatelessWidget {
  const _FlavorStep({required this.selected, required this.onToggle});

  final Set<String> selected;
  final void Function(String) onToggle;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    String label(String key) => switch (key) {
      'sweet' => l10n.recommenderFlavorSweet,
      'sour' => l10n.recommenderFlavorSour,
      'fresh' => l10n.recommenderFlavorFresh,
      'spicy' => l10n.recommenderFlavorSpicy,
      'bitter' => l10n.recommenderFlavorBitter,
      'floral' => l10n.recommenderFlavorFloral,
      _ => key,
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.recommenderStepFlavor,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 4),
        Text(
          l10n.recommenderSubtitle,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 24),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: _flavorAxes.map((f) {
            final isSelected = selected.contains(f.$1);
            return FilterChip(
              label: Text(label(f.$1)),
              selected: isSelected,
              onSelected: (_) => onToggle(f.$1),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class _StrengthStep extends StatelessWidget {
  const _StrengthStep({required this.value, required this.onChanged});

  final int value;
  final void Function(int) onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.recommenderStepStrength,
          style: theme.textTheme.headlineSmall,
        ),
        const SizedBox(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _StrengthOption(
              label: l10n.recommenderStrengthLight,
              value: 1,
              selected: value == 1,
              onTap: onChanged,
            ),
            _StrengthOption(
              label: l10n.recommenderStrengthMedium,
              value: 3,
              selected: value == 3,
              onTap: onChanged,
            ),
            _StrengthOption(
              label: l10n.recommenderStrengthStrong,
              value: 5,
              selected: value == 5,
              onTap: onChanged,
            ),
          ],
        ),
        const SizedBox(height: 32),
        Slider(
          value: value.toDouble(),
          min: 1,
          max: 5,
          divisions: 4,
          label: value.toString(),
          onChanged: (v) => onChanged(v.round()),
        ),
      ],
    );
  }
}

class _StrengthOption extends StatelessWidget {
  const _StrengthOption({
    required this.label,
    required this.value,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final int value;
  final bool selected;
  final void Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: () => onTap(value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: selected ? cs.primaryContainer : cs.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected ? cs.primary : cs.outline.withValues(alpha: 0.3),
            width: selected ? 2 : 1,
          ),
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
            color: selected ? cs.onPrimaryContainer : cs.onSurface,
          ),
        ),
      ),
    );
  }
}

class _MoodStep extends StatelessWidget {
  const _MoodStep({required this.selected, required this.onSelected});

  final String selected;
  final void Function(String) onSelected;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);

    final moods = [
      ('relax', l10n.recommenderMoodRelax, Icons.spa_outlined),
      ('party', l10n.recommenderMoodParty, Icons.celebration_outlined),
      ('focus', l10n.recommenderMoodFocus, Icons.psychology_outlined),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.recommenderStepMood, style: theme.textTheme.headlineSmall),
        const SizedBox(height: 32),
        ...moods.map((m) {
          final isSelected = selected == m.$1;
          final cs = theme.colorScheme;
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              onTap: () => onSelected(m.$1),
              leading: Icon(
                m.$3,
                color: isSelected ? cs.primary : cs.onSurfaceVariant,
              ),
              title: Text(m.$2),
              tileColor: isSelected
                  ? cs.primaryContainer
                  : cs.surfaceContainerHighest,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                  color: isSelected
                      ? cs.primary
                      : cs.outline.withValues(alpha: 0.3),
                  width: isSelected ? 2 : 1,
                ),
              ),
              trailing: isSelected
                  ? Icon(Icons.check_circle, color: cs.primary)
                  : null,
            ),
          );
        }),
      ],
    );
  }
}

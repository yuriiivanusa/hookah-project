import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hookah_mix_master/core/extensions/context_extensions.dart';
import 'package:hookah_mix_master/features/mix_builder/presentation/providers/current_mix_state.dart';
import 'package:hookah_mix_master/features/mix_builder/presentation/providers/mix_builder_notifier.dart';

class SaveMixDialog extends ConsumerStatefulWidget {
  const SaveMixDialog({super.key});

  @override
  ConsumerState<SaveMixDialog> createState() => _SaveMixDialogState();
}

class _SaveMixDialogState extends ConsumerState<SaveMixDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameCtrl;
  late final TextEditingController _descCtrl;

  @override
  void initState() {
    super.initState();
    final mixState = ref.read(mixBuilderProvider);
    _nameCtrl = TextEditingController(text: mixState.name);
    _descCtrl = TextEditingController(text: mixState.description);
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final mixState = ref.watch(mixBuilderProvider);
    final notifier = ref.read(mixBuilderProvider.notifier);
    final isSaving = mixState.saveStatus == MixSaveStatus.saving;

    return AlertDialog(
      title: Text(mixState.isEditing ? l10n.mixBuilderEditTitle : l10n.mixBuilderSave),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _nameCtrl,
              decoration: InputDecoration(
                labelText: l10n.mixBuilderNameLabel,
                hintText: l10n.mixBuilderNameHint,
              ),
              onChanged: notifier.setMixName,
              validator: (v) => (v == null || v.trim().isEmpty) ? l10n.generalError : null,
              textCapitalization: TextCapitalization.sentences,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _descCtrl,
              decoration: InputDecoration(labelText: l10n.mixBuilderDescriptionLabel),
              onChanged: notifier.setMixDescription,
              maxLines: 2,
              textCapitalization: TextCapitalization.sentences,
            ),
            const SizedBox(height: 16),
            _RatingPicker(
              label: l10n.mixBuilderRatingLabel,
              value: mixState.rating,
              onChanged: notifier.setMixRating,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: isSaving ? null : () => Navigator.of(context).pop(),
          child: Text(l10n.mixBuilderCancel),
        ),
        FilledButton(
          onPressed: isSaving ? null : () => _save(context),
          child: isSaving
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Text(mixState.isEditing ? l10n.mixBuilderUpdate : l10n.mixBuilderSave),
        ),
      ],
    );
  }

  Future<void> _save(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;

    final saved = await ref.read(mixBuilderProvider.notifier).saveMix();

    if (!context.mounted) return;

    if (saved != null) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(context.l10n.mixBuilderSaved)));
      ref.read(mixBuilderProvider.notifier).reset();
    } else {
      final errorMsg = ref.read(mixBuilderProvider).errorMessage;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMsg ?? context.l10n.mixBuilderSaveError),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    }
  }
}

class _RatingPicker extends StatelessWidget {
  const _RatingPicker({required this.label, required this.value, required this.onChanged});

  final String label;
  final int value;
  final void Function(int) onChanged;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.bodySmall),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(5, (i) {
            final star = i + 1;
            return IconButton(
              onPressed: () => onChanged(star),
              icon: Icon(
                star <= value ? Icons.star : Icons.star_border,
                color: star <= value ? cs.primary : cs.onSurfaceVariant,
              ),
            );
          }),
        ),
      ],
    );
  }
}

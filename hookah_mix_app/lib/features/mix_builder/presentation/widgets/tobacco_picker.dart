import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hookah_mix_master/core/extensions/context_extensions.dart';
import 'package:hookah_mix_master/features/mix_builder/presentation/providers/mix_builder_notifier.dart';
import 'package:hookah_mix_master/features/tobacco_catalog/domain/entities/tobacco.dart';
import 'package:hookah_mix_master/features/tobacco_catalog/presentation/providers/tobacco_providers.dart';

class TobaccoPicker extends ConsumerStatefulWidget {
  const TobaccoPicker({super.key, required this.alreadyAdded});

  final Set<String> alreadyAdded;

  @override
  ConsumerState<TobaccoPicker> createState() => _TobaccoPickerState();
}

class _TobaccoPickerState extends ConsumerState<TobaccoPicker> {
  final _controller = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final allAsync = ref.watch(tobaccoListProvider);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: SearchBar(
            controller: _controller,
            hintText: l10n.mixBuilderPickerSearch,
            leading: const Icon(Icons.search),
            onChanged: (v) => setState(() => _query = v.trim().toLowerCase()),
          ),
        ),
        Expanded(
          child: allAsync.when(
            data: (tobaccos) {
              final filtered = _query.isEmpty
                  ? tobaccos
                  : tobaccos
                        .where(
                          (t) =>
                              t.nameEn.toLowerCase().contains(_query) ||
                              t.brandName.toLowerCase().contains(_query),
                        )
                        .toList();
              return ListView.builder(
                itemCount: filtered.length,
                itemBuilder: (context, i) => _TobaccoPickerTile(
                  tobacco: filtered[i],
                  isAdded: widget.alreadyAdded.contains(filtered[i].id),
                ),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text(l10n.generalError)),
          ),
        ),
      ],
    );
  }
}

class _TobaccoPickerTile extends ConsumerWidget {
  const _TobaccoPickerTile({required this.tobacco, required this.isAdded});

  final Tobacco tobacco;
  final bool isAdded;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final cs = Theme.of(context).colorScheme;

    return ListTile(
      title: Text(tobacco.nameEn),
      subtitle: Text(tobacco.brandName),
      trailing: isAdded
          ? Text(
              l10n.mixBuilderAlreadyAdded,
              style: TextStyle(color: cs.outline),
            )
          : FilledButton.tonal(
              onPressed: () {
                ref.read(mixBuilderProvider.notifier).addComponent(tobacco);
                Navigator.of(context).pop();
              },
              child: const Icon(Icons.add),
            ),
    );
  }
}

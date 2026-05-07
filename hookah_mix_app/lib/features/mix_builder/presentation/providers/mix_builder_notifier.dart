import 'package:hookah_mix_master/core/services/providers.dart';
import 'package:hookah_mix_master/features/mix_builder/data/datasources/local_mixes_datasource.dart';
import 'package:hookah_mix_master/features/mix_builder/data/repositories/mix_builder_repository_impl.dart';
import 'package:hookah_mix_master/features/mix_builder/domain/entities/mix_component.dart';
import 'package:hookah_mix_master/features/mix_builder/domain/entities/user_mix.dart';
import 'package:hookah_mix_master/features/mix_builder/domain/repositories/mix_builder_repository.dart';
import 'package:hookah_mix_master/features/mix_builder/domain/services/percentage_validator.dart';
import 'package:hookah_mix_master/features/mix_builder/domain/services/taste_profile_calculator.dart';
import 'package:hookah_mix_master/features/mix_builder/presentation/providers/current_mix_state.dart';
import 'package:hookah_mix_master/features/tobacco_catalog/domain/entities/tobacco.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'mix_builder_notifier.g.dart';

@Riverpod(keepAlive: true)
MixBuilderRepository mixBuilderRepository(Ref ref) {
  final ds = LocalMixesDatasource(ref.watch(hiveServiceProvider));
  return MixBuilderRepositoryImpl(ds);
}

@Riverpod(keepAlive: true)
class MixBuilderNotifier extends _$MixBuilderNotifier {
  @override
  CurrentMixState build() => const CurrentMixState();

  void addComponent(Tobacco tobacco) {
    final components = state.components;
    if (components.length >= PercentageValidator.maxComponents) return;
    if (components.any((c) => c.tobaccoId == tobacco.id)) return;

    final newComponent = MixComponent(
      tobaccoId: tobacco.id,
      tobaccoName: tobacco.localName('en'),
      percentage: 0,
    );

    final updated = [...components, newComponent];
    final scaled = _evenDistribute(updated);
    state = state.copyWith(components: scaled, tasteProfile: null);
    _recalcProfile(scaled, []);
  }

  void removeComponent(int index) {
    final updated = [...state.components]..removeAt(index);
    if (updated.isEmpty) {
      state = state.copyWith(components: [], tasteProfile: null);
      return;
    }
    final scaled = _evenDistribute(updated);
    state = state.copyWith(components: scaled);
    _recalcProfile(scaled, []);
  }

  void updateComponentPercentage(
    int index,
    int newValue,
    List<Tobacco> tobaccos,
  ) {
    final clamped = newValue.clamp(1, 99);
    final scaled = PercentageValidator.autoScale(
      state.components,
      index,
      clamped,
    );
    state = state.copyWith(components: scaled);
    _recalcProfile(scaled, tobaccos);
  }

  void setMixName(String name) => state = state.copyWith(name: name);

  void setMixDescription(String description) =>
      state = state.copyWith(description: description);

  void setMixRating(int rating) =>
      state = state.copyWith(rating: rating.clamp(0, 5));

  Future<UserMix?> saveMix() async {
    if (!state.canSave) return null;
    state = state.copyWith(
      saveStatus: MixSaveStatus.saving,
      errorMessage: null,
    );
    try {
      final repo = ref.read(mixBuilderRepositoryProvider);
      final now = DateTime.now();
      final mix = UserMix(
        id: state.editingMixId ?? '',
        userId: '',
        name: state.name.trim(),
        description: state.description.trim(),
        components: state.components,
        tasteProfile: state.tasteProfile,
        rating: state.rating,
        createdAt: now,
        updatedAt: now,
      );
      final saved = state.isEditing
          ? await repo.updateMix(mix)
          : await repo.createMix(mix);
      state = state.copyWith(saveStatus: MixSaveStatus.saved);
      return saved;
    } catch (e) {
      state = state.copyWith(
        saveStatus: MixSaveStatus.error,
        errorMessage: e.toString(),
      );
      return null;
    }
  }

  void loadMix(UserMix mix) {
    state = CurrentMixState(
      name: mix.name,
      description: mix.description,
      components: mix.components,
      tasteProfile: mix.tasteProfile,
      rating: mix.rating,
      editingMixId: mix.id,
    );
  }

  void reset() => state = const CurrentMixState();

  List<MixComponent> _evenDistribute(List<MixComponent> components) {
    if (components.isEmpty) return [];
    final perItem = 100 ~/ components.length;
    final leftover = 100 - perItem * components.length;
    return components.asMap().entries.map((e) {
      return e.value.copyWith(
        percentage: perItem + (e.key == 0 ? leftover : 0),
      );
    }).toList();
  }

  void _recalcProfile(List<MixComponent> components, List<Tobacco> tobaccos) {
    if (tobaccos.isEmpty) return;
    final profile = TasteProfileCalculator.calculate(components, tobaccos);
    state = state.copyWith(tasteProfile: profile);
  }
}

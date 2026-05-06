import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hookah_mix_master/features/mix_builder/domain/entities/mix_component.dart';
import 'package:hookah_mix_master/features/tobacco_catalog/domain/entities/taste_profile.dart';

part 'current_mix_state.freezed.dart';

enum MixSaveStatus { idle, saving, saved, error }

@freezed
abstract class CurrentMixState with _$CurrentMixState {
  const factory CurrentMixState({
    @Default('') String name,
    @Default('') String description,
    @Default([]) List<MixComponent> components,
    TasteProfile? tasteProfile,
    @Default(0) int rating,
    @Default(MixSaveStatus.idle) MixSaveStatus saveStatus,
    String? errorMessage,
    String? editingMixId,
  }) = _CurrentMixState;

  const CurrentMixState._();

  int get totalPercentage => components.fold(0, (sum, c) => sum + c.percentage);

  bool get isPercentageValid => totalPercentage == 100;

  // Enables the "Save" button — name validation happens inside the dialog form
  bool get canSave => components.length >= 2 && isPercentageValid;

  bool get isEditing => editingMixId != null;
}

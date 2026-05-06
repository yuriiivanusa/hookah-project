import 'package:freezed_annotation/freezed_annotation.dart';

part 'wizard_state.freezed.dart';

@freezed
abstract class WizardState with _$WizardState {
  const factory WizardState({
    @Default(0) int step,
    @Default({}) Set<String> selectedFlavors,
    @Default(3) int strengthPreference,
    @Default('') String persona,
    @Default(false) bool submitted,
  }) = _WizardState;

  const WizardState._();

  bool get canSubmit => selectedFlavors.isNotEmpty;
  bool get isLastStep => step == 2;
}

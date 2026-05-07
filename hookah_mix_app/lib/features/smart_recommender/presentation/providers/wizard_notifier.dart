import 'package:hookah_mix_master/features/smart_recommender/presentation/providers/wizard_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'wizard_notifier.g.dart';

@riverpod
class WizardNotifier extends _$WizardNotifier {
  @override
  WizardState build() => const WizardState();

  void toggleFlavor(String flavor) {
    final current = Set<String>.from(state.selectedFlavors);
    if (current.contains(flavor)) {
      current.remove(flavor);
    } else {
      current.add(flavor);
    }
    state = state.copyWith(selectedFlavors: current);
  }

  void setStrength(int strength) =>
      state = state.copyWith(strengthPreference: strength);

  void setPersona(String persona) => state = state.copyWith(persona: persona);

  void nextStep() {
    if (state.step < 2) state = state.copyWith(step: state.step + 1);
  }

  void previousStep() {
    if (state.step > 0) state = state.copyWith(step: state.step - 1);
  }

  void submit() => state = state.copyWith(submitted: true);

  void reset() => state = const WizardState();
}

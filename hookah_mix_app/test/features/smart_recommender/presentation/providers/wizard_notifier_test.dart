import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hookah_mix_master/features/smart_recommender/presentation/providers/wizard_notifier.dart';
import 'package:hookah_mix_master/features/smart_recommender/presentation/providers/wizard_state.dart';

ProviderContainer _makeContainer() => ProviderContainer();

void main() {
  group('WizardNotifier', () {
    test('initial state is step 0, empty flavors, strength 3', () {
      final c = _makeContainer();
      addTearDown(c.dispose);
      final state = c.read(wizardProvider);
      expect(state.step, 0);
      expect(state.selectedFlavors, isEmpty);
      expect(state.strengthPreference, 3);
      expect(state.submitted, isFalse);
    });

    test('toggleFlavor adds and removes flavor', () {
      final c = _makeContainer();
      addTearDown(c.dispose);
      final n = c.read(wizardProvider.notifier);

      n.toggleFlavor('sweet');
      expect(c.read(wizardProvider).selectedFlavors, {'sweet'});

      n.toggleFlavor('sweet');
      expect(c.read(wizardProvider).selectedFlavors, isEmpty);
    });

    test('setStrength updates strength preference', () {
      final c = _makeContainer();
      addTearDown(c.dispose);
      c.read(wizardProvider.notifier).setStrength(5);
      expect(c.read(wizardProvider).strengthPreference, 5);
    });

    test('nextStep increments step up to 2', () {
      final c = _makeContainer();
      addTearDown(c.dispose);
      final n = c.read(wizardProvider.notifier);

      n.nextStep();
      expect(c.read(wizardProvider).step, 1);
      n.nextStep();
      expect(c.read(wizardProvider).step, 2);
      n.nextStep(); // should not go beyond 2
      expect(c.read(wizardProvider).step, 2);
    });

    test('previousStep decrements step but not below 0', () {
      final c = _makeContainer();
      addTearDown(c.dispose);
      final n = c.read(wizardProvider.notifier);

      n.previousStep(); // no-op at 0
      expect(c.read(wizardProvider).step, 0);

      n.nextStep();
      n.previousStep();
      expect(c.read(wizardProvider).step, 0);
    });

    test('submit sets submitted to true', () {
      final c = _makeContainer();
      addTearDown(c.dispose);
      c.read(wizardProvider.notifier).submit();
      expect(c.read(wizardProvider).submitted, isTrue);
    });

    test('reset returns to initial state', () {
      final c = _makeContainer();
      addTearDown(c.dispose);
      final n = c.read(wizardProvider.notifier);

      n.toggleFlavor('sweet');
      n.nextStep();
      n.submit();
      n.reset();

      final state = c.read(wizardProvider);
      expect(state, const WizardState());
    });

    test('canSubmit is true only when flavors selected', () {
      final c = _makeContainer();
      addTearDown(c.dispose);
      expect(c.read(wizardProvider).canSubmit, isFalse);
      c.read(wizardProvider.notifier).toggleFlavor('spicy');
      expect(c.read(wizardProvider).canSubmit, isTrue);
    });

    test('isLastStep is true at step 2', () {
      final c = _makeContainer();
      addTearDown(c.dispose);
      final n = c.read(wizardProvider.notifier);
      expect(c.read(wizardProvider).isLastStep, isFalse);
      n.nextStep();
      n.nextStep();
      expect(c.read(wizardProvider).isLastStep, isTrue);
    });
  });
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hookah_mix_master/features/mix_builder/presentation/providers/current_mix_state.dart';
import 'package:hookah_mix_master/features/mix_builder/presentation/providers/mix_builder_notifier.dart';
import 'package:hookah_mix_master/features/tobacco_catalog/domain/entities/taste_profile.dart';
import 'package:hookah_mix_master/features/tobacco_catalog/domain/entities/tobacco.dart';

Tobacco _tobacco(String id) => Tobacco(
  id: id,
  brandId: 'brand',
  brandName: 'Brand',
  brandCountry: 'UA',
  nameEn: 'Name $id',
  nameUk: 'Назва $id',
  leafType: 'burley',
  strength: 2,
  flavorCategories: const [],
  tasteNotes: const [],
  tasteProfile: const TasteProfile(sweet: 5, sour: 0, fresh: 5, spicy: 0, bitter: 0, floral: 0),
  descriptionEn: '',
  descriptionUk: '',
  popularity: 50,
);

ProviderContainer _makeContainer() => ProviderContainer();

void main() {
  group('MixBuilderNotifier', () {
    test('initial state is empty', () {
      final c = _makeContainer();
      addTearDown(c.dispose);
      expect(c.read(mixBuilderProvider), const CurrentMixState());
    });

    test('addComponent adds tobacco and distributes 100%', () {
      final c = _makeContainer();
      addTearDown(c.dispose);
      c.read(mixBuilderProvider.notifier).addComponent(_tobacco('a'));
      final state = c.read(mixBuilderProvider);
      expect(state.components.length, 1);
      expect(state.totalPercentage, 100);
    });

    test('addComponent adds second tobacco and keeps sum=100', () {
      final c = _makeContainer();
      addTearDown(c.dispose);
      final n = c.read(mixBuilderProvider.notifier);
      n.addComponent(_tobacco('a'));
      n.addComponent(_tobacco('b'));
      final state = c.read(mixBuilderProvider);
      expect(state.components.length, 2);
      expect(state.totalPercentage, 100);
    });

    test('duplicate tobacco is not added', () {
      final c = _makeContainer();
      addTearDown(c.dispose);
      final n = c.read(mixBuilderProvider.notifier);
      n.addComponent(_tobacco('a'));
      n.addComponent(_tobacco('a'));
      expect(c.read(mixBuilderProvider).components.length, 1);
    });

    test('max 5 components enforced', () {
      final c = _makeContainer();
      addTearDown(c.dispose);
      final n = c.read(mixBuilderProvider.notifier);
      for (final id in ['a', 'b', 'c', 'd', 'e', 'f']) {
        n.addComponent(_tobacco(id));
      }
      expect(c.read(mixBuilderProvider).components.length, 5);
    });

    test('removeComponent removes and rebalances', () {
      final c = _makeContainer();
      addTearDown(c.dispose);
      final n = c.read(mixBuilderProvider.notifier);
      n.addComponent(_tobacco('a'));
      n.addComponent(_tobacco('b'));
      n.removeComponent(0);
      final state = c.read(mixBuilderProvider);
      expect(state.components.length, 1);
      expect(state.totalPercentage, 100);
    });

    test('setMixName updates name', () {
      final c = _makeContainer();
      addTearDown(c.dispose);
      c.read(mixBuilderProvider.notifier).setMixName('Test Mix');
      expect(c.read(mixBuilderProvider).name, 'Test Mix');
    });

    test('setMixRating clamps to 0-5', () {
      final c = _makeContainer();
      addTearDown(c.dispose);
      final n = c.read(mixBuilderProvider.notifier);
      n.setMixRating(10);
      expect(c.read(mixBuilderProvider).rating, 5);
      n.setMixRating(-1);
      expect(c.read(mixBuilderProvider).rating, 0);
    });

    test('canSave is false with <2 components', () {
      final c = _makeContainer();
      addTearDown(c.dispose);
      expect(c.read(mixBuilderProvider).canSave, isFalse);
      c.read(mixBuilderProvider.notifier).addComponent(_tobacco('a'));
      expect(c.read(mixBuilderProvider).canSave, isFalse);
    });

    test('canSave is true with 2+ components (name validated in dialog)', () {
      final c = _makeContainer();
      addTearDown(c.dispose);
      final n = c.read(mixBuilderProvider.notifier);
      n.addComponent(_tobacco('a'));
      n.addComponent(_tobacco('b'));
      expect(c.read(mixBuilderProvider).canSave, isTrue);
    });

    test('reset returns to initial state', () {
      final c = _makeContainer();
      addTearDown(c.dispose);
      final n = c.read(mixBuilderProvider.notifier);
      n.addComponent(_tobacco('a'));
      n.setMixName('Test');
      n.reset();
      expect(c.read(mixBuilderProvider), const CurrentMixState());
    });
  });
}

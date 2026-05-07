import 'package:flutter_test/flutter_test.dart';
import 'package:hookah_mix_master/features/mix_builder/domain/entities/mix_component.dart';
import 'package:hookah_mix_master/features/mix_builder/domain/entities/user_mix.dart';

UserMix _makeMix({
  String name = 'Test Mix',
  List<MixComponent> components = const [
    MixComponent(tobaccoId: 't1', tobaccoName: 'A', percentage: 60),
    MixComponent(tobaccoId: 't2', tobaccoName: 'B', percentage: 40),
  ],
}) => UserMix(
  id: 'id1',
  userId: 'u1',
  name: name,
  components: components,
  createdAt: DateTime(2025),
  updatedAt: DateTime(2025),
);

void main() {
  group('UserMix.isValid', () {
    test('returns true when 2 components sum to 100 and name is non-empty', () {
      expect(_makeMix().isValid, isTrue);
    });

    test('returns false when fewer than 2 components', () {
      expect(
        _makeMix(
          components: const [
            MixComponent(tobaccoId: 't1', tobaccoName: 'A', percentage: 100),
          ],
        ).isValid,
        isFalse,
      );
    });

    test('returns false when components do not sum to 100', () {
      expect(
        _makeMix(
          components: const [
            MixComponent(tobaccoId: 't1', tobaccoName: 'A', percentage: 50),
            MixComponent(tobaccoId: 't2', tobaccoName: 'B', percentage: 30),
          ],
        ).isValid,
        isFalse,
      );
    });

    test('returns false when name is blank', () {
      expect(_makeMix(name: '   ').isValid, isFalse);
    });

    test('returns false when name is empty', () {
      expect(_makeMix(name: '').isValid, isFalse);
    });

    test('returns true with 5 components summing to 100', () {
      expect(
        _makeMix(
          components: const [
            MixComponent(tobaccoId: 't1', tobaccoName: 'A', percentage: 20),
            MixComponent(tobaccoId: 't2', tobaccoName: 'B', percentage: 20),
            MixComponent(tobaccoId: 't3', tobaccoName: 'C', percentage: 20),
            MixComponent(tobaccoId: 't4', tobaccoName: 'D', percentage: 20),
            MixComponent(tobaccoId: 't5', tobaccoName: 'E', percentage: 20),
          ],
        ).isValid,
        isTrue,
      );
    });
  });
}

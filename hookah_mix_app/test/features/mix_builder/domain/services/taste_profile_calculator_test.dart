import 'package:flutter_test/flutter_test.dart';
import 'package:hookah_mix_master/features/mix_builder/domain/entities/mix_component.dart';
import 'package:hookah_mix_master/features/mix_builder/domain/services/taste_profile_calculator.dart';
import 'package:hookah_mix_master/features/tobacco_catalog/domain/entities/taste_profile.dart';
import 'package:hookah_mix_master/features/tobacco_catalog/domain/entities/tobacco.dart';

Tobacco _tobacco(String id, TasteProfile profile) => Tobacco(
  id: id,
  brandId: 'brand',
  brandName: 'Brand',
  brandCountry: 'UA',
  nameEn: id,
  nameUk: id,
  leafType: 'burley',
  strength: 2,
  flavorCategories: const [],
  tasteNotes: const [],
  tasteProfile: profile,
  descriptionEn: '',
  descriptionUk: '',
  popularity: 50,
);

MixComponent _comp(String id, int pct) =>
    MixComponent(tobaccoId: id, tobaccoName: id, percentage: pct);

const _sweet = TasteProfile(sweet: 8, sour: 0, fresh: 0, spicy: 0, bitter: 0, floral: 0);
const _fresh = TasteProfile(sweet: 0, sour: 0, fresh: 8, spicy: 0, bitter: 0, floral: 0);
const _zeros = TasteProfile(sweet: 0, sour: 0, fresh: 0, spicy: 0, bitter: 0, floral: 0);

void main() {
  group('TasteProfileCalculator', () {
    test('single tobacco 100% returns that tobacco profile', () {
      final result = TasteProfileCalculator.calculate(
        [_comp('sweet', 100)],
        [_tobacco('sweet', _sweet)],
      );
      expect(result.sweet, 8);
      expect(result.fresh, 0);
    });

    test('50/50 two tobaccos → average of their profiles', () {
      final result = TasteProfileCalculator.calculate(
        [_comp('sweet', 50), _comp('fresh', 50)],
        [_tobacco('sweet', _sweet), _tobacco('fresh', _fresh)],
      );
      expect(result.sweet, 4);
      expect(result.fresh, 4);
    });

    test('25/25/25/25 four same tobaccos → same profile', () {
      final result = TasteProfileCalculator.calculate(
        [_comp('a', 25), _comp('b', 25), _comp('c', 25), _comp('d', 25)],
        [
          _tobacco('a', _sweet),
          _tobacco('b', _sweet),
          _tobacco('c', _sweet),
          _tobacco('d', _sweet),
        ],
      );
      expect(result.sweet, 8);
    });

    test('empty components returns zeros', () {
      final result = TasteProfileCalculator.calculate([], []);
      expect(result, _zeros);
    });

    test('tobacco not in list is skipped', () {
      final result = TasteProfileCalculator.calculate(
        [_comp('missing', 100)],
        [_tobacco('other', _sweet)],
      );
      expect(result, _zeros);
    });
  });
}

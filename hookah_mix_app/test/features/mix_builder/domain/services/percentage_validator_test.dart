import 'package:flutter_test/flutter_test.dart';
import 'package:hookah_mix_master/features/mix_builder/domain/entities/mix_component.dart';
import 'package:hookah_mix_master/features/mix_builder/domain/services/percentage_validator.dart';

MixComponent _comp(String id, int pct) =>
    MixComponent(tobaccoId: id, tobaccoName: id, percentage: pct);

void main() {
  group('PercentageValidator.isValid', () {
    test('2 components at 50/50 → valid', () {
      expect(PercentageValidator.isValid([_comp('a', 50), _comp('b', 50)]), isTrue);
    });

    test('4 components at 25/25/25/25 → valid', () {
      expect(
        PercentageValidator.isValid([
          _comp('a', 25),
          _comp('b', 25),
          _comp('c', 25),
          _comp('d', 25),
        ]),
        isTrue,
      );
    });

    test('2 components at 60/40 → valid', () {
      expect(PercentageValidator.isValid([_comp('a', 60), _comp('b', 40)]), isTrue);
    });

    test('3 components at 50/30/15 → invalid (sum=95)', () {
      expect(
        PercentageValidator.isValid([_comp('a', 50), _comp('b', 30), _comp('c', 15)]),
        isFalse,
      );
    });

    test('empty list → invalid', () {
      expect(PercentageValidator.isValid([]), isFalse);
    });
  });

  group('PercentageValidator.autoScale', () {
    test('change first of 2 from 50 to 70 → second becomes 30', () {
      final comps = [_comp('a', 50), _comp('b', 50)];
      final result = PercentageValidator.autoScale(comps, 0, 70);
      expect(result[0].percentage, 70);
      expect(result[1].percentage, 30);
      expect(result.fold(0, (s, c) => s + c.percentage), 100);
    });

    test('change first of 4 → other 3 scale proportionally, sum=100', () {
      final comps = [_comp('a', 40), _comp('b', 20), _comp('c', 20), _comp('d', 20)];
      final result = PercentageValidator.autoScale(comps, 0, 50);
      expect(result[0].percentage, 50);
      expect(result.fold(0, (s, c) => s + c.percentage), 100);
    });

    test('single component stays at 100', () {
      final result = PercentageValidator.autoScale([_comp('a', 100)], 0, 80);
      expect(result[0].percentage, 100);
    });
  });
}

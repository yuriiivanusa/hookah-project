import 'package:hookah_mix_master/features/mix_builder/domain/entities/mix_component.dart';
import 'package:hookah_mix_master/features/tobacco_catalog/domain/entities/taste_profile.dart';
import 'package:hookah_mix_master/features/tobacco_catalog/domain/entities/tobacco.dart';

abstract final class TasteProfileCalculator {
  static TasteProfile calculate(
    List<MixComponent> components,
    List<Tobacco> tobaccos,
  ) {
    if (components.isEmpty) {
      return const TasteProfile(
        sweet: 0,
        sour: 0,
        fresh: 0,
        spicy: 0,
        bitter: 0,
        floral: 0,
      );
    }

    double sweet = 0, sour = 0, fresh = 0, spicy = 0, bitter = 0, floral = 0;
    int totalPct = 0;

    for (final component in components) {
      final tobacco = tobaccos
          .where((t) => t.id == component.tobaccoId)
          .firstOrNull;
      if (tobacco == null) continue;
      final p = component.percentage;
      sweet += tobacco.tasteProfile.sweet * p;
      sour += tobacco.tasteProfile.sour * p;
      fresh += tobacco.tasteProfile.fresh * p;
      spicy += tobacco.tasteProfile.spicy * p;
      bitter += tobacco.tasteProfile.bitter * p;
      floral += tobacco.tasteProfile.floral * p;
      totalPct += p;
    }

    if (totalPct == 0) {
      return const TasteProfile(
        sweet: 0,
        sour: 0,
        fresh: 0,
        spicy: 0,
        bitter: 0,
        floral: 0,
      );
    }

    return TasteProfile(
      sweet: (sweet / totalPct).round(),
      sour: (sour / totalPct).round(),
      fresh: (fresh / totalPct).round(),
      spicy: (spicy / totalPct).round(),
      bitter: (bitter / totalPct).round(),
      floral: (floral / totalPct).round(),
    );
  }
}

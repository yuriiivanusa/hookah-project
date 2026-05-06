import 'package:hookah_mix_master/features/smart_recommender/domain/entities/curated_mix.dart';
import 'package:hookah_mix_master/features/tobacco_catalog/domain/entities/taste_profile.dart';

class RecommendationResult {
  const RecommendationResult({required this.mix, required this.distance, required this.matchLabel});

  final CuratedMix mix;
  final double distance;
  final MatchLabel matchLabel;
}

enum MatchLabel { excellent, good, fair }

abstract final class RecommendationAlgorithm {
  static const _strengthWeight = 1.5;

  /// Maps user-selected flavor tags to a [TasteProfile].
  /// Selected axis → 8, unselected → 2.
  static TasteProfile buildUserProfile(Set<String> selectedFlavors) {
    int axis(String name) => selectedFlavors.contains(name) ? 8 : 2;
    return TasteProfile(
      sweet: axis('sweet'),
      sour: axis('sour'),
      fresh: axis('fresh'),
      spicy: axis('spicy'),
      bitter: axis('bitter'),
      floral: axis('floral'),
    );
  }

  /// Returns mixes sorted by Manhattan distance (closest first).
  /// Optionally filters by [persona] ('beginner'|'intermediate'|'expert').
  static List<RecommendationResult> recommend({
    required List<CuratedMix> mixes,
    required TasteProfile userProfile,
    required int userStrength,
    String? persona,
    int topN = 5,
  }) {
    var candidates = mixes;
    if (persona != null && persona.isNotEmpty) {
      candidates = candidates.where((m) => m.targetPersona == persona).toList();
    }

    final results =
        candidates.map((mix) {
          final d = _totalDistance(mix, userProfile, userStrength);
          return RecommendationResult(mix: mix, distance: d, matchLabel: _label(d));
        }).toList()..sort((a, b) {
          final cmp = a.distance.compareTo(b.distance);
          if (cmp != 0) return cmp;
          return b.mix.popularity.compareTo(a.mix.popularity);
        });

    return results.take(topN).toList();
  }

  static double _totalDistance(CuratedMix mix, TasteProfile user, int userStrength) {
    final p = mix.expectedProfile;
    final tasteDist =
        (user.sweet - p.sweet).abs() +
        (user.sour - p.sour).abs() +
        (user.fresh - p.fresh).abs() +
        (user.spicy - p.spicy).abs() +
        (user.bitter - p.bitter).abs() +
        (user.floral - p.floral).abs();

    final strengthDist = (userStrength - mix.strengthLevel).abs() * _strengthWeight;
    return tasteDist + strengthDist;
  }

  static MatchLabel _label(double distance) {
    if (distance <= 8) return MatchLabel.excellent;
    if (distance <= 18) return MatchLabel.good;
    return MatchLabel.fair;
  }
}

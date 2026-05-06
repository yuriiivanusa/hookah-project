import 'package:flutter_test/flutter_test.dart';
import 'package:hookah_mix_master/features/smart_recommender/domain/entities/curated_mix.dart';
import 'package:hookah_mix_master/features/smart_recommender/domain/entities/mix_component.dart';
import 'package:hookah_mix_master/features/smart_recommender/domain/services/recommendation_algorithm.dart';
import 'package:hookah_mix_master/features/tobacco_catalog/domain/entities/taste_profile.dart';

CuratedMix _mix({
  String id = 'm1',
  int sweet = 5,
  int sour = 0,
  int fresh = 5,
  int spicy = 0,
  int bitter = 0,
  int floral = 0,
  int strength = 2,
  String persona = 'beginner',
  int popularity = 80,
}) => CuratedMix(
  id: id,
  nameEn: 'Mix $id',
  nameUk: 'Мікс $id',
  components: const [MixComponent(tobaccoId: 'brand__tobacco', percentage: 100)],
  expectedProfile: TasteProfile(
    sweet: sweet,
    sour: sour,
    fresh: fresh,
    spicy: spicy,
    bitter: bitter,
    floral: floral,
  ),
  strengthLevel: strength,
  difficulty: 'easy',
  descriptionEn: 'Desc',
  descriptionUk: 'Опис',
  targetPersona: persona,
  tags: const [],
  popularity: popularity,
);

void main() {
  group('RecommendationAlgorithm.buildUserProfile', () {
    test('selected axis gets value 8, unselected gets 2', () {
      final profile = RecommendationAlgorithm.buildUserProfile({'sweet', 'fresh'});
      expect(profile.sweet, 8);
      expect(profile.fresh, 8);
      expect(profile.sour, 2);
      expect(profile.spicy, 2);
      expect(profile.bitter, 2);
      expect(profile.floral, 2);
    });

    test('empty selection gives all axes value 2', () {
      final profile = RecommendationAlgorithm.buildUserProfile({});
      expect(profile.values, everyElement(equals(2)));
    });
  });

  group('RecommendationAlgorithm.recommend', () {
    test('returns mixes sorted by distance ascending', () {
      // m1: sweet+fresh=5 each → distance to user sweet+fresh=8 is |8-5|*2 + |2-0|+|2-0|+|2-0|+|2-0| = 6 + 8 = 14 + strength
      // m2: sweet=8, fresh=8 → distance 0 for those axes
      final m1 = _mix(id: 'm1', sweet: 5, fresh: 5);
      final m2 = _mix(id: 'm2', sweet: 8, fresh: 8, sour: 2, spicy: 2, bitter: 2, floral: 2);

      final profile = RecommendationAlgorithm.buildUserProfile({'sweet', 'fresh'});
      final results = RecommendationAlgorithm.recommend(
        mixes: [m1, m2],
        userProfile: profile,
        userStrength: 2,
      );

      expect(results.first.mix.id, 'm2');
    });

    test('tie-breaking uses popularity descending', () {
      final m1 = _mix(
        id: 'm1',
        sweet: 8,
        fresh: 8,
        sour: 2,
        spicy: 2,
        bitter: 2,
        floral: 2,
        popularity: 50,
      );
      final m2 = _mix(
        id: 'm2',
        sweet: 8,
        fresh: 8,
        sour: 2,
        spicy: 2,
        bitter: 2,
        floral: 2,
        popularity: 90,
      );

      final profile = RecommendationAlgorithm.buildUserProfile({'sweet', 'fresh'});
      final results = RecommendationAlgorithm.recommend(
        mixes: [m1, m2],
        userProfile: profile,
        userStrength: 2,
      );

      expect(results.first.mix.id, 'm2');
    });

    test('filters by persona', () {
      final beginner = _mix(id: 'b', persona: 'beginner');
      final expert = _mix(id: 'e', persona: 'expert');

      final results = RecommendationAlgorithm.recommend(
        mixes: [beginner, expert],
        userProfile: RecommendationAlgorithm.buildUserProfile({'sweet'}),
        userStrength: 2,
        persona: 'beginner',
      );

      expect(results.length, 1);
      expect(results.first.mix.id, 'b');
    });

    test('returns empty list when no mixes match persona', () {
      final mix = _mix(persona: 'expert');
      final results = RecommendationAlgorithm.recommend(
        mixes: [mix],
        userProfile: RecommendationAlgorithm.buildUserProfile({'sweet'}),
        userStrength: 2,
        persona: 'beginner',
      );
      expect(results, isEmpty);
    });

    test('match label is excellent for distance ≤ 8', () {
      final mix = _mix(sweet: 8, fresh: 8, sour: 2, spicy: 2, bitter: 2, floral: 2);
      final profile = RecommendationAlgorithm.buildUserProfile({'sweet', 'fresh'});
      final results = RecommendationAlgorithm.recommend(
        mixes: [mix],
        userProfile: profile,
        userStrength: 2,
      );
      expect(results.first.matchLabel, MatchLabel.excellent);
    });

    test('topN limits results', () {
      final mixes = List.generate(10, (i) => _mix(id: 'm$i'));
      final results = RecommendationAlgorithm.recommend(
        mixes: mixes,
        userProfile: RecommendationAlgorithm.buildUserProfile({'sweet'}),
        userStrength: 3,
        topN: 3,
      );
      expect(results.length, 3);
    });
  });
}

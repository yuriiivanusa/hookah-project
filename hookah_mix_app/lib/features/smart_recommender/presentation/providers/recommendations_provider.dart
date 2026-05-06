import 'package:hookah_mix_master/core/services/providers.dart';
import 'package:hookah_mix_master/features/smart_recommender/data/datasources/curated_mixes_datasource.dart';
import 'package:hookah_mix_master/features/smart_recommender/data/repositories/recommendation_repository_impl.dart';
import 'package:hookah_mix_master/features/smart_recommender/domain/repositories/recommendation_repository.dart';
import 'package:hookah_mix_master/features/smart_recommender/domain/services/recommendation_algorithm.dart';
import 'package:hookah_mix_master/features/smart_recommender/presentation/providers/wizard_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'recommendations_provider.g.dart';

@Riverpod(keepAlive: true)
RecommendationRepository recommendationRepository(Ref ref) {
  final ds = CuratedMixesDatasource(
    ref.watch(firebaseFirestoreProvider),
    ref.watch(hiveServiceProvider),
  );
  return RecommendationRepositoryImpl(ds);
}

@riverpod
Future<List<RecommendationResult>> recommendations(Ref ref) async {
  final wizard = ref.watch(wizardProvider);
  if (!wizard.submitted) return [];

  final mixes = await ref.watch(recommendationRepositoryProvider).getCuratedMixes();
  final userProfile = RecommendationAlgorithm.buildUserProfile(wizard.selectedFlavors);

  final persona = switch (wizard.persona) {
    'relax' => 'beginner',
    'party' => 'intermediate',
    'focus' => 'expert',
    _ => null,
  };

  return RecommendationAlgorithm.recommend(
    mixes: mixes,
    userProfile: userProfile,
    userStrength: wizard.strengthPreference,
    persona: persona,
  );
}

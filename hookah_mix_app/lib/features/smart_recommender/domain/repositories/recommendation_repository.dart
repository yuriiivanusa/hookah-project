import 'package:hookah_mix_master/features/smart_recommender/domain/entities/curated_mix.dart';

abstract interface class RecommendationRepository {
  Future<List<CuratedMix>> getCuratedMixes();
}

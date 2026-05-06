import 'package:hookah_mix_master/features/smart_recommender/data/datasources/curated_mixes_datasource.dart';
import 'package:hookah_mix_master/features/smart_recommender/domain/entities/curated_mix.dart';
import 'package:hookah_mix_master/features/smart_recommender/domain/repositories/recommendation_repository.dart';

class RecommendationRepositoryImpl implements RecommendationRepository {
  RecommendationRepositoryImpl(this._datasource);

  final CuratedMixesDatasource _datasource;

  @override
  Future<List<CuratedMix>> getCuratedMixes() async {
    final dtos = await _datasource.getCuratedMixes();
    return dtos.map((d) => d.toDomain()).toList();
  }
}

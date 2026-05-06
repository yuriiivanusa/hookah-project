import 'package:hookah_mix_master/features/mix_builder/data/datasources/local_mixes_datasource.dart';
import 'package:hookah_mix_master/features/mix_builder/domain/entities/user_mix.dart';
import 'package:hookah_mix_master/features/mix_builder/domain/repositories/mix_builder_repository.dart';

class MixBuilderRepositoryImpl implements MixBuilderRepository {
  MixBuilderRepositoryImpl(this._datasource);

  final LocalMixesDatasource _datasource;

  @override
  Future<List<UserMix>> getUserMixes(String userId) async => _datasource.getUserMixes();

  @override
  Future<UserMix> createMix(UserMix mix) => _datasource.createMix(mix);

  @override
  Future<UserMix> updateMix(UserMix mix) => _datasource.updateMix(mix);

  @override
  Future<void> deleteMix(String mixId, String userId) => _datasource.deleteMix(mixId);
}

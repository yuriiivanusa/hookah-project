import 'package:hookah_mix_master/features/mix_builder/domain/entities/user_mix.dart';

abstract interface class MixBuilderRepository {
  Future<List<UserMix>> getUserMixes(String userId);
  Future<UserMix> createMix(UserMix mix);
  Future<UserMix> updateMix(UserMix mix);
  Future<void> deleteMix(String mixId, String userId);
}

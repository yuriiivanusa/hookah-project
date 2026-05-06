import 'package:hookah_mix_master/features/tobacco_catalog/domain/entities/brand.dart';
import 'package:hookah_mix_master/features/tobacco_catalog/domain/entities/tobacco.dart';
import 'package:hookah_mix_master/features/tobacco_catalog/domain/entities/tobacco_filter.dart';

abstract interface class TobaccoRepository {
  Future<List<Tobacco>> getTobaccos();
  Future<Tobacco?> getTobaccoById(String id);
  Future<List<Brand>> getBrands();
  Future<List<Tobacco>> filterTobaccos(TobaccoFilter filter);
}

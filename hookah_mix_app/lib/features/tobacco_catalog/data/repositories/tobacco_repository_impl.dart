import 'package:hookah_mix_master/features/tobacco_catalog/data/datasources/tobacco_local_datasource.dart';
import 'package:hookah_mix_master/features/tobacco_catalog/data/datasources/tobacco_remote_datasource.dart';
import 'package:hookah_mix_master/features/tobacco_catalog/data/dtos/brand_dto.dart';
import 'package:hookah_mix_master/features/tobacco_catalog/data/dtos/tobacco_dto.dart';
import 'package:hookah_mix_master/features/tobacco_catalog/domain/entities/brand.dart';
import 'package:hookah_mix_master/features/tobacco_catalog/domain/entities/tobacco.dart';
import 'package:hookah_mix_master/features/tobacco_catalog/domain/entities/tobacco_filter.dart';
import 'package:hookah_mix_master/features/tobacco_catalog/domain/repositories/tobacco_repository.dart';

class TobaccoRepositoryImpl implements TobaccoRepository {
  TobaccoRepositoryImpl(this._remote, this._local);

  final TobaccoRemoteDataSource _remote;
  final TobaccoLocalDataSource _local;

  List<TobaccoDto>? _tobaccoCache;
  List<BrandDto>? _brandCache;

  @override
  Future<List<Tobacco>> getTobaccos() async {
    if (_tobaccoCache != null) {
      return _tobaccoCache!.map((d) => d.toDomain()).toList();
    }
    if (_local.isCacheValid()) {
      final cached = _local.getCachedTobaccos();
      if (cached != null) {
        _tobaccoCache = cached;
        _brandCache = _local.getCachedBrands();
        return cached.map((d) => d.toDomain()).toList();
      }
    }
    return _fetchAndCache();
  }

  @override
  Future<Tobacco?> getTobaccoById(String id) async {
    final all = await getTobaccos();
    try {
      return all.firstWhere((t) => t.id == id);
    } on StateError {
      return null;
    }
  }

  @override
  Future<List<Brand>> getBrands() async {
    if (_brandCache != null) {
      return _brandCache!.map((d) => d.toDomain()).toList();
    }
    await getTobaccos();
    return _brandCache?.map((d) => d.toDomain()).toList() ?? [];
  }

  @override
  Future<List<Tobacco>> filterTobaccos(TobaccoFilter filter) async {
    var tobaccos = await getTobaccos();

    if (filter.query.isNotEmpty) {
      final q = filter.query.toLowerCase();
      tobaccos = tobaccos
          .where(
            (t) =>
                t.nameEn.toLowerCase().contains(q) ||
                t.nameUk.toLowerCase().contains(q) ||
                t.brandName.toLowerCase().contains(q) ||
                t.tasteNotes.any((n) => n.toLowerCase().contains(q)),
          )
          .toList();
    }

    if (filter.brandId != null) {
      tobaccos = tobaccos.where((t) => t.brandId == filter.brandId).toList();
    }
    if (filter.leafType != null) {
      tobaccos = tobaccos.where((t) => t.leafType == filter.leafType).toList();
    }
    if (filter.flavorCategory != null) {
      tobaccos = tobaccos.where((t) => t.flavorCategories.contains(filter.flavorCategory)).toList();
    }

    tobaccos = tobaccos
        .where((t) => t.strength >= filter.minStrength && t.strength <= filter.maxStrength)
        .toList();

    switch (filter.sortOrder) {
      case TobaccoSortOrder.nameAsc:
        tobaccos.sort((a, b) => a.nameEn.compareTo(b.nameEn));
      case TobaccoSortOrder.nameDesc:
        tobaccos.sort((a, b) => b.nameEn.compareTo(a.nameEn));
      case TobaccoSortOrder.strengthAsc:
        tobaccos.sort((a, b) => a.strength.compareTo(b.strength));
      case TobaccoSortOrder.strengthDesc:
        tobaccos.sort((a, b) => b.strength.compareTo(a.strength));
      case TobaccoSortOrder.popularityDesc:
        tobaccos.sort((a, b) => b.popularity.compareTo(a.popularity));
    }

    return tobaccos;
  }

  Future<List<Tobacco>> _fetchAndCache() async {
    final tobaccos = await _remote.getTobaccos();
    final brands = await _remote.getBrands();
    final version = await _remote.getCatalogVersion() ?? '1.0.0';
    await _local.cacheTobaccos(tobaccos, brands, version);
    _tobaccoCache = tobaccos;
    _brandCache = brands;
    return tobaccos.map((d) => d.toDomain()).toList();
  }
}

import 'package:hookah_mix_master/core/services/providers.dart';
import 'package:hookah_mix_master/features/tobacco_catalog/data/datasources/tobacco_local_datasource.dart';
import 'package:hookah_mix_master/features/tobacco_catalog/data/datasources/tobacco_remote_datasource.dart';
import 'package:hookah_mix_master/features/tobacco_catalog/data/repositories/tobacco_repository_impl.dart';
import 'package:hookah_mix_master/features/tobacco_catalog/domain/entities/brand.dart';
import 'package:hookah_mix_master/features/tobacco_catalog/domain/entities/tobacco.dart';
import 'package:hookah_mix_master/features/tobacco_catalog/domain/repositories/tobacco_repository.dart';
import 'package:hookah_mix_master/features/tobacco_catalog/presentation/providers/catalog_filter_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'tobacco_providers.g.dart';

@Riverpod(keepAlive: true)
TobaccoRepository tobaccoRepository(Ref ref) {
  final remote = TobaccoRemoteDataSource(ref.watch(firebaseFirestoreProvider));
  final local = TobaccoLocalDataSource(ref.watch(hiveServiceProvider));
  return TobaccoRepositoryImpl(remote, local);
}

@riverpod
Future<List<Tobacco>> tobaccoList(Ref ref) => ref.watch(tobaccoRepositoryProvider).getTobaccos();

@riverpod
Future<List<Brand>> brandList(Ref ref) => ref.watch(tobaccoRepositoryProvider).getBrands();

@riverpod
Future<Tobacco?> tobaccoDetail(Ref ref, String id) =>
    ref.watch(tobaccoRepositoryProvider).getTobaccoById(id);

@riverpod
Future<List<Tobacco>> filteredTobaccoList(Ref ref) {
  final filter = ref.watch(catalogFilterProvider);
  return ref.watch(tobaccoRepositoryProvider).filterTobaccos(filter);
}

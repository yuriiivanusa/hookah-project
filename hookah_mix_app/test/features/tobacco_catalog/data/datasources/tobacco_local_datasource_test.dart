import 'package:flutter_test/flutter_test.dart';
import 'package:hookah_mix_master/core/services/local/hive_service.dart';
import 'package:hookah_mix_master/features/tobacco_catalog/data/datasources/tobacco_local_datasource.dart';
import 'package:hookah_mix_master/features/tobacco_catalog/data/dtos/brand_dto.dart';
import 'package:hookah_mix_master/features/tobacco_catalog/data/dtos/tobacco_dto.dart';

class _FakeHiveService extends Fake implements HiveService {
  final _store = <String, Map<String, String>>{};

  @override
  String? get(String boxName, String key) => _store[boxName]?[key];

  @override
  Future<void> put(String boxName, String key, String value) async {
    (_store[boxName] ??= {})[key] = value;
  }

  @override
  Future<void> clearBox(String boxName) async {
    _store[boxName]?.clear();
  }

  @override
  bool isCacheValid(String boxName, String timestampKey) {
    final raw = get(boxName, timestampKey);
    if (raw == null) return false;
    final cached = DateTime.tryParse(raw);
    return cached != null &&
        DateTime.now().difference(cached) < const Duration(hours: 24);
  }

  @override
  Future<void> touchTimestamp(String boxName, String timestampKey) async {
    await put(boxName, timestampKey, DateTime.now().toIso8601String());
  }
}

TobaccoDto _makeDto({String id = 't1', String nameEn = 'Blue Mist'}) =>
    TobaccoDto(
      id: id,
      brand: const TobaccoBrandRef(id: 'b1', name: 'Fumari', country: 'US'),
      name: LocalizedString(en: nameEn, uk: 'Назва'),
      leafType: 'virginia',
      strength: 3,
      flavorCategories: const ['fruity'],
      tasteNotes: const ['blueberry'],
      tasteProfile: const TasteProfileDto(),
      description: const LocalizedString(en: 'Desc', uk: 'Опис'),
      popularity: 90,
    );

BrandDto _makeBrand({String id = 'b1'}) => BrandDto(
  id: id,
  name: 'Fumari',
  country: 'US',
  countryName: const LocalizedString(en: 'United States', uk: 'США'),
  leafType: 'virginia',
  description: const LocalizedString(en: 'Premium', uk: 'Преміум'),
  popularity: 90,
);

void main() {
  late _FakeHiveService hive;
  late TobaccoLocalDataSource sut;

  setUp(() {
    hive = _FakeHiveService();
    sut = TobaccoLocalDataSource(hive);
  });

  group('TobaccoLocalDataSource', () {
    test('getCachedTobaccos returns null when cache is empty', () {
      expect(sut.getCachedTobaccos(), isNull);
    });

    test('getCachedBrands returns null when cache is empty', () {
      expect(sut.getCachedBrands(), isNull);
    });

    test('isCacheValid returns false when cache is empty', () {
      expect(sut.isCacheValid(), isFalse);
    });

    test('getCachedVersion returns null when not cached', () {
      expect(sut.getCachedVersion(), isNull);
    });

    test('cacheTobaccos stores tobaccos and brands', () async {
      final tobaccos = [_makeDto(id: 't1'), _makeDto(id: 't2', nameEn: 'Mint')];
      final brands = [_makeBrand()];

      await sut.cacheTobaccos(tobaccos, brands, 'v1');

      final cached = sut.getCachedTobaccos();
      expect(cached, isNotNull);
      expect(cached!.length, 2);
      expect(cached.first.id, 't1');
      expect(cached.last.name.en, 'Mint');
    });

    test('cacheTobaccos stores brands correctly', () async {
      await sut.cacheTobaccos([_makeDto()], [_makeBrand(id: 'brand1')], 'v1');

      final brands = sut.getCachedBrands();
      expect(brands, isNotNull);
      expect(brands!.length, 1);
      expect(brands.first.id, 'brand1');
    });

    test('cacheTobaccos stores version', () async {
      await sut.cacheTobaccos([_makeDto()], [_makeBrand()], 'v2');
      expect(sut.getCachedVersion(), 'v2');
    });

    test('isCacheValid returns true after caching', () async {
      await sut.cacheTobaccos([_makeDto()], [_makeBrand()], 'v1');
      expect(sut.isCacheValid(), isTrue);
    });

    test('getCachedTobaccos round-trips tasteNotes', () async {
      final dto = _makeDto();
      await sut.cacheTobaccos([dto], [_makeBrand()], 'v1');

      final cached = sut.getCachedTobaccos()!.first;
      expect(cached.tasteNotes, ['blueberry']);
      expect(cached.flavorCategories, ['fruity']);
    });

    test('clearCache removes cached data', () async {
      await sut.cacheTobaccos([_makeDto()], [_makeBrand()], 'v1');
      await sut.clearCache();

      expect(sut.getCachedTobaccos(), isNull);
      expect(sut.getCachedBrands(), isNull);
      expect(sut.isCacheValid(), isFalse);
    });

    test('cacheTobaccos overwrites previous cache', () async {
      await sut.cacheTobaccos([_makeDto(id: 't1')], [_makeBrand()], 'v1');
      await sut.cacheTobaccos(
        [_makeDto(id: 't2'), _makeDto(id: 't3')],
        [_makeBrand()],
        'v2',
      );

      expect(sut.getCachedTobaccos()!.length, 2);
      expect(sut.getCachedVersion(), 'v2');
    });
  });
}

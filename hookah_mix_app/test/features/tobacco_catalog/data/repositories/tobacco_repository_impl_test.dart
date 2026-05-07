import 'package:flutter_test/flutter_test.dart';
import 'package:hookah_mix_master/features/tobacco_catalog/data/datasources/tobacco_local_datasource.dart';
import 'package:hookah_mix_master/features/tobacco_catalog/data/datasources/tobacco_remote_datasource.dart';
import 'package:hookah_mix_master/features/tobacco_catalog/data/dtos/brand_dto.dart';
import 'package:hookah_mix_master/features/tobacco_catalog/data/dtos/tobacco_dto.dart';
import 'package:hookah_mix_master/features/tobacco_catalog/data/repositories/tobacco_repository_impl.dart';
import 'package:hookah_mix_master/features/tobacco_catalog/domain/entities/tobacco.dart';
import 'package:hookah_mix_master/features/tobacco_catalog/domain/entities/tobacco_filter.dart';
import 'package:mocktail/mocktail.dart';

class _MockRemote extends Mock implements TobaccoRemoteDataSource {}

class _MockLocal extends Mock implements TobaccoLocalDataSource {}

TobaccoDto _makeDto({
  String id = 't1',
  String nameEn = 'Blue Mist',
  String nameUk = 'Блакитний Туман',
  String brandId = 'b1',
  String brandName = 'Fumari',
  String brandCountry = 'US',
  String leafType = 'virginia',
  int strength = 3,
  List<String> flavorCategories = const ['fruity'],
  List<String> tasteNotes = const ['blueberry'],
  int popularity = 90,
}) => TobaccoDto(
  id: id,
  brand: TobaccoBrandRef(id: brandId, name: brandName, country: brandCountry),
  name: LocalizedString(en: nameEn, uk: nameUk),
  leafType: leafType,
  strength: strength,
  flavorCategories: flavorCategories,
  tasteNotes: tasteNotes,
  tasteProfile: const TasteProfileDto(),
  description: const LocalizedString(en: 'Desc', uk: 'Опис'),
  popularity: popularity,
);

BrandDto _makeBrandDto({String id = 'b1', String name = 'Fumari'}) => BrandDto(
  id: id,
  name: name,
  country: 'US',
  countryName: const LocalizedString(en: 'United States', uk: 'США'),
  leafType: 'virginia',
  description: const LocalizedString(en: 'Premium brand', uk: 'Преміум бренд'),
  popularity: 90,
);

void main() {
  late _MockRemote remote;
  late _MockLocal local;
  late TobaccoRepositoryImpl sut;

  final sampleDto = _makeDto();
  final sampleBrand = _makeBrandDto();

  setUp(() {
    remote = _MockRemote();
    local = _MockLocal();
    sut = TobaccoRepositoryImpl(remote, local);

    when(() => local.isCacheValid()).thenReturn(false);
    when(() => local.getCachedTobaccos()).thenReturn(null);
    when(() => remote.getTobaccos()).thenAnswer((_) async => [sampleDto]);
    when(() => remote.getBrands()).thenAnswer((_) async => [sampleBrand]);
    when(() => remote.getCatalogVersion()).thenAnswer((_) async => '1.0.0');
    when(
      () => local.cacheTobaccos(any(), any(), any()),
    ).thenAnswer((_) async {});
  });

  group('getTobaccos', () {
    test('fetches from remote when cache is invalid', () async {
      final result = await sut.getTobaccos();
      expect(result, isA<List<Tobacco>>());
      expect(result.length, 1);
      expect(result.first.nameEn, 'Blue Mist');
      verify(() => remote.getTobaccos()).called(1);
    });

    test('returns in-memory cache on second call', () async {
      await sut.getTobaccos();
      await sut.getTobaccos();
      verify(() => remote.getTobaccos()).called(1);
    });
  });

  group('getTobaccoById', () {
    test('returns tobacco when found', () async {
      final result = await sut.getTobaccoById('t1');
      expect(result?.id, 't1');
    });

    test('returns null when not found', () async {
      final result = await sut.getTobaccoById('unknown');
      expect(result, isNull);
    });
  });

  group('getBrands', () {
    test('returns brand list populated during getTobaccos', () async {
      final brands = await sut.getBrands();
      expect(brands.length, 1);
      expect(brands.first.name, 'Fumari');
    });
  });

  group('filterTobaccos', () {
    test('returns all when filter is empty', () async {
      final result = await sut.filterTobaccos(const TobaccoFilter());
      expect(result.length, 1);
    });

    test('filters by query matching name', () async {
      final result = await sut.filterTobaccos(
        const TobaccoFilter(query: 'blue'),
      );
      expect(result.length, 1);

      final noMatch = await sut.filterTobaccos(
        const TobaccoFilter(query: 'zzz'),
      );
      expect(noMatch, isEmpty);
    });

    test('filters by brandId', () async {
      final match = await sut.filterTobaccos(
        const TobaccoFilter(brandId: 'b1'),
      );
      expect(match.length, 1);

      final noMatch = await sut.filterTobaccos(
        const TobaccoFilter(brandId: 'other'),
      );
      expect(noMatch, isEmpty);
    });

    test('filters by flavorCategory', () async {
      final match = await sut.filterTobaccos(
        const TobaccoFilter(flavorCategory: 'fruity'),
      );
      expect(match.length, 1);

      final noMatch = await sut.filterTobaccos(
        const TobaccoFilter(flavorCategory: 'mint'),
      );
      expect(noMatch, isEmpty);
    });

    test('filters by strength range', () async {
      final match = await sut.filterTobaccos(
        const TobaccoFilter(minStrength: 2, maxStrength: 4),
      );
      expect(match.length, 1);

      final noMatch = await sut.filterTobaccos(
        const TobaccoFilter(minStrength: 4, maxStrength: 5),
      );
      expect(noMatch, isEmpty);
    });

    test('sorts by name ascending', () async {
      when(() => remote.getTobaccos()).thenAnswer(
        (_) async => [
          _makeDto(id: 't2', nameEn: 'Zest', popularity: 50),
          _makeDto(id: 't1', nameEn: 'Apple', popularity: 80),
        ],
      );
      // Reset in-memory cache so new mocks are used
      sut = TobaccoRepositoryImpl(remote, local);

      final result = await sut.filterTobaccos(
        const TobaccoFilter(sortOrder: TobaccoSortOrder.nameAsc),
      );
      expect(result.first.nameEn, 'Apple');
      expect(result.last.nameEn, 'Zest');
    });
  });
}

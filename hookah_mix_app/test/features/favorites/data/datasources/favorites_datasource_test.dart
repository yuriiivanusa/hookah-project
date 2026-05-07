import 'package:flutter_test/flutter_test.dart';
import 'package:hookah_mix_master/core/services/local/hive_service.dart';
import 'package:hookah_mix_master/features/favorites/data/datasources/favorites_datasource.dart';
import 'package:hookah_mix_master/features/favorites/domain/entities/favorite_entry.dart';

class _FakeHiveService extends Fake implements HiveService {
  final _store = <String, Map<String, String>>{};

  @override
  String? get(String boxName, String key) => _store[boxName]?[key];

  @override
  Future<void> put(String boxName, String key, String value) async {
    (_store[boxName] ??= {})[key] = value;
  }

  @override
  Future<void> delete(String boxName, String key) async {
    _store[boxName]?.remove(key);
  }
}

FavoriteEntry _makeEntry({
  String id = 'fav1',
  FavoriteType type = FavoriteType.tobacco,
  String refId = 'ref1',
  String displayName = 'Blue Mist',
}) => FavoriteEntry(
  id: id,
  type: type,
  refId: refId,
  displayName: displayName,
  addedAt: DateTime(2025),
);

void main() {
  late _FakeHiveService hive;
  late FavoritesDatasource sut;

  setUp(() {
    hive = _FakeHiveService();
    sut = FavoritesDatasource(hive);
  });

  group('FavoritesDatasource', () {
    test('getFavorites returns empty list when Hive has no data', () {
      expect(sut.getFavorites(), isEmpty);
    });

    test('addFavorite persists entry and returns it', () async {
      final entry = _makeEntry();
      final result = await sut.addFavorite(entry);

      expect(result.id, entry.id);
      expect(sut.getFavorites().length, 1);
      expect(sut.getFavorites().first.refId, 'ref1');
    });

    test('addFavorite accumulates multiple entries', () async {
      await sut.addFavorite(_makeEntry(id: 'f1', refId: 'r1'));
      await sut.addFavorite(_makeEntry(id: 'f2', refId: 'r2'));

      expect(sut.getFavorites().length, 2);
    });

    test('removeFavorite removes entry by id', () async {
      await sut.addFavorite(_makeEntry(id: 'f1', refId: 'r1'));
      await sut.addFavorite(_makeEntry(id: 'f2', refId: 'r2'));

      await sut.removeFavorite('f1');

      final remaining = sut.getFavorites();
      expect(remaining.length, 1);
      expect(remaining.first.id, 'f2');
    });

    test('removeFavorite with unknown id leaves list unchanged', () async {
      await sut.addFavorite(_makeEntry());
      await sut.removeFavorite('nonexistent');
      expect(sut.getFavorites().length, 1);
    });

    test('isFavorite returns false when empty', () {
      expect(sut.isFavorite(FavoriteType.tobacco, 'ref1'), isFalse);
    });

    test('isFavorite returns true after adding', () async {
      await sut.addFavorite(
        _makeEntry(type: FavoriteType.tobacco, refId: 'ref1'),
      );
      expect(sut.isFavorite(FavoriteType.tobacco, 'ref1'), isTrue);
    });

    test('isFavorite returns false for different type', () async {
      await sut.addFavorite(
        _makeEntry(type: FavoriteType.tobacco, refId: 'ref1'),
      );
      expect(sut.isFavorite(FavoriteType.mix, 'ref1'), isFalse);
    });

    test('isFavorite returns false after removing', () async {
      await sut.addFavorite(
        _makeEntry(id: 'f1', type: FavoriteType.tobacco, refId: 'ref1'),
      );
      await sut.removeFavorite('f1');
      expect(sut.isFavorite(FavoriteType.tobacco, 'ref1'), isFalse);
    });

    test('getFavorites preserves type and displayName', () async {
      await sut.addFavorite(
        _makeEntry(
          type: FavoriteType.mix,
          refId: 'mix1',
          displayName: 'Evening Blend',
        ),
      );

      final entry = sut.getFavorites().first;
      expect(entry.type, FavoriteType.mix);
      expect(entry.displayName, 'Evening Blend');
    });
  });
}

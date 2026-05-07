import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hookah_mix_master/features/favorites/domain/entities/favorite_entry.dart';
import 'package:hookah_mix_master/features/favorites/domain/repositories/favorites_repository.dart';
import 'package:hookah_mix_master/features/favorites/presentation/providers/favorites_notifier.dart';
import 'package:mocktail/mocktail.dart';

class _MockFavoritesRepository extends Mock implements FavoritesRepository {}

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
  late _MockFavoritesRepository repo;

  setUp(() {
    repo = _MockFavoritesRepository();
  });

  ProviderContainer makeContainer(List<FavoriteEntry> initial) {
    when(() => repo.getFavorites()).thenReturn(initial);
    return ProviderContainer(
      overrides: [favoritesRepositoryProvider.overrideWithValue(repo)],
    );
  }

  group('FavoritesNotifier', () {
    test('initial state loads favorites from repository', () {
      final entries = [_makeEntry()];
      final c = makeContainer(entries);
      addTearDown(c.dispose);

      expect(c.read(favoritesProvider), entries);
    });

    test('initial state is empty when repository has no favorites', () {
      final c = makeContainer([]);
      addTearDown(c.dispose);

      expect(c.read(favoritesProvider), isEmpty);
    });

    test('toggle adds new favorite when not yet favorited', () async {
      final added = _makeEntry();

      // Create container first — makeContainer stubs getFavorites → []
      final c = makeContainer([]);
      addTearDown(c.dispose);
      c.read(favoritesProvider); // force build() to run with current stub

      // Now stub for what happens after the toggle
      when(
        () => repo.isFavorite(FavoriteType.tobacco, 'ref1'),
      ).thenReturn(false);
      when(
        () => repo.addFavorite(
          type: FavoriteType.tobacco,
          refId: 'ref1',
          displayName: 'Blue Mist',
        ),
      ).thenAnswer((_) async => added);
      when(() => repo.getFavorites()).thenReturn([added]);

      await c
          .read(favoritesProvider.notifier)
          .toggle(FavoriteType.tobacco, 'ref1', 'Blue Mist');

      verify(
        () => repo.addFavorite(
          type: FavoriteType.tobacco,
          refId: 'ref1',
          displayName: 'Blue Mist',
        ),
      ).called(1);
      expect(c.read(favoritesProvider), [added]);
    });

    test('toggle removes existing favorite when already favorited', () async {
      final existing = _makeEntry();

      // Create container first — makeContainer stubs getFavorites → [existing]
      final c = makeContainer([existing]);
      addTearDown(c.dispose);
      c.read(favoritesProvider); // force build() to run with [existing] state

      // Now stub for what happens after the toggle
      when(
        () => repo.isFavorite(FavoriteType.tobacco, 'ref1'),
      ).thenReturn(true);
      when(() => repo.removeFavorite('fav1')).thenAnswer((_) async {});
      when(() => repo.getFavorites()).thenReturn([]);

      await c
          .read(favoritesProvider.notifier)
          .toggle(FavoriteType.tobacco, 'ref1', 'Blue Mist');

      verify(() => repo.removeFavorite('fav1')).called(1);
      expect(c.read(favoritesProvider), isEmpty);
    });

    test('isFavorite delegates to repository', () {
      when(() => repo.isFavorite(FavoriteType.mix, 'mix1')).thenReturn(true);

      final c = makeContainer([]);
      addTearDown(c.dispose);

      expect(
        c.read(favoritesProvider.notifier).isFavorite(FavoriteType.mix, 'mix1'),
        isTrue,
      );
      verify(() => repo.isFavorite(FavoriteType.mix, 'mix1')).called(1);
    });

    test('isFavorite returns false when not in repository', () {
      when(
        () => repo.isFavorite(FavoriteType.tobacco, 'unknown'),
      ).thenReturn(false);

      final c = makeContainer([]);
      addTearDown(c.dispose);

      expect(
        c
            .read(favoritesProvider.notifier)
            .isFavorite(FavoriteType.tobacco, 'unknown'),
        isFalse,
      );
    });
  });
}

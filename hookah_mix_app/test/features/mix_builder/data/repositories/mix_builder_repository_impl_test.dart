import 'package:flutter_test/flutter_test.dart';
import 'package:hookah_mix_master/features/mix_builder/data/datasources/local_mixes_datasource.dart';
import 'package:hookah_mix_master/features/mix_builder/data/repositories/mix_builder_repository_impl.dart';
import 'package:hookah_mix_master/features/mix_builder/domain/entities/mix_component.dart';
import 'package:hookah_mix_master/features/mix_builder/domain/entities/user_mix.dart';
import 'package:mocktail/mocktail.dart';

class _MockLocalMixesDatasource extends Mock implements LocalMixesDatasource {}

UserMix _makeMix({String id = 'id1', String name = 'Test'}) => UserMix(
  id: id,
  userId: 'u1',
  name: name,
  components: const [
    MixComponent(tobaccoId: 't1', tobaccoName: 'Tobacco A', percentage: 60),
    MixComponent(tobaccoId: 't2', tobaccoName: 'Tobacco B', percentage: 40),
  ],
  createdAt: DateTime(2025),
  updatedAt: DateTime(2025),
);

void main() {
  late _MockLocalMixesDatasource datasource;
  late MixBuilderRepositoryImpl sut;

  setUp(() {
    datasource = _MockLocalMixesDatasource();
    sut = MixBuilderRepositoryImpl(datasource);
  });

  group('MixBuilderRepositoryImpl', () {
    test('getUserMixes delegates to datasource', () async {
      final mixes = [_makeMix(id: 'a'), _makeMix(id: 'b')];
      when(() => datasource.getUserMixes()).thenReturn(mixes);

      final result = await sut.getUserMixes('u1');

      expect(result, mixes);
      verify(() => datasource.getUserMixes()).called(1);
    });

    test('createMix delegates to datasource and returns result', () async {
      final mix = _makeMix();
      final created = mix.copyWith(id: 'generated');
      when(() => datasource.createMix(mix)).thenAnswer((_) async => created);

      final result = await sut.createMix(mix);

      expect(result.id, 'generated');
      verify(() => datasource.createMix(mix)).called(1);
    });

    test('updateMix delegates to datasource and returns updated', () async {
      final mix = _makeMix();
      final updated = mix.copyWith(name: 'Updated');
      when(() => datasource.updateMix(mix)).thenAnswer((_) async => updated);

      final result = await sut.updateMix(mix);

      expect(result.name, 'Updated');
      verify(() => datasource.updateMix(mix)).called(1);
    });

    test('deleteMix delegates to datasource with mix id', () async {
      when(() => datasource.deleteMix('id1')).thenAnswer((_) async {});

      await sut.deleteMix('id1', 'u1');

      verify(() => datasource.deleteMix('id1')).called(1);
    });
  });
}

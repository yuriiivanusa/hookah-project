import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hookah_mix_master/core/services/local/secure_storage_service.dart';
import 'package:mocktail/mocktail.dart';

class _MockSecureStorage extends Mock implements FlutterSecureStorage {}

void main() {
  late _MockSecureStorage mockStorage;
  late SecureStorageService sut;

  setUp(() {
    mockStorage = _MockSecureStorage();
    sut = SecureStorageService(mockStorage);
  });

  group('SecureStorageService', () {
    test('writeAuthToken calls storage.write with correct key', () async {
      when(() => mockStorage.write(key: any(named: 'key'), value: any(named: 'value')))
          .thenAnswer((_) async {});
      await sut.writeAuthToken('my-token');
      verify(() => mockStorage.write(key: 'auth_token', value: 'my-token')).called(1);
    });

    test('readAuthToken calls storage.read with correct key', () async {
      when(() => mockStorage.read(key: 'auth_token')).thenAnswer((_) async => 'my-token');
      final result = await sut.readAuthToken();
      expect(result, 'my-token');
    });

    test('deleteAuthToken calls storage.delete', () async {
      when(() => mockStorage.delete(key: 'auth_token')).thenAnswer((_) async {});
      await sut.deleteAuthToken();
      verify(() => mockStorage.delete(key: 'auth_token')).called(1);
    });
  });
}

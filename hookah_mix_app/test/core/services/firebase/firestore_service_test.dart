import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hookah_mix_master/core/services/firebase/firestore_service.dart';

void main() {
  late FakeFirebaseFirestore fakeDb;
  late FirestoreService sut;

  setUp(() {
    fakeDb = FakeFirebaseFirestore();
    sut = FirestoreService(fakeDb);
  });

  group('FirestoreService.addDocument + getDocument', () {
    test('adds and retrieves a document', () async {
      final id = await sut.addDocument('brands', {
        'name': 'Adalya',
        'country': 'TR',
      });
      expect(id, isNotEmpty);

      final doc = await sut.getDocument('brands/$id');
      expect(doc, isNotNull);
      expect(doc!['name'], 'Adalya');
    });
  });

  group('FirestoreService.getCollection', () {
    test('returns list of documents', () async {
      await fakeDb.collection('tobaccos').add({'name': 'Love 66'});
      await fakeDb.collection('tobaccos').add({'name': 'Two Apples'});

      final results = await sut.getCollection('tobaccos');
      expect(results.length, 2);
    });
  });

  group('FirestoreService.setDocument', () {
    test('sets and merges document', () async {
      await sut.setDocument('users/u1', {'name': 'Yurii'});
      await sut.setDocument('users/u1', {'age': 25}, merge: true);

      final doc = await sut.getDocument('users/u1');
      expect(doc!['name'], 'Yurii');
      expect(doc['age'], 25);
    });
  });

  group('FirestoreService.deleteDocument', () {
    test('deletes a document', () async {
      await fakeDb.collection('test').doc('d1').set({'x': 1});
      await sut.deleteDocument('test/d1');
      final doc = await sut.getDocument('test/d1');
      expect(doc, isNull);
    });
  });
}

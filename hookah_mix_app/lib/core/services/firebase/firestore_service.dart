import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hookah_mix_master/core/errors/network_exception.dart';

class FirestoreService {
  FirestoreService(this._db);

  final FirebaseFirestore _db;

  Future<List<Map<String, dynamic>>> getCollection(
    String path, {
    List<QueryFilter> filters = const [],
    String? orderBy,
    bool descending = false,
    int? limit,
    DocumentSnapshot? startAfter,
  }) async {
    try {
      Query<Map<String, dynamic>> query = _db.collection(path);
      for (final f in filters) {
        query = query.where(f.field, isEqualTo: f.isEqualTo, arrayContainsAny: f.arrayContainsAny);
      }
      if (orderBy != null) query = query.orderBy(orderBy, descending: descending);
      if (limit != null) query = query.limit(limit);
      if (startAfter != null) query = query.startAfterDocument(startAfter);

      final snapshot = await query.get();
      return snapshot.docs.map((d) => {'id': d.id, ...d.data()}).toList();
    } on FirebaseException catch (e) {
      throw _mapError(e);
    }
  }

  Future<Map<String, dynamic>?> getDocument(String path) async {
    try {
      final doc = await _db.doc(path).get();
      if (!doc.exists) return null;
      return {'id': doc.id, ...doc.data()!};
    } on FirebaseException catch (e) {
      throw _mapError(e);
    }
  }

  Future<String> addDocument(String collection, Map<String, dynamic> data) async {
    try {
      final ref = await _db.collection(collection).add(data);
      return ref.id;
    } on FirebaseException catch (e) {
      throw _mapError(e);
    }
  }

  Future<void> setDocument(String path, Map<String, dynamic> data, {bool merge = false}) async {
    try {
      await _db.doc(path).set(data, SetOptions(merge: merge));
    } on FirebaseException catch (e) {
      throw _mapError(e);
    }
  }

  Future<void> updateDocument(String path, Map<String, dynamic> data) async {
    try {
      await _db.doc(path).update(data);
    } on FirebaseException catch (e) {
      throw _mapError(e);
    }
  }

  Future<void> deleteDocument(String path) async {
    try {
      await _db.doc(path).delete();
    } on FirebaseException catch (e) {
      throw _mapError(e);
    }
  }

  NetworkException _mapError(FirebaseException e) => switch (e.code) {
        'permission-denied' => NetworkException.permissionDenied(),
        'not-found' => NetworkException.notFound(),
        'unavailable' || 'deadline-exceeded' => NetworkException.timeout(),
        _ => NetworkException.unknown(e.message),
      };
}

class QueryFilter {
  const QueryFilter({required this.field, this.isEqualTo, this.arrayContainsAny});

  final String field;
  final Object? isEqualTo;
  final List<Object?>? arrayContainsAny;
}

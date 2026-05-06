import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hookah_mix_master/features/mix_builder/data/dtos/user_mix_dto.dart';
import 'package:hookah_mix_master/features/mix_builder/domain/entities/user_mix.dart';

class UserMixesDatasource {
  UserMixesDatasource(this._firestore);

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> _col(String userId) =>
      _firestore.collection('users').doc(userId).collection('mixes');

  Future<List<UserMix>> getUserMixes(String userId) async {
    final snap = await _col(userId).orderBy('updatedAt', descending: true).get();
    return snap.docs.map((doc) => UserMixDto.fromFirestore(doc.id, doc.data()).toDomain()).toList();
  }

  Future<UserMix> createMix(UserMix mix) async {
    final docRef = _col(mix.userId).doc();
    final now = DateTime.now();
    final withId = mix.copyWith(id: docRef.id, createdAt: now, updatedAt: now);
    final dto = UserMixDto.fromDomain(withId);
    await docRef.set(dto.toFirestore());
    return withId;
  }

  Future<UserMix> updateMix(UserMix mix) async {
    final updated = mix.copyWith(updatedAt: DateTime.now());
    final dto = UserMixDto.fromDomain(updated);
    await _col(mix.userId).doc(mix.id).update(dto.toFirestore());
    return updated;
  }

  Future<void> deleteMix(String mixId, String userId) async {
    await _col(userId).doc(mixId).delete();
  }
}

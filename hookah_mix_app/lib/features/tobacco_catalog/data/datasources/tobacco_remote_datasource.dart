import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hookah_mix_master/features/tobacco_catalog/data/dtos/brand_dto.dart';
import 'package:hookah_mix_master/features/tobacco_catalog/data/dtos/tobacco_dto.dart';

class TobaccoRemoteDataSource {
  TobaccoRemoteDataSource(this._firestore);

  final FirebaseFirestore _firestore;

  Future<List<TobaccoDto>> getTobaccos() async {
    final snapshot = await _firestore.collection('tobaccos').get();
    return snapshot.docs.map((doc) => TobaccoDto.fromFirestore(doc.id, doc.data())).toList();
  }

  Future<TobaccoDto?> getTobaccoById(String id) async {
    final doc = await _firestore.collection('tobaccos').doc(id).get();
    if (!doc.exists || doc.data() == null) return null;
    return TobaccoDto.fromFirestore(doc.id, doc.data()!);
  }

  Future<List<BrandDto>> getBrands() async {
    final snapshot = await _firestore.collection('brands').get();
    return snapshot.docs.map((doc) => BrandDto.fromFirestore(doc.id, doc.data())).toList();
  }

  Future<String?> getCatalogVersion() async {
    final doc = await _firestore.collection('metadata').doc('catalog').get();
    return doc.data()?['version'] as String?;
  }
}

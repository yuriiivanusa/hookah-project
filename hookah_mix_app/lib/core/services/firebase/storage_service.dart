import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hookah_mix_master/core/errors/network_exception.dart';

class StorageService {
  StorageService(this._storage);

  final FirebaseStorage _storage;

  Future<String> uploadFile(String path, File file) async {
    try {
      final ref = _storage.ref(path);
      await ref.putFile(file);
      return await ref.getDownloadURL();
    } on FirebaseException catch (e) {
      throw NetworkException.unknown(e.message);
    }
  }

  Future<void> deleteFile(String path) async {
    try {
      await _storage.ref(path).delete();
    } on FirebaseException catch (e) {
      throw NetworkException.unknown(e.message);
    }
  }

  Future<String> getDownloadUrl(String path) async {
    try {
      return await _storage.ref(path).getDownloadURL();
    } on FirebaseException catch (e) {
      throw NetworkException.unknown(e.message);
    }
  }
}

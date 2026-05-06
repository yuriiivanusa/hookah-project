import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hookah_mix_master/core/services/analytics/analytics_service.dart';
import 'package:hookah_mix_master/core/services/firebase/auth_service.dart';
import 'package:hookah_mix_master/core/services/firebase/firestore_service.dart';
import 'package:hookah_mix_master/core/services/firebase/storage_service.dart';
import 'package:hookah_mix_master/core/services/local/hive_service.dart';
import 'package:hookah_mix_master/core/services/local/secure_storage_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'providers.g.dart';

@Riverpod(keepAlive: true)
FirebaseAuth firebaseAuth(Ref ref) => FirebaseAuth.instance;

@Riverpod(keepAlive: true)
FirebaseFirestore firebaseFirestore(Ref ref) => FirebaseFirestore.instance;

@Riverpod(keepAlive: true)
FirebaseStorage firebaseStorage(Ref ref) => FirebaseStorage.instance;

@Riverpod(keepAlive: true)
FirebaseAnalytics firebaseAnalytics(Ref ref) => FirebaseAnalytics.instance;

@Riverpod(keepAlive: true)
AuthService authService(Ref ref) =>
    AuthService(ref.watch(firebaseAuthProvider));

@Riverpod(keepAlive: true)
FirestoreService firestoreService(Ref ref) =>
    FirestoreService(ref.watch(firebaseFirestoreProvider));

@Riverpod(keepAlive: true)
StorageService storageService(Ref ref) =>
    StorageService(ref.watch(firebaseStorageProvider));

@Riverpod(keepAlive: true)
AnalyticsService analyticsService(Ref ref) =>
    AnalyticsService(ref.watch(firebaseAnalyticsProvider));

@Riverpod(keepAlive: true)
HiveService hiveService(Ref ref) => HiveService();

@Riverpod(keepAlive: true)
SecureStorageService secureStorage(Ref ref) =>
    SecureStorageService(const FlutterSecureStorage());

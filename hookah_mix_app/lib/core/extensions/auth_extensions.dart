import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hookah_mix_master/features/auth/domain/entities/app_user.dart';
import 'package:hookah_mix_master/features/auth/presentation/providers/auth_provider.dart';
import 'package:hookah_mix_master/features/auth/presentation/providers/auth_state.dart';

extension AuthContextExtensions on BuildContext {
  AppUser? get currentUser {
    final state = ProviderScope.containerOf(this).read(authProvider);
    return switch (state) {
      AuthStateAuthenticated(:final user) => user,
      _ => null,
    };
  }

  bool get isAuthenticated =>
      ProviderScope.containerOf(this).read(authProvider)
          is AuthStateAuthenticated;
}

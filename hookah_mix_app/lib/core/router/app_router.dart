import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hookah_mix_master/core/extensions/context_extensions.dart';
import 'package:hookah_mix_master/core/router/auth_guard.dart';
import 'package:hookah_mix_master/core/router/routes.dart';
import 'package:hookah_mix_master/core/services/providers.dart';
import 'package:hookah_mix_master/features/auth/presentation/providers/auth_provider.dart';
import 'package:hookah_mix_master/features/auth/presentation/screens/age_gate_screen.dart';
import 'package:hookah_mix_master/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:hookah_mix_master/features/auth/presentation/screens/login_screen.dart';
import 'package:hookah_mix_master/features/auth/presentation/screens/signup_screen.dart';
import 'package:hookah_mix_master/features/auth/presentation/screens/splash_screen.dart';
import 'package:hookah_mix_master/features/favorites/presentation/screens/favorites_screen.dart';
import 'package:hookah_mix_master/features/mix_builder/presentation/screens/mix_builder_screen.dart';
import 'package:hookah_mix_master/features/mix_history/presentation/screens/mix_history_screen.dart';
import 'package:hookah_mix_master/features/profile/presentation/screens/profile_screen.dart';
import 'package:hookah_mix_master/features/smart_recommender/presentation/screens/recommender_screen.dart';
import 'package:hookah_mix_master/features/tobacco_catalog/presentation/screens/catalog_screen.dart';
import 'package:hookah_mix_master/features/tobacco_catalog/presentation/screens/tobacco_detail_screen.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) {
  final router = GoRouter(
    initialLocation: Routes.splash,
    redirect: (context, state) => authGuard(
      isLoggedIn: ref.read(firebaseAuthProvider).currentUser != null,
      matchedLocation: state.matchedLocation,
    ),
    routes: [
      GoRoute(
        path: Routes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: Routes.ageGate,
        builder: (context, state) => const AgeGateScreen(),
      ),
      GoRoute(
        path: Routes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: Routes.signup,
        builder: (context, state) => const SignupScreen(),
      ),
      GoRoute(
        path: Routes.forgotPassword,
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      ShellRoute(
        builder: (context, state, child) => _AppShell(child: child),
        routes: [
          GoRoute(
            path: Routes.catalog,
            builder: (context, state) => const CatalogScreen(),
            routes: [
              GoRoute(
                path: ':id',
                builder: (context, state) =>
                    TobaccoDetailScreen(tobaccoId: state.pathParameters['id']!),
              ),
            ],
          ),
          GoRoute(
            path: Routes.recommender,
            builder: (context, state) => const RecommenderScreen(),
          ),
          GoRoute(
            path: Routes.builder,
            builder: (context, state) => const MixBuilderScreen(),
          ),
          GoRoute(
            path: Routes.favorites,
            builder: (context, state) => const FavoritesScreen(),
          ),
          GoRoute(
            path: Routes.profile,
            builder: (context, state) => const ProfileScreen(),
            routes: [
              GoRoute(
                path: 'history',
                builder: (context, state) => const MixHistoryScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );

  ref.listen(authProvider, (_, _) => router.refresh());

  return router;
}

class _AppShell extends ConsumerWidget {
  const _AppShell({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final location = GoRouterState.of(context).matchedLocation;
    final currentIndex = _indexForLocation(location);

    final l10n = context.l10n;
    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (i) => _onTap(context, i),
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.local_fire_department_outlined),
            selectedIcon: const Icon(Icons.local_fire_department),
            label: l10n.navCatalog,
          ),
          NavigationDestination(
            icon: const Icon(Icons.auto_awesome_outlined),
            selectedIcon: const Icon(Icons.auto_awesome),
            label: l10n.navRecommender,
          ),
          NavigationDestination(
            icon: const Icon(Icons.science_outlined),
            selectedIcon: const Icon(Icons.science),
            label: l10n.navBuilder,
          ),
          NavigationDestination(
            icon: const Icon(Icons.favorite_outline),
            selectedIcon: const Icon(Icons.favorite),
            label: l10n.navFavorites,
          ),
          NavigationDestination(
            icon: const Icon(Icons.person_outline),
            selectedIcon: const Icon(Icons.person),
            label: l10n.navProfile,
          ),
        ],
      ),
    );
  }

  int _indexForLocation(String location) => switch (location) {
    Routes.catalog => 0,
    Routes.recommender => 1,
    Routes.builder => 2,
    Routes.favorites => 3,
    Routes.profile => 4,
    _ => 0,
  };

  void _onTap(BuildContext context, int index) {
    final path = [
      Routes.catalog,
      Routes.recommender,
      Routes.builder,
      Routes.favorites,
      Routes.profile,
    ][index];
    context.go(path);
  }
}

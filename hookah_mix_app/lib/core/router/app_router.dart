import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hookah_mix_master/core/router/auth_guard.dart';
import 'package:hookah_mix_master/core/router/routes.dart';
import 'package:hookah_mix_master/core/services/providers.dart';
import 'package:hookah_mix_master/features/auth/presentation/providers/auth_provider.dart';
import 'package:hookah_mix_master/features/auth/presentation/screens/age_gate_screen.dart';
import 'package:hookah_mix_master/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:hookah_mix_master/features/auth/presentation/screens/login_screen.dart';
import 'package:hookah_mix_master/features/auth/presentation/screens/signup_screen.dart';
import 'package:hookah_mix_master/features/auth/presentation/screens/splash_screen.dart';
import 'package:hookah_mix_master/features/mix_builder/presentation/screens/mix_builder_screen.dart';
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
      GoRoute(path: Routes.splash, builder: (context, state) => const SplashScreen()),
      GoRoute(path: Routes.ageGate, builder: (context, state) => const AgeGateScreen()),
      GoRoute(path: Routes.login, builder: (context, state) => const LoginScreen()),
      GoRoute(path: Routes.signup, builder: (context, state) => const SignupScreen()),
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
          GoRoute(path: Routes.recommender, builder: (context, state) => const RecommenderScreen()),
          GoRoute(path: Routes.builder, builder: (context, state) => const MixBuilderScreen()),
          GoRoute(
            path: Routes.favorites,
            builder: (context, state) => const _PlaceholderScreen(label: 'Favorites'),
          ),
          GoRoute(
            path: Routes.profile,
            builder: (context, state) => const _PlaceholderScreen(label: 'Profile'),
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

    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (i) => _onTap(context, i),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.local_fire_department_outlined),
            label: 'Catalog',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.auto_awesome_outlined), label: 'Recommender'),
          BottomNavigationBarItem(icon: Icon(Icons.science_outlined), label: 'Builder'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_outline), label: 'Favorites'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
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

class _PlaceholderScreen extends StatelessWidget {
  const _PlaceholderScreen({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(label)),
    body: Center(child: Text(label, style: Theme.of(context).textTheme.headlineMedium)),
  );
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hookah_mix_master/core/router/auth_guard.dart';
import 'package:hookah_mix_master/core/router/routes.dart';
import 'package:hookah_mix_master/core/services/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) => GoRouter(
  initialLocation: Routes.catalog,
  redirect: (context, state) => authGuard(
    isLoggedIn: ref.read(firebaseAuthProvider).currentUser != null,
    matchedLocation: state.matchedLocation,
  ),
  routes: [
    GoRoute(
      path: Routes.login,
      builder: (_, _) => const _PlaceholderScreen(label: 'Login'),
    ),
    GoRoute(
      path: Routes.signup,
      builder: (_, _) => const _PlaceholderScreen(label: 'Sign Up'),
    ),
    GoRoute(
      path: Routes.forgotPassword,
      builder: (_, _) => const _PlaceholderScreen(label: 'Forgot Password'),
    ),
    GoRoute(
      path: Routes.ageGate,
      builder: (_, _) => const _PlaceholderScreen(label: 'Age Gate'),
    ),
    ShellRoute(
      builder: (context, state, child) => _AppShell(child: child),
      routes: [
        GoRoute(
          path: Routes.catalog,
          builder: (_, _) => const _PlaceholderScreen(label: 'Catalog'),
        ),
        GoRoute(
          path: Routes.recommender,
          builder: (_, _) => const _PlaceholderScreen(label: 'Recommender'),
        ),
        GoRoute(
          path: Routes.builder,
          builder: (_, _) => const _PlaceholderScreen(label: 'Mix Builder'),
        ),
        GoRoute(
          path: Routes.favorites,
          builder: (_, _) => const _PlaceholderScreen(label: 'Favorites'),
        ),
        GoRoute(
          path: Routes.profile,
          builder: (_, _) => const _PlaceholderScreen(label: 'Profile'),
        ),
      ],
    ),
  ],
);

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
          BottomNavigationBarItem(
            icon: Icon(Icons.auto_awesome_outlined),
            label: 'Recommender',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.science_outlined),
            label: 'Builder',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
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

class _PlaceholderScreen extends StatelessWidget {
  const _PlaceholderScreen({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(label)),
    body: Center(
      child: Text(label, style: Theme.of(context).textTheme.headlineMedium),
    ),
  );
}

sealed class Routes {
  static const String splash = '/';
  static const String ageGate = '/age-gate';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String forgotPassword = '/forgot-password';

  // Shell routes (bottom nav)
  static const String catalog = '/catalog';
  static const String tobaccoDetail = '/catalog/:id';
  static const String recommender = '/recommender';
  static const String builder = '/builder';
  static const String favorites = '/favorites';
  static const String profile = '/profile';

  // Sub-routes
  static const String editMix = '/builder/edit/:mixId';
  static const String mixHistory = '/profile/history';
}

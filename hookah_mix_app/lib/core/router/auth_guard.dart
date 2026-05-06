import 'package:hookah_mix_master/core/router/routes.dart';

String? authGuard({required bool isLoggedIn, required String matchedLocation}) {
  const publicRoutes = {Routes.login, Routes.signup, Routes.forgotPassword, Routes.ageGate};
  final isPublic = publicRoutes.contains(matchedLocation);

  if (!isLoggedIn && !isPublic) return Routes.login;
  if (isLoggedIn && isPublic) return Routes.catalog;
  return null;
}

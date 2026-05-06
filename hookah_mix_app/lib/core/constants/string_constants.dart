sealed class StringConstants {
  // Timeouts
  static const Duration networkTimeout = Duration(seconds: 15);
  static const Duration firestoreTimeout = Duration(seconds: 10);
  static const Duration cacheMaxAge = Duration(hours: 24);

  // Pagination
  static const int catalogPageSize = 20;
  static const int mixHistoryPageSize = 15;

  // Validation limits
  static const int passwordMinLength = 8;
  static const int mixNameMaxLength = 50;
  static const int mixNotesMaxLength = 300;
  static const int maxMixComponents = 5;

  // Hive box names
  static const String tobaccoBoxName = 'tobacco_cache';
  static const String mixesBoxName = 'mixes_cache';
  static const String userPrefsBoxName = 'user_prefs';
  static const String userMixesBoxName = 'user_mixes';

  // Secure storage keys
  static const String authTokenKey = 'auth_token';
}

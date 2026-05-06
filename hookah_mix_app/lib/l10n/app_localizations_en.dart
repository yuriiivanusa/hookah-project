// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Hookah Mix Master';

  @override
  String get generalRetry => 'Retry';

  @override
  String get generalCancel => 'Cancel';

  @override
  String get generalSave => 'Save';

  @override
  String get generalDelete => 'Delete';

  @override
  String get generalConfirm => 'Confirm';

  @override
  String get generalSearch => 'Search';

  @override
  String get generalLoading => 'Loading…';

  @override
  String get generalError => 'Something went wrong';

  @override
  String get generalNoResults => 'No results found';

  @override
  String get generalAdd => 'Add';

  @override
  String get generalEdit => 'Edit';

  @override
  String get generalClose => 'Close';

  @override
  String get generalBack => 'Back';

  @override
  String get authAgeGateTitle => 'Confirm your age';

  @override
  String get authAgeGateBody => 'You must be 18 or older to use this app';

  @override
  String get authAgeGateConfirm => 'I am 18 or older';

  @override
  String get authAgeGateDeny => 'I am under 18';

  @override
  String get authLoginTitle => 'Sign in';

  @override
  String get authLoginEmail => 'Email';

  @override
  String get authLoginPassword => 'Password';

  @override
  String get authLoginButton => 'Sign in';

  @override
  String get authLoginForgotPassword => 'Forgot password?';

  @override
  String get authLoginNoAccount => 'Don\'t have an account?';

  @override
  String get authLoginSignUpLink => 'Sign up';

  @override
  String get authSignupTitle => 'Create account';

  @override
  String get authSignupName => 'Your name';

  @override
  String get authSignupEmail => 'Email';

  @override
  String get authSignupPassword => 'Password';

  @override
  String get authSignupButton => 'Create account';

  @override
  String get authSignupHaveAccount => 'Already have an account?';

  @override
  String get authSignupLoginLink => 'Sign in';

  @override
  String get authForgotPasswordTitle => 'Reset password';

  @override
  String get authForgotPasswordHint =>
      'Enter your email to receive a reset link';

  @override
  String get authForgotPasswordButton => 'Send reset link';

  @override
  String get authForgotPasswordSuccess =>
      'Check your email for reset instructions';

  @override
  String get authErrorInvalidEmail => 'Invalid email address';

  @override
  String get authErrorWeakPassword => 'Password must be at least 8 characters';

  @override
  String get authErrorEmailInUse => 'This email is already registered';

  @override
  String get authErrorUserNotFound => 'No account found with this email';

  @override
  String get authErrorWrongPassword => 'Incorrect password';

  @override
  String get authErrorTooManyRequests => 'Too many attempts. Try again later';

  @override
  String get catalogTitle => 'Tobacco Catalog';

  @override
  String get catalogSearchHint => 'Search tobacco…';

  @override
  String get catalogFilterBrand => 'Brand';

  @override
  String get catalogFilterStrength => 'Strength';

  @override
  String get catalogFilterFlavor => 'Flavor';

  @override
  String get catalogFilterReset => 'Reset filters';

  @override
  String get catalogSortBy => 'Sort by';

  @override
  String get catalogSortNameAsc => 'Name A–Z';

  @override
  String get catalogSortNameDesc => 'Name Z–A';

  @override
  String get catalogSortStrengthAsc => 'Strength: low to high';

  @override
  String get catalogSortStrengthDesc => 'Strength: high to low';

  @override
  String get catalogStrengthLight => 'Light';

  @override
  String get catalogStrengthMedium => 'Medium';

  @override
  String get catalogStrengthStrong => 'Strong';

  @override
  String get catalogEmptyState => 'No tobaccos found';

  @override
  String get catalogEmptyStateFiltered => 'No tobaccos match your filters';

  @override
  String get catalogTobaccoDetailTitle => 'Tobacco details';

  @override
  String get catalogAddToFavorites => 'Add to favorites';

  @override
  String get catalogRemoveFromFavorites => 'Remove from favorites';

  @override
  String get catalogAddToMix => 'Add to mix';

  @override
  String get catalogFlavorNotes => 'Flavor notes';

  @override
  String get catalogNicotineContent => 'Nicotine';

  @override
  String get catalogBrandLabel => 'Brand';

  @override
  String get recommenderTitle => 'Mix Recommender';

  @override
  String get recommenderSubtitle => 'Find your perfect mix';

  @override
  String get recommenderStepFlavor => 'What flavor do you prefer?';

  @override
  String get recommenderStepStrength => 'How strong?';

  @override
  String get recommenderStepMood => 'What\'s the vibe?';

  @override
  String get recommenderFlavorSweet => 'Sweet';

  @override
  String get recommenderFlavorFruity => 'Fruity';

  @override
  String get recommenderFlavorFresh => 'Fresh';

  @override
  String get recommenderFlavorSpicy => 'Spicy';

  @override
  String get recommenderFlavorEarthy => 'Earthy';

  @override
  String get recommenderStrengthLight => 'Light';

  @override
  String get recommenderStrengthMedium => 'Medium';

  @override
  String get recommenderStrengthStrong => 'Strong';

  @override
  String get recommenderMoodRelax => 'Relax';

  @override
  String get recommenderMoodParty => 'Party';

  @override
  String get recommenderMoodFocus => 'Focus';

  @override
  String get recommenderResultTitle => 'Your mix';

  @override
  String get recommenderResultEmpty => 'No matching mixes found';

  @override
  String get recommenderTryAgain => 'Try different preferences';

  @override
  String get recommenderSaveMix => 'Save this mix';

  @override
  String get builderTitle => 'Mix Builder';

  @override
  String get builderAddTobacco => 'Add tobacco';

  @override
  String get builderPercentageLabel => 'Percentage';

  @override
  String get builderTotalPercentage => 'Total';

  @override
  String get builderSave => 'Save mix';

  @override
  String get builderMixName => 'Mix name';

  @override
  String get builderMixNotes => 'Notes (optional)';

  @override
  String get builderEmptyState => 'Add tobacco to start building your mix';

  @override
  String get builderErrorExceeds100 => 'Total percentage cannot exceed 100%';

  @override
  String get builderErrorMaxComponents => 'Maximum 5 components per mix';

  @override
  String get builderErrorEmptyMix => 'Add at least one tobacco';

  @override
  String get builderSavedSuccess => 'Mix saved';

  @override
  String get builderDeleteComponent => 'Remove';

  @override
  String get builderEditComponent => 'Edit';

  @override
  String get favoritesTitle => 'Favorites';

  @override
  String get favoritesEmptyTobaccos => 'No favorite tobaccos yet';

  @override
  String get favoritesEmptyMixes => 'No favorite mixes yet';

  @override
  String get favoritesTabTobaccos => 'Tobaccos';

  @override
  String get favoritesTabMixes => 'Mixes';

  @override
  String get favoritesRemoveConfirm => 'Remove from favorites?';

  @override
  String get historyTitle => 'Mix History';

  @override
  String get historyEmpty => 'You haven\'t created any mixes yet';

  @override
  String get historyDeleteConfirm => 'Delete this mix from history?';

  @override
  String get historyReuseButton => 'Recreate mix';

  @override
  String get profileTitle => 'Profile';

  @override
  String get profileEditName => 'Edit name';

  @override
  String get profileSettingsSection => 'Settings';

  @override
  String get profileSettingsLanguage => 'Language';

  @override
  String get profileSettingsTheme => 'Theme';

  @override
  String get profileSettingsThemeDark => 'Dark';

  @override
  String get profileSettingsThemeLight => 'Light';

  @override
  String get profileSettingsThemeSystem => 'System';

  @override
  String get profileSignOut => 'Sign out';

  @override
  String get profileSignOutConfirm => 'Are you sure you want to sign out?';

  @override
  String get profileLanguageEn => 'English';

  @override
  String get profileLanguageUk => 'Ukrainian';

  @override
  String get errorNetworkTitle => 'Connection error';

  @override
  String get errorNetworkBody => 'Check your internet connection and try again';

  @override
  String get errorPermissionDenied => 'Permission denied';

  @override
  String get errorUnknown => 'An unexpected error occurred';
}

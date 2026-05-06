import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_uk.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('uk'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Hookah Mix Master'**
  String get appName;

  /// No description provided for @generalRetry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get generalRetry;

  /// No description provided for @generalCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get generalCancel;

  /// No description provided for @generalSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get generalSave;

  /// No description provided for @generalDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get generalDelete;

  /// No description provided for @generalConfirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get generalConfirm;

  /// No description provided for @generalSearch.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get generalSearch;

  /// No description provided for @generalLoading.
  ///
  /// In en, this message translates to:
  /// **'Loading…'**
  String get generalLoading;

  /// No description provided for @generalError.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get generalError;

  /// No description provided for @generalNoResults.
  ///
  /// In en, this message translates to:
  /// **'No results found'**
  String get generalNoResults;

  /// No description provided for @generalAdd.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get generalAdd;

  /// No description provided for @generalEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get generalEdit;

  /// No description provided for @generalClose.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get generalClose;

  /// No description provided for @generalBack.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get generalBack;

  /// No description provided for @authAgeGateTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm your age'**
  String get authAgeGateTitle;

  /// No description provided for @authAgeGateBody.
  ///
  /// In en, this message translates to:
  /// **'You must be 18 or older to use this app'**
  String get authAgeGateBody;

  /// No description provided for @authAgeGateConfirm.
  ///
  /// In en, this message translates to:
  /// **'I am 18 or older'**
  String get authAgeGateConfirm;

  /// No description provided for @authAgeGateDeny.
  ///
  /// In en, this message translates to:
  /// **'I am under 18'**
  String get authAgeGateDeny;

  /// No description provided for @authLoginTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get authLoginTitle;

  /// No description provided for @authLoginEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get authLoginEmail;

  /// No description provided for @authLoginPassword.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get authLoginPassword;

  /// No description provided for @authLoginButton.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get authLoginButton;

  /// No description provided for @authLoginForgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get authLoginForgotPassword;

  /// No description provided for @authLoginNoAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get authLoginNoAccount;

  /// No description provided for @authLoginSignUpLink.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get authLoginSignUpLink;

  /// No description provided for @authSignupTitle.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get authSignupTitle;

  /// No description provided for @authSignupName.
  ///
  /// In en, this message translates to:
  /// **'Your name'**
  String get authSignupName;

  /// No description provided for @authSignupEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get authSignupEmail;

  /// No description provided for @authSignupPassword.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get authSignupPassword;

  /// No description provided for @authSignupButton.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get authSignupButton;

  /// No description provided for @authSignupHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get authSignupHaveAccount;

  /// No description provided for @authSignupLoginLink.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get authSignupLoginLink;

  /// No description provided for @authForgotPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Reset password'**
  String get authForgotPasswordTitle;

  /// No description provided for @authForgotPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your email to receive a reset link'**
  String get authForgotPasswordHint;

  /// No description provided for @authForgotPasswordButton.
  ///
  /// In en, this message translates to:
  /// **'Send reset link'**
  String get authForgotPasswordButton;

  /// No description provided for @authForgotPasswordSuccess.
  ///
  /// In en, this message translates to:
  /// **'Check your email for reset instructions'**
  String get authForgotPasswordSuccess;

  /// No description provided for @authErrorInvalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Invalid email address'**
  String get authErrorInvalidEmail;

  /// No description provided for @authErrorWeakPassword.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters'**
  String get authErrorWeakPassword;

  /// No description provided for @authErrorEmailInUse.
  ///
  /// In en, this message translates to:
  /// **'This email is already registered'**
  String get authErrorEmailInUse;

  /// No description provided for @authErrorUserNotFound.
  ///
  /// In en, this message translates to:
  /// **'No account found with this email'**
  String get authErrorUserNotFound;

  /// No description provided for @authErrorWrongPassword.
  ///
  /// In en, this message translates to:
  /// **'Incorrect password'**
  String get authErrorWrongPassword;

  /// No description provided for @authErrorTooManyRequests.
  ///
  /// In en, this message translates to:
  /// **'Too many attempts. Try again later'**
  String get authErrorTooManyRequests;

  /// No description provided for @authGuestModeTitle.
  ///
  /// In en, this message translates to:
  /// **'Guest Mode'**
  String get authGuestModeTitle;

  /// No description provided for @authGuestModeBody.
  ///
  /// In en, this message translates to:
  /// **'Sign in to save favorites and create custom mixes.'**
  String get authGuestModeBody;

  /// No description provided for @authGuestSignIn.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get authGuestSignIn;

  /// No description provided for @catalogTitle.
  ///
  /// In en, this message translates to:
  /// **'Tobacco Catalog'**
  String get catalogTitle;

  /// No description provided for @catalogSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search tobacco…'**
  String get catalogSearchHint;

  /// No description provided for @catalogFilterBrand.
  ///
  /// In en, this message translates to:
  /// **'Brand'**
  String get catalogFilterBrand;

  /// No description provided for @catalogFilterStrength.
  ///
  /// In en, this message translates to:
  /// **'Strength'**
  String get catalogFilterStrength;

  /// No description provided for @catalogFilterFlavor.
  ///
  /// In en, this message translates to:
  /// **'Flavor'**
  String get catalogFilterFlavor;

  /// No description provided for @catalogFilterReset.
  ///
  /// In en, this message translates to:
  /// **'Reset filters'**
  String get catalogFilterReset;

  /// No description provided for @catalogSortBy.
  ///
  /// In en, this message translates to:
  /// **'Sort by'**
  String get catalogSortBy;

  /// No description provided for @catalogSortNameAsc.
  ///
  /// In en, this message translates to:
  /// **'Name A–Z'**
  String get catalogSortNameAsc;

  /// No description provided for @catalogSortNameDesc.
  ///
  /// In en, this message translates to:
  /// **'Name Z–A'**
  String get catalogSortNameDesc;

  /// No description provided for @catalogSortStrengthAsc.
  ///
  /// In en, this message translates to:
  /// **'Strength: low to high'**
  String get catalogSortStrengthAsc;

  /// No description provided for @catalogSortStrengthDesc.
  ///
  /// In en, this message translates to:
  /// **'Strength: high to low'**
  String get catalogSortStrengthDesc;

  /// No description provided for @catalogSortPopularityDesc.
  ///
  /// In en, this message translates to:
  /// **'Most popular'**
  String get catalogSortPopularityDesc;

  /// No description provided for @catalogFilterLeafType.
  ///
  /// In en, this message translates to:
  /// **'Leaf type'**
  String get catalogFilterLeafType;

  /// No description provided for @catalogStrengthLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get catalogStrengthLight;

  /// No description provided for @catalogStrengthMedium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get catalogStrengthMedium;

  /// No description provided for @catalogStrengthStrong.
  ///
  /// In en, this message translates to:
  /// **'Strong'**
  String get catalogStrengthStrong;

  /// No description provided for @catalogEmptyState.
  ///
  /// In en, this message translates to:
  /// **'No tobaccos found'**
  String get catalogEmptyState;

  /// No description provided for @catalogEmptyStateFiltered.
  ///
  /// In en, this message translates to:
  /// **'No tobaccos match your filters'**
  String get catalogEmptyStateFiltered;

  /// No description provided for @catalogTobaccoDetailTitle.
  ///
  /// In en, this message translates to:
  /// **'Tobacco details'**
  String get catalogTobaccoDetailTitle;

  /// No description provided for @catalogAddToFavorites.
  ///
  /// In en, this message translates to:
  /// **'Add to favorites'**
  String get catalogAddToFavorites;

  /// No description provided for @catalogRemoveFromFavorites.
  ///
  /// In en, this message translates to:
  /// **'Remove from favorites'**
  String get catalogRemoveFromFavorites;

  /// No description provided for @catalogAddToMix.
  ///
  /// In en, this message translates to:
  /// **'Add to mix'**
  String get catalogAddToMix;

  /// No description provided for @catalogFlavorNotes.
  ///
  /// In en, this message translates to:
  /// **'Flavor notes'**
  String get catalogFlavorNotes;

  /// No description provided for @catalogNicotineContent.
  ///
  /// In en, this message translates to:
  /// **'Nicotine'**
  String get catalogNicotineContent;

  /// No description provided for @catalogBrandLabel.
  ///
  /// In en, this message translates to:
  /// **'Brand'**
  String get catalogBrandLabel;

  /// No description provided for @recommenderTitle.
  ///
  /// In en, this message translates to:
  /// **'Mix Recommender'**
  String get recommenderTitle;

  /// No description provided for @recommenderSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Find your perfect mix'**
  String get recommenderSubtitle;

  /// No description provided for @recommenderStepFlavor.
  ///
  /// In en, this message translates to:
  /// **'What flavor do you prefer?'**
  String get recommenderStepFlavor;

  /// No description provided for @recommenderStepStrength.
  ///
  /// In en, this message translates to:
  /// **'How strong?'**
  String get recommenderStepStrength;

  /// No description provided for @recommenderStepMood.
  ///
  /// In en, this message translates to:
  /// **'What\'s the vibe?'**
  String get recommenderStepMood;

  /// No description provided for @recommenderFlavorSweet.
  ///
  /// In en, this message translates to:
  /// **'Sweet'**
  String get recommenderFlavorSweet;

  /// No description provided for @recommenderFlavorFruity.
  ///
  /// In en, this message translates to:
  /// **'Fruity'**
  String get recommenderFlavorFruity;

  /// No description provided for @recommenderFlavorFresh.
  ///
  /// In en, this message translates to:
  /// **'Fresh'**
  String get recommenderFlavorFresh;

  /// No description provided for @recommenderFlavorSpicy.
  ///
  /// In en, this message translates to:
  /// **'Spicy'**
  String get recommenderFlavorSpicy;

  /// No description provided for @recommenderFlavorEarthy.
  ///
  /// In en, this message translates to:
  /// **'Earthy'**
  String get recommenderFlavorEarthy;

  /// No description provided for @recommenderStrengthLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get recommenderStrengthLight;

  /// No description provided for @recommenderStrengthMedium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get recommenderStrengthMedium;

  /// No description provided for @recommenderStrengthStrong.
  ///
  /// In en, this message translates to:
  /// **'Strong'**
  String get recommenderStrengthStrong;

  /// No description provided for @recommenderMoodRelax.
  ///
  /// In en, this message translates to:
  /// **'Relax'**
  String get recommenderMoodRelax;

  /// No description provided for @recommenderMoodParty.
  ///
  /// In en, this message translates to:
  /// **'Party'**
  String get recommenderMoodParty;

  /// No description provided for @recommenderMoodFocus.
  ///
  /// In en, this message translates to:
  /// **'Focus'**
  String get recommenderMoodFocus;

  /// No description provided for @recommenderResultTitle.
  ///
  /// In en, this message translates to:
  /// **'Your mix'**
  String get recommenderResultTitle;

  /// No description provided for @recommenderResultEmpty.
  ///
  /// In en, this message translates to:
  /// **'No matching mixes found'**
  String get recommenderResultEmpty;

  /// No description provided for @recommenderTryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try different preferences'**
  String get recommenderTryAgain;

  /// No description provided for @recommenderSaveMix.
  ///
  /// In en, this message translates to:
  /// **'Save this mix'**
  String get recommenderSaveMix;

  /// No description provided for @builderTitle.
  ///
  /// In en, this message translates to:
  /// **'Mix Builder'**
  String get builderTitle;

  /// No description provided for @builderAddTobacco.
  ///
  /// In en, this message translates to:
  /// **'Add tobacco'**
  String get builderAddTobacco;

  /// No description provided for @builderPercentageLabel.
  ///
  /// In en, this message translates to:
  /// **'Percentage'**
  String get builderPercentageLabel;

  /// No description provided for @builderTotalPercentage.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get builderTotalPercentage;

  /// No description provided for @builderSave.
  ///
  /// In en, this message translates to:
  /// **'Save mix'**
  String get builderSave;

  /// No description provided for @builderMixName.
  ///
  /// In en, this message translates to:
  /// **'Mix name'**
  String get builderMixName;

  /// No description provided for @builderMixNotes.
  ///
  /// In en, this message translates to:
  /// **'Notes (optional)'**
  String get builderMixNotes;

  /// No description provided for @builderEmptyState.
  ///
  /// In en, this message translates to:
  /// **'Add tobacco to start building your mix'**
  String get builderEmptyState;

  /// No description provided for @builderErrorExceeds100.
  ///
  /// In en, this message translates to:
  /// **'Total percentage cannot exceed 100%'**
  String get builderErrorExceeds100;

  /// No description provided for @builderErrorMaxComponents.
  ///
  /// In en, this message translates to:
  /// **'Maximum 5 components per mix'**
  String get builderErrorMaxComponents;

  /// No description provided for @builderErrorEmptyMix.
  ///
  /// In en, this message translates to:
  /// **'Add at least one tobacco'**
  String get builderErrorEmptyMix;

  /// No description provided for @builderSavedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Mix saved'**
  String get builderSavedSuccess;

  /// No description provided for @builderDeleteComponent.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get builderDeleteComponent;

  /// No description provided for @builderEditComponent.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get builderEditComponent;

  /// No description provided for @favoritesTitle.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get favoritesTitle;

  /// No description provided for @favoritesEmptyTobaccos.
  ///
  /// In en, this message translates to:
  /// **'No favorite tobaccos yet'**
  String get favoritesEmptyTobaccos;

  /// No description provided for @favoritesEmptyMixes.
  ///
  /// In en, this message translates to:
  /// **'No favorite mixes yet'**
  String get favoritesEmptyMixes;

  /// No description provided for @favoritesTabTobaccos.
  ///
  /// In en, this message translates to:
  /// **'Tobaccos'**
  String get favoritesTabTobaccos;

  /// No description provided for @favoritesTabMixes.
  ///
  /// In en, this message translates to:
  /// **'Mixes'**
  String get favoritesTabMixes;

  /// No description provided for @favoritesRemoveConfirm.
  ///
  /// In en, this message translates to:
  /// **'Remove from favorites?'**
  String get favoritesRemoveConfirm;

  /// No description provided for @historyTitle.
  ///
  /// In en, this message translates to:
  /// **'Mix History'**
  String get historyTitle;

  /// No description provided for @historyEmpty.
  ///
  /// In en, this message translates to:
  /// **'You haven\'t created any mixes yet'**
  String get historyEmpty;

  /// No description provided for @historyDeleteConfirm.
  ///
  /// In en, this message translates to:
  /// **'Delete this mix from history?'**
  String get historyDeleteConfirm;

  /// No description provided for @historyReuseButton.
  ///
  /// In en, this message translates to:
  /// **'Recreate mix'**
  String get historyReuseButton;

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTitle;

  /// No description provided for @profileEditName.
  ///
  /// In en, this message translates to:
  /// **'Edit name'**
  String get profileEditName;

  /// No description provided for @profileSettingsSection.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get profileSettingsSection;

  /// No description provided for @profileSettingsLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get profileSettingsLanguage;

  /// No description provided for @profileSettingsTheme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get profileSettingsTheme;

  /// No description provided for @profileSettingsThemeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get profileSettingsThemeDark;

  /// No description provided for @profileSettingsThemeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get profileSettingsThemeLight;

  /// No description provided for @profileSettingsThemeSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get profileSettingsThemeSystem;

  /// No description provided for @profileSignOut.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get profileSignOut;

  /// No description provided for @profileSignOutConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to sign out?'**
  String get profileSignOutConfirm;

  /// No description provided for @profileLanguageEn.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get profileLanguageEn;

  /// No description provided for @profileLanguageUk.
  ///
  /// In en, this message translates to:
  /// **'Ukrainian'**
  String get profileLanguageUk;

  /// No description provided for @errorNetworkTitle.
  ///
  /// In en, this message translates to:
  /// **'Connection error'**
  String get errorNetworkTitle;

  /// No description provided for @errorNetworkBody.
  ///
  /// In en, this message translates to:
  /// **'Check your internet connection and try again'**
  String get errorNetworkBody;

  /// No description provided for @errorPermissionDenied.
  ///
  /// In en, this message translates to:
  /// **'Permission denied'**
  String get errorPermissionDenied;

  /// No description provided for @errorUnknown.
  ///
  /// In en, this message translates to:
  /// **'An unexpected error occurred'**
  String get errorUnknown;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'uk'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'uk':
      return AppLocalizationsUk();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}

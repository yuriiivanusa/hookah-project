import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsService {
  AnalyticsService(this._analytics);

  final FirebaseAnalytics _analytics;
  bool _enabled = true;

  void setEnabled(bool enabled) {
    _enabled = enabled;
    _analytics.setAnalyticsCollectionEnabled(enabled);
  }

  bool get isEnabled => _enabled;

  Future<void> logEvent(String name, {Map<String, Object>? params}) async {
    if (!_enabled) return;
    await _analytics.logEvent(name: name, parameters: params);
  }

  Future<void> logScreenView(String screenName) async {
    if (!_enabled) return;
    await _analytics.logScreenView(screenName: screenName);
  }

  Future<void> setUserId(String? userId) async {
    if (!_enabled) return;
    await _analytics.setUserId(id: userId);
  }

  Future<void> logLogin() => logEvent('login');
  Future<void> logSignUp() => logEvent('sign_up');
  Future<void> logMixCreated() => logEvent('mix_created');
  Future<void> logMixSaved() => logEvent('mix_saved');
  Future<void> logTobaccoViewed(String tobaccoId) =>
      logEvent('tobacco_viewed', params: {'tobacco_id': tobaccoId});
}

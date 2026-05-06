import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hookah_mix_master/core/services/analytics/analytics_service.dart';
import 'package:mocktail/mocktail.dart';

class _MockAnalytics extends Mock implements FirebaseAnalytics {}

void main() {
  late _MockAnalytics mockAnalytics;
  late AnalyticsService sut;

  setUp(() {
    mockAnalytics = _MockAnalytics();
    sut = AnalyticsService(mockAnalytics);
  });

  group('AnalyticsService opt-out', () {
    test('isEnabled is true by default', () {
      expect(sut.isEnabled, isTrue);
    });

    test('setEnabled(false) disables tracking', () {
      when(() => mockAnalytics.setAnalyticsCollectionEnabled(false))
          .thenAnswer((_) async {});
      sut.setEnabled(false);
      expect(sut.isEnabled, isFalse);
    });

    test('logEvent is skipped when disabled', () async {
      when(() => mockAnalytics.setAnalyticsCollectionEnabled(false))
          .thenAnswer((_) async {});
      sut.setEnabled(false);
      await sut.logEvent('test_event');
      verifyNever(() => mockAnalytics.logEvent(name: any(named: 'name')));
    });
  });
}

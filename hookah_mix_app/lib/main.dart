import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hookah_mix_master/core/providers/locale_provider.dart';
import 'package:hookah_mix_master/core/providers/theme_provider.dart';
import 'package:hookah_mix_master/core/router/app_router.dart';
import 'package:hookah_mix_master/core/services/local/hive_service.dart';
import 'package:hookah_mix_master/core/theme/app_theme.dart';
import 'package:hookah_mix_master/firebase_options.dart';
import 'package:hookah_mix_master/l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await HiveService().init();
  runApp(const ProviderScope(child: App()));
}

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeMode$Provider);
    final locale = ref.watch(appLocaleProvider);
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'Hookah Mix Master',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,
      locale: locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: router,
    );
  }
}

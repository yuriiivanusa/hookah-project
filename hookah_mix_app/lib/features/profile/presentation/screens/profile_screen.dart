import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hookah_mix_master/core/extensions/context_extensions.dart';
import 'package:hookah_mix_master/core/providers/locale_provider.dart';
import 'package:hookah_mix_master/core/providers/theme_provider.dart';
import 'package:hookah_mix_master/core/router/routes.dart';
import 'package:hookah_mix_master/features/auth/presentation/providers/auth_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final user = ref.watch(currentUserProvider);
    final themeMode = ref.watch(themeMode$Provider);
    final locale = ref.watch(appLocaleProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.profileTitle)),
      body: ListView(
        children: [
          if (user != null) ...[
            ListTile(
              leading: const CircleAvatar(child: Icon(Icons.person)),
              title: Text(user.displayName ?? user.email),
              subtitle: user.displayName != null
                  ? Text(
                      user.email,
                      style: Theme.of(context).textTheme.bodySmall,
                    )
                  : null,
            ),
            const Divider(),
          ],
          ListTile(
            leading: const Icon(Icons.history_outlined),
            title: Text(l10n.mixBuilderMyMixes),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push(Routes.mixHistory),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: Text(
              l10n.profileSettingsSection,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.brightness_6_outlined),
            title: Text(l10n.profileSettingsTheme),
            trailing: DropdownButton<ThemeMode>(
              value: themeMode,
              underline: const SizedBox.shrink(),
              items: [
                DropdownMenuItem(
                  value: ThemeMode.system,
                  child: Text(l10n.profileSettingsThemeSystem),
                ),
                DropdownMenuItem(
                  value: ThemeMode.light,
                  child: Text(l10n.profileSettingsThemeLight),
                ),
                DropdownMenuItem(
                  value: ThemeMode.dark,
                  child: Text(l10n.profileSettingsThemeDark),
                ),
              ],
              onChanged: (mode) {
                if (mode == null) return;
                final notifier = ref.read(themeMode$Provider.notifier);
                switch (mode) {
                  case ThemeMode.dark:
                    notifier.setDark();
                  case ThemeMode.light:
                    notifier.setLight();
                  case ThemeMode.system:
                    notifier.setSystem();
                }
              },
            ),
          ),
          ListTile(
            leading: const Icon(Icons.language_outlined),
            title: Text(l10n.profileSettingsLanguage),
            trailing: DropdownButton<Locale>(
              value: locale,
              underline: const SizedBox.shrink(),
              items: [
                DropdownMenuItem(
                  value: const Locale('en'),
                  child: Text(l10n.profileLanguageEn),
                ),
                DropdownMenuItem(
                  value: const Locale('uk'),
                  child: Text(l10n.profileLanguageUk),
                ),
              ],
              onChanged: (loc) {
                if (loc == null) return;
                ref.read(appLocaleProvider.notifier).setLocale(loc);
              },
            ),
          ),
          const Divider(),
          ListTile(
            leading: Icon(
              Icons.logout,
              color: Theme.of(context).colorScheme.error,
            ),
            title: Text(
              l10n.profileSignOut,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
            onTap: () => _confirmSignOut(context, ref),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmSignOut(BuildContext context, WidgetRef ref) async {
    final l10n = context.l10n;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.profileSignOut),
        content: Text(l10n.profileSignOutConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(l10n.mixBuilderCancel),
          ),
          FilledButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text(l10n.profileSignOut),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      await ref.read(authProvider.notifier).logout();
    }
  }
}

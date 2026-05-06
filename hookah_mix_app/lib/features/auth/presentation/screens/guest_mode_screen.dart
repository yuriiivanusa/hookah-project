import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hookah_mix_master/core/extensions/context_extensions.dart';
import 'package:hookah_mix_master/core/router/routes.dart';
import 'package:hookah_mix_master/core/theme/app_colors.dart';
import 'package:hookah_mix_master/core/widgets/app_button.dart';

class GuestModeScreen extends ConsumerWidget {
  const GuestModeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(Icons.person_outline, size: 80, color: AppColors.primary),
              const SizedBox(height: 24),
              Text(
                context.l10n.authGuestModeTitle,
                style: context.textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                context.l10n.authGuestModeBody,
                style: context.textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),
              AppButton(
                label: context.l10n.authGuestSignIn,
                onPressed: () => context.go(Routes.login),
              ),
              const SizedBox(height: 12),
              AppButton(
                label: context.l10n.generalBack,
                onPressed: () => context.pop(),
                variant: AppButtonVariant.outlined,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

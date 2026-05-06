import 'package:flutter/material.dart';
import 'package:hookah_mix_master/core/extensions/context_extensions.dart';
import 'package:hookah_mix_master/core/utils/validators.dart';
import 'package:hookah_mix_master/core/widgets/app_text_field.dart';

class EmailFormField extends StatelessWidget {
  const EmailFormField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) => AppTextField(
    label: context.l10n.authLoginEmail,
    controller: controller,
    keyboardType: TextInputType.emailAddress,
    prefixIcon: Icons.email_outlined,
    validator: Validators.email,
  );
}

class PasswordFormField extends StatelessWidget {
  const PasswordFormField({super.key, required this.controller, this.label});

  final TextEditingController controller;
  final String? label;

  @override
  Widget build(BuildContext context) => AppTextField(
    label: label ?? context.l10n.authLoginPassword,
    controller: controller,
    isPassword: true,
    prefixIcon: Icons.lock_outline,
    validator: Validators.password,
  );
}

class NameFormField extends StatelessWidget {
  const NameFormField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) => AppTextField(
    label: context.l10n.authSignupName,
    controller: controller,
    prefixIcon: Icons.person_outline,
    validator: (v) => Validators.required(v, fieldName: 'Name'),
  );
}

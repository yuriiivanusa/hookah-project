import 'package:flutter/material.dart';
import 'package:hookah_mix_master/core/extensions/context_extensions.dart';

class AuthErrorDialog extends StatelessWidget {
  const AuthErrorDialog({super.key, required this.message});

  final String message;

  static Future<void> show(BuildContext context, String message) => showDialog<void>(
    context: context,
    builder: (_) => AuthErrorDialog(message: message),
  );

  @override
  Widget build(BuildContext context) => AlertDialog(
    title: Text(context.l10n.generalError),
    content: Text(message),
    actions: [
      TextButton(
        onPressed: () => Navigator.of(context).pop(),
        child: Text(context.l10n.generalClose),
      ),
    ],
  );
}

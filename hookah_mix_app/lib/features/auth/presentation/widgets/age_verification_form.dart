import 'package:flutter/material.dart';
import 'package:hookah_mix_master/core/extensions/context_extensions.dart';

class AgeVerificationForm extends StatefulWidget {
  const AgeVerificationForm({super.key, required this.onChanged});

  final void Function(DateTime? dateOfBirth, bool ageConfirmed) onChanged;

  @override
  State<AgeVerificationForm> createState() => _AgeVerificationFormState();
}

class _AgeVerificationFormState extends State<AgeVerificationForm> {
  DateTime? _dateOfBirth;
  bool _ageConfirmed = false;

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 365 * 18)),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() => _dateOfBirth = picked);
      widget.onChanged(_dateOfBirth, _ageConfirmed);
    }
  }

  void _onCheckboxChanged(bool? value) {
    setState(() => _ageConfirmed = value ?? false);
    widget.onChanged(_dateOfBirth, _ageConfirmed);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        OutlinedButton.icon(
          onPressed: _pickDate,
          icon: const Icon(Icons.calendar_today_outlined),
          label: Text(
            _dateOfBirth == null
                ? 'Select date of birth'
                : '${_dateOfBirth!.day}/${_dateOfBirth!.month}/${_dateOfBirth!.year}',
          ),
        ),
        const SizedBox(height: 8),
        CheckboxListTile(
          value: _ageConfirmed,
          onChanged: _onCheckboxChanged,
          title: Text(context.l10n.authAgeGateConfirm),
          controlAffinity: ListTileControlAffinity.leading,
          contentPadding: EdgeInsets.zero,
        ),
      ],
    );
  }
}

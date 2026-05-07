class MixComponent {
  const MixComponent({required this.tobaccoId, required this.percentage});

  final String tobaccoId;
  final int percentage;

  String get displayName {
    final parts = tobaccoId.split('__');
    if (parts.length == 2) {
      final brand = parts[0].replaceAll('_', ' ');
      final product = parts[1].replaceAll('_', ' ');
      return '${_capitalize(brand)} – ${_capitalize(product)}';
    }
    return _capitalize(tobaccoId.replaceAll('_', ' '));
  }

  String _capitalize(String s) =>
      s.isEmpty ? s : s[0].toUpperCase() + s.substring(1);
}

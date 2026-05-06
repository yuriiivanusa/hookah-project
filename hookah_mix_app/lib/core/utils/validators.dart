sealed class Validators {
  static String? email(String? value) {
    if (value == null || value.isEmpty) return 'Email is required';
    if (!RegExp(r'^[a-zA-Z0-9._%+\-]+@[a-zA-Z0-9.\-]+\.[a-zA-Z]{2,}$').hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    if (value.length < 8) return 'Password must be at least 8 characters';
    return null;
  }

  static String? mixName(String? value) {
    if (value == null || value.isEmpty) return 'Mix name is required';
    if (value.length > 50) return 'Mix name must be 50 characters or less';
    return null;
  }

  static String? mixPercentage(String? value) {
    if (value == null || value.isEmpty) return 'Percentage is required';
    final number = double.tryParse(value);
    if (number == null) return 'Enter a valid number';
    if (number <= 0 || number > 100) return 'Percentage must be between 1 and 100';
    return null;
  }

  static String? required(String? value, {String? fieldName}) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? 'Field'} is required';
    }
    return null;
  }
}

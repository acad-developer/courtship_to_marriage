class Validators {
  Validators._();

  static String? fullName(String? value) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return 'Please enter your full name';
    if (v.length < 2) return 'Name is too short';
    return null;
  }

  static String? email(String? value) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return 'Please enter your email address';
    final regex = RegExp(r'^[\w\-.+]+@([\w-]+\.)+[\w-]{2,}$');
    if (!regex.hasMatch(v)) return 'Enter a valid email address';
    return null;
  }

  /// [value] is the number without the country code.
  static String? phone(String? value, String dialCode) {
    final digits = (value ?? '').replaceAll(RegExp(r'\D'), '');
    if (digits.isEmpty) return 'Please enter your phone number';

    if (dialCode == '+91') {
      if (!RegExp(r'^[6-9]\d{9}$').hasMatch(digits)) {
        return 'Enter a valid 10-digit Indian mobile number';
      }
      return null;
    }
    if (digits.length < 6 || digits.length > 14) {
      return 'Enter a valid phone number';
    }
    return null;
  }

  static String? requiredField(String? value, String label) {
    if ((value ?? '').trim().isEmpty) return 'Please enter the $label';
    return null;
  }

  static String? supportMessage(String? value) {
    final t = (value ?? '').trim();
    if (t.isEmpty) return 'Please describe your issue';
    if (t.length < 10) return 'Please add a little more detail (10+ characters)';
    if (t.length > 1500) return 'Message is too long (max 1500 characters)';
    return null;
  }
}
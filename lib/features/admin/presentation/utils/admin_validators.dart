import '../../../../core/utils/duration_parser.dart';

class AdminValidators {
  AdminValidators._();

  static String? requiredText(String? value, String label) {
    if ((value ?? '').trim().isEmpty) return 'Please enter the $label';
    return null;
  }

  static String? price(String? value) {
    final t = (value ?? '').trim();
    if (t.isEmpty) return 'Enter a price';
    final n = double.tryParse(t);
    if (n == null || n <= 0) return 'Enter a valid price';
    return null;
  }

  /// Optional positive number (used for the hours override).
  static String? optionalPositive(String? value) {
    final t = (value ?? '').trim();
    if (t.isEmpty) return null;
    final n = double.tryParse(t);
    if (n == null || n <= 0) return 'Enter a valid number';
    return null;
  }

  /// Optional "original price" shown struck through. Must exceed the price.
  static String? originalPrice(String? value, String priceText) {
    final t = (value ?? '').trim();
    if (t.isEmpty) return null;
    final n = double.tryParse(t);
    if (n == null || n <= 0) return 'Enter a valid price';
    final price = double.tryParse(priceText.trim());
    if (price != null && n <= price) return 'Must be higher than the price';
    return null;
  }

  static String? videoUrl(String? value) {
    final t = (value ?? '').trim();
    if (t.isEmpty) return 'Please enter the video URL';
    final uri = Uri.tryParse(t);
    final ok = uri != null &&
        (uri.scheme == 'http' || uri.scheme == 'https') &&
        uri.host.isNotEmpty;
    if (!ok) return 'Enter a valid link starting with https://';
    return null;
  }

  /// Optional: empty is allowed (it is detected on save).
  static String? duration(String? value) {
    final t = (value ?? '').trim();
    if (t.isEmpty) return null;
    final seconds = DurationParser.parse(t);
    if (seconds == null || seconds <= 0) return 'Use mm:ss or h:mm:ss';
    return null;
  }

  static String? languageName(String? value) {
    final t = (value ?? '').trim();
    if (t.isEmpty) return 'Please enter the language name';
    if (t.length < 2) return 'Language name is too short';
    if (t.length > 30) return 'Language name is too long';
    return null;
  }

}
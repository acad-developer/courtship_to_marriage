import 'currency.dart';

class Formatters {
  Formatters._();

  /// USD only (used by the admin screens).
  static String price(double value) => '\$${value.toStringAsFixed(2)}';

  static String inr(double value) =>
      '₹${value.toStringAsFixed(value % 1 == 0 ? 0 : 2)}';

  /// Price in the user's currency. INR uses Indian digit grouping (1,23,456).
  static String money(double value, Currency currency) {
    switch (currency) {
      case Currency.usd:
        return '\$${value.toStringAsFixed(2)}';
      case Currency.inr:
        return '₹${_indianGrouping(value)}';
    }
  }

  static String _indianGrouping(double value) {
    final fixed = value.toStringAsFixed(value % 1 == 0 ? 0 : 2);
    final parts = fixed.split('.');
    var intPart = parts[0];

    if (intPart.length > 3) {
      final last3 = intPart.substring(intPart.length - 3);
      var rest = intPart.substring(0, intPart.length - 3);
      final groups = <String>[];
      while (rest.length > 2) {
        groups.insert(0, rest.substring(rest.length - 2));
        rest = rest.substring(0, rest.length - 2);
      }
      if (rest.isNotEmpty) groups.insert(0, rest);
      intPart = '${groups.join(',')},$last3';
    }
    return parts.length > 1 ? '$intPart.${parts[1]}' : intPart;
  }

  /// 4.5 -> "4.5 Hours", 0.5 -> "30 Min"
  static String hours(double value) {
    if (value <= 0) return '0 Hours';
    if (value < 1) return '${(value * 60).round()} Min';
    return '${value.toStringAsFixed(1)} Hours';
  }

  static String duration(int seconds) {
    final h = seconds ~/ 3600;
    final m = (seconds % 3600) ~/ 60;
    if (h > 0) return m > 0 ? '${h}h ${m}m' : '${h}h';
    return '${m}m';
  }

  /// 765 -> "12:45", 3750 -> "1:02:30"
  static String clock(int seconds) {
    final h = seconds ~/ 3600;
    final m = (seconds % 3600) ~/ 60;
    final s = (seconds % 60).toString().padLeft(2, '0');
    if (h > 0) return '$h:${m.toString().padLeft(2, '0')}:$s';
    return '$m:$s';
  }

  static const _months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
  ];

  /// 18 Oct 2026, 9:55 PM
  static String dateTime(DateTime date) {
    final d = date.toLocal();
    final hour12 = d.hour % 12 == 0 ? 12 : d.hour % 12;
    final minute = d.minute.toString().padLeft(2, '0');
    final period = d.hour >= 12 ? 'PM' : 'AM';
    return '${d.day} ${_months[d.month - 1]} ${d.year}, $hour12:$minute $period';
  }
}
class DurationParser {
  DurationParser._();

  /// "12:45" -> 765, "1:02:30" -> 3750, "12" -> 720 (a single number = minutes).
  static int? parse(String? input) {
    final text = (input ?? '').trim();
    if (text.isEmpty) return null;

    final parts = text.split(':');
    if (parts.length > 3) return null;

    final nums = <int>[];
    for (final p in parts) {
      final n = int.tryParse(p.trim());
      if (n == null || n < 0) return null;
      nums.add(n);
    }

    if (nums.length == 1) return nums[0] * 60;
    if (nums.length == 2) {
      if (nums[1] >= 60) return null;
      return nums[0] * 60 + nums[1];
    }
    if (nums[1] >= 60 || nums[2] >= 60) return null;
    return nums[0] * 3600 + nums[1] * 60 + nums[2];
  }
}
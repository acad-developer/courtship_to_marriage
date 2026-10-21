import '../../../../../core/utils/currency.dart';

class CourseEntity {
  final String id;
  final String title;
  final String? fullTitle;
  final String description;
  final String language;
  final String imageUrl;
  final double priceUsd;
  final double priceInr;
  final double? originalPriceUsd;
  final double? originalPriceInr;
  final int lessonCount;
  final double durationHours;
  final List<String> learnings;
  final List<String> aboutParagraphs;
  final DateTime? createdAt;

  const CourseEntity({
    required this.id,
    required this.title,
    this.fullTitle,
    required this.description,
    required this.language,
    required this.imageUrl,
    required this.priceUsd,
    required this.priceInr,
    this.originalPriceUsd,
    this.originalPriceInr,
    required this.lessonCount,
    required this.durationHours,
    this.learnings = const [],
    this.aboutParagraphs = const [],
    this.createdAt,
  });

  String get displayTitle => fullTitle ?? title;

  double priceIn(Currency c) => c == Currency.inr ? priceInr : priceUsd;

  /// The struck-through price, only when it is higher than the real price.
  double? originalPriceIn(Currency c) {
    final original = c == Currency.inr ? originalPriceInr : originalPriceUsd;
    return (original != null && original > priceIn(c)) ? original : null;
  }
}
enum CourseStatus { draft, published }

class AdminCourse {
  final String id;
  final String title;
  final String description; // short text for cards
  final String about; // long "About this course" text (optional)
  final List<String> learnings;
  final String language; // 'English', 'Hindi' or any custom (ALL CAPS)
  final String imagePath; // Firebase Storage path
  final String imageUrl; // cached download URL
  final double priceUsd;
  final double priceInr;
  final double? originalPriceUsd;
  final double? originalPriceInr;
  final CourseStatus status;
  final int lessonCount; // maintained automatically
  final int totalDurationSeconds; // maintained automatically
  final double? totalHoursOverride; // optional manual value
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const AdminCourse({
    required this.id,
    required this.title,
    required this.description,
    this.about = '',
    this.learnings = const [],
    this.language = 'English',
    this.imagePath = '',
    this.imageUrl = '',
    required this.priceUsd,
    required this.priceInr,
    this.originalPriceUsd,
    this.originalPriceInr,
    this.status = CourseStatus.draft,
    this.lessonCount = 0,
    this.totalDurationSeconds = 0,
    this.totalHoursOverride,
    this.createdAt,
    this.updatedAt,
  });

  bool get isPublished => status == CourseStatus.published;

  /// Manual override if set, otherwise calculated from the lessons.
  double get totalHours => totalHoursOverride ?? totalDurationSeconds / 3600;

  AdminCourse copyWith({
    String? id,
    String? imagePath,
    String? imageUrl,
    CourseStatus? status,
  }) =>
      AdminCourse(
        id: id ?? this.id,
        title: title,
        description: description,
        about: about,
        learnings: learnings,
        language: language,
        imagePath: imagePath ?? this.imagePath,
        imageUrl: imageUrl ?? this.imageUrl,
        priceUsd: priceUsd,
        priceInr: priceInr,
        originalPriceUsd: originalPriceUsd,
        originalPriceInr: originalPriceInr,
        status: status ?? this.status,
        lessonCount: lessonCount,
        totalDurationSeconds: totalDurationSeconds,
        totalHoursOverride: totalHoursOverride,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
}
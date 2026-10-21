class AdminLesson {
  final String id;
  final String courseId;
  final String title;
  final String description;
  final String videoUrl;
  final String thumbnailPath; // Firebase Storage path
  final String thumbnailUrl; // cached download URL
  final int order; // 1-based position inside the course
  final int durationSeconds;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const AdminLesson({
    required this.id,
    required this.courseId,
    required this.title,
    this.description = '',
    required this.videoUrl,
    this.thumbnailPath = '',
    this.thumbnailUrl = '',
    required this.order,
    required this.durationSeconds,
    this.createdAt,
    this.updatedAt,
  });

  AdminLesson copyWith({
    String? id,
    String? thumbnailPath,
    String? thumbnailUrl,
  }) =>
      AdminLesson(
        id: id ?? this.id,
        courseId: courseId,
        title: title,
        description: description,
        videoUrl: videoUrl,
        thumbnailPath: thumbnailPath ?? this.thumbnailPath,
        thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
        order: order,
        durationSeconds: durationSeconds,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
}
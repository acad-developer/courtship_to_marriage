import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/admin_lesson.dart';

class AdminLessonModel {
  AdminLessonModel._();

  static AdminLesson fromMap(
      String courseId, String id, Map<String, dynamic> m) {
    return AdminLesson(
      id: id,
      courseId: courseId,
      title: (m['title'] as String?) ?? '',
      description: (m['description'] as String?) ?? '',
      videoUrl: (m['videoUrl'] as String?) ?? '',
      thumbnailPath: (m['thumbnailPath'] as String?) ?? '',
      thumbnailUrl: (m['thumbnailUrl'] as String?) ?? '',
      order: (m['order'] as num?)?.toInt() ?? 0,
      durationSeconds: (m['durationSeconds'] as num?)?.toInt() ?? 0,
      createdAt: (m['createdAt'] as Timestamp?)?.toDate(),
      updatedAt: (m['updatedAt'] as Timestamp?)?.toDate(),
    );
  }

  /// 'order' and timestamps are handled by the data source.
  static Map<String, dynamic> toMap(AdminLesson l) => {
    'title': l.title,
    'description': l.description,
    'videoUrl': l.videoUrl,
    'thumbnailPath': l.thumbnailPath,
    'thumbnailUrl': l.thumbnailUrl,
    'durationSeconds': l.durationSeconds,
  };
}
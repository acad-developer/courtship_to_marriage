import '../../domain/entities/lesson_entity.dart';

class LessonModel {
  LessonModel._();

  static LessonEntity fromMap(String id, Map<String, dynamic> m) =>
      LessonEntity(
        id: id,
        title: (m['title'] as String?) ?? '',
        description: (m['description'] as String?) ?? '',
        videoUrl: (m['videoUrl'] as String?) ?? '',
        thumbnailUrl: (m['thumbnailUrl'] as String?) ?? '',
        durationSeconds: (m['durationSeconds'] as num?)?.toInt() ?? 0,
        order: (m['order'] as num?)?.toInt() ?? 0,
      );
}
import '../entities/admin_lesson.dart';

abstract class AdminLessonsRepository {
  Stream<List<AdminLesson>> watchLessons(String courseId);

  String newLessonId(String courseId);

  Future<void> saveLesson(AdminLesson lesson, {required bool isNew});

  Future<void> deleteLesson(String courseId, String lessonId);

  /// Saves the given order (index + 1) for every lesson id.
  Future<void> reorderLessons(String courseId, List<String> orderedIds);

  /// Recounts lessons and sums their durations into the course document.
  Future<void> recalculateCourseTotals(String courseId);
}
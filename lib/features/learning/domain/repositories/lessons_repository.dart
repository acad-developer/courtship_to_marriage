import '../entities/lesson_entity.dart';

abstract class LessonsRepository {
  /// All lessons of a course, in order. Allowed only for purchased courses.
  Future<List<LessonEntity>> getLessons(String courseId);
}
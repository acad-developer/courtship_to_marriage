import '../entities/course_entity.dart';

abstract class CoursesRepository {
  /// Published courses only, newest first.
  Future<List<CourseEntity>> getCourses();
}
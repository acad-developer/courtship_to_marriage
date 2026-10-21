import '../entities/course_entity.dart';

abstract class HomeRepository {
  Future<List<CourseEntity>> getCourses();
}
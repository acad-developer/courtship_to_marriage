import '../../../courses/domain/entities/course_entity.dart';

abstract class MyLearningRepository {
  Future<List<CourseEntity>> getPurchasedCourses();
  Future<Set<String>> getPurchasedCourseIds();
}
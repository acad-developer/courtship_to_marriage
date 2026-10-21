import '../entities/admin_course.dart';

abstract class AdminCoursesRepository {
  Stream<List<AdminCourse>> watchCourses();

  /// Generates a Firestore id without writing anything.
  String newCourseId();

  Future<void> saveCourse(AdminCourse course, {required bool isNew});

  Future<void> updateStatus(String courseId, CourseStatus status);

  /// Deletes the course and its lessons. Returns the Storage paths of the
  /// lesson thumbnails so the caller can delete those files too.
  Future<List<String>> deleteCourse(String courseId);
}
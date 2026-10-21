import '../entities/admin_course.dart';
import '../repositories/admin_courses_repository.dart';
import '../repositories/admin_storage_repository.dart';

class DeleteCourseUseCase {
  final AdminCoursesRepository _courses;
  final AdminStorageRepository _storage;
  DeleteCourseUseCase(this._courses, this._storage);

  Future<void> call(AdminCourse course) async {
    final lessonFiles = await _courses.deleteCourse(course.id);
    final files = [
      if (course.imagePath.isNotEmpty) course.imagePath,
      ...lessonFiles,
    ];
    for (final path in files) {
      await _storage.deleteFile(path); // best effort
    }
  }
}
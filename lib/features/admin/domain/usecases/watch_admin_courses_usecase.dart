import '../entities/admin_course.dart';
import '../repositories/admin_courses_repository.dart';

class WatchAdminCoursesUseCase {
  final AdminCoursesRepository _repository;
  WatchAdminCoursesUseCase(this._repository);

  Stream<List<AdminCourse>> call() => _repository.watchCourses();
}
import '../../../../core/errors/app_exception.dart';
import '../entities/admin_course.dart';
import '../repositories/admin_courses_repository.dart';

class SetCourseStatusUseCase {
  final AdminCoursesRepository _repository;
  SetCourseStatusUseCase(this._repository);

  Future<void> call(AdminCourse course, CourseStatus status) {
    if (status == CourseStatus.published &&
        (course.imageUrl.isEmpty ||
            course.priceUsd <= 0 ||
            course.priceInr <= 0)) {
      throw const AppException(
          'Add a cover image and both prices before publishing.');
    }
    return _repository.updateStatus(course.id, status);
  }
}
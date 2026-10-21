import '../entities/course_entity.dart';
import '../repositories/courses_repository.dart';

class GetCoursesUseCase {
  final CoursesRepository _repository;
  GetCoursesUseCase(this._repository);

  Future<List<CourseEntity>> call() => _repository.getCourses();
}
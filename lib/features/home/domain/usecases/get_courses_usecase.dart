import '../entities/course_entity.dart';
import '../repositories/home_repository.dart';

class GetCoursesUseCase {
  final HomeRepository _repository;
  GetCoursesUseCase(this._repository);

  Future<List<CourseEntity>> call() => _repository.getCourses();
}
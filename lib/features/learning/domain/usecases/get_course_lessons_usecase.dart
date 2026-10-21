import '../entities/lesson_entity.dart';
import '../repositories/lessons_repository.dart';

class GetCourseLessonsUseCase {
  final LessonsRepository _repository;
  GetCourseLessonsUseCase(this._repository);

  Future<List<LessonEntity>> call(String courseId) =>
      _repository.getLessons(courseId);
}
import '../repositories/admin_lessons_repository.dart';

class ReorderLessonsUseCase {
  final AdminLessonsRepository _repository;
  ReorderLessonsUseCase(this._repository);

  Future<void> call(String courseId, List<String> orderedIds) =>
      _repository.reorderLessons(courseId, orderedIds);
}
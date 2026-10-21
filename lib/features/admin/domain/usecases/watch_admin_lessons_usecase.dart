import '../entities/admin_lesson.dart';
import '../repositories/admin_lessons_repository.dart';

class WatchAdminLessonsUseCase {
  final AdminLessonsRepository _repository;
  WatchAdminLessonsUseCase(this._repository);

  Stream<List<AdminLesson>> call(String courseId) =>
      _repository.watchLessons(courseId);
}
import '../entities/admin_lesson.dart';
import '../repositories/admin_lessons_repository.dart';
import '../repositories/admin_storage_repository.dart';

class DeleteLessonUseCase {
  final AdminLessonsRepository _lessons;
  final AdminStorageRepository _storage;
  DeleteLessonUseCase(this._lessons, this._storage);

  Future<void> call(AdminLesson lesson) async {
    await _lessons.deleteLesson(lesson.courseId, lesson.id);
    if (lesson.thumbnailPath.isNotEmpty) {
      await _storage.deleteFile(lesson.thumbnailPath);
    }
    await _lessons.recalculateCourseTotals(lesson.courseId);
  }
}
import 'dart:io';
import '../../../../core/utils/file_utils.dart';
import '../entities/admin_lesson.dart';
import '../entities/uploaded_file.dart';
import '../repositories/admin_lessons_repository.dart';
import '../repositories/admin_storage_repository.dart';

class SaveLessonUseCase {
  final AdminLessonsRepository _lessons;
  final AdminStorageRepository _storage;
  SaveLessonUseCase(this._lessons, this._storage);

  Future<void> call({
    required AdminLesson lesson,
    required bool isNew,
    File? newThumbnail,
  }) async {
    final id = lesson.id.isEmpty ? _lessons.newLessonId(lesson.courseId) : lesson.id;
    final oldThumbPath = lesson.thumbnailPath;
    var toSave = lesson.copyWith(id: id);

    UploadedFile? uploaded;
    if (newThumbnail != null) {
      final stamp = DateTime.now().millisecondsSinceEpoch;
      uploaded = await _storage.uploadImage(
        path: 'courses/${lesson.courseId}/lessons/$id/'
            'thumb_$stamp${FileUtils.extension(newThumbnail)}',
        file: newThumbnail,
      );
      toSave = toSave.copyWith(
          thumbnailPath: uploaded.path, thumbnailUrl: uploaded.url);
    }

    try {
      await _lessons.saveLesson(toSave, isNew: isNew);
    } catch (_) {
      if (uploaded != null) await _storage.deleteFile(uploaded.path);
      rethrow;
    }

    if (uploaded != null && oldThumbPath.isNotEmpty) {
      await _storage.deleteFile(oldThumbPath);
    }
    await _lessons.recalculateCourseTotals(lesson.courseId);
  }
}
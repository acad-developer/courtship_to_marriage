import 'dart:io';
import '../../../../core/utils/file_utils.dart';
import '../entities/admin_course.dart';
import '../entities/uploaded_file.dart';
import '../repositories/admin_courses_repository.dart';
import '../repositories/admin_storage_repository.dart';

class SaveCourseUseCase {
  final AdminCoursesRepository _courses;
  final AdminStorageRepository _storage;
  SaveCourseUseCase(this._courses, this._storage);

  /// [course.id] may be empty for a new course.
  Future<void> call({
    required AdminCourse course,
    required bool isNew,
    File? newImage,
  }) async {
    final id = course.id.isEmpty ? _courses.newCourseId() : course.id;
    final oldImagePath = course.imagePath;
    var toSave = course.copyWith(id: id);

    UploadedFile? uploaded;
    if (newImage != null) {
      final stamp = DateTime.now().millisecondsSinceEpoch;
      uploaded = await _storage.uploadImage(
        path: 'courses/$id/cover_$stamp${FileUtils.extension(newImage)}',
        file: newImage,
      );
      toSave = toSave.copyWith(imagePath: uploaded.path, imageUrl: uploaded.url);
    }

    try {
      await _courses.saveCourse(toSave, isNew: isNew);
    } catch (_) {
      // Do not leave an orphan upload behind.
      if (uploaded != null) await _storage.deleteFile(uploaded.path);
      rethrow;
    }

    // Replace: remove the previous cover only after the save succeeded.
    if (uploaded != null && oldImagePath.isNotEmpty) {
      await _storage.deleteFile(oldImagePath);
    }
  }
}
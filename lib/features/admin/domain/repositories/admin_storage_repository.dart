import 'dart:io';
import '../entities/uploaded_file.dart';

abstract class AdminStorageRepository {
  Future<UploadedFile> uploadImage({required String path, required File file});

  /// Best effort: a missing file is not an error.
  Future<void> deleteFile(String path);
}
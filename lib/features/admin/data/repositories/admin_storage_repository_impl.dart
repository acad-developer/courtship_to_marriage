import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import '../../../../core/errors/firebase_error_mapper.dart';
import '../../domain/entities/uploaded_file.dart';
import '../../domain/repositories/admin_storage_repository.dart';

class AdminStorageRepositoryImpl implements AdminStorageRepository {
  final FirebaseStorage _storage;
  AdminStorageRepositoryImpl(this._storage);

  @override
  Future<UploadedFile> uploadImage({
    required String path,
    required File file,
  }) async {
    try {
      final ref = _storage.ref(path);
      await ref.putFile(file, SettableMetadata(contentType: _contentType(path)));
      final url = await ref.getDownloadURL();
      return UploadedFile(path: path, url: url);
    } on FirebaseException catch (e) {
      throw mapFirebaseException(e);
    }
  }

  @override
  Future<void> deleteFile(String path) async {
    try {
      await _storage.ref(path).delete();
    } on FirebaseException catch (_) {
      // Best effort: missing files or failed cleanup must not block the admin.
    }
  }

  String _contentType(String path) {
    final p = path.toLowerCase();
    if (p.endsWith('.png')) return 'image/png';
    if (p.endsWith('.webp')) return 'image/webp';
    if (p.endsWith('.gif')) return 'image/gif';
    return 'image/jpeg';
  }
}
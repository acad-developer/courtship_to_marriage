import 'dart:io';
import 'package:image_picker/image_picker.dart';
import '../errors/app_exception.dart';

class ImagePickerHelper {
  ImagePickerHelper._();

  static const maxBytes = 5 * 1024 * 1024;
  static final _picker = ImagePicker();

  /// Returns null if the user cancels. Throws [AppException] if too large.
  static Future<File?> pickFromGallery() async {
    final picked = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1600,
      imageQuality: 85,
    );
    if (picked == null) return null;

    final file = File(picked.path);
    if (await file.length() > maxBytes) {
      throw const AppException('Image must be smaller than 5 MB.');
    }
    return file;
  }
}
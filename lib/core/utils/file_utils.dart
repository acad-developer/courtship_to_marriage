import 'dart:io';

class FileUtils {
  FileUtils._();

  /// Lower-case extension including the dot, e.g. ".png".
  static String extension(File file, {String fallback = '.jpg'}) {
    final name = file.path.split(RegExp(r'[\\/]')).last;
    final dot = name.lastIndexOf('.');
    if (dot == -1 || dot == name.length - 1) return fallback;
    return name.substring(dot).toLowerCase();
  }
}
import '../../../../../core/utils/youtube_utils.dart';

class LessonEntity {
  final String id;
  final String title;
  final String description;
  final String videoUrl;
  final String thumbnailUrl;
  final int durationSeconds;
  final int order;

  const LessonEntity({
    required this.id,
    required this.title,
    this.description = '',
    required this.videoUrl,
    this.thumbnailUrl = '',
    this.durationSeconds = 0,
    this.order = 0,
  });

  String? get youtubeId => YoutubeUtils.videoId(videoUrl);

  /// Uploaded thumbnail, or YouTube's automatic one when none was uploaded.
  String get displayThumbnail {
    if (thumbnailUrl.isNotEmpty) return thumbnailUrl;
    final id = youtubeId;
    return id == null ? '' : YoutubeUtils.thumbnailUrl(id);
  }
}
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import '../../domain/repositories/video_info_repository.dart';

class VideoInfoRepositoryImpl implements VideoInfoRepository {
  @override
  Future<int?> getDurationSeconds(String url) async {
    final videoId = VideoId.parseVideoId(url);
    if (videoId == null) return null; // not a YouTube link

    final yt = YoutubeExplode();
    try {
      final video =
      await yt.videos.get(videoId).timeout(const Duration(seconds: 15));
      final duration = video.duration;
      if (duration == null || duration.inSeconds <= 0) return null;
      return duration.inSeconds;
    } catch (_) {
      return null; // private video, offline, YouTube changed, ...
    } finally {
      yt.close();
    }
  }
}
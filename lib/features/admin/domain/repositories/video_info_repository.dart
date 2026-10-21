abstract class VideoInfoRepository {
  /// Length of the video in seconds, or null if it cannot be read
  /// (not a YouTube link, private video, offline, ...).
  Future<int?> getDurationSeconds(String url);
}
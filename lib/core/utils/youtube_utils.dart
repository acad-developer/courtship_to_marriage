class YoutubeUtils {
  YoutubeUtils._();

  static final _patterns = [
    RegExp(r'youtu\.be/([A-Za-z0-9_-]{11})'),
    RegExp(r'[?&]v=([A-Za-z0-9_-]{11})'),
    RegExp(
        r'youtube(?:-nocookie)?\.com/(?:embed|shorts|live|v)/([A-Za-z0-9_-]{11})'),
  ];

  /// Extracts the 11-character video id from any common YouTube link.
  static String? videoId(String url) {
    for (final p in _patterns) {
      final match = p.firstMatch(url);
      if (match != null) return match.group(1);
    }
    return null;
  }

  static String thumbnailUrl(String videoId) =>
      'https://img.youtube.com/vi/$videoId/hqdefault.jpg';
}
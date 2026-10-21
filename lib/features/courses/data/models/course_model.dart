import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/course_entity.dart';

class CourseModel {
  CourseModel._();

  static CourseEntity fromMap(String id, Map<String, dynamic> m) {
    final totalSeconds = (m['totalDurationSeconds'] as num?)?.toInt() ?? 0;
    final override = (m['totalHoursOverride'] as num?)?.toDouble();

    return CourseEntity(
      id: id,
      title: (m['title'] as String?) ?? '',
      description: (m['description'] as String?) ?? '',
      language: (m['language'] as String?) ?? 'English',
      imageUrl: (m['imageUrl'] as String?) ?? '',
      priceUsd: (m['priceUsd'] as num?)?.toDouble() ?? 0,
      priceInr: (m['priceInr'] as num?)?.toDouble() ?? 0,
      originalPriceUsd: (m['originalPriceUsd'] as num?)?.toDouble(),
      originalPriceInr: (m['originalPriceInr'] as num?)?.toDouble(),
      lessonCount: (m['lessonCount'] as num?)?.toInt() ?? 0,
      // Manual override wins; otherwise the sum of the lesson durations.
      durationHours: override ?? totalSeconds / 3600,
      learnings: List<String>.from((m['learnings'] as List?) ?? const []),
      aboutParagraphs: _paragraphs((m['about'] as String?) ?? ''),
      createdAt: (m['createdAt'] as Timestamp?)?.toDate(),
    );
  }

  /// Paragraphs are separated by a blank line in the admin form.
  static List<String> _paragraphs(String text) => text
      .split(RegExp(r'\n\s*\n'))
      .map((p) => p.trim())
      .where((p) => p.isNotEmpty)
      .toList();
}
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/admin_course.dart';

class AdminCourseModel {
  AdminCourseModel._();

  static AdminCourse fromMap(String id, Map<String, dynamic> m) => AdminCourse(
    id: id,
    title: (m['title'] as String?) ?? '',
    description: (m['description'] as String?) ?? '',
    about: (m['about'] as String?) ?? '',
    learnings: List<String>.from((m['learnings'] as List?) ?? const []),
    language: (m['language'] as String?) ?? 'English',
    imagePath: (m['imagePath'] as String?) ?? '',
    imageUrl: (m['imageUrl'] as String?) ?? '',
    priceUsd: (m['priceUsd'] as num?)?.toDouble() ?? 0,
    priceInr: (m['priceInr'] as num?)?.toDouble() ?? 0,
    originalPriceUsd: (m['originalPriceUsd'] as num?)?.toDouble(),
    originalPriceInr: (m['originalPriceInr'] as num?)?.toDouble(),
    status: m['status'] == 'published'
        ? CourseStatus.published
        : CourseStatus.draft,
    lessonCount: (m['lessonCount'] as num?)?.toInt() ?? 0,
    totalDurationSeconds: (m['totalDurationSeconds'] as num?)?.toInt() ?? 0,
    totalHoursOverride: (m['totalHoursOverride'] as num?)?.toDouble(),
    createdAt: (m['createdAt'] as Timestamp?)?.toDate(),
    updatedAt: (m['updatedAt'] as Timestamp?)?.toDate(),
  );

  /// lessonCount / totalDurationSeconds / timestamps are handled by the
  /// data source, so they are not part of this map.
  static Map<String, dynamic> toMap(AdminCourse c) => {
    'title': c.title,
    'description': c.description,
    'about': c.about,
    'learnings': c.learnings,
    'language': c.language,
    'imagePath': c.imagePath,
    'imageUrl': c.imageUrl,
    'priceUsd': c.priceUsd,
    'priceInr': c.priceInr,
    'originalPriceUsd': c.originalPriceUsd,
    'originalPriceInr': c.originalPriceInr,
    'status': c.status.name,
    'totalHoursOverride': c.totalHoursOverride,
  };
}
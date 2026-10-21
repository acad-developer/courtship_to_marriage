import '../../../courses/domain/entities/course_entity.dart';
import '../../domain/entities/lesson_entity.dart';

class LessonPlayerArgs {
  final CourseEntity course;
  final List<LessonEntity> lessons;
  final int startIndex;

  /// Lets the course screen keep its CURRENT tag in sync with the player.
  final void Function(int index) onLessonChanged;

  const LessonPlayerArgs({
    required this.course,
    required this.lessons,
    required this.startIndex,
    required this.onLessonChanged,
  });
}
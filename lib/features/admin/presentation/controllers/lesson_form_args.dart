import '../../domain/entities/admin_course.dart';
import '../../domain/entities/admin_lesson.dart';

class LessonFormArgs {
  final AdminCourse course;
  final AdminLesson? lesson; // null = new lesson
  final int nextOrder; // order given to a new lesson

  const LessonFormArgs({
    required this.course,
    this.lesson,
    required this.nextOrder,
  });
}
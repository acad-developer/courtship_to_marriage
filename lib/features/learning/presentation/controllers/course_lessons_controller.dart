import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../../core/errors/app_exception.dart';
import '../../../../../core/routes/app_routes.dart';
import '../../../../../core/utils/app_snackbar.dart';
import '../../../courses/domain/entities/course_entity.dart';
import '../../domain/entities/lesson_entity.dart';
import '../../domain/usecases/learning_preferences_usecase.dart';
import '../../domain/usecases/get_course_lessons_usecase.dart';
import 'lesson_player_args.dart';

class CourseLessonsController extends GetxController {
  final GetCourseLessonsUseCase _getLessons;
  final GetAutoPlayNextUseCase _getAutoPlay;
  final SetAutoPlayNextUseCase _setAutoPlay;

  CourseLessonsController(
      this._getLessons,
      this._getAutoPlay,
      this._setAutoPlay,
      );

  final CourseEntity course = Get.arguments as CourseEntity;

  final lessons = <LessonEntity>[].obs;
  final isLoading = true.obs;
  final errorMessage = RxnString();
  final autoPlayNext = true.obs;
  final currentIndex = 0.obs; // the lesson marked CURRENT

  @override
  void onInit() {
    super.onInit();
    _getAutoPlay().then((v) => autoPlayNext.value = v);
    load();
  }

  Future<void> load() async {
    isLoading.value = true;
    errorMessage.value = null;
    try {
      lessons.assignAll(await _getLessons(course.id));
    } on AppException catch (e) {
      errorMessage.value = e.message;
    } catch (_) {
      errorMessage.value = 'Could not load the lessons.';
    } finally {
      isLoading.value = false;
    }
  }

  void toggleAutoPlay(bool value) {
    autoPlayNext.value = value;
    _setAutoPlay(value);
  }

  void openLesson(int index) {
    currentIndex.value = index;
    Get.toNamed(
      AppRoutes.lessonPlayer,
      arguments: LessonPlayerArgs(
        course: course,
        lessons: lessons.toList(),
        startIndex: index,
        onLessonChanged: (i) => currentIndex.value = i,
      ),
    );
  }

  Future<void> share() async {
    try {
      await SharePlus.instance.share(
        ShareParams(
          subject: course.title,
          text: 'I am learning "${course.title}" on Courtship to Marriage.',
        ),
      );
    } catch (_) {
      AppSnackbar.error('Unable to share right now.');
    }
  }
}
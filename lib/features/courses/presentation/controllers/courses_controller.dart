import 'package:get/get.dart';
import '../../../../../core/routes/nested_routes.dart';
import '../../../../../core/utils/app_snackbar.dart';
import '../../../../../core/utils/currency.dart';
import '../../domain/entities/course_entity.dart';
import '../../domain/usecases/get_courses_usecase.dart';
import '../../domain/usecases/get_user_currency_usecase.dart';

class CoursesController extends GetxController {
  final GetCoursesUseCase _getCourses;
  final GetUserCurrencyUseCase _getCurrency;

  CoursesController(this._getCourses, this._getCurrency);

  final courses = <CourseEntity>[].obs;
  final isLoading = true.obs;
  final hasError = false.obs;
  final isSearching = false.obs;
  final query = ''.obs;

  Currency get currency => _getCurrency();

  List<CourseEntity> get visibleCourses {
    final q = query.value.trim().toLowerCase();
    if (q.isEmpty) return courses;
    return courses
        .where((c) =>
    c.title.toLowerCase().contains(q) ||
        c.description.toLowerCase().contains(q))
        .toList();
  }

  @override
  void onInit() {
    super.onInit();
    load();
  }

  Future<void> load({bool showLoader = true}) async {
    if (showLoader) isLoading.value = true;
    hasError.value = false;
    try {
      courses.assignAll(await _getCourses());
    } catch (_) {
      if (!showLoader && courses.isNotEmpty) {
        AppSnackbar.error('Could not refresh courses.');
      } else {
        hasError.value = true;
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshList() => load(showLoader: false);

  void toggleSearch() {
    isSearching.value = !isSearching.value;
    if (!isSearching.value) query.value = '';
  }

  void onQueryChanged(String value) => query.value = value;

  void openCourse(CourseEntity course) {
    Get.nestedKey(NestedNavKeys.courses)
        ?.currentState
        ?.pushNamed(CoursesRoutes.detail, arguments: course);
  }
}
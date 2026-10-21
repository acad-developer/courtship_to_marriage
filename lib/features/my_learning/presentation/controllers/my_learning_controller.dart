import 'package:get/get.dart';
import '../../../courses/domain/entities/course_entity.dart';
import '../../domain/usecases/get_purchased_courses_usecase.dart';
import '../../../../../core/routes/app_routes.dart';
import 'purchase_status_controller.dart';

class MyLearningController extends GetxController {
  final GetPurchasedCoursesUseCase _getPurchasedCourses;
  MyLearningController(this._getPurchasedCourses);

  final courses = <CourseEntity>[].obs;
  final isLoading = true.obs;
  final hasError = false.obs;

  @override
  void onInit() {
    super.onInit();
    load();
  }

  Future<void> load({bool showLoader = true}) async {
    if (showLoader) isLoading.value = true;
    hasError.value = false;
    try {
      courses.assignAll(await _getPurchasedCourses());
      if (Get.isRegistered<PurchaseStatusController>()) {
        Get.find<PurchaseStatusController>().refresh();
      }
    } catch (_) {
      hasError.value = true;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshList() => load(showLoader: false);

  void openCourse(CourseEntity course) =>
      Get.toNamed(AppRoutes.courseLessons, arguments: course);
}
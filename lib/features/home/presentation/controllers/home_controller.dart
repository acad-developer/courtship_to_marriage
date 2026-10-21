import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../../../../../core/routes/nested_routes.dart';
import '../../../../../core/utils/currency.dart';
import '../../../auth/domain/usecases/get_current_auth_user_usecase.dart';
import '../../../auth/domain/usecases/get_user_profile_usecase.dart';
import '../../../courses/domain/entities/course_entity.dart';
import '../../../courses/domain/usecases/get_courses_usecase.dart';
import '../../../courses/domain/usecases/get_user_currency_usecase.dart';

class HomeController extends GetxController {
  final GetCurrentAuthUserUseCase _getCurrentAuthUser;
  final GetUserProfileUseCase _getUserProfile;
  final GetCoursesUseCase _getCourses;
  final GetUserCurrencyUseCase _getCurrency;

  HomeController(
      this._getCurrentAuthUser,
      this._getUserProfile,
      this._getCourses,
      this._getCurrency,
      );

  final currentTab = 0.obs;
  final userName = ''.obs;
  final courses = <CourseEntity>[].obs;

  Currency get currency => _getCurrency();

  @override
  void onInit() {
    super.onInit();
    _load();
  }

  void changeTab(int index) => currentTab.value = index;

  /// Opens a course's detail page inside the Courses tab.
  void openCourse(CourseEntity course) {
    changeTab(1);
    // Wait one frame so the Courses tab is visible before pushing the page.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.nestedKey(NestedNavKeys.courses)
          ?.currentState
          ?.pushNamed(CoursesRoutes.detail, arguments: course);
    });
  }

  Future<void> _load() async {
    await Future.wait([refreshUserName(), _loadCourses()]);
  }

  Future<void> _loadCourses() async {
    try {
      courses.assignAll(await _getCourses());
    } catch (_) {
      // Home still works without the course strip; the Courses tab shows errors.
    }
  }

  Future<void> refreshUserName() async {
    final authUser = _getCurrentAuthUser();
    if (authUser == null) return;
    try {
      final profile = await _getUserProfile(authUser.uid);
      userName.value = profile?.name ?? '';
    } catch (_) {
      // The name is optional in the header; ignore failures.
    }
  }
}
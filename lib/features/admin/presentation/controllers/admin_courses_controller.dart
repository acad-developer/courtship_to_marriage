import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/errors/app_exception.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/utils/app_snackbar.dart';
import '../../../../core/widgets/confirm_dialog.dart';
import '../../domain/entities/admin_course.dart';
import '../../domain/usecases/delete_course_usecase.dart';
import '../../domain/usecases/set_course_status_usecase.dart';
import '../../domain/usecases/watch_admin_courses_usecase.dart';
import '../widgets/admin_course_card.dart';

class AdminCoursesController extends GetxController {
  final WatchAdminCoursesUseCase _watchCourses;
  final SetCourseStatusUseCase _setStatus;
  final DeleteCourseUseCase _deleteCourse;

  AdminCoursesController(
      this._watchCourses,
      this._setStatus,
      this._deleteCourse,
      );

  final courses = <AdminCourse>[].obs;
  final isLoading = true.obs;
  final errorMessage = RxnString();

  StreamSubscription<List<AdminCourse>>? _subscription;

  @override
  void onInit() {
    super.onInit();
    _listen();
  }

  void _listen() {
    isLoading.value = true;
    errorMessage.value = null;
    _subscription?.cancel();
    _subscription = _watchCourses().listen(
          (list) {
        courses.assignAll(list);
        isLoading.value = false;
      },
      onError: (Object e) {
        errorMessage.value =
        e is AppException ? e.message : 'Could not load courses.';
        isLoading.value = false;
      },
    );
  }

  void retry() => _listen();

  void openCreate() => Get.toNamed(AppRoutes.adminCourseForm);

  void openEdit(AdminCourse course) =>
      Get.toNamed(AppRoutes.adminCourseForm, arguments: course);

  void openLessons(AdminCourse course) =>
      Get.toNamed(AppRoutes.adminLessons, arguments: course);

  void onMenuAction(AdminCourse course, CourseMenuAction action) {
    switch (action) {
      case CourseMenuAction.edit:
        openEdit(course);
      case CourseMenuAction.lessons:
        openLessons(course);
      case CourseMenuAction.togglePublish:
        toggleStatus(course);
      case CourseMenuAction.delete:
        confirmDelete(course);
    }
  }

  Future<void> toggleStatus(AdminCourse course) async {
    final target =
    course.isPublished ? CourseStatus.draft : CourseStatus.published;
    try {
      await _setStatus(course, target);
      AppSnackbar.success(course.isPublished
          ? 'Course moved to draft.'
          : 'Course published.');
    } on AppException catch (e) {
      AppSnackbar.error(e.message);
    }
  }

  Future<void> confirmDelete(AdminCourse course) async {
    final confirmed = await Get.dialog<bool>(
      ConfirmDialog(
        title: 'Delete course?',
        message: '"${course.title}", all of its lessons and its images '
            'will be permanently deleted. This cannot be undone.',
        confirmLabel: 'Delete',
        icon: Icons.delete_outline_rounded,
      ),
    ) ??
        false;
    if (!confirmed) return;

    Get.dialog(
      const Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );
    try {
      await _deleteCourse(course);
      Get.back(); // close the loader
      AppSnackbar.success('Course deleted.');
    } on AppException catch (e) {
      Get.back();
      AppSnackbar.error(e.message);
    }
  }

  @override
  void onClose() {
    _subscription?.cancel();
    super.onClose();
  }
}
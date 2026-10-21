import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/errors/app_exception.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/utils/app_snackbar.dart';
import '../../../../core/widgets/confirm_dialog.dart';
import '../../domain/entities/admin_course.dart';
import '../../domain/entities/admin_lesson.dart';
import '../../domain/usecases/delete_lesson_usecase.dart';
import '../../domain/usecases/reorder_lessons_usecase.dart';
import '../../domain/usecases/watch_admin_lessons_usecase.dart';
import '../widgets/admin_lesson_tile.dart';
import 'lesson_form_args.dart';

class AdminLessonsController extends GetxController {
  final WatchAdminLessonsUseCase _watchLessons;
  final ReorderLessonsUseCase _reorderLessons;
  final DeleteLessonUseCase _deleteLesson;

  AdminLessonsController(
      this._watchLessons,
      this._reorderLessons,
      this._deleteLesson,
      );

  final AdminCourse course = Get.arguments as AdminCourse;

  final lessons = <AdminLesson>[].obs;
  final isLoading = true.obs;
  final errorMessage = RxnString();

  StreamSubscription<List<AdminLesson>>? _subscription;

  int get totalSeconds =>
      lessons.fold(0, (sum, lesson) => sum + lesson.durationSeconds);

  int get _nextOrder => lessons.isEmpty
      ? 1
      : lessons.map((l) => l.order).reduce((a, b) => a > b ? a : b) + 1;

  @override
  void onInit() {
    super.onInit();
    _listen();
  }

  void _listen() {
    isLoading.value = true;
    errorMessage.value = null;
    _subscription?.cancel();
    _subscription = _watchLessons(course.id).listen(
          (list) {
        lessons.assignAll(list);
        isLoading.value = false;
      },
      onError: (Object e) {
        errorMessage.value =
        e is AppException ? e.message : 'Could not load lessons.';
        isLoading.value = false;
      },
    );
  }

  void retry() => _listen();

  void openCreate() => Get.toNamed(
    AppRoutes.adminLessonForm,
    arguments: LessonFormArgs(course: course, nextOrder: _nextOrder),
  );

  void openEdit(AdminLesson lesson) => Get.toNamed(
    AppRoutes.adminLessonForm,
    arguments: LessonFormArgs(
        course: course, lesson: lesson, nextOrder: lesson.order),
  );

  void onMenuAction(AdminLesson lesson, LessonMenuAction action) {
    switch (action) {
      case LessonMenuAction.edit:
        openEdit(lesson);
      case LessonMenuAction.delete:
        confirmDelete(lesson);
    }
  }

  Future<void> reorder(int oldIndex, int newIndex) async {
    if (newIndex > oldIndex) newIndex -= 1;
    if (oldIndex == newIndex) return;

    // Update the screen immediately, then save.
    final item = lessons.removeAt(oldIndex);
    lessons.insert(newIndex, item);

    try {
      await _reorderLessons(course.id, lessons.map((l) => l.id).toList());
    } on AppException catch (e) {
      AppSnackbar.error(e.message);
      _listen(); // restore the real order from the server
    }
  }

  Future<void> confirmDelete(AdminLesson lesson) async {
    final confirmed = await Get.dialog<bool>(
      ConfirmDialog(
        title: 'Delete lesson?',
        message: '"${lesson.title}" and its thumbnail will be permanently '
            'deleted.',
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
      await _deleteLesson(lesson);
      Get.back(); // close the loader
      AppSnackbar.success('Lesson deleted.');
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
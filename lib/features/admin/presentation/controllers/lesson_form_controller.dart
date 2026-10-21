import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/errors/app_exception.dart';
import '../../../../core/utils/app_snackbar.dart';
import '../../../../core/utils/duration_parser.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/utils/image_picker_helper.dart';
import '../../domain/entities/admin_lesson.dart';
import '../../domain/usecases/get_video_duration_usecase.dart';
import '../../domain/usecases/save_lesson_usecase.dart';
import '../utils/admin_validators.dart';
import 'lesson_form_args.dart';

enum DurationStatus { idle, detecting, detected, failed }

class LessonFormController extends GetxController {
  final SaveLessonUseCase _saveLesson;
  final GetVideoDurationUseCase _getVideoDuration;

  LessonFormController(this._saveLesson, this._getVideoDuration);

  final LessonFormArgs args = Get.arguments as LessonFormArgs;
  AdminLesson? get editing => args.lesson;
  bool get isEditing => editing != null;

  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final videoUrlController = TextEditingController();
  final durationController = TextEditingController();

  final pickedThumbnail = Rxn<File>();
  final existingThumbnailUrl = ''.obs;
  final durationStatus = DurationStatus.idle.obs;
  final isSaving = false.obs;

  Timer? _debounce;
  int _detectToken = 0;
  bool _durationEditedManually = false;

  @override
  void onInit() {
    super.onInit();
    final l = editing;
    if (l == null) return;
    titleController.text = l.title;
    descriptionController.text = l.description;
    videoUrlController.text = l.videoUrl;
    durationController.text =
    l.durationSeconds > 0 ? Formatters.clock(l.durationSeconds) : '';
    existingThumbnailUrl.value = l.thumbnailUrl;
  }

  // ---- duration ----------------------------------------------------------

  /// Called while typing/pasting the link: detect after a short pause.
  void onVideoUrlChanged(String _) {
    _debounce?.cancel();
    _debounce = Timer(
      const Duration(milliseconds: 700),
          () => detectDuration(auto: true),
    );
  }

  /// Called when the admin types a duration by hand.
  void onDurationChanged(String _) {
    _durationEditedManually = true;
    _detectToken++; // ignore any detection still in flight
    durationStatus.value = DurationStatus.idle;
  }

  Future<void> detectDuration({bool auto = false}) async {
    final url = videoUrlController.text.trim();
    if (AdminValidators.videoUrl(url) != null) {
      if (!auto) AppSnackbar.error('Enter a valid video link first.');
      return;
    }
    // Never overwrite a duration the admin typed, unless they tap "Detect".
    if (auto && _durationEditedManually) return;

    final token = ++_detectToken;
    durationStatus.value = DurationStatus.detecting;
    final seconds = await _getVideoDuration(url);
    if (token != _detectToken || isClosed) return; // outdated result

    if (seconds == null) {
      durationStatus.value = DurationStatus.failed;
      return;
    }
    durationController.text = Formatters.clock(seconds);
    _durationEditedManually = false;
    durationStatus.value = DurationStatus.detected;
  }

  // ---- thumbnail ---------------------------------------------------------

  Future<void> pickThumbnail() async {
    try {
      final file = await ImagePickerHelper.pickFromGallery();
      if (file != null) pickedThumbnail.value = file;
    } on AppException catch (e) {
      AppSnackbar.error(e.message);
    } catch (_) {
      AppSnackbar.error('Could not open the gallery.');
    }
  }

  // ---- save --------------------------------------------------------------

  Future<void> save() async {
    if (isSaving.value) return;
    if (!formKey.currentState!.validate()) return;

    FocusManager.instance.primaryFocus?.unfocus();
    _debounce?.cancel();
    _detectToken++; // ignore in-flight detection

    isSaving.value = true;
    try {
      final url = videoUrlController.text.trim();
      var seconds = DurationParser.parse(durationController.text);

      if (seconds == null || seconds <= 0) {
        // No duration yet: try to detect it now.
        seconds = await _getVideoDuration(url);
        if (seconds == null) {
          durationStatus.value = DurationStatus.failed;
          AppSnackbar.error("Couldn't read the video length automatically. "
              'Please enter the duration (mm:ss).');
          return;
        }
        durationController.text = Formatters.clock(seconds);
      }

      final lesson = AdminLesson(
        id: editing?.id ?? '',
        courseId: args.course.id,
        title: titleController.text.trim(),
        description: descriptionController.text.trim(),
        videoUrl: url,
        thumbnailPath: editing?.thumbnailPath ?? '',
        thumbnailUrl: editing?.thumbnailUrl ?? '',
        order: editing?.order ?? args.nextOrder,
        durationSeconds: seconds,
      );

      await _saveLesson(
        lesson: lesson,
        isNew: !isEditing,
        newThumbnail: pickedThumbnail.value,
      );
      Get.back();
      AppSnackbar.success(isEditing ? 'Lesson updated.' : 'Lesson added.');
    } on AppException catch (e) {
      AppSnackbar.error(e.message);
    } finally {
      if (!isClosed) isSaving.value = false;
    }
  }

  @override
  void onClose() {
    _debounce?.cancel();
    titleController.dispose();
    descriptionController.dispose();
    videoUrlController.dispose();
    durationController.dispose();
    super.onClose();
  }
}
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/errors/app_exception.dart';
import '../../../../core/utils/app_snackbar.dart';
import '../../domain/entities/admin_course.dart';
import '../../domain/usecases/save_course_usecase.dart';

class CourseFormController extends GetxController {
  final SaveCourseUseCase _saveCourse;
  CourseFormController(this._saveCourse);

  static const _maxImageBytes = 5 * 1024 * 1024;

  /// null = creating a new course.
  final AdminCourse? editing = Get.arguments as AdminCourse?;
  bool get isEditing => editing != null;

  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final aboutController = TextEditingController();
  final learningsController = TextEditingController();
  final priceUsdController = TextEditingController();
  final priceInrController = TextEditingController();
  final originalUsdController = TextEditingController();
  final originalInrController = TextEditingController();
  final hoursOverrideController = TextEditingController();

  static const presetLanguages = ['English', 'Hindi'];

  /// 'English', 'Hindi' or 'Others'
  final language = 'English'.obs;
  final otherLanguageController = TextEditingController();
  final isPublished = false.obs;
  final pickedImage = Rxn<File>();
  final existingImageUrl = ''.obs;
  final isSaving = false.obs;

  final _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    final c = editing;
    if (c == null) return;
    titleController.text = c.title;
    descriptionController.text = c.description;
    aboutController.text = c.about;
    learningsController.text = c.learnings.join('\n');
    priceUsdController.text = _fmt(c.priceUsd);
    priceInrController.text = _fmt(c.priceInr);
    originalUsdController.text =
    c.originalPriceUsd == null ? '' : _fmt(c.originalPriceUsd!);
    originalInrController.text =
    c.originalPriceInr == null ? '' : _fmt(c.originalPriceInr!);
    hoursOverrideController.text =
    c.totalHoursOverride == null ? '' : _fmt(c.totalHoursOverride!);
    isPublished.value = c.isPublished;
    existingImageUrl.value = c.imageUrl;

    final preset = presetLanguages
        .where((l) => l.toLowerCase() == c.language.toLowerCase());
    if (preset.isNotEmpty) {
      language.value = preset.first;
    } else {
      language.value = 'Others';
      otherLanguageController.text = c.language;
    }
  }

  String _fmt(double v) => v % 1 == 0 ? v.toStringAsFixed(0) : v.toString();
  double? _number(TextEditingController c) => double.tryParse(c.text.trim());

  /// Numbers only (digits and one dot).
  static final amountFormatters = [
    FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
  ];

  Future<void> pickImage() async {
    try {
      final picked = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1600,
        imageQuality: 85,
      );
      if (picked == null) return;

      final file = File(picked.path);
      if (await file.length() > _maxImageBytes) {
        AppSnackbar.error('Image must be smaller than 5 MB.');
        return;
      }
      pickedImage.value = file;
    } catch (_) {
      AppSnackbar.error('Could not open the gallery.');
    }
  }

  Future<void> save() async {
    if (isSaving.value) return;
    if (!formKey.currentState!.validate()) return;

    final hasImage =
        pickedImage.value != null || existingImageUrl.value.isNotEmpty;
    if (isPublished.value && !hasImage) {
      AppSnackbar.error('Add a cover image before publishing.');
      return;
    }

    final learnings = learningsController.text
        .split('\n')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();

    final course = AdminCourse(
      id: editing?.id ?? '',
      title: titleController.text.trim(),
      description: descriptionController.text.trim(),
      about: aboutController.text.trim(),
      learnings: learnings,
      language: language.value == 'Others'
          ? otherLanguageController.text
          .trim()
          .replaceAll(RegExp(r'\s+'), ' ')
          .toUpperCase()
          : language.value,
      imagePath: editing?.imagePath ?? '',
      imageUrl: editing?.imageUrl ?? '',
      priceUsd: _number(priceUsdController)!,
      priceInr: _number(priceInrController)!,
      originalPriceUsd: _number(originalUsdController),
      originalPriceInr: _number(originalInrController),
      status: isPublished.value ? CourseStatus.published : CourseStatus.draft,
      lessonCount: editing?.lessonCount ?? 0,
      totalDurationSeconds: editing?.totalDurationSeconds ?? 0,
      totalHoursOverride: _number(hoursOverrideController),
    );

    FocusManager.instance.primaryFocus?.unfocus();
    isSaving.value = true;
    try {
      await _saveCourse(
        course: course,
        isNew: !isEditing,
        newImage: pickedImage.value,
      );
      Get.back();
      AppSnackbar.success(isEditing ? 'Course updated.' : 'Course created.');
    } on AppException catch (e) {
      AppSnackbar.error(e.message);
    } finally {
      if (!isClosed) isSaving.value = false;
    }
  }

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    aboutController.dispose();
    learningsController.dispose();
    priceUsdController.dispose();
    priceInrController.dispose();
    originalUsdController.dispose();
    originalInrController.dispose();
    hoursOverrideController.dispose();
    otherLanguageController.dispose();
    super.onClose();
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/primary_button.dart';
import '../controllers/lesson_form_controller.dart';
import '../utils/admin_validators.dart';
import '../widgets/admin_header.dart';
import '../widgets/image_picker_box.dart';

class LessonFormView extends GetView<LessonFormController> {
  const LessonFormView({super.key});

  @override
  Widget build(BuildContext context) {
    final c = controller;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          AdminHeader(title: c.isEditing ? 'Edit Lesson' : 'New Lesson'),
          Expanded(
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 40),
              child: Form(
                key: c.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Course: ${c.args.course.title}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text('Thumbnail', style: AppTextStyles.heading(22)),
                    const SizedBox(height: 12),
                    Center(
                      child: SizedBox(
                        width: 240,
                        child: Obx(() => ImagePickerBox(
                          file: c.pickedThumbnail.value,
                          url: c.existingThumbnailUrl.value,
                          onTap: c.pickThumbnail,
                          aspectRatio: 1,
                          title: 'Tap to add thumbnail',
                        )),
                      ),
                    ),
                    const SizedBox(height: 32),
                    Text('Lesson details', style: AppTextStyles.heading(22)),
                    const SizedBox(height: 16),
                    AppTextField(
                      label: 'Lesson title *',
                      hint: 'e.g. Welcome to the Course',
                      icon: Icons.title_rounded,
                      controller: c.titleController,
                      textCapitalization: TextCapitalization.words,
                      validator: (v) =>
                          AdminValidators.requiredText(v, 'lesson title'),
                    ),
                    const SizedBox(height: 20),
                    AppTextField(
                      label: 'Description',
                      hint: 'What will students learn in this lesson?',
                      controller: c.descriptionController,
                      minLines: 3,
                      maxLines: 6,
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                      textCapitalization: TextCapitalization.sentences,
                    ),
                    const SizedBox(height: 32),
                    Text('Video', style: AppTextStyles.heading(22)),
                    const SizedBox(height: 16),
                    AppTextField(
                      label: 'Video URL *',
                      hint: 'https://www.youtube.com/watch?v=...',
                      icon: Icons.link_rounded,
                      controller: c.videoUrlController,
                      keyboardType: TextInputType.url,
                      onChanged: c.onVideoUrlChanged,
                      validator: AdminValidators.videoUrl,
                    ),
                    const SizedBox(height: 20),
                    AppTextField(
                      label: 'Duration',
                      hint: 'mm:ss  (e.g. 12:45)',
                      icon: Icons.schedule_rounded,
                      controller: c.durationController,
                      keyboardType: TextInputType.datetime,
                      onChanged: c.onDurationChanged,
                      validator: AdminValidators.duration,
                    ),
                    const SizedBox(height: 8),
                    Obx(() => _DurationStatusRow(
                      status: c.durationStatus.value,
                      onDetect: () => c.detectDuration(),
                    )),
                    const SizedBox(height: 32),
                    Obx(() => PrimaryButton(
                      label: c.isEditing ? 'SAVE CHANGES' : 'ADD LESSON',
                      isLoading: c.isSaving.value,
                      onPressed: c.save,
                    )),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DurationStatusRow extends StatelessWidget {
  final DurationStatus status;
  final VoidCallback onDetect;
  const _DurationStatusRow({required this.status, required this.onDetect});

  static const _green = Color(0xFF16A34A);
  static const _orange = Color(0xFFD97706);

  @override
  Widget build(BuildContext context) {
    late final Widget icon;
    late final String text;
    late final Color color;

    switch (status) {
      case DurationStatus.detecting:
        icon = const SizedBox(
          width: 14,
          height: 14,
          child: CircularProgressIndicator(
              strokeWidth: 2, color: AppColors.primary),
        );
        text = 'Detecting video length…';
        color = AppColors.textSecondary;
      case DurationStatus.detected:
        icon = const Icon(Icons.check_circle_rounded, size: 16, color: _green);
        text = 'Detected from the video link';
        color = _green;
      case DurationStatus.failed:
        icon = const Icon(Icons.info_outline_rounded, size: 16, color: _orange);
        text = "Couldn't detect it. Enter the duration manually.";
        color = _orange;
      case DurationStatus.idle:
        icon = const Icon(Icons.auto_awesome_rounded,
            size: 16, color: AppColors.hint);
        text = 'Detected automatically from YouTube links.';
        color = AppColors.textSecondary;
    }

    return Row(
      children: [
        icon,
        const SizedBox(width: 8),
        Expanded(
          child: Text(text, style: TextStyle(fontSize: 12, color: color)),
        ),
        TextButton(
          onPressed: status == DurationStatus.detecting ? null : onDetect,
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            minimumSize: const Size(0, 32),
          ),
          child: const Text('Detect',
              style: TextStyle(
                  color: AppColors.primary, fontWeight: FontWeight.w700)),
        ),
      ],
    );
  }
}
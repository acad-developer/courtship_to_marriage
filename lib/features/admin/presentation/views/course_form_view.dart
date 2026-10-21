import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/app_network_image.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/primary_button.dart';
import '../controllers/course_form_controller.dart';
import '../../../../core/utils/text_formatters.dart';
import '../utils/admin_validators.dart';
import '../widgets/admin_header.dart';

class CourseFormView extends GetView<CourseFormController> {
  const CourseFormView({super.key});

  @override
  Widget build(BuildContext context) {
    final c = controller;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          AdminHeader(title: c.isEditing ? 'Edit Course' : 'New Course'),
          Expanded(
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 40),
              child: Form(
                key: c.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _SectionTitle('Cover image'),
                    const SizedBox(height: 12),
                    _CoverPicker(controller: c),
                    const SizedBox(height: 32),

                    const _SectionTitle('Basic info'),
                    const SizedBox(height: 16),
                    AppTextField(
                      label: 'Course title *',
                      hint: 'e.g. Foundations of Courtship',
                      icon: Icons.title_rounded,
                      controller: c.titleController,
                      textCapitalization: TextCapitalization.words,
                      validator: (v) =>
                          AdminValidators.requiredText(v, 'course title'),
                    ),
                    const SizedBox(height: 20),
                    AppTextField(
                      label: 'Short description *',
                      hint: 'One or two sentences shown on course cards',
                      controller: c.descriptionController,
                      minLines: 3,
                      maxLines: 5,
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                      textCapitalization: TextCapitalization.sentences,
                      validator: (v) =>
                          AdminValidators.requiredText(v, 'description'),
                    ),
                    const SizedBox(height: 20),
                    _LanguageSelector(controller: c),
                    const SizedBox(height: 32),

                    const _SectionTitle('Pricing'),
                    const SizedBox(height: 16),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: AppTextField(
                            label: 'Price (USD) *',
                            hint: '49.99',
                            icon: Icons.attach_money_rounded,
                            controller: c.priceUsdController,
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
                            inputFormatters: CourseFormController.amountFormatters,
                            validator: AdminValidators.price,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: AppTextField(
                            label: 'Price (INR) *',
                            hint: '3999',
                            icon: Icons.currency_rupee_rounded,
                            controller: c.priceInrController,
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
                            inputFormatters: CourseFormController.amountFormatters,
                            validator: AdminValidators.price,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: AppTextField(
                            label: 'Original USD',
                            hint: '69.99',
                            icon: Icons.attach_money_rounded,
                            controller: c.originalUsdController,
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
                            inputFormatters: CourseFormController.amountFormatters,
                            validator: (v) => AdminValidators.originalPrice(
                                v, c.priceUsdController.text),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: AppTextField(
                            label: 'Original INR',
                            hint: '5999',
                            icon: Icons.currency_rupee_rounded,
                            controller: c.originalInrController,
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
                            inputFormatters: CourseFormController.amountFormatters,
                            validator: (v) => AdminValidators.originalPrice(
                                v, c.priceInrController.text),
                          ),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 8, left: 4),
                      child: Text(
                        'Original prices are optional and shown struck through '
                            'to display a discount.',
                        style: TextStyle(
                            fontSize: 12, color: AppColors.textSecondary),
                      ),
                    ),
                    const SizedBox(height: 32),

                    const _SectionTitle('Content'),
                    const SizedBox(height: 16),
                    AppTextField(
                      label: 'What users will learn',
                      hint:
                      'Understand the foundations of a healthy relationship\nIdentify and communicate boundaries',
                      controller: c.learningsController,
                      minLines: 4,
                      maxLines: 10,
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                      textCapitalization: TextCapitalization.sentences,
                      helper:
                      'One point per line. Shown as a checklist on the course page.',
                    ),
                    const SizedBox(height: 20),
                    AppTextField(
                      label: 'About this course',
                      hint: 'Longer description (optional)',
                      controller: c.aboutController,
                      minLines: 5,
                      maxLines: 14,
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                      textCapitalization: TextCapitalization.sentences,
                      helper: 'Optional. Separate paragraphs with a blank line.',
                    ),
                    const SizedBox(height: 32),

                    const _SectionTitle('Settings'),
                    const SizedBox(height: 16),
                    AppTextField(
                      label: 'Total hours (optional)',
                      hint: 'Leave empty to calculate automatically',
                      icon: Icons.schedule_rounded,
                      controller: c.hoursOverrideController,
                      keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: CourseFormController.amountFormatters,
                      validator: AdminValidators.optionalPositive,
                      helper:
                      'By default this is the sum of all lesson durations.',
                    ),
                    if (c.isEditing) ...[
                      const SizedBox(height: 16),
                      _AutoInfo(
                        lessons: c.editing!.lessonCount,
                        seconds: c.editing!.totalDurationSeconds,
                      ),
                    ],
                    const SizedBox(height: 20),
                    _ToggleCard(
                      title: 'Published',
                      subtitle:
                      'Off = draft. Only published courses are visible to users.',
                      value: c.isPublished,
                    ),
                    const SizedBox(height: 32),

                    Obx(() => PrimaryButton(
                      label: c.isEditing ? 'SAVE CHANGES' : 'CREATE COURSE',
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

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) =>
      Text(text, style: AppTextStyles.heading(22));
}

class _CoverPicker extends StatelessWidget {
  final CourseFormController controller;
  const _CoverPicker({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final file = controller.pickedImage.value;
      final url = controller.existingImageUrl.value;
      final hasImage = file != null || url.isNotEmpty;

      return GestureDetector(
        onTap: controller.pickImage,
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: AppColors.border),
            ),
            clipBehavior: Clip.antiAlias,
            child: Stack(
              fit: StackFit.expand,
              children: [
                if (file != null)
                  Image.file(file, fit: BoxFit.cover)
                else if (url.isNotEmpty)
                  AppNetworkImage(url)
                else
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add_photo_alternate_outlined,
                          size: 44, color: AppColors.primary),
                      SizedBox(height: 10),
                      Text('Tap to add cover image',
                          style: TextStyle(fontWeight: FontWeight.w600)),
                      SizedBox(height: 4),
                      Text('Landscape (16:9) works best, under 5 MB',
                          style: TextStyle(
                              fontSize: 12, color: AppColors.textSecondary)),
                    ],
                  ),
                if (hasImage)
                  Positioned(
                    right: 12,
                    bottom: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.6),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.edit_rounded,
                              size: 14, color: Colors.white),
                          SizedBox(width: 6),
                          Text('Change',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class _LanguageSelector extends StatelessWidget {
  final CourseFormController controller;
  const _LanguageSelector({required this.controller});

  static const _options = ['English', 'Hindi', 'Others'];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('COURSE LANGUAGE', style: AppTextStyles.label),
        const SizedBox(height: 8),
        Obx(() => Row(
          children: [
            for (var i = 0; i < _options.length; i++) ...[
              Expanded(
                child: _LanguageChoice(
                  label: _options[i],
                  selected: controller.language.value == _options[i],
                  onTap: () => controller.language.value = _options[i],
                ),
              ),
              if (i != _options.length - 1) const SizedBox(width: 10),
            ],
          ],
        )),
        Obx(() {
          if (controller.language.value != 'Others') {
            return const SizedBox.shrink();
          }
          return Padding(
            padding: const EdgeInsets.only(top: 16),
            child: AppTextField(
              label: 'Language name *',
              hint: 'e.g. Urdu, Punjabi, Tamil',
              icon: Icons.translate_rounded,
              controller: controller.otherLanguageController,
              textCapitalization: TextCapitalization.characters,
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                    RegExp(r'[\p{L} -]', unicode: true)),
                UpperCaseTextFormatter(),
              ],
              helper: 'Saved in capital letters, e.g. URDU.',
              validator: AdminValidators.languageName,
            ),
          );
        }),
      ],
    );
  }
}

class _LanguageChoice extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _LanguageChoice({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: selected ? AppColors.primaryLight : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selected ? AppColors.primary : AppColors.border,
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Center(
          child: Text(label,
              style: const TextStyle(fontWeight: FontWeight.w600)),
        ),
      ),
    );
  }
}

class _ToggleCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final RxBool value;
  const _ToggleCard({
    required this.title,
    required this.subtitle,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 12, 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w600)),
                const SizedBox(height: 2),
                Text(subtitle,
                    style: const TextStyle(
                        fontSize: 12, color: AppColors.textSecondary)),
              ],
            ),
          ),
          Switch(value: value.value, onChanged: (v) => value.value = v),
        ],
      ),
    ));
  }
}

class _AutoInfo extends StatelessWidget {
  final int lessons;
  final int seconds;
  const _AutoInfo({required this.lessons, required this.seconds});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const Icon(Icons.auto_awesome_rounded,
              size: 20, color: AppColors.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              '$lessons lessons • ${Formatters.duration(seconds)} of video. '
                  'Calculated automatically from the lessons.',
              style: const TextStyle(fontSize: 13, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}
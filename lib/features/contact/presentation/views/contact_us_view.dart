// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import '../../../../core/constants/app_colors.dart';
// import '../../../../core/constants/contact_constants.dart';
// import '../../../../core/theme/app_theme.dart';
// import '../../../../core/utils/validators.dart';
// import '../../../../core/widgets/app_text_field.dart';
// import '../../../../core/widgets/page_header.dart';
// import '../../../../core/widgets/primary_button.dart';
// import '../controllers/contact_us_controller.dart';
//
// class ContactUsView extends GetView<ContactUsController> {
//   const ContactUsView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.background,
//       body: Column(
//         children: [
//           const AppPageHeader(title: 'Contact Us'),
//           Expanded(
//             child: SingleChildScrollView(
//               keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
//               padding: const EdgeInsets.fromLTRB(24, 24, 24, 40),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text("We'd love to hear from you",
//                       style: AppTextStyles.heading(24)),
//                   const SizedBox(height: 8),
//                   const Text(
//                     'Questions, feedback or a problem with a course? Reach us '
//                         'directly, or send a message below and our team will '
//                         'reply soon.',
//                     style: TextStyle(
//                         color: AppColors.textSecondary, height: 1.5),
//                   ),
//                   const SizedBox(height: 20),
//                   _ContactCard(controller: controller),
//                   const SizedBox(height: 32),
//                   Text('Send Us a Message', style: AppTextStyles.heading(24)),
//                   const SizedBox(height: 16),
//                   _MessageForm(controller: controller),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class _ContactCard extends StatelessWidget {
//   final ContactUsController controller;
//   const _ContactCard({required this.controller});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(24),
//         border: Border.all(color: AppColors.border),
//       ),
//       clipBehavior: Clip.antiAlias,
//       child: Column(
//         children: [
//           _ContactRow(
//             icon: Icons.mail_outline_rounded,
//             label: 'EMAIL US',
//             value: AppContact.supportEmail,
//             onTap: controller.emailUs,
//           ),
//           const Divider(height: 1, color: AppColors.border),
//           _ContactRow(
//             icon: Icons.call_outlined,
//             label: 'CALL US',
//             value: AppContact.supportPhone,
//             onTap: controller.callUs,
//           ),
//           const Divider(height: 1, color: AppColors.border),
//           _ContactRow(
//             icon: Icons.chat_bubble_outline_rounded,
//             label: 'WHATSAPP',
//             value: AppContact.whatsappPhone,
//             onTap: controller.whatsappUs,
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class _ContactRow extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   final String value;
//   final VoidCallback onTap;
//
//   const _ContactRow({
//     required this.icon,
//     required this.label,
//     required this.value,
//     required this.onTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
//         child: Row(
//           children: [
//             Container(
//               width: 46,
//               height: 46,
//               decoration: const BoxDecoration(
//                   shape: BoxShape.circle, color: AppColors.primaryLight),
//               child: Icon(icon, color: AppColors.primary, size: 22),
//             ),
//             const SizedBox(width: 16),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(label, style: AppTextStyles.label),
//                   const SizedBox(height: 4),
//                   Text(value,
//                       style: const TextStyle(
//                           fontSize: 15, fontWeight: FontWeight.w600)),
//                 ],
//               ),
//             ),
//             const Icon(Icons.chevron_right_rounded, color: AppColors.hint),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class _MessageForm extends StatelessWidget {
//   final ContactUsController controller;
//   const _MessageForm({required this.controller});
//
//   @override
//   Widget build(BuildContext context) {
//     final c = controller;
//     return Form(
//       key: c.formKey,
//       child: Column(
//         children: [
//           AppTextField(
//             label: 'Your name *',
//             hint: 'Enter your name',
//             icon: Icons.person_outline_rounded,
//             controller: c.nameController,
//             textCapitalization: TextCapitalization.words,
//             validator: Validators.fullName,
//           ),
//           const SizedBox(height: 18),
//           AppTextField(
//             label: 'Email *',
//             hint: 'example@email.com',
//             icon: Icons.mail_outline_rounded,
//             controller: c.emailController,
//             keyboardType: TextInputType.emailAddress,
//             validator: Validators.email,
//           ),
//           const SizedBox(height: 18),
//           AppTextField(
//             label: 'Subject *',
//             hint: 'e.g. Question about a course',
//             icon: Icons.title_rounded,
//             controller: c.subjectController,
//             textCapitalization: TextCapitalization.sentences,
//             inputFormatters: [LengthLimitingTextInputFormatter(150)],
//             validator: (v) => Validators.requiredField(v, 'subject'),
//           ),
//           const SizedBox(height: 18),
//           AppTextField(
//             label: 'Message *',
//             hint: 'Tell us how we can help you',
//             controller: c.messageController,
//             minLines: 5,
//             maxLines: 8,
//             keyboardType: TextInputType.multiline,
//             textInputAction: TextInputAction.newline,
//             textCapitalization: TextCapitalization.sentences,
//             inputFormatters: [LengthLimitingTextInputFormatter(1500)],
//             validator: Validators.supportMessage,
//           ),
//           const SizedBox(height: 24),
//           Obx(() => PrimaryButton(
//             label: 'SEND MESSAGE',
//             isLoading: c.isSubmitting.value,
//             onPressed: c.submit,
//           )),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/contact_constants.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/page_header.dart';
import '../../../../core/widgets/primary_button.dart';
import '../controllers/contact_us_controller.dart';

class ContactUsView extends GetView<ContactUsController> {
  const ContactUsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          const AppPageHeader(title: 'Contact Us'),
          Expanded(
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("We'd love to hear from you",
                      style: AppTextStyles.heading(24)),
                  const SizedBox(height: 8),
                  const Text(
                    'Questions, feedback or a problem with a course? Send us '
                        'a message and our team will reply soon.',
                    style: TextStyle(
                        color: AppColors.textSecondary, height: 1.5),
                  ),
                  const SizedBox(height: 24),
                  _MessageForm(controller: controller),
                  const SizedBox(height: 36),
                  Text('Reach Us Directly', style: AppTextStyles.heading(24)),
                  const SizedBox(height: 8),
                  const Text(
                    'Prefer to talk or write from your own apps? Use any of '
                        'the options below.',
                    style: TextStyle(
                        color: AppColors.textSecondary, height: 1.5),
                  ),
                  const SizedBox(height: 16),
                  _ContactCard(controller: controller),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ContactCard extends StatelessWidget {
  final ContactUsController controller;
  const _ContactCard({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          _ContactRow(
            icon: Icons.mail_outline_rounded,
            label: 'EMAIL US',
            value: AppContact.supportEmail,
            onTap: controller.emailUs,
          ),
          const Divider(height: 1, color: AppColors.border),
          _ContactRow(
            icon: Icons.call_outlined,
            label: 'CALL US',
            value: AppContact.supportPhone,
            onTap: controller.callUs,
          ),
          const Divider(height: 1, color: AppColors.border),
          _ContactRow(
            icon: Icons.chat_bubble_outline_rounded,
            label: 'WHATSAPP',
            value: AppContact.whatsappPhone,
            onTap: controller.whatsappUs,
          ),
        ],
      ),
    );
  }
}

class _ContactRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final VoidCallback onTap;

  const _ContactRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        child: Row(
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: AppColors.primaryLight),
              child: Icon(icon, color: AppColors.primary, size: 22),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: AppTextStyles.label),
                  const SizedBox(height: 4),
                  Text(value,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded, color: AppColors.hint),
          ],
        ),
      ),
    );
  }
}

class _MessageForm extends StatelessWidget {
  final ContactUsController controller;
  const _MessageForm({required this.controller});

  @override
  Widget build(BuildContext context) {
    final c = controller;
    return Form(
      key: c.formKey,
      child: Column(
        children: [
          AppTextField(
            label: 'Your name *',
            hint: 'Enter your name',
            icon: Icons.person_outline_rounded,
            controller: c.nameController,
            textCapitalization: TextCapitalization.words,
            validator: Validators.fullName,
          ),
          const SizedBox(height: 18),
          AppTextField(
            label: 'Email *',
            hint: 'example@email.com',
            icon: Icons.mail_outline_rounded,
            controller: c.emailController,
            keyboardType: TextInputType.emailAddress,
            validator: Validators.email,
          ),
          const SizedBox(height: 18),
          AppTextField(
            label: 'Subject *',
            hint: 'e.g. Question about a course',
            icon: Icons.title_rounded,
            controller: c.subjectController,
            textCapitalization: TextCapitalization.sentences,
            inputFormatters: [LengthLimitingTextInputFormatter(150)],
            validator: (v) => Validators.requiredField(v, 'subject'),
          ),
          const SizedBox(height: 18),
          AppTextField(
            label: 'Message *',
            hint: 'Tell us how we can help you',
            controller: c.messageController,
            minLines: 5,
            maxLines: 8,
            keyboardType: TextInputType.multiline,
            textInputAction: TextInputAction.newline,
            textCapitalization: TextCapitalization.sentences,
            inputFormatters: [LengthLimitingTextInputFormatter(1500)],
            validator: Validators.supportMessage,
          ),
          const SizedBox(height: 24),
          Obx(() => PrimaryButton(
            label: 'SEND MESSAGE',
            isLoading: c.isSubmitting.value,
            onPressed: c.submit,
          )),
        ],
      ),
    );
  }
}